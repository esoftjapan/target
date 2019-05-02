@echo off
set PATH=C:\Xilinx\Vivado\2018.3\bin
if exist vivado_hls.log del vivado_hls.log
if exist "./hls/pg1" rd /s /q "./hls/pg1"
C:\WINDOWS\system32\cmd.exe C:\WINDOWS\system32\cmd.exe /c vivado_hls.bat -f pg1_hls.tcl
if not errorlevel 0 (
	echo failed vivado_hls pg1
	pause
	exit 1
)
