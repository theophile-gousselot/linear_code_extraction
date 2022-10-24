''' Script to analyse and plot clock cycle overheads as a fucntion of wwdl (Worst Wanted Detection Latency). '''

import argparse
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import style
import os
style.use('tableau-colorblind10')

LOG_FILE_OVERHEAD_PATH = "../log/lce_overhead"
LOG_FILE_OVERHEAD_EXTENSION = ".log"
PLOT_PATH = "../log/plot/"
RTLS = ("SMM", "DIM")
MARKERS = {"SMM":"+", "DIM":"x"}
FORBIDDEN_CODE_NAME = ("AVERAGE", "THEORY")
COLUMN_HEADER=("-"*60, f"{' '*24}RTL   A  WWDL   Delay  Bench_name         Extracted   Alarm  Last_cycle  Last_addr")

CODE_NAMES = [
    'crc32',
    'cubic',
    'dhrystone',
    'edn',
    'fibonacci',
    'huffbench',
    'matmult-int',
    'md5sum',
    'minver',
    'mont64',
    'nbody',
    'nettle-aes',
    'nettle-sha256',
    'nsichneu',
    'picojpeg',
    'primecount',
    'qrduino',
    'sglib-combined',
    'slre',
    'st',
    'statemate',
    'tarfind',
    'ud',
    'wikisort']

parser = argparse.ArgumentParser(description="Script to analyse and plot clock cycle overheads as a function of WWDL (Worst Wanted Detection Latency).")
parser.add_argument("code_names")
parser.add_argument("-s","--save_fig", help="save a pdf of the plot", action="store_true")
parser.add_argument("-a","--average", help="Plot the average", action="store_true")
parser.add_argument(
    "-i",
    "--log_id",
    help="Give the ids of  old log files like ..._overhead-1.log",
    type=str, nargs='?', const='', default=''
)
parser.add_argument(
    "-l",
    "--log_path",
    help="Give the path of log file",
    type=str, nargs='?', const='', default=''
)
args = parser.parse_args()


def extract_overheads(code_name, log_file_path):
    '''
    Extract number of clock cycles on lines corresponding to <code_name> in <log_file_path>.

    Parameters
    ----------
    code_name : str
        Name of code to be extracted.
    log_file_path : str
        Path to log file.

    Returns
    ----------
    cycles_reference : int
        Number of clock cycles needed to execute <code_name> on unprotected core.
    cycles : dict of int
        Dict keys are countermeasures, values are clock cycles needed to execute
        <code_name> on protected core.
    '''
    with open(log_file_path, "r", encoding="utf-8") as log_file_overhead:
        log_overhead=log_file_overhead.read().split("\n")

    cycles_reference = -1
    cycles = {}
    for rtl in RTLS:
        cycles[rtl]=[]

    for line_overhead in log_overhead:
        if f" {code_name} " in line_overhead and line_overhead not in COLUMN_HEADER:
            line_overhead_split = line_overhead.split("|")
            line_overhead_list = [ll.replace(" ","") for ll in line_overhead_split if ll not in (" ", "")]
            if int(line_overhead_list[2]) == 0:  # no attack
                if line_overhead_list[1] == "INIT":
                    cycles_reference = int(line_overhead_list[-2])
                elif line_overhead_list[1] == "LAM":
                    raise ValueError("Error, the Linear Addressing Monitoring (lam_cv32e40p) causes zero-cycle overhead.")
                elif line_overhead_list[1] in RTLS:
                    cycles[line_overhead_list[1]].append([int(line_overhead_list[3]), int(line_overhead_list[-2])])

    # Remove empty RTL and sort by wwdl
    rtl_list = list(cycles.keys())
    for rtl in rtl_list:
        if cycles[rtl] == []:
            cycles.pop(rtl)
        else:
            cycles[rtl].sort()
    return cycles_reference, cycles



def get_overheads_codes(code_names, log_file_path):
    '''
    Get codes overhead.

    Parameters
    ----------
    code_names : list of str
        Names of all codes to be plotted.
    log_file_path : str
        Path to log file.

    Returns
    ----------
    wwdl : list of int
        List of worst wanted detection latency used.
    overheads : dict of dict of list of int
        Dict keys are rtl, dict of dict keys are code names. The lists are clock
        cycles needed to execute codes on core for the wwdl value at the same index.
    '''
    overheads = {}

    for code_name in code_names:
        cycles_reference, cycles = extract_overheads(code_name, log_file_path)

        # Compute overheads from number of clock cycles
        for rtl in cycles:
            if cycles_reference == -1:
                raise ValueError("You need to simulate execution without countermeasure.")

            if rtl not in overheads:
                overheads[rtl]={}
            overheads[rtl][code_name]=np.array([c[1]/cycles_reference for c in cycles[rtl]])
            if 'wwdl' not in locals():
                wwdl = [c[0] for c in cycles[rtl]]
            if wwdl != [c[0] for c in cycles[rtl]]:
                raise ValueError(f"Error, not same wwdl for all codes, {wwdl} is different from {[c[0] for c in cycles[rtl]]}.")

    # Compute average
    for rtl in overheads:
        average = np.zeros(len(wwdl))
        for code in list(overheads[rtl].keys()):
            average += np.array(overheads[rtl][code])
        overheads[rtl]["AVERAGE"]=average/len(overheads[rtl])

    # Compute theoritical estimation for SMM
    if "SMM" in overheads:
        overheads["SMM"]["THEORY"]=np.array([1/(1-2/(x-1)) for x in range (wwdl[0],wwdl[-1]+1)])

    return (wwdl, overheads)


