#!/bin/bash

LONG_VALID_ARGS=rtl:,bb_len:,firmwares:,no_plot_cycling_overhead:,attacks:
VALID_ARGS=$(getopt -o r:b:f:pa: --long ${LONG_VALID_ARGS} -- "$@")
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
    -a | --attacks) ATTACKS=$2; shift 2; ;;
    --) shift; break; ;;
  esac
done
# csr_instr_asm csr_instructions dhrystone fibonacci generic_exception_test hello-world illegal load_store_rs1_zero misalign

[ -z ${RTL+x} ] && RTL=(0 1 11 2)
[ -z ${BB_LEN+x} ] && BB_LEN=(15) #(`seq 6 1 50`) #(30 25 20 15 10 5)
[ -z ${FIRMWARES+x} ] && FIRMWARES=(fibonacci) #(csr_instr_asm csr_instructions dhrystone fibonacci hello-world load_store_rs1_zero)
[ -z ${PLOT_CYCLING_OVERHEAD+x} ] && PLOT_CYCLING_OVERHEAD=1 #(csr_instr_asm csr_instructions dhrystone fibonacci hello-world load_store_rs1_zero)
[ -z ${ATTACKS+x} ] && ATTACKS=(0 1 2 3 4)

FIRMWARES_OFFSET=(-3716 -1848 -1884)


# csr_instr_asm csr_instructions dhrystone fibonacci generic_exception_test hello-world illegal load_store_rs1_zero misalign



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
