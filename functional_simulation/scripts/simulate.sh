#!/bin/bash


echo_then_exe() { echo "\$ $@" ; "$@" ; }



##### Constants and paths
MAKE=make
PYTHON="python3"
# Core-v-verif directories
SIM_DIR=../core-v-verif/cv32e40p/sim/core/
SIM_RESULTS_DIR=../core-v-verif/cv32e40p/sim/core/sim_results/
TB_DIR=../core-v-verif/cv32e40p/tb/core/
CODE_DIR=../core-v-verif/cv32e40p/tests/programs/custom/
LCE_FOLDER=/lce/
# Files names
EXTRACTED_CODE_FILE=extracted_code.txt
CODE_COMPARISON_SCRIPT_PYTHON=lce_analysis.py
STRATEGIES_FILE=lce_strategies.txt


##### Valid arguments
SIMULATORS=(verilator vsim-run)
ATTACKS_ID=(0 1 2 3)
RTLS=(INIT LAM SMM DIM)
CODES=(dhrystone fibonacci)
LONG_VALID_ARGS=help,zzz,delay_lce:,waves,verbose,ignore_instr_0,overhead,create_overhead_log,simulator:,codes:,attack_id:,rtl:,offset:,wwdl:


##### Default arguments
SIMULATOR=verilator
TB_TOP_FILE=tb_top_verilator.sv
LCE=false
LCE_DELAY=0
ATTACk_ID=0
RTL_FLAG="CV_CORE_BRANCH=init_cv32e40p"
ID_RTL_FLAG="--rtl INIT"
RTL="INIT"
MONITORING=0


##### Argument analysis
VALID_ARGS=$(getopt -o hzd:wviecs:f:a:r:o:l: --long ${LONG_VALID_ARGS} -- "$@")
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
     -e | --overhead) OVERHEAD_FLAG="--overhead"; shift; ;;
     -c | --create_overhead_log) CREATE_OVERHEAD_LOG_FLAG="--create_overhead_log"; shift; ;;
     -o | --offset) OFFSET=$2;  OFFSET_FLAG="--offset $2"; shift 2; ;;
     -d | --delay_lce) [[ $(($2)) != $2 ]] && echo "Error : --delay_lce [number of delay] should be an integer not $2" && exit
		LCE=true; LCE_DELAY=$2; LCE_FLAG="--lce"; LCE_DELAY_FLAG="--delay_lce $2"; shift 2; ;;

     -s | --simulator) [[ ! " ${SIMULATORS[@]} " =~ " $2 " ]] && echo "Error : Incorrect simulator, it should be one of ${SIMULATORS[@]}" && exit; SIMULATOR=$2
		[[ ${SIMULATOR} == "verilator" ]] && TB_TOP_FILE=tb_top_verilator.sv
		[[ ${SIMULATOR} == "vsim-run" ]] && TB_TOP_FILE=tb_top.sv
        shift 2; ;;

    -f | --codes)
# Don't check !
#		for code in $2
#		do
#			[[ ! " ${CODES[@]} " =~ " ${code} " ]] && echo "Error : Incorrect code name '${code}', it should be one of ${CODES[@]}" && exit
#		done
        CODES=($2); shift 2; ;;

    -a | --attack_id)
	    [[ ! " ${ATTACKS_ID[@]} " =~ " $2 " ]] && echo "Error : Incorrect attack_id number '${attack_id}', it should be one of ${ATTACKS_ID[@]}" && exit
        ATTACK_ID=$2; ATTACK_ID_FOR_PYTHON=$2;
        if [[ ${ATTACK_ID} > 0 ]]; then
            LCE=true; LCE_FLAG="--lce";
        else
            ATTACK_ID=1;
        fi       
        shift 2; ;;

    -r | --rtl)
		[[ ! " ${RTLS[@]} " =~ " $2 " ]] && echo "Error : Incorrect rtl number '$2', it should be one of ${RTLS[@]}" && exit
        if [[ ! $2 == "INIT" ]]; then
            RTL_FLAG="CV_CORE_BRANCH=${2,,}_cv32e40p";
		    ID_RTL_FLAG="--rtl ${2}";
            MONITORING=1;
            RTL=$2;
        fi
        shift 2
        ;;
    -l | --wwdl) 
        [[ $(($2)) != $2 ]] && echo "Error : the worst wanted detection latency --wwdl [WWDL] should be an integer not $2" && exit
        WWDL=$2; WWDL_FLAG="--wwdl $2"; shift 2; ;;
    --) shift; break; ;;
  esac
