#!/bin/sh

sh assembler.sh $1
number=`ls -l ../test_bench_and_memory/TB_romem/*.txt | wc -l`
name=hex$number.txt

mv ../test_bench_and_memory/TB_romem/hex.txt ../test_bench_and_memory/TB_romem/$name
mv ./hex.txt ../test_bench_and_memory/TB_romem/hex.txt
