@echo off
set PATH=C:\Xilinx\Vivado\2018.3\bin
if exist vivado.log del vivado.log
C:\WINDOWS\system32\cmd.exe C:\WINDOWS\system32\cmd.exe /c vivado.bat -mode batch -source vivado_project.tcl
if not errorlevel 0 (
	echo failed vivado
	pause
	exit 2
)
