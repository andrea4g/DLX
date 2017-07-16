#!/bin/sh

if [ ! -r $1 ]; then
  echo "Usage: $0 <dlx_assembly_file>.asm"
else
  asmfile= `echo $1 | sed s/[.].*//g`
  perl ./dlxasm.pl -o $asmfile.bin $1
  rm $asmfile.bin.hdr
  cat $asmfile.bin | hexdump -v -e '/1 "%02X\n"' > iram
  rm $asmfile.bin
fi

echo "end of conversion"

