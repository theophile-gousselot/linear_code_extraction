''' Script to compare the dumped firmware to the original.'''
import argparse
import binascii
import subprocess
import re
from datetime import datetime

###### Arguments ######
parser = argparse.ArgumentParser(description="compare the dumped firmware to the original")
parser.add_argument("bench_name")
parser.add_argument("-v","--verbose", help="increase output verbosity", action="store_true")
parser.add_argument("-l","--log", help="write log into file_log", action="store_true")
parser.add_argument(
    "-i",
    "--ignore_instr_0",
    help="ignore instructions equal to 0x00000000",
    action="store_true"
)
parser.add_argument("-ldm", "--ldm", help="ldm done ?", action="store_true")
parser.add_argument(
    "-b",
    "--max_bb_len",
    help="max_bb_len of ldm_detector",
    type=int, nargs='?', const=20, default=20
)
parser.add_argument(
    "-c",
    "--max_instr_exe_cycles",
    help="max_instr_exe_cycles of ldm_detector",
    type=int, nargs='?', const=35, default=35
)
parser.add_argument(
    "-a",
    "--attack_id",
    help="specify the attack path to the log file",
    type=str, nargs='?', const=" ", default=" "
)
parser.add_argument(
    "-r",
    "--rtl",
    help="specify the rtl id to the log file",
    type=int, nargs='?', const=0, default=0
)
parser.add_argument(
    "-o",
    "--offset",
    help="specify an offset between the original firmware and the dumped",
    type=int, nargs='?', const=0, default=0
)
parser.add_argument(
    "-d",
    "--delay_ldm",
    help="specify a delay before begining to force wire",
    type=int, nargs='?', const=0, default=0
)
args = parser.parse_args()


##### Paths ######
SIM_DIR = "../core-v-verif/cv32e40p/sim/core/"
SIM_RES_DIR = f"{SIM_DIR}/sim_results/"
TEST_DIR = "../core-v-verif/cv32e40p/tests/programs/custom/"
GCC_SIZE = "/opt/corev/bin/riscv32-corev-elf-size"
LOG_FILE_PATH = "../log/linear_dump_attack.log"
ALARM_LOG_FILE = "ldm_detector_alarm_log.txt"
FINAL_CYCLE_FILE = "final_cycle_log.txt"
FINAL_ADDR_FILE = "final_addr_log.txt"


##### String #####
LOG_COL_NAMES = f"{' '*23}RTL  A   BB  Instr  Delay  Bench_name              Dump   Alarm  Last_cycle  Last_addr"
COLUMNS_NAMES_EVERY = 46


#### Print/write functions ######
def print_column_names():
    ''' Print names of columns. '''
    if args.verbose and args.ldm :
        print(f"{'-'*60}\n  Address          Firmware         #unmatched  #ignored\n",
            f" (hexa)     original     dumped      instr.     instr.\n{'-'*60}")

def print_success_dump(card_unmatched_instr):

    ''' Print percentage of dumped firmware. '''
    if args.verbose and args.ldm :
        print(f"\n Success dump {args.bench_name} : {card_unmatched_instr}")

def write_logs(card_unmatched_instr):
    ''' Write data in log file. '''
    with open(f"{SIM_DIR}/{FINAL_CYCLE_FILE}", "r", encoding="utf-8") as final_cycle_file:
        final_cycle_read = final_cycle_file.read()
    final_cycle = str(int(final_cycle_read)) if len(final_cycle_read)>0 else ""

    with open(f"{SIM_DIR}/{FINAL_ADDR_FILE}", "r", encoding="utf-8") as final_addr_file:
        final_addr_read = final_addr_file.read()
    final_addr = hex(int(final_addr_read)) if len(final_addr_read)>0 else ""

    if args.log:
        if args.rtl > 0:
            with open(f"{SIM_DIR}/{ALARM_LOG_FILE}", "r", encoding="utf-8") as alarm_file:
                alarm_log = alarm_file.read()
                alarm_cycle = '' if len(alarm_log) == 0 else int(alarm_log)

            max_bb_len = args.max_bb_len
            max_instr_exe_cycles = args.max_instr_exe_cycles

        else:
            alarm_cycle = ""
            max_bb_len = ""
            max_instr_exe_cycles = ""

        # Create file if it dosen't exist
        with open(LOG_FILE_PATH, 'a+', encoding="utf-8") as log_file :
            None

        with open(LOG_FILE_PATH, 'r', encoding="utf-8") as log_file :
            log = log_file.read()
        log_list = list(log.split('\n'))
        log_list.reverse()
        if LOG_COL_NAMES not in log_list or log_list.index(LOG_COL_NAMES) > COLUMNS_NAMES_EVERY:
            with open(LOG_FILE_PATH, 'a+', encoding="utf-8") as log_file :
                log_file.write(f"{'-'*len(LOG_COL_NAMES)}\n{LOG_COL_NAMES}\n{'-'*len(LOG_COL_NAMES)}\n")

        with open(LOG_FILE_PATH, 'a+', encoding="utf-8") as log_file :
            log_file.write(f"[{str(datetime.now())[:-7]}] |{args.rtl:>2}|"+
                f" |{args.attack_id}|"+ 
                f" |{max_bb_len:>2}| |{max_instr_exe_cycles:>2}|"+
                f" |{args.delay_ldm:>6}| {args.bench_name:<22}"+
                f" {card_unmatched_instr:>5} |{alarm_cycle:>6}|"+
                f" |{final_cycle:>8}| |{final_addr:>8}|\n")

