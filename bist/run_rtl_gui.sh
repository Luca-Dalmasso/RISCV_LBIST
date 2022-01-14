#!/bin/bash

cd $( dirname $0)
root_dir=${PWD}
cd - &>/dev/null

program=${root_dir}/sbst/sbst.hex

run_dir=${root_dir}/run
export TB_DIR=${root_dir}/tb/core

#if [ $# -ne 1 ]; then
#   echo "Usage: $0 path/to/file.hex" >&2
#   exit 1
#fi

if [ ! -e "${program}" ]; then
   echo "Error: ${program} not found." >&2
   exit 1
fi


export RUN_GUI=1
export RUN_GATE=0


cd ${run_dir}

./compile.sh
vsim -gui -t ns -novopt work.riscv_bist_testbench -do dumport_generate.tcl

./compile_testbench.sh
#the following has been delayed
vsim -gui -work work_rtl tb_top_vopt "+firmware=${program}" # +dumpports+nocollapse -do ${root_dir}/vsim.tcl