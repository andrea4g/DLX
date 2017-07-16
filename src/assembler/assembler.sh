#!/bin/sh

if [ ! -r $1.asm ]; then
  echo "Usage: $0 <dlx_assembly_file>.asm"
else
  sed '/^$/d' $1.asm > $1.out 
  mv  $1.out $1.asm
  echo "nop\n" >> $1.asm

  perl ./dlxasm.pl -o $1.bin $1.asm
  rm $1.bin.hdr
  od --width=4 -v -t xC $1.bin | awk '{print $2$3$4$5}' >  hex.txt
  rm $1.bin

  echo "end of conversion"

fi
