find ../log/ -maxdepth 1 -type f -exec rm -v {} \;
find ../log/plot/ -maxdepth 1 -type f \( ! -iname "plot_overheads_and_wwdls_4-35__average.pdf" ! -iname "plot_overheads_and_wwdls_4-35.pdf" \) -exec rm -v {} \;
make -C ../core-v-verif/cv32e40p/sim/core/ clean_all
