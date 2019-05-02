@echo off
set PATH=C:\Xilinx\Vivado\2018.3\bin
if exist vivado_hls.log del vivado_hls.log
if exist "./hls/stepper" rd /s /q "./hls/stepper"
C:\WINDOWS\system32\cmd.exe C:\WINDOWS\system32\cmd.exe /c vivado_hls.bat -f stepper_hls.tcl
if not errorlevel 0 (
	echo failed vivado_hls stepper
	pause
	exit 1
)
