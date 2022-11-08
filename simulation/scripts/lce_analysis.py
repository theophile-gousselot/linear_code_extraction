''' Script to compare the extracted code to the original.'''
import argparse
import binascii
import subprocess
import re
import os
from datetime import datetime

###### Arguments ######
parser = argparse.ArgumentParser(description="compare the extracted code to the original")
parser.add_argument("code_name")
parser.add_argument("-v","--verbose", help="increase output verbosity", action="store_true")
parser.add_argument("-o","--overhead", help="save logs on overhead log file", action="store_true")
parser.add_argument("-c","--create_overhead_log", help="save logs on overhead log file", action="store_true")
parser.add_argument(
    "-i",
    "--ignore_instr_0",
    help="ignore instructions equal to 0x00000000",
    action="store_true"
)
parser.add_argument("-lce", "--lce", help="lce done ?", action="store_true")
parser.add_argument(
    "-l",
    "--wwdl",
    help="wwdl of lce_detector",
    type=int, nargs='?', const=20, default=20
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
    type=str, nargs='?', const="INIT", default="INIT",
    choices=['INIT', 'LAM', 'SMM', 'DIM']
)
parser.add_argument(
    "-d",
    "--delay_lce",
    help="specify a delay before begining to force wire",
    type=int, nargs='?', const=0, default=0
)
args = parser.parse_args()


##### Paths ######
SIM_DIR = "../core-v-verif/cv32e40p/sim/core/"
SIM_RES_DIR = f"{SIM_DIR}/sim_results/"
TEST_DIR = "../core-v-verif/cv32e40p/tests/programs/custom/"
GCC_SIZE = "/opt/corev/bin/riscv32-corev-elf-size"
LCE_FOLDER = "/lce/"
LOG_FILE_PATH = "../log/lce.log"
LOG_FILE_OVERHEAD_PATH = "../log/lce_overhead"
LOG_FILE_OVERHEAD_EXTENSION = ".log"
ALARM_LOG_FILE = "lce_detector_alarm_log.txt"
FINAL_CYCLE_FILE = "final_cycle_log.txt"
FINAL_ADDR_FILE = "final_addr_log.txt"

COMP_LENGTH = 16

##### String #####
LOG_COL_NAMES = f"{' '*24}RTL   A  WWDL   Delay   Code_name         Extracted   Alarm  Last_cycle  Last_addr"
COLUMNS_NAMES_EVERY = 25


#### Print/write functions ######
def print_column_names():
    ''' Print names of columns. '''
    if args.verbose and args.lce :
        print(f"{'-'*60}\n  Address            Code          #mismatched  #ignored\n",
            f" (hexa)     original   extracted     instr.     instr.\n{'-'*60}")

def print_success_to_extract(card_unmatched_instr):

    ''' Print percentage of extracted code. '''
    if args.verbose and args.lce :
        print(f"\n Success to extract {args.code_name} : {card_unmatched_instr}")

def index_log_file_overhead():
    filename, extension = LOG_FILE_OVERHEAD_PATH, LOG_FILE_OVERHEAD_EXTENSION
    counter = 1
    path = f"{filename}-{counter}{extension}"
    while os.path.exists(path):
        counter += 1
        path = f"{filename}-{counter}{extension}"
    if not args.create_overhead_log:
        counter = counter - 1
    print(f"{filename}-{counter}{extension}")
    return f"{filename}-{counter}{extension}"



