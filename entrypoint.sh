#!/bin/bash

mkdir /result
source /build/env.sh
(
    git clone --depth 1 -b $BRANCH $REPOSITORY bmo
    cd bmo
    cp ../cpanfile.snapshot .
    $PERL Makefile.PL
    make cpanfile GEN_CPANFILE_ARGS="-D bmo"
    $PERL $CARTON install
    mv cpanfile cpanfile.snapshot result
) &> /result/build.log

tar -C /result -zc build.log cpanfile cpanfile.snapshot
