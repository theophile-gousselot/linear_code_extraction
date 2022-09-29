#!/bin/bash

LONG_VALID_ARGS=rtl:,bb_len:,firmwares:,no_plot_cycling_overhead:,log_name_file:
VALID_ARGS=$(getopt -o r:b:f:pn: --long ${LONG_VALID_ARGS} -- "$@")
if [[ $? -ne 0 ]]; then
    exit 1;
fi


eval set -- "$VALID_ARGS"
while [ : ]; do
  case "$1" in
    -r | --rtl) RTL=$2;echo ${RTL[@]}; echo $2; shift 2; ;;
    -b | --bb_len) BB_LEN=$2; shift 2; ;;
    -f | --firmwares) FIRMWARES=$2; shift 2; ;;
    -p | --no_plot_cycling_overhead) PLOT_CYCLING_OVERHEAD=0; shift 1; ;;
    -n | --log_name_file) LOG_NAME_FILE=$2; shift 2; ;;
    --) shift; break; ;;
  esac
done
# csr_instr_asm csr_instructions dhrystone fibonacci generic_exception_test hello-world illegal load_store_rs1_zero misalign

[ -z ${RTL+x} ] && RTL=(0 11)
[ -z ${BB_LEN+x} ] && BB_LEN=(10 20) #(`seq 6 1 50`) #(30 25 20 15 10 5)
[ -z ${FIRMWARES+x} ] && FIRMWARES=(fibonacci) #(csr_instr_asm csr_instructions dhrystone fibonacci hello-world load_store_rs1_zero)
[ -z ${PLOT_CYCLING_OVERHEAD+x} ] && PLOT_CYCLING_OVERHEAD=1 #(csr_instr_asm csr_instructions dhrystone fibonacci hello-world load_store_rs1_zero)

FIRMWARES_OFFSET=(-3716 -1848 -1884)
ATTACKS=(0) # (0 1 2 3) #(0 1 2 3 4)

LOG_PATH="../log/"
LOG_FILE="../log/linear_dump_attack.log"
BACKUP_LOG_FILE="../log/linear_dump_attack_backup.log"
LOG_FILE_OVERHEAD="../log/linear_dump_attack_overhead.log"

mv ${LOG_FILE} ${BACKUP_LOG_FILE}

for r in ${RTL[@]}; do
    cmd="./sim_core-v-verif.sh -r $r"

    fusible=0
    for b in ${BB_LEN[@]}; do
        if [[ $r == 0 ]]; then
            cmd3=${cmd}
        else
            cmd3="${cmd} -b $b"
        fi

        if [[ ${fusible} == 0 ]]; then

            for a in ${ATTACKS[@]}; do
                cmd4="${cmd3} -a $a -i"

                count=0
                for f in ${FIRMWARES[@]}; do
                    cmd5="${cmd4} -f $f"

                    if [[ $a == 4 ]]; then
                        cmd6="${cmd5} -d 25 -o ${FIRMWARES_OFFSET[${count}]}"
                    else
                        cmd6=${cmd5}
                    fi

                    count=$(($count+1))

                    echo ${cmd6}
                    ${cmd6}
                done
            done
        fi

        if [[ $r == 0 ]]; then
            fusible=1
        fi
    done
done


if [ -z ${LOG_NAME_FILE+x} ]; then
    # Don't erase previous LOG_FILE_OVERHEAD
    mv --backup=t ${LOG_FILE} ${LOG_FILE_OVERHEAD}
else
    mv ${LOG_FILE} ${LOG_PATH}${LOG_NAME_FILE}
fi

cp ${BACKUP_LOG_FILE} ${LOG_FILE}


if [[ ${PLOT_CYCLING_OVERHEAD} == 1 ]];then
    echo python3 cycling_overhead.py nall
    python3 cycling_overhead.py nall
fi
