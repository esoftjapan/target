@echo off
set PATH=C:\Xilinx\Vivado\2018.3\bin
if exist vivado_hls.log del vivado_hls.log
if exist "./hls/real2bool_0" rd /s /q "./hls/real2bool_0"
C:\WINDOWS\system32\cmd.exe C:\WINDOWS\system32\cmd.exe /c vivado_hls.bat -f real2bool_0_hls.tcl
if not errorlevel 0 (
	echo failed vivado_hls real2bool_0
	pause
	exit 1
)