def find_last_log_file_overhead():
    counter = 1
    path = f"{LOG_FILE_OVERHEAD_PATH}-{counter}{LOG_FILE_OVERHEAD_EXTENSION}"
    if not os.path.exists(path):
        raise ValueError("Log file overhead not already generate.")

    while os.path.exists(path):
        counter += 1
        path = f"{LOG_FILE_OVERHEAD_PATH}-{counter}{LOG_FILE_OVERHEAD_EXTENSION}"

    return f"{LOG_FILE_OVERHEAD_PATH}-{counter-1}{LOG_FILE_OVERHEAD_EXTENSION}"

def nb_to_percent(array):
    return ((array-1)*100)

def plot_clock_cycle_overheads(code_names):
    '''
    Plot clock cycle overheads in function of wwdl. One curve per code or the average
    can be plotted. Theritical estimation for SMM is plotted. Figure can be saved.

    Parameters
    ----------
    code_names : list of str
        Names of all codes to be plotted.
    '''
    # Plot setup
    plt.rc('font', family='serif')
    if args.save_fig:
        plt.figure(figsize=(5, 3))
    else:
        plt.figure(figsize=(9, 6))
    plt.axhline(y=0, color="black", linewidth=0.25)


    # Log overheads file
    if args.log_path == '':
        log_file_paths = [find_last_log_file_overhead()]
    elif args.log_id != '':
        log_ids = list(args.log_id.split(" "))
        log_file_paths = []
        for log_id in log_ids:
            log_file_paths.append(f"{LOG_FILE_OVERHEAD_PATH}-{log_id}{LOG_FILE_OVERHEAD_EXTENSION}")
    else:
        log_file_paths = list(args.log_path.split(" "))


    for log_file_path in log_file_paths:
        wwdl, overheads = get_overheads_codes(code_names, log_file_path)

        for rtl in overheads:
            if args.average :
                plt.plot(wwdl, nb_to_percent(overheads[rtl]["AVERAGE"]), f"k{MARKERS[rtl]}-", ms=5, linewidth=0.5, label=f"Average ({rtl})")

            else:
                for code in overheads[rtl]:
                    if code not in FORBIDDEN_CODE_NAME:
                        plt.plot(wwdl, nb_to_percent(overheads[rtl][code]), f"{MARKERS[rtl]}-", ms=5, linewidth=1, label=f'{code} ({rtl})')
            if rtl == "SMM":
                plt.plot([l for l in range(wwdl[0],wwdl[-1]+1)], nb_to_percent(overheads["SMM"]["THEORY"]), "k--", linewidth=1, label="Theoritical estimation (SMM)")

    # Setup layout, axes names
    leg=plt.legend()
    xmin, xmax, ymin, ymax = 4.5, 35, -5, 90
    plt.xlim([xmin, xmax])
    plt.ylim([ymin, ymax])
    plt.gca().invert_xaxis()
    plt.xlabel("Worst wanted detection latency (in instructions executed)")  #("Latency detection (in instructions)")
    plt.ylabel("Clock cycles overheads (%)")
    plt.tight_layout(pad=0.4, w_pad=0.5, h_pad=1.0)
    if args.save_fig:
        avg_mode = 'average__' if args.average else ""
        short_code_names = ""
        for code in overheads[overheads.keys()[0]]:
            short_code_names+=f"-{code}[0:3]" if code not in FORBIDDEN_CODE_NAME else ""
        plt.savefig(f"{PLOT_PATH}/plot_overheads_and_wwdls__range{int(xmin)}-{int(xmax)}__{avg_mode}f{short_code_names}.pdf")
    plt.show()

def main():
    '''Main'''
    # Filter arguments to detect "all"
    if args.code_names == "all":
        code_names = CODE_NAMES
    else:
        code_names = list(args.code_names.split(" "))

    if not set(code_names).isdisjoint(FORBIDDEN_CODE_NAME):
        raise ValueError(f"Codes shoudl not be named like this names {FORBIDDEN_CODE_NAME}.")

    plot_clock_cycle_overheads(code_names)


if __name__ == "__main__":
    main()
