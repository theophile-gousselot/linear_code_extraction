''' Script to analyse and plot BB len in benchmarks. '''

import argparse
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import style
style.use('tableau-colorblind10')

LOG_FILE_OVERHEAD = "../log/lce_overhead.log"
PLOT_PATH = "../log/plot/"

NEARLY_ALL_BENCHMARKS_NAME = [
    'csr_instructions',
    'dhrystone',
    'fibonacci',
    'hello-world',
    'illegal',
    'misalign']

ALL_BENCHMARKS_NAME = [
    'csr_instr_asm',
    'csr_instructions',
    'dhrystone',
    'fibonacci',
    'generic_exception_test',
    'hello-world',
    'illegal',
    'load_store_rs1_zero',
    'misalign']

parser = argparse.ArgumentParser(description="analyse BB of a bench")
parser.add_argument("bench_name")
parser.add_argument("-s","--save_fig", help="save a pdf of the plot", action="store_true")
parser.add_argument("-a","--average", help="Plot the average", action="store_true")
parser.add_argument(
    "-i",
    "--id",
    help="Give the id of an old log file like ..._overhead.~1~",
    type=int, nargs='?', const=-1, default=-1
)
parser.add_argument(
    "-l",
    "--log_path",
    help="Give the path of log file",
    type=str, nargs='?', const='', default=''
)
args = parser.parse_args()


def extract_overheads(benchmark_name, log_file_path):

    '''
    Parameters
    ----------
    itb_line : str
        Line of .itb file, which contains instructions data.

    Returns
    ----------
     _ : bool
        True if it is a discontinuity instruction.
    '''
    with open(log_file_path, "r", encoding="utf-8") as log_file_overhead:
        log_overhead=log_file_overhead.read().split("\n")

    cycles_reference = -1
    rtl=-1
    cycles_cm = []  # Cycle for countermeasures
    for line_overhead in log_overhead:
        if benchmark_name in line_overhead:
            line_overhead_split = line_overhead.split("|")
            line_overhead_list = [ll for ll in line_overhead_split if ll not in (" ", "")]
            if int(line_overhead_list[2]) == 0:
                if int(line_overhead_list[1]) == 0:
                    cycles_reference = int(line_overhead_list[-2])
                elif int(line_overhead_list[1]) == 11 or int(line_overhead_list[1]) == 2:
                    if rtl == -1:
                        rtl = int(line_overhead_list[1])
                    elif rtl != int(line_overhead_list[1]):
                        raise ValueError("Only one RTL number should be consider")

                    cycles_cm.append([int(line_overhead_list[3]), int(line_overhead_list[-2])])
    cycles_cm.sort()
    return cycles_reference, cycles_cm, rtl



def get_overhead_benchmarks(benchmarks_names, log_file_path):
    '''
    Get benchmarks overhead.

    Parameters
    ----------
    benchmarks_names : list of str
        Names of all benchmarks to be plotted.
    '''
    overhead = []
    rtl = -1
    for benchmark_name in benchmarks_names:
        cycles_reference, cycles_cm, rtl_tmp = extract_overheads(benchmark_name, log_file_path)
        rtl = rtl_tmp if rtl == -1 else rtl
        if rtl == 1:
            raise ValueError("Error, the Passive countermeasure (ldm1_cv32e40p) causo zero-cycle overhead.")
 
        if cycles_reference != -1:
            overhead.append([benchmark_name, [c[1]/cycles_reference for c in cycles_cm]])

            if 'latency' not in locals():
                latency = [c[0] for c in cycles_cm]
            if latency != [c[0] for c in cycles_cm]:
                raise ValueError("Error, not same latency (BB) for all benchmarks.")

    overhead_theoretical=[]
    for x in range (latency[0],latency[-1]+1):
        overhead_theoretical.append(1/(1-2/(x-1)))

    return (latency, overhead_theoretical, overhead, rtl)


