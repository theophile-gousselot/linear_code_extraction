<style>
img {
  display: block;
  margin-left: auto;
  margin-right: auto;
}
</style>

# Scripts for simulation



## Getting Started

To quickly get familiar with execution simulations, follow these instructions :

1. Simulate [crc32](#codes) code execution on unprotected core without performing LCE.
   ```sh
   ./simulate.sh -c crc32 -r INIT -a 0
   ```

2. The `../log/lce.log` was updated by adding analysis of simulation output. Details about [log files formatting](#log-files) are available.
   ```sh
   less ../log/lce.log
   ```

3. Simulate crc32 code execution on unprotected core with performing LCE with [strategy I](#strategy-i). The `../log/lce.log` file was updated and shows that 100% of the code in memory was extracted.
   ```sh
   ./simulate.sh -c crc32 -r INIT -a 1
   ```

4. Simulate in verbose mode. The comparison between original and extracted instructions is printed. The localization of the original code is presented [bellow](#codes).
   ```sh
   ./simulate.sh -c crc32 -r INIT -a 1 -v
   ```

5. Simulate with generation of waveform. The generated waveform is available on `../core-v-verif/cv32e40p.sim/core/verilator_tb.vcd`. [GTKWave](https://gtkwave.sourceforge.net/) is recommanded to open waveform.
   ```sh
   ./simulate.sh -c crc32 -r INIT -a 0 -w
   ```

6. Simulate execution on protected core with SMM (WWDL=15) while LCE with [strategy I](#strategy-i) is performing. The `../log/lce.log` shows that the detection latency was 15 executed instructions.
   ```sh
   ./simulate.sh -c crc32 -r SMM -l 15 -a 1 -v
   ```

7. Run a campaign of simulations of execution of crc32 and nettle-aes codes. Unprotected core and protected by the three countermeasures cores (with WWDL equal to 15, 30 then 60) will execute codes. LCE will be no performing, and performing with its three strategies.
   ```sh
   ./run_campaign.sh -c "crc32 nettle-aes" -r "INIT LAM SMM DIM" -l "15 30 60" -a "0 1 2 3"
   ```

8. Run a campaign of simulation to plot the clock cycle overhead. The analysed outputs are written into a new `../log/lce_overhead-<X>.log` file.
   ```sh
   ./run_campaign.sh -c "mont64 md5sum" -r "INIT SMM DIM" -l "10 15 20 25 30 60" -a 0 -o
   ```

9. Plotting the last already computed overhead campaign. Display the help to discover option -i and -l, usefull to plot a specific zlready computed overhead campaigns.
   ```sh
   python3 clock_cycle_overhead.py all
   python3 clock_cycle_overhead.py all -h
   ```

10. Plot an already computed overhead campaign by ourself, containing 24 codes, for large number of WWDL. This campaign was getting by executing `./run_campaign.sh -r "INIT SMM DIM" -a 0 -o`.
   ```sh
   python3 clock_cycle_overhead.py all -l ../log/already_computed/lce_overhead__INIT-SMM-DIM__wwdl_6-150.log
   ```

10. As the graph contains too much curves to be readable, plot the average of codes for both countermeasures. 
   ```sh
   python3 clock_cycle_overhead.py all -l ../log/already_computed/lce_overhead__INIT-SMM-DIM__wwdl_6-150.log -a
   ```

11. Finally, explore the already computed log file `../log/already_computed/lce__INIT-LAM-SMM-DIM__a_0-1-2-3__wwdl_10-100.log` getting by executing `./run_campaign.sh -r "INIT LAM SMM DIM" -a "0 1 2 3" -l "10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100`

12. To remove all log generated and to clean core-v-verif use:
   ```sh
   ./clean_everything.sh 
   ```




## Log files

For every simulation a line is added at the bottom of `../log/lce.log` file, as illustrated bellow. As `run_campaigns.sh` runs several simulations, several lines will be added.

Executing `run_campaigns.sh` with option `-o/--overhead` will create and generate outputs in a new file `../log/lce_overhead-<X>.log` with a new index X.



``` bash
----------------------------------------------------------------------------------------------------------
                        RTL   A  WWDL   Delay   Code_name         Extracted   Alarm  Last_cycle  Last_addr
----------------------------------------------------------------------------------------------------------
[2022-10-28 19:15:50] |INIT| |0| |  | |     0| md5sum                       |      | |  340545| |   0x888|
[2022-10-28 19:24:07] |INIT| |1| |  | |     0| crc32                  100 % |      | |   15380| |  0x1e8c|
[2022-10-28 19:16:22] | LAM| |3| |10| |    24| dhrystone                1 % |    10| |      10| |    0xa0|
[2022-10-28 19:18:09] | DIM| |2| |20| |     0| md5sum                   1 % |    20| |      20| |    0xcc|
```


Some outputs are avilable at the bottom of log/linear_dump_attack.log file.

#### RTL 

#### A : Linear code execution attack strategies

###### Strategy I
Three different strategies lead to a linear execution.
*Force* statement emulates the microprobes.

|           Strategy          	|                                                                                     Forcing                                                                                    	|
|:---------------------------:	|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:	|
|        (I) - Feeezing       	| cv32e40p_core_i.if_stage_i.prefetch_buffer_i.instruction_obi_i.resp_rdata_o[6]=1'b0<br>cv32e40p_core_i.if_stage_i.prefetch_buffer_i.instruction_obi_i.resp_rdata_o[4:2]=3'b101 	|
|   (II) - Instruction edits  	|                                                                 cv32e40p_core_i.if_stage_i.instr_valid = 1'h0                                                                 	|
| (III) - Linear mode forcing 	|                                                                   cv32e40p_core_i.id_stage_i.pc_set_o = 1'h0                                                                   	|

<img src="../../doc/diagram_lce_linear_extraction_strategies-1.jpg" alt="drawing" width="400" class="center"/>


#### WWDL : Worst Wanted Detection Latency

#### Delay

#### Code_name




## Scripts

### Folder organization
```
.
├── simulate.sh                 // simulate one execution
├── run_campaigns.sh            // simulate a campaign of executions
├── clean_everything.sh         // clean ../log folder and core-v-verif framework
├── lce_analysis.py             // analysis of one simulation outputs
├── clock_cycle_overhead.py     // plot clock cycle overheads of a campaign
├── lce_strategies.txt          // list of linear execution strategies for LCE
└── README.md
```



## Codes
### Core-v-verif
- dhrystone
- fibonacci

### Embench

[Embench](https://github.com/embench/embench-iot).  

- crc32
- cubic
- edn
- huffbench
- matmult-int
- md5sum
- minver
- mont64
- nbody
- nettle-aes
- nettle-sha256
- nsichneu
- picojpeg
- primecount
- qrduino
- sglib-combined
- slre
- st
- statemate
- tarfind
- ud
- wikisort
