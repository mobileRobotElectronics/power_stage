#!/bin/sh

# Project F: Lint Script
# (C)2023 Will Green, open source software released under the MIT License
# Learn more at https://projectf.io/posts/verilog-lint-with-verilator/

DIR=`dirname $0`
LIB="${DIR}/../lib"

# Verilator Simulation
# Lattice iCE40
if [ -d "${DIR}/ice40" ]; then
    echo "## Linting top modules in ${DIR}/ice40"
    for f in ${DIR}/ice40/top_*\.*v; do
        echo "##   Checking ${f}";
        verilator --lint-only -Wall -I${DIR} -I${DIR}/ice40 \
            -I${LIB}/seven_seg $f;
    done
fi