#!/bin/sh

#if [ ! -r $1 ]; then
#  echo "Usage: $0 <dlx_assembly_file>.asm"
#  exit 1
#fi
echo "write bin"
read b
echo "write asm"
read a 

asmfile=`echo $a | sed s/[.].*//g`
#perl ./dlxasm.pl -o $asmfile.bin $1
perl ./dlxasm.pl -o $b $a
rm $asmfile.bin.hdr
cat $asmfile.bin | hexdump -v -e '/1 "%02X\n"' > hex
rm $asmfile.bin
