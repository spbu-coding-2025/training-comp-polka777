#!/bin/sh -e

BASEDIR=$(realpath "$(dirname "$0")")
ROOTDIR=$(realpath "$BASEDIR/..")
BUILDDIR="$ROOTDIR/build"
SCRIPTSDIR="$ROOTDIR/scripts"

echo "Test preprocessing"

rm -f "$BUILDDIR/"*
"$SCRIPTSDIR/preprocess.sh"
file "$BUILDDIR/main.i" | grep -q 'C source'

echo "Test compilation"

rm -f "$BUILDDIR/"*
"$SCRIPTSDIR/compile.sh"
file "$BUILDDIR/main.s" | grep -q 'assembler source'

echo "Test assembly"

rm -f "$BUILDDIR/"*
"$SCRIPTSDIR/assemble.sh"
file "$BUILDDIR/main.o" | grep -q 'relocatable'

echo "Test linking"

rm -f "$BUILDDIR/*"
"$SCRIPTSDIR/assemble.sh"
"$SCRIPTSDIR/link.sh"
"$BUILDDIR/main" | diff "$ROOTDIR/test/main.out" -
