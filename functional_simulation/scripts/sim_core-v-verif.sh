#!/bin/bash

LONG_VALID_ARGS=help,zzz,linear_memory_dump,delay_linear_memory_dump:,waves,verbose,ignore_instr_0,simulator:,firmwares:,attack_id:,rtl:,offset:,max_bb_len:,max_instr_exe_cycles:
SIMULATORS=(verilator vsim-run)
SIMULATOR=verilator
FIRMWARES=(csr_instr_asm csr_instructions dhrystone fibonacci generic_exception_test hello-world illegal load_store_rs1_zero misalign towers)
TB_TOP_FILE=tb_top_verilator.sv
LDM=false
LDM_DELAY=0
ATTACKS_ID=(0 1 2 3 4 5)
ATTACk_ID=0
RTL=(0 1 11 2)
RTL_FLAG="CV_CORE_BRANCH=init_cv32e40p"
ID_RTL_FLAG="--rtl 0"
ID_RTL=0

VALID_ARGS=$(getopt -o hzld:wvis:f:a:r:o:b:c: --long ${LONG_VALID_ARGS} -- "$@")
if [[ $? -ne 0 ]]; then
    exit 1;
fi

eval set -- "$VALID_ARGS"
while [ : ]; do
  case "$1" in
     -h | --help) echo -e "usage: sim_core-v-verif.sh \nArguments :\n${LONG_VALID_ARGS}"; exit; shift; ;;
     -z | --zzz) echo -e "usage: unuse argument"; exit; shift; ;;
     -w | --waves) WAVES_FLAG="WAVES=1"; shift; ;;
     -v | --verbose) VERBOSE_FLAG="--verbose"; shift; ;;
     -i | --ignore_instr_0) IGNORE_INSTR_0_FLAG="--ignore_instr_0"; shift; ;;
     -o | --offset) OFFSET=$2;  OFFSET_FLAG="--offset $2"; shift 2; ;;
     -l | --linear_memory_dump) LDM=true; LDM_FLAG="--ldm";  shift; ;;
     -d | --delay_linear_memory_dump) [[ $(($2)) != $2 ]] && echo "Error : --delay_linear_memory_dump [number of delay] should be an integer not $2" && exit
		LDM=true; LDM_DELAY=$2; LDM_FLAG="--ldm"; LDM_DELAY_FLAG="--delay_ldm $2"; shift 2; ;;

     -s | --simulator) [[ ! " ${SIMULATORS[@]} " =~ " $2 " ]] && echo "Error : Incorrect simulator, it should be one of ${SIMULATORS[@]}" && exit; SIMULATOR=$2
		[[ ${SIMULATOR} == "verilator" ]] && TB_TOP_FILE=tb_top_verilator.sv
		[[ ${SIMULATOR} == "vsim-run" ]] && TB_TOP_FILE=tb_top.sv
        shift 2; ;;

    -f | --firmwares)
		for firmware in $2
		do
			[[ ! " ${FIRMWARES[@]} " =~ " ${firmware} " ]] && echo "Error : Incorrect firmware name '${firmware}', it should be one of ${FIRMWARES[@]}" && exit
		done
        FIRMWARES=($2); shift 2; ;;

    -a | --attack_id)
	    [[ ! " ${ATTACKS_ID[@]} " =~ " $2 " ]] && echo "Error : Incorrect attack_id number '${attack_id}', it should be one of ${ATTACKS_ID[@]}" && exit
        ATTACK_ID=$2; ATTACK_ID_FOR_PYTHON=$2;
        if [[ ${ATTACK_ID} > 0 ]]; then
            LDM=true; LDM_FLAG="--ldm";
        else
            ATTACK_ID=1;
        fi       
        shift 2; ;;

    -r | --rtl)
		[[ ! " ${RTL[@]} " =~ " $2 " ]] && echo "Error : Incorrect rtl number '$2', it should be one of ${RTL[@]}" && exit
        if [[ $2 > 0 ]]; then
            RTL_FLAG="CV_CORE_BRANCH=ldm${2}_cv32e40p"
		    ID_RTL_FLAG="--rtl $2"
            ID_RTL=$2
        fi
        shift 2
        ;;
    -b | --max_bb_len) [[ $(($2)) != $2 ]] && echo "Error : --max_bb_len [MAX_BB_LEN] should be an integer not $2" && exit
        MAX_BB_LEN=$2; MAX_BB_LEN_FLAG="--max_bb_len $2"; shift 2; ;;
    -c | --max_instr_exe_cycles) [[ $(($2)) != $2 ]] && echo "Error : --max_instr_exe_cycles [MAX_INSTR_EXE_CYCLES] should be an integer not $2" && exit
        MAX_INSTR_EXE_CYCLES=$2; MAX_INSTR_EXE_CYCLES_FLAG="--max_instr_exe_cycles $2"; shift 2; ;;
    --) shift; break; ;;
  esac
