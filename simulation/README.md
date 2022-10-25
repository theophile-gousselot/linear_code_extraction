# Functional simulation

based on core-v-verif


### core-v-verif
- simulation framework edit to simulate LCE and use protected cv32e40p from this repo (link)

### Scripts
- to automatisation of simulation with options to simulate
    - lce (which one, delay)
    - cm (which one, wwdl)
- to analysis simulattion and generate
- to launch campaigns with plenty of simulation to test  every configuration
    - clock cyckle overhead

go into scripts to simulate !

### log
- outputs of analysis are saved here into file log/lce.log
    - one line per simulation + explain every column
- graph generated for clock cycle overhead are saved in plot
- lce_overhead-XXX.log  with XX a number campaign for clock cycle overhead + theorititical estimation
    - already computed overhead are saved into already_computed 


## Setup

installation
- toolchain
+ core-v-verif
