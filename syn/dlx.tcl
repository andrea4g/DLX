set LIBRARY work
set SOURCE_DIRECTORY ../src
set DEST_DIRECTORY report
set SOURCE_FILES {
  000-functions.vhd
  000-globals.vhd
  000-rocache.vhd
  000-rwcache.vhd
  a-DLX.vhd
  a.a-cu.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a-basic_blocks/a.c.a.a-and_2.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a-basic_blocks/a.c.a.a-and_3.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a-basic_blocks/a.c.a.a-and_n1.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a-basic_blocks/a.c.a.a-nor_n1.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a-basic_blocks/a.c.a.a-not_1.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a-basic_blocks/a.c.a.a-not_n.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a-basic_blocks/a.c.a.a-or_2.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a-basic_blocks/a.c.a.a-xnor_2.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a-basic_blocks/a.c.a.a-xor_2.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a-basic_blocks/a.c.a.b-fa_2.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a-basic_blocks/a.c.a.b-mux21.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a-basic_blocks/a.c.a.c-mux21_generic.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a-basic_blocks/a.c.a.c-rca_n.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a.b-PG.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a.b-PG_general.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a.b-encoder.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a.b-functions.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a.c-G_general.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a.d-PG_network.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a.e-sparse_tree_carry_gen.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a.f-carry_select_block.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a.f-sum_generator.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.a.g-p4.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.b-subtractor.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.c-barrel_shifter_left.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.d-barrel_shifter_right.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.e.a-logic.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.e.b-logic_n.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.f-comparator.vhd
  a.b-DataPath.core/a.b-alu.core/a.c.g-zero_comp.vhd
  a.b-DataPath.core/a.d.b-ffd_async.vhd
  a.b-DataPath.core/a.d.c-reg_n.vhd
  a.b-DataPath.core/a.d.d-register_file.vhd
  a.b-DataPath.core/a.d.e-sign_extension.vhd
  a.b-DataPath.core/a.d.f-alu.vhd
  a.b-datapath.vhd
}

sh rm -rf $LIBRARY
sh mkdir -p $LIBRARY

foreach file $SOURCE_FILES {
    analyze -library $LIBRARY -format vhdl $SOURCE_DIRECTORY/$file
  }

set ENTITY DLX
set ARCH structural

elaborate $ENTITY -architecture $ARCH -library DEFAULT -parameters "IR_SIZE = 32, PC_SIZE = 32"

# compile
# 
# report_timing > $DEST_DIRECTORY/$ENTITY\_timing_nopt_max_path.rpt
# report_area   > $DEST_DIRECTORY/$ENTITY\_area_nopt_max_path.rpt
# report_power  > $DEST_DIRECTORY/$ENTITY\_power_nopt_max_path.rpt
# 
# report_power -cell > $DEST_DIRECTORY/$ENTITY\_power_cell_nopt_max_path.rpt
# report_power -net  > $DEST_DIRECTORY/$ENTITY\_power_net_nopt_max_path.rpt
