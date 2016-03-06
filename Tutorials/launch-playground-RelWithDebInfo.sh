#!/bin/sh
bindir=$(pwd)
cd /Users/administrator/Downloads/ogl-OpenGL-tutorial_0015_21-2/playground/
export 

if test "x$1" = "x--debugger"; then
	shift
	if test "x" = "xYES"; then
		echo "r  " > $bindir/gdbscript
		echo "bt" >> $bindir/gdbscript
		GDB_COMMAND-NOTFOUND -batch -command=$bindir/gdbscript  /Users/administrator/Desktop/OpenGL-ES-2.0/Tutorials/RelWithDebInfo/playground 
	else
		"/Users/administrator/Desktop/OpenGL-ES-2.0/Tutorials/RelWithDebInfo/playground"  
	fi
else
	"/Users/administrator/Desktop/OpenGL-ES-2.0/Tutorials/RelWithDebInfo/playground"  
fi