done


##### Simulation setup
# test code configuration
sed -i "s/define WWDL.*/define WWDL ${WWDL}/" ${TB_DIR}/${TB_TOP_FILE}
if [[ ${MONITORING} == 1 ]]; then
    sed -i "s/define NOT_LCE_DETECTOR/define LCE_DETECTOR/" ${TB_DIR}/${TB_TOP_FILE}
else
    sed -i "s/define LCE_DETECTOR/define NOT_LCE_DETECTOR/" ${TB_DIR}/${TB_TOP_FILE}
fi
# Linear extraction strategies
if [[ ${LCE} == true ]]; then
    sed -i "s/.*\/\/This line will be automatically changes/                $(sed -n ${ATTACK_ID}p ${STRATEGIES_FILE}) \/\/This line will be automatically changes/" ${TB_DIR}/${TB_TOP_FILE}
else
    sed -i "s/.*\/\/This line will be automatically changes/                \/\/This line will be automatically changes/" ${TB_DIR}/${TB_TOP_FILE}
fi




##### Running the imulation
for code in ${CODES[@]}
do
    # Print configuration
    echo -e "\n-------------------------------------------"
    echo -e "         Simulation configuration"
    echo -e "-------------------------------------------"
    echo -e "SIMULATOR              : ${SIMULATOR}"
    echo -e "VERBOSE                : \c"; if [ ! -z ${VERBOSE_FLAG} ]; then echo "yes"; else echo "no"; fi
    echo -e "WAVEFORM               : \c"; if [ ! -z ${WAVES_FLAG} ]; then echo "yes"; else echo "no"; fi
    echo -e "LCE                    : \c"; if [ ${LCE} == true ]; then echo "yes"; else echo "no"; fi
    echo -e "IGNORE INSTR. 00000000 : \c"; if [ ! -z ${IGNORE_INSTR_0_FLAG} ]; then echo "yes"; else echo "no"; fi
    echo -e "CODE                   : ${code}"
    echo -e "RTL                    : ${RTL}"
    echo -e "WWDL                   : ${WWDL}"
    echo -e "ATTACK ID              : ${ATTACK_ID}"
    echo -e "DELAY                  : ${LCE_DELAY}"
    echo -e "OFFSET COMPARISON      : ${OFFSET}"
    echo -e "-------------------------------------------\n"


    if [ ${LCE} = true ] ; then 
        # The simulation max cycle is computed considering the executed code
        [ ! -f ${CODE_DIR}/${code}/${code}.elf ] && echo "Please compile ${code} without attack for the first execution (use -a 0)" && exit
        SIZE=(`${RISCV}/bin/riscv32-corev-elf-size -Ax ${CODE_DIR}/${code}/${code}.elf | grep .data`)
        MAXCYCLES=$(((${SIZE[1]}+${SIZE[2]})))

        # Launch simulation
        echo_then_exe ${MAKE} -C ${SIM_DIR} ${SIMULATOR} TEST=${code} ${RTL_FLAG} ${WAVES_FLAG} VFLAG="\"+maxcycles=${MAXCYCLES}\" \"+lce_delay=${LCE_DELAY}\"" #\"+rtl=${ID_RTL}\""

        # Save initial and extracted codes
        mkdir -p ${SIM_RESULTS_DIR}/${code}/${LCE_FOLDER}
        cp ${CODE_DIR}/${code}/${code}.elf ${SIM_RESULTS_DIR}/${code}/${LCE_FOLDER}/${code}.elf
        mv ${SIM_DIR}${EXTRACTED_CODE_FILE} ${SIM_RESULTS_DIR}/${code}/${LCE_FOLDER}/${code}_lce.hex
    else
        # Launch simulation without LCE
        echo_then_exe ${MAKE} -C ${SIM_DIR} ${SIMULATOR} TEST=${code} ${RTL_FLAG} ${WAVES_FLAG} # VFLAG="\"+rtl=${ID_RTL}\""
    fi

    # Python simulation analysis: save outputs into log files
    echo_then_exe ${PYTHON} ${CODE_COMPARISON_SCRIPT_PYTHON} ${code} ${VERBOSE_FLAG} ${IGNORE_INSTR_0_FLAG} ${ID_RTL_FLAG} ${OFFSET_FLAG} ${LCE_FLAG} ${LCE_DELAY_FLAG} ${WWDL_FLAG} --attack_id ${ATTACK_ID_FOR_PYTHON} ${OVERHEAD_FLAG} ${CREATE_OVERHEAD_LOG_FLAG}
done