done








# Constants
MAKE=make
PYTHON="python3"

# Core-v-verif directories
SIM_DIR=../core-v-verif/cv32e40p/sim/core/
SIM_RESULTS_DIR=../core-v-verif/cv32e40p/sim/core/sim_results/
TB_DIR=../core-v-verif/cv32e40p/tb/core/
BENCH_DIR=../core-v-verif/cv32e40p/tests/programs/custom/

# Files names
LINEAR_MEMORY_DUMP_FILE=memory_dump.txt
FIRMWARE_COMPARISON_SCRIPT_PYTHON=linear_memory_dump_analyse.py
ATTACKS_ID_FILE=attacks_id.txt

sed -i "s/define MAX_BB_LEN.*/define MAX_BB_LEN ${MAX_BB_LEN}/" ${TB_DIR}/${TB_TOP_FILE}
sed -i "s/define MAX_INSTR_EXE_CYCLES.*/define MAX_INSTR_EXE_CYCLES ${MAX_INSTR_EXE_CYCLES}/" ${TB_DIR}/${TB_TOP_FILE}

if [[ ${ID_RTL} > 0 ]]; then
    sed -i "s/define NOT_LDM_DETECTOR/define LDM_DETECTOR/" ${TB_DIR}/${TB_TOP_FILE}
else
    sed -i "s/define LDM_DETECTOR/define NOT_LDM_DETECTOR/" ${TB_DIR}/${TB_TOP_FILE}
fi


# Select the wire to inject fault
sed -i "s/force.*\/\/This line will be automatically changes.*/$(sed -n ${ATTACK_ID}p attacks_id.txt) \/\/This line will be automatically changes/" ${TB_DIR}/${TB_TOP_FILE}

