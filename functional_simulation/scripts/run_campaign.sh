#!/bin/bash

LONG_VALID_ARGS=rtl:,wwdl:,firmwares:,no_plot_cycling_overhead:,attacks:,overhead
VALID_ARGS=$(getopt -o r:l:f:pa:o --long ${LONG_VALID_ARGS} -- "$@")
if [[ $? -ne 0 ]]; then
    exit 1;
fi


eval set -- "$VALID_ARGS"
while [ : ]; do
  case "$1" in
    -r | --rtl) RTLS=$2; shift 2; ;;
    -l | --wwdl) WWDLS=$2; shift 2; ;;
    -f | --firmwares) FIRMWARES=$2; shift 2; ;;
    -a | --attacks) ATTACKS=$2; shift 2; ;;
    -o | --overhead) OVERHEAD_FLAG="--overhead"; CREATE_OVERHEAD_LOG_FLAG="--create_overhead_log"; ATTACKS="0"; shift 1; ;;
    --) shift; break; ;;
  esac
done


# csr_instr_asm csr_instructions dhrystone fibonacci generic_exception_test hello-world illegal load_store_rs1_zero misalign
ALL_FIRMAWRES=(crc32 cubic dhrystone edn fibonacci huffbench matmult-int md5sum minver mont64 nbody nettle-aes nettle-sha256 nsichneu picojpeg primecount qrduino sglib-combined slre st statemate tarfind ud wikisort)

# Default values
[ -z ${RTLS+x} ] && RTLS=(INIT LAM SMM DIM)
[ -z ${WWDLS+x} ] && WWDLS=(`seq 6 1 150`) #(30 25 20 15 10 5)
[ -z ${FIRMWARES+x} ] && FIRMWARES=${ALL_FIRMAWRES[@]} #(csr_instr_asm csr_instructions dhrystone fibonacci hello-world load_store_rs1_zero)
[ -z ${ATTACKS+x} ] && ATTACKS=(0 1 2 3 4)


first_simu=1
for r in ${RTLS[@]}; do
    cmd_sim="./simulate.sh -r $r"

    bypass_wwdl_for_init=0
    for l in ${WWDLS[@]}; do
        if [[ $r == INIT ]]; then
            cmd_wwdl=${cmd_sim}
        else
            cmd_wwdl="${cmd_sim} -l $l"
        fi

        if [[ ${bypass_wwdl_for_init} == 0 ]]; then

            for a in ${ATTACKS[@]}; do
                cmd_a="${cmd_wwdl} -a $a -i"

                for f in ${FIRMWARES[@]}; do
                    cmd_f="${cmd_a} -f $f"

                    [ $a == "3" ] && cmd_f="${cmd_f} -d 24"

                    cmd="${cmd_f} ${OVERHEAD_FLAG}"
                    [ ${first_simu} == 1 ] && cmd="${cmd} ${CREATE_OVERHEAD_LOG_FLAG}"
                    echo ${cmd}
                    ${cmd}
                    first_simu=0
                done
            done
        fi

        # INIT ignore variation of WWDL
        if [[ $r == "INIT" ]]; then
            bypass_wwdl_for_init=1
        fi
    done
done


[ ${OVERHEAD_FLAG+x} ] && echo "python3 clock_cycle_overhead.py nall" && python3 clock_cycle_overhead.py all