def write_logs(card_unmatched_instr):
    ''' Write data in log file. '''
    with open(f"{SIM_DIR}/{FINAL_CYCLE_FILE}", "r", encoding="utf-8") as final_cycle_file:
        final_cycle_read = final_cycle_file.read()
    final_cycle = str(int(final_cycle_read)) if len(final_cycle_read)>0 else ""

    with open(f"{SIM_DIR}/{FINAL_ADDR_FILE}", "r", encoding="utf-8") as final_addr_file:
        final_addr_read = final_addr_file.read()
    final_addr = hex(int(final_addr_read)) if len(final_addr_read)>0 else ""

    if args.rtl != "INIT":
        with open(f"{SIM_DIR}/{ALARM_LOG_FILE}", "r", encoding="utf-8") as alarm_file:
            alarm_log = alarm_file.read()
            alarm_cycle = '' if len(alarm_log) == 0 else int(alarm_log)

        wwdl = args.wwdl

    else:
        alarm_cycle = ""
        wwdl = ""

    log_file_path = index_log_file_overhead() if args.overhead else LOG_FILE_PATH

    # Create file if it dosen't exist
    with open(log_file_path, 'a+', encoding="utf-8") as log_file :
        None

    with open(log_file_path, 'r', encoding="utf-8") as log_file :
        log = log_file.read()
    log_list = list(log.split('\n'))
    log_list.reverse()
    if LOG_COL_NAMES not in log_list or log_list.index(LOG_COL_NAMES) > COLUMNS_NAMES_EVERY:
        with open(log_file_path, 'a+', encoding="utf-8") as log_file :
            log_file.write(f"{'-'*len(LOG_COL_NAMES)}\n{LOG_COL_NAMES}\n{'-'*len(LOG_COL_NAMES)}\n")

    with open(log_file_path, 'a+', encoding="utf-8") as log_file :
        log_file.write(f"[{str(datetime.now())[:-7]}] |{args.rtl:>4}|"+
            f" |{args.attack_id}|"+ 
            f" |{wwdl:>2}|"+
            f" |{args.delay_lce:>6}| {args.code_name:<22}"+
            f" {card_unmatched_instr:>5} |{alarm_cycle:>6}|"+
            f" |{final_cycle:>8}| |{final_addr:>8}|\n")

##### Codes comparison #####
def load_codes(code_name):
    '''
    Load code intital (vo) and extracted (bin)

    Parameters
    ----------
    code_name : str
        Name of the code.

    Returns
    ----------
    vo_firm : bytes
        The original code.
    lce_firm : bytes
        The extracted code by LCE. For an unknown reason there
        are 0xa0a0 between ervry groups of 4 bytes, these 0xa0a0 are remove.

    '''
    with open(f"{TEST_DIR}/{code_name}/{code_name}.elf",'rb') as vo_file :
        vo_firm = binascii.hexlify(vo_file.read())

    with open(f"{SIM_RES_DIR}/{code_name}/{LCE_FOLDER}/{code_name}_lce.hex",'rb') as lce_file :
        lce_firm_untreated = binascii.hexlify(lce_file.read())

    # Remove 0x0a0a between every 4 bytes of extracted code
    lce_firm=b''
    for index in range (len(lce_firm_untreated)):
        if index%12<8:
            lce_firm+=lce_firm_untreated[index:index+1]

    return (vo_firm, lce_firm)

