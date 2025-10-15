#!/bin/sh -e

ROOTDIR=$(realpath "$(dirname "$0")/..")
SRCDIR="$ROOTDIR/src"
BUILDDIR="$ROOTDIR/build"

# Расположите свою команду на следующей строке
gcc $BUILDDIR/main.o -o $BUILDDIR/main
