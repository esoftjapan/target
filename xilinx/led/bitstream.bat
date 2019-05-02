@echo off
set PATH=C:\Xilinx\Vivado\2018.3\bin
del *.log
del *.jou

C:\WINDOWS\system32\cmd.exe C:\WINDOWS\system32\cmd.exe /c vivado.bat -mode gui -source bitstream.tcl ./build/build.xpr
if not errorlevel 0 (
	echo failed create vivado project
	pause
	exit 2
)