def get_code_section_size_addr(code_name):
    '''
    Get section size and address of code_name with gcc_size

    Parameters
    ----------
    code_name : str
        Name of the code.

    Returns
    ----------
    firm_size_addr : dict
        Keys are sections names and values are size and addr of sections.

    '''
    firm_size_addr_cmd = subprocess.run([GCC_SIZE,
        f"{TEST_DIR}/{code_name}/{code_name}.elf", "-A"],
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
        extracted codes.

    Remarks
    ----------
    i_ : index
    o_lce_i0 : offset for lce due to instruction 0 ignorance

    '''
    vo_firm, lce_firm = load_codes(args.code_name)
    firm_size_addr=get_code_section_size_addr(args.code_name)

    o_lce_i0 = 0  # offset for lce due to instruction 0 ignorance
    i_4b = 0  # index counting groups of 4 bits
    o_address = 0x80

    # Apply offset given by the user
    #if args.offset >= 0:
    #    o_vo=1056*8
    #    o_lce=firm_size_addr['.init'][1]-0x40 + args.offset*2
    #else:
    o_vo=1056*8
    o_lce=firm_size_addr['.init'][1]-0x40

    card_unmatched_instr=0
    i_4b_max =  firm_size_addr['.init'][0]*2 + firm_size_addr['.text'][0]*2# + args.offset*2


    fuse_error = True if args.delay_lce else False
    # Compare both code
    while i_4b <= i_4b_max:
        if args.ignore_instr_0 and lce_firm[o_lce+i_4b+o_lce_i0:o_lce+i_4b+o_lce_i0+8] == b'00000000':
            o_lce_i0 += 8
            if args.verbose:
                print(f"        :"
                    +f"    {str(vo_firm[o_vo+i_4b:o_vo+i_4b+8])[2:-1]:>8}"
                    +f"    {str(lce_firm[o_lce+i_4b+o_lce_i0:o_lce+i_4b+o_lce_i0+8])[2:-1]:>8}"
                    +f"       {card_unmatched_instr:<6}     {o_lce_i0//8}   # wait instruction 00000000")

        elif lce_firm[o_lce+i_4b+o_lce_i0:o_lce+i_4b+o_lce_i0+8] == b'6f000000':
            #if lce_firm[o_lce+i_4b+o_lce_i0+8:o_lce+i_4b+o_lce_i0+16] != b'00000000':
            i_4b+=8

            max_security_marker_exec_cycle = 5
            security_marker_exec_cycle = 1
            while (vo_firm[o_vo+i_4b:o_vo+i_4b+COMP_LENGTH] != lce_firm[o_lce+i_4b+o_lce_i0:o_lce+i_4b+o_lce_i0+COMP_LENGTH] and i_4b <= i_4b_max and lce_firm[o_lce+i_4b+o_lce_i0:o_lce+i_4b+o_lce_i0+COMP_LENGTH] != b'' and security_marker_exec_cycle < max_security_marker_exec_cycle):

                if args.ignore_instr_0 and lce_firm[o_lce+i_4b+o_lce_i0:o_lce+i_4b+o_lce_i0+8] == b'00000000':
                    o_lce_i0 += 8
                    if args.verbose:
                        print(f"        :"
                            +f"    {str(vo_firm[o_vo+i_4b:o_vo+i_4b+8])[2:-1]:>8}"
                            +f"    {str(lce_firm[o_lce+i_4b+o_lce_i0:o_lce+i_4b+o_lce_i0+8])[2:-1]:>8}"
                            +f"       {card_unmatched_instr:<6}     {o_lce_i0//8}   # wait instruction 00000000")


                else:
                    if args.verbose:
                        print(f"        :"
                            +f"    {str(vo_firm[o_vo+i_4b:o_vo+i_4b+8])[2:-1]:>8}"
                            +f"    {str(lce_firm[o_lce+i_4b+o_lce_i0:o_lce+i_4b+o_lce_i0+8])[2:-1]:>8}"
                            +f"       {card_unmatched_instr:<6}     {o_lce_i0//8}   # wait the end of security marker exec")
                    security_marker_exec_cycle += 1
                    o_lce+=8
        else:
            if vo_firm[o_vo+i_4b:o_vo+i_4b+8] != lce_firm[o_lce+i_4b+o_lce_i0:o_lce+i_4b+o_lce_i0+8]:
                if fuse_error:
                    fuse_error = False

                    # When jump over exit instructions, comparison has to be synchonize by increasing original 
                    # code until they fit again or until they reach and of comparison or end of lce_firm 
                    # is reach
                    while (vo_firm[o_vo+i_4b:o_vo+i_4b+COMP_LENGTH] != lce_firm[o_lce+i_4b+o_lce_i0:o_lce+i_4b+o_lce_i0+COMP_LENGTH] and i_4b <= i_4b_max and lce_firm[o_lce+i_4b+o_lce_i0:o_lce+i_4b+o_lce_i0+COMP_LENGTH] != b''):
                        if args.verbose:
                            print(f"{str(hex(i_4b//2+o_address)):>8}:"
                                +f"    {str(vo_firm[o_vo+i_4b:o_vo+i_4b+8])[2:-1]:>8}"
                                +f"    {str(lce_firm[o_lce+i_4b+o_lce_i0:o_lce+i_4b+o_lce_i0+8])[2:-1]:>8}"
                                +f"       {card_unmatched_instr:<6}     {o_lce_i0//8}   # wait the jump destination")
                        i_4b+=8
                        o_lce-=8
                        card_unmatched_instr += 1
                else:
                    card_unmatched_instr += 1

            if args.verbose:
                print(f"{str(hex(i_4b//2+o_address)):>8}:"
                    +f"    {str(vo_firm[o_vo+i_4b:o_vo+i_4b+8])[2:-1]:>8}"
                    +f"    {str(lce_firm[o_lce+i_4b+o_lce_i0:o_lce+i_4b+o_lce_i0+8])[2:-1]:>8}"
                    +f"       {card_unmatched_instr:<6}     {o_lce_i0//8}")
            i_4b += 8
    return(str(100-card_unmatched_instr*100*8//i_4b) + " %")

def main():
    ''' Main '''
    print_column_names()
    if args.lce:
        card_unmatched_instr = parse_firm()
    else:
        card_unmatched_instr = ""

    print_success_to_extract(card_unmatched_instr)
    print_column_names()
    write_logs(card_unmatched_instr)

if __name__ == "__main__":
    main()
