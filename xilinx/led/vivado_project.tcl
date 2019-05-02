########################################################################
# (C)eSoft 2019, all rights reserved                                   
#                                                                          
# Vivado Prject                                                         
# How To Use :                                                          
# (1)vivado -mode batch -source <fileName>.tcl                          
# (2)Lunch Vivado                                                       
# (3)Open Block Diagaram                                                
# (4)Create HDL wrapper                                                 
# (5)Generate Block Design                                              
# (6)Run Synthesis                                                      
# (7)Run Implementation                                                 
# (8)Generate Bitstream                                                 
#
# ----------------------------------------------------------------------
# 2019/05/02	created                                                
########################################################################

# create vivado prject
create_project build build -force -part xc7a35ticsg324-1L

# create block diagram
create_bd_design design_1

# add files to the project
add_files -fileset constrs_1 -norecurse arty.xdc

# update IP catalog
set_property ip_repo_paths ./hls [ current_project ]
update_ip_catalog

# create clock wizard, fext=100MHz, fout1=50MHz, fout2=25MHz(not used)
set clk_wiz_0 [ create_bd_cell -type ip -vlnv [ get_ipdefs *clk_wiz* ] clk_wiz_0 ]
set_property -dict [ list \
CONFIG.PRIM_IN_FREQ {100.00} \
CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {50.00} \
CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {25.00}  \
CONFIG.CLKOUT2_USED {true}  \
CONFIG.NUM_OUT_CLKS {2}  \
] $clk_wiz_0

create_bd_port -dir I -type CLK CLK100MHZ
create_bd_port -dir I -type RST CLK_RST

# create inverter
set_property CONFIG.POLARITY ACTIVE_LOW [get_bd_ports CLK_RST]
set util_vector_logic_0 [ create_bd_cell -type ip -vlnv [ get_ipdefs *util_vector_logi* ] util_vector_logic_0 ]
set_property -dict [ list \
CONFIG.C_SIZE {1} \
CONFIG.C_OPERATION {not} \
CONFIG.LOGO_FILE {data/sym_notgate.png} \
] $util_vector_logic_0

# create stepper, pg1, real2bool_0 and output port for LED4
set stepper [create_bd_cell -type ip -vlnv eSoft:VLX:stepper:1.0 stepper]
set pg1 [create_bd_cell -type ip -vlnv eSoft:VLX:pg1:1.0 pg1]
set real2bool_0 [create_bd_cell -type ip -vlnv eSoft:VLX:real2bool_0:1.0 real2bool_0]
create_bd_port -dir O -type DATA LED4
set xoutport1 [get_bd_ports LED4]

# connection blocks
connect_bd_net -net pg1_o_out_net [get_bd_pins pg1/o_out] [get_bd_pins real2bool_0/pinin]
connect_bd_net -net real2bool_0_o_pinout_net [get_bd_pins real2bool_0/o_pinout_V] [get_bd_ports LED4]
connect_bd_net -net clk_out1_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins stepper/ap_clk] [get_bd_pins pg1/ap_clk] [get_bd_pins real2bool_0/ap_clk]
connect_bd_net -net clk_reset_net [get_bd_pins util_vector_logic_0/Res] [get_bd_pins clk_wiz_0/reset] [get_bd_pins stepper/ap_rst] [get_bd_pins pg1/ap_rst] [get_bd_pins real2bool_0/ap_rst]
connect_bd_net -net stepper_net [get_bd_pin stepper/step_V] [get_bd_pins pg1/ap_start] [get_bd_pins real2bool_0/ap_start]
connect_bd_net -net clk_in1_1 [get_bd_ports CLK100MHZ] [get_bd_pins clk_wiz_0/clk_in1]
connect_bd_net -net clk_reset_net_in [get_bd_ports CLK_RST] [get_bd_pins util_vector_logic_0/Op1]

# save design
save_bd_design