for firmware in ${FIRMWARES[@]}
do
    # Print configuration
    echo -e "\n-------------------------------------------"
    echo -e "         Simulation configuration"
    echo -e "-------------------------------------------"
    echo -e "SIMULATOR              : ${SIMULATOR}"
    echo -e "VERBOSE                : \c"; if [ ! -z ${VERBOSE_FLAG} ]; then echo "yes"; else echo "no"; fi
    echo -e "WAVEFORM               : \c"; if [ ! -z ${WAVES_FLAG} ]; then echo "yes"; else echo "no"; fi
    echo -e "LDM                    : \c"; if [ ${LDM} == true ]; then echo "yes"; else echo "no"; fi
    echo -e "IGNORE INSTR. 00000000 : \c"; if [ ! -z ${IGNORE_INSTR_0_FLAG} ]; then echo "yes"; else echo "no"; fi
    echo -e "FIRMWARE               : ${firmware}"
    echo -e "RTL ID                 : ${ID_RTL}"
    echo -e "MAX_BB_LEN             : ${MAX_BB_LEN}"
    echo -e "MAX_INSTR_EXE_CYCLES   : ${MAX_INSTR_EXE_CYCLES}"
    echo -e "ATTACK ID              : ${ATTACK_ID}"
    echo -e "DELAY                  : ${LDM_DELAY}"
    echo -e "OFFSET COMPARISON      : ${OFFSET}"
    echo -e "-------------------------------------------\n"


    if [ ${LDM} = true ] ; then 
        SIZE=(`${RISCV}/bin/riscv32-corev-elf-size -Ax ${BENCH_DIR}/${firmware}/${firmware}.elf | grep .data`)
        MAXCYCLES=$(((${SIZE[1]}+${SIZE[2]})))
        MAXCYCLES=50000
        echo ${MAKE} -C ${SIM_DIR} ${SIMULATOR} TEST=${firmware} ${RTL_FLAG} ${WAVES_FLAG} VFLAG="\"+maxcycles=${MAXCYCLES}\" \"+delay_linear_dump=${LDM_DELAY}\" \"+rtl=${ID_RTL}\""
        ${MAKE} -C ${SIM_DIR} ${SIMULATOR} TEST=${firmware} ${RTL_FLAG} ${WAVES_FLAG} VFLAG="\"+maxcycles=${MAXCYCLES}\" \"+delay_linear_dump=${LDM_DELAY}\" \"+rtl=${ID_RTL}\""
        mkdir -p ${SIM_RESULTS_DIR}/${firmware}/linear_dump_memory/
        cp ${BENCH_DIR}/${firmware}/${firmware}.elf ${SIM_RESULTS_DIR}/${firmware}/linear_dump_memory/${firmware}.elf
        mv ${SIM_DIR}${LINEAR_MEMORY_DUMP_FILE} ${SIM_RESULTS_DIR}/${firmware}/linear_dump_memory/${firmware}_ldm.hex
    else
        ${MAKE} -C ${SIM_DIR} ${SIMULATOR} TEST=${firmware} ${RTL_FLAG} ${WAVES_FLAG} VFLAG="\"+rtl=${ID_RTL}\""
        echo ${MAKE} -C ${SIM_DIR} ${SIMULATOR} TEST=${firmware} ${RTL_FLAG} ${WAVES_FLAG} VFLAG="\"+rtl=${ID_RTL}\""
    fi
    echo ${PYTHON} ${FIRMWARE_COMPARISON_SCRIPT_PYTHON} ${firmware} ${VERBOSE_FLAG} ${IGNORE_INSTR_0_FLAG} ${ID_RTL_FLAG} ${OFFSET_FLAG} ${LDM_FLAG} ${LDM_DELAY_FLAG} --log --attack_id ${ATTACK_ID_FOR_PYTHON}
    ${PYTHON} ${FIRMWARE_COMPARISON_SCRIPT_PYTHON} ${firmware} ${VERBOSE_FLAG} ${IGNORE_INSTR_0_FLAG} ${ID_RTL_FLAG} ${OFFSET_FLAG} ${LDM_FLAG} ${LDM_DELAY_FLAG} ${MAX_BB_LEN_FLAG} ${MAX_INSTR_EXE_CYCLES_FLAG} --log --attack_id ${ATTACK_ID_FOR_PYTHON}
done
#mostlyclean:
#	$(MAKE) -C $(SIM_DIR) mostlyclean
#
#clean:
#	$(MAKE) -C $(SIM_DIR) clean


## Programs
#BLACK_LIST=all_csr_por
#FAIL_LIST=cv32e40p_csr_access_test cv32e40p_csr_access_test
#WHITE_LIST=csr_instr_asm csr_instructions dhrystone fibonacci generic_exception_test hello-world illegal illegal_instr_test load_store_rs1_zero misalign
#TARGETS=$(WHITE_LIST) #$(addprefix sim_, $(WHITE_LIST))
#
#ifdef LDM
##GET_TB_SIZE = TB_SIZE=`${RISCV}/bin/riscv32-corev-elf-size -A ${BENCH_DIR}/$@/$@.elf | grep data` && SV_TB_FLAGS="\"+maxcycles=${${$TB_SIZE} | awk '{print $3}'}" \"+linear_dump\""
#SV_TB_FLAGS = VFLAG="\"+maxcycles=10000\" \"+linear_dump\""
#endif
#
#
#
## Targets
#all: $(TARGETS)
#
#$(SIM_DIR)/Makefile: src/core-v-verif-cv32e40p_sim_core_Makefile
#	cp src/core-v-verif-cv32e40p_sim_core_Makefile $(SIM_DIR)/Makefile
#
#$(TARGETS): $(SIM_DIR)/Makefile
#	cp src/core-v-verif-cv32e40p_sim_core_Makefile $(SIM_DIR)/Makefile
#	$(MAKE) -C $(SIM_DIR) $(SIMULATOR) TEST=$@ $(SIM_MAKE_FLAGS)
#		
#	
#linear_memory_dump_analyse:
#
