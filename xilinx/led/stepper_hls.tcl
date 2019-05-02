########################################################################
# (C)eSoft 2019, all rights reserved                                   #
#                                                                      #
# Vivado-HLS Prject                                                    #
# How To Use : > vivado_hls -f <fileName>.tcl                          #
#                                                                      #
# ---------------------------------------------------------------------#
# 2019/05/02	created                                                #
########################################################################

set srcdir [pwd]
set workdir "./hls"

set vendor "eSoft"
set library "VLX"
set major "1"
set minor "0"
set version "0"

############################################################
if { [ file exists $workdir ] == 0 } then {
	file mkdir $workdir
}
cd $workdir
set topfunc stepper
puts "========= $topfunc ========= "
set projname $topfunc
set description stepper

file delete -force $projname
open_project -reset $projname
set_top $topfunc
set cpp_file $topfunc
append cpp_file ".cpp"
add_files "$srcdir/types.h"
add_files "$srcdir/$cpp_file"
set h_file "$srcdir/$topfunc"
append h_file ".h"
if { [ file exists $h_file ] == 1 } then {
	add_files $h_file
}
open_solution "solution1"
set_part {xc7a35ticsg324-1L} -tool vivado
create_clock -period 20 -name default
config_rtl -reset all -reset_async -reset_level high
csynth_design
export_design -format ip_catalog -description $description -vendor $vendor -library $library -version "$major.$minor.$version"
close_project
exit

