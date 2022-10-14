<style>
img {
  display: block;
  margin-left: auto;
  margin-right: auto;
}
</style>

# Simulation

## Launch quickly execution simulation and analysis.
### Simulate execution

explains one simulation -> one line of outputs in log file

 with the performing of an LCE
Simulate execution with the performing of an LCE on a protected core



### Linear extraction strategies

Three different strategies lead to a linear execution.
*Force* statement emulates the microprobes.

|           Strategy          	|                                                                                     Forcing                                                                                    	|
|:---------------------------:	|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:	|
|        (I) - Feeezing       	| cv32e40p_core_i.if_stage_i.prefetch_buffer_i.instruction_obi_i.resp_rdata_o[6]=1'b0<br>cv32e40p_core_i.if_stage_i.prefetch_buffer_i.instruction_obi_i.resp_rdata_o[4:2]=3'b101 	|
|   (II) - Instruction edits  	|                                                                 cv32e40p_core_i.if_stage_i.instr_valid = 1'h0                                                                 	|
| (III) - Linear mode forcing 	|                                                                   cv32e40p_core_i.id_stage_i.pc_set_o = 1'h0                                                                   	|

<img src="../../doc/diagram_lce_linear_extraction_strategies-1.jpg" alt="drawing" width="400" class="center"/>


### Outputs
Some outputs are avilable at the bottom of log/linear_dump_attack.log file.

``` bash
-------------------------------------------------------------------------------------------------------------
                       RTL  A   BB  Instr  Delay  Bench_name              Dump   Alarm  Last_cycle  Last_addr
-------------------------------------------------------------------------------------------------------------
[2022-09-29 10:29:50] | 0| |0| |  | |  | |     0| hello-world                  |      | |   21080| |   0x420|
[2022-09-29 10:29:52] | 2| |0| |25| |35| |     0| hello-world                  |      | |   23064| |   0x420|
[2022-09-29 10:46:49] | 0| |0| |  | |  | |     0| fibonacci                    |      | |   93824| |   0x3e4|
[2022-09-29 10:46:54] | 0| |1| |  | |  | |     0| fibonacci              100 % |      | |   50000| | 0x30dbc|
[2022-09-29 10:46:58] | 0| |2| |  | |  | |     0| fibonacci              100 % |      | |   50000| | 0x30dbc|
[2022-09-29 10:47:03] | 0| |3| |  | |  | |     0| fibonacci              100 % |      | |   50000| | 0x1a01a|
[2022-09-29 10:47:07] | 0| |4| |  | |  | |    25| fibonacci                1 % |      | |   50000| |  0x7cac|
```



### Cycling overhead
To simulate the execution of a set of benchmarks with a variety of latency detection:
For ASM countermeasure :
``` bash
 ./launch_sim_overhead.sh -r "0 2" -f "hello-world" -b "25" -p -n "lce_overhead_2.log"
```

For ADI-SM countermeasure :
``` bash
./launch_sim_overhead.sh -r "0 11" -f "hello-world" -b "25" -p -n "lce_overhead_11.log"
```


To plot the cycling overhead from the benchmarks execution:
``` bash
python3 cycling_overhead.py nall -l "../log/lce_overhead_11.log ../log/lce_overhead_2.log"
```


To plot the average of cycling ovehead:
``` bash
python3 cycling_overhead.py nall -l "../log/lce_overhead_11.log ../log/lce_overhead_2.log" -a
```


 



## Simulator
By using the script sim_core-v-verif.sh, you can :
- simulate some programs
- simulate a linear memory dump and analyse the percentage of dumped programs

## Script

```
./sim_core-v-verif.sh -s <simulator> -l -w -t <bench_name>
```

Options :
- **-s** : choose a simulator between
	- verilator
	- vsim-run (modelsim/questa)
- **-t** : specify the program(s)
- **-w** : generate waveforms
- **-l** : simulate the linear memory dump and generate a log file
