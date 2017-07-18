###################################################################

# Created by write_sdc on Tue Jul 18 14:19:09 2017

###################################################################
set sdc_version 1.7

create_clock [get_ports CLK]  -period 5  -waveform {0 2.5}
set_max_delay 5  -from [list [get_ports CLK] [get_ports RST] [get_ports IRAM_READY] [get_ports \
{IRAM_DATA[31]}] [get_ports {IRAM_DATA[30]}] [get_ports {IRAM_DATA[29]}]       \
[get_ports {IRAM_DATA[28]}] [get_ports {IRAM_DATA[27]}] [get_ports             \
{IRAM_DATA[26]}] [get_ports {IRAM_DATA[25]}] [get_ports {IRAM_DATA[24]}]       \
[get_ports {IRAM_DATA[23]}] [get_ports {IRAM_DATA[22]}] [get_ports             \
{IRAM_DATA[21]}] [get_ports {IRAM_DATA[20]}] [get_ports {IRAM_DATA[19]}]       \
[get_ports {IRAM_DATA[18]}] [get_ports {IRAM_DATA[17]}] [get_ports             \
{IRAM_DATA[16]}] [get_ports {IRAM_DATA[15]}] [get_ports {IRAM_DATA[14]}]       \
[get_ports {IRAM_DATA[13]}] [get_ports {IRAM_DATA[12]}] [get_ports             \
{IRAM_DATA[11]}] [get_ports {IRAM_DATA[10]}] [get_ports {IRAM_DATA[9]}]        \
[get_ports {IRAM_DATA[8]}] [get_ports {IRAM_DATA[7]}] [get_ports               \
{IRAM_DATA[6]}] [get_ports {IRAM_DATA[5]}] [get_ports {IRAM_DATA[4]}]          \
[get_ports {IRAM_DATA[3]}] [get_ports {IRAM_DATA[2]}] [get_ports               \
{IRAM_DATA[1]}] [get_ports {IRAM_DATA[0]}] [get_ports {DRAM_DATA_in[31]}]      \
[get_ports {DRAM_DATA_in[30]}] [get_ports {DRAM_DATA_in[29]}] [get_ports       \
{DRAM_DATA_in[28]}] [get_ports {DRAM_DATA_in[27]}] [get_ports                  \
{DRAM_DATA_in[26]}] [get_ports {DRAM_DATA_in[25]}] [get_ports                  \
{DRAM_DATA_in[24]}] [get_ports {DRAM_DATA_in[23]}] [get_ports                  \
{DRAM_DATA_in[22]}] [get_ports {DRAM_DATA_in[21]}] [get_ports                  \
{DRAM_DATA_in[20]}] [get_ports {DRAM_DATA_in[19]}] [get_ports                  \
{DRAM_DATA_in[18]}] [get_ports {DRAM_DATA_in[17]}] [get_ports                  \
{DRAM_DATA_in[16]}] [get_ports {DRAM_DATA_in[15]}] [get_ports                  \
{DRAM_DATA_in[14]}] [get_ports {DRAM_DATA_in[13]}] [get_ports                  \
{DRAM_DATA_in[12]}] [get_ports {DRAM_DATA_in[11]}] [get_ports                  \
{DRAM_DATA_in[10]}] [get_ports {DRAM_DATA_in[9]}] [get_ports                   \
{DRAM_DATA_in[8]}] [get_ports {DRAM_DATA_in[7]}] [get_ports {DRAM_DATA_in[6]}] \
[get_ports {DRAM_DATA_in[5]}] [get_ports {DRAM_DATA_in[4]}] [get_ports         \
{DRAM_DATA_in[3]}] [get_ports {DRAM_DATA_in[2]}] [get_ports {DRAM_DATA_in[1]}] \
[get_ports {DRAM_DATA_in[0]}] [get_ports DRAM_READY]]  -to [list [get_ports {IRAM_ADDRESS[31]}] [get_ports {IRAM_ADDRESS[30]}]       \
[get_ports {IRAM_ADDRESS[29]}] [get_ports {IRAM_ADDRESS[28]}] [get_ports       \
{IRAM_ADDRESS[27]}] [get_ports {IRAM_ADDRESS[26]}] [get_ports                  \
{IRAM_ADDRESS[25]}] [get_ports {IRAM_ADDRESS[24]}] [get_ports                  \
{IRAM_ADDRESS[23]}] [get_ports {IRAM_ADDRESS[22]}] [get_ports                  \
{IRAM_ADDRESS[21]}] [get_ports {IRAM_ADDRESS[20]}] [get_ports                  \
{IRAM_ADDRESS[19]}] [get_ports {IRAM_ADDRESS[18]}] [get_ports                  \
{IRAM_ADDRESS[17]}] [get_ports {IRAM_ADDRESS[16]}] [get_ports                  \
{IRAM_ADDRESS[15]}] [get_ports {IRAM_ADDRESS[14]}] [get_ports                  \
{IRAM_ADDRESS[13]}] [get_ports {IRAM_ADDRESS[12]}] [get_ports                  \
{IRAM_ADDRESS[11]}] [get_ports {IRAM_ADDRESS[10]}] [get_ports                  \
{IRAM_ADDRESS[9]}] [get_ports {IRAM_ADDRESS[8]}] [get_ports {IRAM_ADDRESS[7]}] \
[get_ports {IRAM_ADDRESS[6]}] [get_ports {IRAM_ADDRESS[5]}] [get_ports         \
{IRAM_ADDRESS[4]}] [get_ports {IRAM_ADDRESS[3]}] [get_ports {IRAM_ADDRESS[2]}] \
[get_ports {IRAM_ADDRESS[1]}] [get_ports {IRAM_ADDRESS[0]}] [get_ports         \
IRAM_ISSUE] [get_ports {DRAM_ADDRESS[31]}] [get_ports {DRAM_ADDRESS[30]}]      \
[get_ports {DRAM_ADDRESS[29]}] [get_ports {DRAM_ADDRESS[28]}] [get_ports       \
{DRAM_ADDRESS[27]}] [get_ports {DRAM_ADDRESS[26]}] [get_ports                  \
{DRAM_ADDRESS[25]}] [get_ports {DRAM_ADDRESS[24]}] [get_ports                  \
{DRAM_ADDRESS[23]}] [get_ports {DRAM_ADDRESS[22]}] [get_ports                  \
{DRAM_ADDRESS[21]}] [get_ports {DRAM_ADDRESS[20]}] [get_ports                  \
{DRAM_ADDRESS[19]}] [get_ports {DRAM_ADDRESS[18]}] [get_ports                  \
{DRAM_ADDRESS[17]}] [get_ports {DRAM_ADDRESS[16]}] [get_ports                  \
{DRAM_ADDRESS[15]}] [get_ports {DRAM_ADDRESS[14]}] [get_ports                  \
{DRAM_ADDRESS[13]}] [get_ports {DRAM_ADDRESS[12]}] [get_ports                  \
{DRAM_ADDRESS[11]}] [get_ports {DRAM_ADDRESS[10]}] [get_ports                  \
{DRAM_ADDRESS[9]}] [get_ports {DRAM_ADDRESS[8]}] [get_ports {DRAM_ADDRESS[7]}] \
[get_ports {DRAM_ADDRESS[6]}] [get_ports {DRAM_ADDRESS[5]}] [get_ports         \
{DRAM_ADDRESS[4]}] [get_ports {DRAM_ADDRESS[3]}] [get_ports {DRAM_ADDRESS[2]}] \
[get_ports {DRAM_ADDRESS[1]}] [get_ports {DRAM_ADDRESS[0]}] [get_ports         \
DRAM_READNOTWRITE] [get_ports DRAM_ISSUE] [get_ports {DRAM_DATA_out[31]}]      \
[get_ports {DRAM_DATA_out[30]}] [get_ports {DRAM_DATA_out[29]}] [get_ports     \
{DRAM_DATA_out[28]}] [get_ports {DRAM_DATA_out[27]}] [get_ports                \
{DRAM_DATA_out[26]}] [get_ports {DRAM_DATA_out[25]}] [get_ports                \
{DRAM_DATA_out[24]}] [get_ports {DRAM_DATA_out[23]}] [get_ports                \
{DRAM_DATA_out[22]}] [get_ports {DRAM_DATA_out[21]}] [get_ports                \
{DRAM_DATA_out[20]}] [get_ports {DRAM_DATA_out[19]}] [get_ports                \
{DRAM_DATA_out[18]}] [get_ports {DRAM_DATA_out[17]}] [get_ports                \
{DRAM_DATA_out[16]}] [get_ports {DRAM_DATA_out[15]}] [get_ports                \
{DRAM_DATA_out[14]}] [get_ports {DRAM_DATA_out[13]}] [get_ports                \
{DRAM_DATA_out[12]}] [get_ports {DRAM_DATA_out[11]}] [get_ports                \
{DRAM_DATA_out[10]}] [get_ports {DRAM_DATA_out[9]}] [get_ports                 \
{DRAM_DATA_out[8]}] [get_ports {DRAM_DATA_out[7]}] [get_ports                  \
{DRAM_DATA_out[6]}] [get_ports {DRAM_DATA_out[5]}] [get_ports                  \
{DRAM_DATA_out[4]}] [get_ports {DRAM_DATA_out[3]}] [get_ports                  \
{DRAM_DATA_out[2]}] [get_ports {DRAM_DATA_out[1]}] [get_ports                  \
{DRAM_DATA_out[0]}]]
