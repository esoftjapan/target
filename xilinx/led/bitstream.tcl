########################################################################
# (C)eSoft 2019, all rights reserved
#
# Vivado                                                                
# (1)Open Block Design                                                  
# (2)Create HDL wrapper                                                 
# (3)Generate Block Design                                              
# (4)Generate Bitstream                                                 
#
# ----------------------------------------------------------------------
# 2019/05/02	created
########################################################################

set srcdir ./build/build.srcs/sources_1
open_bd_design "$srcdir/bd/design_1/design_1.bd"
make_wrapper -files [get_files $srcdir/bd/design_1/design_1.bd] -top
add_files -norecurse $srcdir/bd/design_1/hdl/design_1_wrapper.v
update_compile_order -fileset sources_1
set_property synth_checkpoint_mode None [get_files $srcdir/bd/design_1/design_1.bd]
generate_target all [get_files $srcdir/bd/design_1]
export_ip_user_files -of_objects [get_files $srcdir/bd/design_1/design_1.bd] -no_script -sync -force -quiet
launch_runs impl_1 -to_step write_bitstream
