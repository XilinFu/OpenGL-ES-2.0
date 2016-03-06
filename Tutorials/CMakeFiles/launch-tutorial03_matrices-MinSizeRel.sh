#!/bin/sh
bindir=$(pwd)
cd /Users/administrator/Downloads/ogl-OpenGL-tutorial_0015_21-2/tutorial03_matrices/
export 

if test "x$1" = "x--debugger"; then
	shift
	if test "x" = "xYES"; then
		echo "r  " > $bindir/gdbscript
		echo "bt" >> $bindir/gdbscript
		GDB_COMMAND-NOTFOUND -batch -command=$bindir/gdbscript  /Users/administrator/Desktop/OpenGL-ES-2.0/Tutorials/MinSizeRel/tutorial03_matrices 
	else
		"/Users/administrator/Desktop/OpenGL-ES-2.0/Tutorials/MinSizeRel/tutorial03_matrices"  
	fi
else
	"/Users/administrator/Desktop/OpenGL-ES-2.0/Tutorials/MinSizeRel/tutorial03_matrices"  
fi