def plot_cycles_overhead(benchmarks_names):
    '''
    Plot BB length of every benchmark given.

    Parameters
    ----------
    benchmarks_names : list of str
        Names of all benchmarks to be plotted.
    '''

    if args.log_path == '':
        log_files_path = [f"{LOG_FILE_OVERHEAD}"]
        if args.id != -1:
            log_files_path[0] += f".~{args.id}~"
    else:
        log_files_path = list(args.log_path.split(" "))

    plt.rc('font', family='serif')
    #plt.rc('xtick', labelsize='x-large')
    #plt.rc('ytick', labelsize='x-large')
    #plt.rc('text', usetex=True)
    if args.save_fig:
        plt.figure(figsize=(5, 3))
    else:
        plt.figure(figsize=(9, 6))

    plt.axhline(y=0, color="black", linewidth=0.25)

    for log_file_path in log_files_path:
        latency, overhead_theoretical, overhead, rtl = get_overhead_benchmarks(benchmarks_names, log_file_path)

        if args.average :
            avg_overhead = np.zeros(len(overhead[0][1]))
            bench_name = ''
            for o in overhead:
                avg_overhead += np.array(o[1])
                bench_name += f"-{o[0][0:3]}"
            avg_overhead = avg_overhead / len(overhead)
            if rtl == 11:
                label_text = "DIM"
                latency = np.array(latency[1:]) - 2
                avg_overhead = avg_overhead[1:]
                marker = "x"
            if rtl == 2:
                label_text = "SMM"
                marker = "+"
            plt.plot(latency, (np.array(avg_overhead)-1)*100, f"k{marker}-", ms=5, linewidth=0.5, label=f"Average ({label_text})")


            if rtl == 2:
                plt.plot([l for l in range(latency[0],latency[-1]+1)], (np.array(overhead_theoretical)-1)*100, "k--", linewidth=1, label="Theoritical estimation (SMM)")

        else:
            cut = 0
            if rtl == 11:
                label_text = "DIM"
                latency = np.array(latency[1:]) - 2
                cut = 1
                marker = "x"
            if rtl == 2:
                label_text = "SMM"
                marker = "+"
                plt.plot([l for l in range(latency[0],latency[-1]+1)], (np.array(overhead_theoretical)-1)*100, "k--", linewidth=1, label="Theoritical estimation (SMM)")
                #plt.plot(latency,(np.array(overhead_theoretical)-1)*100, "-", linewidth=20, alpha=0.4, label="Theoritical estimation (SMM)")

            bench_name = ''
            for o in overhead:
                plt.plot(latency, (np.array(o[1][cut:])-1)*100, f"{marker}-", ms=4, linewidth=1, label=f'{o[0]} ({label_text})')
                bench_name += f"-{o[0][0:3]}"


    leg=plt.legend()
    xmin, xmax, ymin, ymax = 4.5, 35, -5, 90
    plt.xlim([xmin, xmax])
    plt.ylim([ymin, ymax])
    plt.gca().invert_xaxis()
    plt.xlabel("Worst wanted detection latency (in instructions executed)")  #("Latency detection (in instructions)")
    plt.ylabel("Clock cycles overhead (%)")
    plt.tight_layout(pad=0.4, w_pad=0.5, h_pad=1.0)
    if args.save_fig:
        if args.average:
            avg_mode = 'average__'
        plt.savefig(f"{PLOT_PATH}/plot_latency_and_overhead__range{int(xmin)}-{int(xmax)}__{avg_mode}f{bench_name}.pdf")
    plt.show()

def main():
    '''Main'''
    # Filter arguments to detect "all"
    if args.bench_name == "all":
        benchmarks_names = ALL_BENCHMARKS_NAME
    elif args.bench_name == "nall":
        benchmarks_names = NEARLY_ALL_BENCHMARKS_NAME
    else:
        benchmarks_names = list(args.bench_name.split(" "))

    plot_cycles_overhead(benchmarks_names)


if __name__ == "__main__":
    main()
