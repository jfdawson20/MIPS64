transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/jdawson/Dropbox/FPGA/Processor {C:/Users/jdawson/Dropbox/FPGA/Processor/controller.v}
vlog -sv -work work +incdir+C:/Users/jdawson/Dropbox/FPGA/Processor {C:/Users/jdawson/Dropbox/FPGA/Processor/WB_Block.v}
vlog -sv -work work +incdir+C:/Users/jdawson/Dropbox/FPGA/Processor {C:/Users/jdawson/Dropbox/FPGA/Processor/registers.v}
vlog -sv -work work +incdir+C:/Users/jdawson/Dropbox/FPGA/Processor {C:/Users/jdawson/Dropbox/FPGA/Processor/MEM_WB_PIPE.v}
vlog -sv -work work +incdir+C:/Users/jdawson/Dropbox/FPGA/Processor {C:/Users/jdawson/Dropbox/FPGA/Processor/MEM_Block.v}
vlog -sv -work work +incdir+C:/Users/jdawson/Dropbox/FPGA/Processor {C:/Users/jdawson/Dropbox/FPGA/Processor/IF_ID_PIPE.v}
vlog -sv -work work +incdir+C:/Users/jdawson/Dropbox/FPGA/Processor {C:/Users/jdawson/Dropbox/FPGA/Processor/IF_Block.v}
vlog -sv -work work +incdir+C:/Users/jdawson/Dropbox/FPGA/Processor {C:/Users/jdawson/Dropbox/FPGA/Processor/IE_MEM_PIPE.v}
vlog -sv -work work +incdir+C:/Users/jdawson/Dropbox/FPGA/Processor {C:/Users/jdawson/Dropbox/FPGA/Processor/ID_IE_PIPE.v}
vlog -sv -work work +incdir+C:/Users/jdawson/Dropbox/FPGA/Processor {C:/Users/jdawson/Dropbox/FPGA/Processor/ID_Block.v}
vlog -sv -work work +incdir+C:/Users/jdawson/Dropbox/FPGA/Processor {C:/Users/jdawson/Dropbox/FPGA/Processor/alu.v}
vlog -sv -work work +incdir+C:/Users/jdawson/Dropbox/FPGA/Processor {C:/Users/jdawson/Dropbox/FPGA/Processor/addrDyn.v}
vlog -sv -work work +incdir+C:/Users/jdawson/Dropbox/FPGA/Processor {C:/Users/jdawson/Dropbox/FPGA/Processor/MIPS64.v}
vlog -sv -work work +incdir+C:/Users/jdawson/Dropbox/FPGA/Processor {C:/Users/jdawson/Dropbox/FPGA/Processor/IE_Block.v}

vlog -sv -work work +incdir+C:/Users/jdawson/Dropbox/FPGA/Processor/simulation/modelsim {C:/Users/jdawson/Dropbox/FPGA/Processor/simulation/modelsim/mips64.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  mips64_tb

add wave *
view structure
view signals
run -all