##### Firmwares comparison #####
def load_firmwares(bench_name):
    '''
    Load firmware intital (vo) and extracted (bin)

    Parameters
    ----------
    bench_name : str
        Name of the benchmark.

    Returns
    ----------
    vo_firm : bytes
        The original firmware.
    ldm_firm : bytes
        The dumped firmware by linear dump memory. For an unknown reason there
        are 0xa0a0 between ervry groups of 4 bytes, these 0xa0a0 are remove.

    '''
    with open(f"{TEST_DIR}/{bench_name}/{bench_name}.elf",'rb') as vo_file :
        vo_firm = binascii.hexlify(vo_file.read())

    with open(f"{SIM_RES_DIR}/{bench_name}/linear_dump_memory/{bench_name}_ldm.hex",'rb') as ldm_file :
        ldm_firm_untreated = binascii.hexlify(ldm_file.read())

    # Remove 0x0a0a between every 4 bytes of dumped firmware
    ldm_firm=b''
    for index in range (len(ldm_firm_untreated)):
        if index%12<8:
            ldm_firm+=ldm_firm_untreated[index:index+1]

    return (vo_firm, ldm_firm)

def get_bench_section_size_addr(bench_name):
    '''
    Get section size and address of bench_name with gcc_size

    Parameters
    ----------
    bench_name : str
        Name of the benchmark.

    Returns
    ----------
    firm_size_addr : dict
        Keys are sections names and values are size and addr of sections.

    '''
    firm_size_addr_cmd = subprocess.run([GCC_SIZE,
        f"{TEST_DIR}/{bench_name}/{bench_name}.elf", "-A"],
        capture_output=True, text=True, check=True)
    firm_size_addr_tmp=list(filter(('').__ne__, list(re.sub(' +', ';',
        firm_size_addr_cmd.stdout).split("\n"))))
    firm_size_addr = {}
    for line in firm_size_addr_tmp:
        line_split=list(line.split(";"))
        if line_split[0][0] == "." and line_split[0][1].isalpha():
            firm_size_addr.update({line_split[0]:list(map(int,line_split[1:]))})
        else:
            firm_size_addr.update({line_split[0]:line_split[1:]})
    return firm_size_addr


def parse_firm():
    '''
    Parameters
    ----------
    Given by args.

    Returns
    ----------
    card_unmatched_instr : int
        Cardinal (=number) of different instruction between original and
        dumped firmwares.

    Remarks
    ----------
    o_ : offset
    i_ : index
    o_ldm_i0 : offset for ldm due to instruction 0 ignorance

    '''
    vo_firm, ldm_firm = load_firmwares(args.bench_name)
    firm_size_addr=get_bench_section_size_addr(args.bench_name)

    o_ldm_i0 = 0  # offset for ldm due to instruction 0 ignorance
    i_4b = 0  # index counting groups of 4 bits
    o_address = 0x80

    # Apply offset given by the user
    if args.offset >= 0:
        o_vo=1056*8
        o_ldm=firm_size_addr['.init'][1]-0x40 + args.offset*2
    else:
        o_vo=1056*8 - args.offset*2
        o_ldm=firm_size_addr['.init'][1]-0x40

    card_unmatched_instr=0
    i_4b_max =  firm_size_addr['.init'][0]*2 + firm_size_addr['.text'][0]*2 + args.offset*2

    # Compare both firmware
    while i_4b <= i_4b_max:
        if args.ignore_instr_0 and ldm_firm[o_ldm+i_4b+o_ldm_i0:o_ldm+i_4b+o_ldm_i0+8] == b'00000000':
            o_ldm_i0 += 8
        else:
            if vo_firm[o_vo+i_4b:o_vo+i_4b+8] != ldm_firm[o_ldm+i_4b+o_ldm_i0:o_ldm+i_4b+o_ldm_i0+8]:
                card_unmatched_instr += 1

            if args.verbose:
                print(f"{str(hex(i_4b//2+o_address)):>8}:"
                    +f"    {str(vo_firm[o_vo+i_4b:o_vo+i_4b+8])[2:-1]:>8}"
                    +f"    {str(ldm_firm[o_ldm+i_4b+o_ldm_i0:o_ldm+i_4b+o_ldm_i0+8])[2:-1]:>8}"
                    +f"       {card_unmatched_instr:<6}     {o_ldm_i0//8}")
            i_4b += 8
    return(str(100-card_unmatched_instr*100*8//i_4b) + " %")

def main():
    ''' Main '''
    print_column_names()
    if args.ldm:
        card_unmatched_instr = parse_firm()
    else:
        card_unmatched_instr = ""

    print_success_dump(card_unmatched_instr)
    print_column_names()
    write_logs(card_unmatched_instr)

if __name__ == "__main__":
    main()
