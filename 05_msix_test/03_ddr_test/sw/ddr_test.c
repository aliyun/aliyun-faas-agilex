//
// Copyright (c) 2017, Intel Corporation
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// Neither the name of the Intel Corporation nor the names of its contributors
// may be used to endorse or promote products derived from this software
// without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <uuid/uuid.h>

#include <opae/fpga.h>

// State from the AFU's JSON file, extracted using OPAE's afu_json_mgr script
#include "afu_json_info.h"

#define CACHELINE_BYTES 64
#define CL(x) ((x) * CACHELINE_BYTES)

//pcie test define
#define FIFO_MODE               0x0
#define COPY_MODE               0x1
#define WR_PERF_MODE            0x2
#define RD_PERF_MODE            0x3
#define RD_CMD 					0x0
#define WR_CMD 					0x1
#define ADDR_RSV                0x0018
#define ADDR_WORK_MODE          0x0020
#define ADDR_WORK_EN            0x0028
#define ADDR_WORK_STOP          0x0030
#define ADDR_WR_TEST_NUM        0x0038
#define ADDR_WR_ADDR_H          0x0040
#define ADDR_WR_ADDR_L          0x0048
#define ADDR_WR_LEN             0x0050
#define ADDR_RD_TEST_NUM        0x0058
#define ADDR_RD_ADDR_H          0x0060
#define ADDR_RD_ADDR_L          0x0068
#define ADDR_RD_LEN             0x0070
#define ADDR_FUNCTION_NUM       0x0078
#define ADDR_RD_DATA_STORAGE    0x0080
#define ADDR_RD_DATA_CLEAR      0x0088
#define ADDR_RD_DATA            0x0090
#define ADDR_FIFO_CMD_NUM       0x0098
#define ADDR_FIFO_STATUS        0x00a0
#define ADDR_WR_TIME_COST_H     0x00a8
#define ADDR_WR_TIME_COST_L     0x00b0
#define ADDR_RD_TIME_COST_H     0x00b8
#define ADDR_RD_TIME_COST_L     0x00c0
#define ADDR_RD_TIME_DELAY      0x00c8
#define ADDR_WR_SEND_CNT_H      0x00d0
#define ADDR_WR_SEND_CNT_L      0x00d8
#define ADDR_RD_SEND_CNT_H      0x00e0
#define ADDR_RD_SEND_CNT_L      0x00e8
#define ADDR_RD_TOTAL_TIME_H    0x00f0
#define ADDR_RD_TOTAL_TIME_L    0x00f8
#define ADDR_COPY_WR_ADDR_H     0x0100
#define ADDR_COPY_WR_ADDR_L     0x0108
#define ADDR_COPY_RD_ADDR_H     0x0110
#define ADDR_COPY_RD_ADDR_L     0x0118
#define ADDR_COPY_SIZE          0x0120
#define ADDR_COPY_MODE          0x0128
#define ADDR_COPY_SEED          0x0130
#define ADDR_COPY_STATUS        0x0138
#define ADDR_COPY_TIME_COST     0x0140
#define ADDR_STAT               0x0148
#define ADDR_FIFO_STAT_0        0x0150
#define ADDR_FIFO_STAT_1        0x0158
#define ADDR_FIFO_STAT_2        0x0160
#define ADDR_FIFO_STAT_3        0x0168
#define ADDR_FIFO_STAT          0x0170
#define ADDR_COPY_CNT           0x0178
#define ADDR_AXI_CMD_CNT        0x0180
#define ADDR_AXI_WR_CNT         0x0188
#define ADDR_AXI_RD_CNT         0x0190
//DDR test define
#define TEST_START              0x0020 
#define DDR_RUNNING             0x0038
#define FIXED_ERROR             0x0040   
#define PRBS_ERROR              0x0048
#define DDR_CAL_DONE            0x0060
#define WR_CYCLE_CNT            0x0080
#define RD_CYCLE_CNT            0x0088
#define ROUND_TIME_L            0x0098
#define ROUND_TIME_H            0x00a0
#define DDR_CAP                 8

typedef struct 
{
	uint8_t  cmd_type;
	uint64_t addr;
	uint16_t len;
	uint16_t cycles;
} Bridge_cmd;
//
// Search for an accelerator matching the requested UUID and connect to it.
//
static fpga_handle connect_to_accel(const char *accel_uuid)
{
    fpga_properties filter = NULL;
    fpga_guid guid;
    fpga_token accel_token;
    uint32_t num_matches;
    fpga_handle accel_handle;
    fpga_result r;

    // Don't print verbose messages in ASE by default
    setenv("ASE_LOG", "0", 0);

    // Set up a filter that will search for an accelerator
    fpgaGetProperties(NULL, &filter);
    fpgaPropertiesSetObjectType(filter, FPGA_ACCELERATOR);

    // Add the desired UUID to the filter
    uuid_parse(accel_uuid, guid);
    fpgaPropertiesSetGUID(filter, guid);

    // Do the search across the available FPGA contexts
    num_matches = 1;
    fpgaEnumerate(&filter, 1, &accel_token, 1, &num_matches);

    // Not needed anymore
    fpgaDestroyProperties(&filter);

    if (num_matches < 1)
    {
        fprintf(stderr, "Accelerator %s not found!\n", accel_uuid);
        return 0;
    }

    // Open accelerator
    r = fpgaOpen(accel_token, &accel_handle, FPGA_OPEN_SHARED);
	// r = fpgaOpen(accel_token, &accel_handle, 0);
    assert(FPGA_OK == r);

    // Done with token
    fpgaDestroyToken(&accel_token);

    return accel_handle;
}


//
// Allocate a buffer in I/O memory, shared with the FPGA.
//
static volatile void* alloc_buffer(fpga_handle accel_handle,
                                   ssize_t size,
                                   uint64_t *wsid,
                                   uint64_t *io_addr)
{
    fpga_result r;
    volatile void* buf;

    r = fpgaPrepareBuffer(accel_handle, size, (void*)&buf, wsid, 0);
    if (FPGA_OK != r) return NULL;

    // Get the physical address of the buffer in the accelerator
    r = fpgaGetIOAddress(accel_handle, *wsid, io_addr);
    assert(FPGA_OK == r);

    return buf;
}

//
// send wr/rd command to fifo in FPGA.
//
static int
bridge_fifo_mode_cmd(fpga_handle accel_handle, Bridge_cmd *cmd_set, uint16_t cmd_len)
{
	uint64_t wr_value, rd_value;

	uint16_t i;
	for (i=0; i<cmd_len; i++)
	{
		if (cmd_set->cmd_type == WR_CMD)
		{
			wr_value = cmd_set->addr>>32;
			fpgaWriteMMIO64(accel_handle, 0, ADDR_WR_ADDR_H, wr_value);
			fpgaReadMMIO64(accel_handle, 0, ADDR_WR_ADDR_H, &rd_value);
			if (rd_value!=wr_value) {
				printf("FIFO_MODE Haddr reg error %x, exp: %x\n", rd_value, wr_value);
				return -1;
			}
			wr_value = cmd_set->addr & 0xffffffff;
			fpgaWriteMMIO64(accel_handle, 0, ADDR_WR_ADDR_L, wr_value);
			fpgaReadMMIO64(accel_handle, 0, ADDR_WR_ADDR_L, &rd_value);
			if (rd_value!=wr_value) {
				printf("FIFO_MODE Laddr reg error %x, exp: %x\n", rd_value, wr_value);
				return -1;
			}
			wr_value = cmd_set->len;
			fpgaWriteMMIO64(accel_handle, 0, ADDR_WR_LEN, wr_value);
			fpgaReadMMIO64(accel_handle, 0, ADDR_WR_LEN, &rd_value);
			if (rd_value!=wr_value) {
				printf("FIFO_MODE Len reg error %x, exp: %x\n", rd_value, wr_value);
				return -1;
			}
			wr_value = cmd_set->cycles;
			fpgaWriteMMIO64(accel_handle, 0, ADDR_WR_TEST_NUM, wr_value);
			fpgaReadMMIO64(accel_handle, 0, ADDR_WR_TEST_NUM, &rd_value);
			if (rd_value!=wr_value) {
				printf("FIFO_MODE Cycle reg error %x, exp: %x\n", rd_value, wr_value);
				return -1;
			}
		}
		else if (cmd_set->cmd_type == RD_CMD)
		{
			wr_value = cmd_set->addr>>32;
			fpgaWriteMMIO64(accel_handle, 0, ADDR_RD_ADDR_H, wr_value);
			fpgaReadMMIO64(accel_handle, 0, ADDR_RD_ADDR_H, &rd_value);
			if (rd_value!=wr_value) {
				printf("FIFO_MODE Haddr reg error %x, exp: %x\n", rd_value, wr_value);
				return -1;
			}
			wr_value = cmd_set->addr & 0xffffffff;
			fpgaWriteMMIO64(accel_handle, 0, ADDR_RD_ADDR_L, wr_value);
			fpgaReadMMIO64(accel_handle, 0, ADDR_RD_ADDR_L, &rd_value);
			if (rd_value!=wr_value) {
				printf("FIFO_MODE Laddr reg error %x, exp: %x\n", rd_value, wr_value);
				return -1;
			}
			wr_value = cmd_set->len;
			fpgaWriteMMIO64(accel_handle, 0, ADDR_RD_LEN, wr_value);
			fpgaReadMMIO64(accel_handle, 0, ADDR_RD_LEN, &rd_value);
			if (rd_value!=wr_value) {
				printf("FIFO_MODE Len reg error %x, exp: %x\n", rd_value, wr_value);
				return -1;
			}
			wr_value = cmd_set->cycles;
			fpgaWriteMMIO64(accel_handle, 0, ADDR_RD_TEST_NUM, wr_value);
			fpgaReadMMIO64(accel_handle, 0, ADDR_RD_TEST_NUM, &rd_value);
			if (rd_value!=wr_value) {
				printf("FIFO_MODE Cycle reg error %x, exp: %x\n", rd_value, wr_value);
				return -1;
			}
		}
		cmd_set++;
	}
	return 0;
}

static int
bridge_copy_config(fpga_handle accel_handle, uint64_t wr_addr, uint64_t rd_addr, uint32_t size, uint16_t seed)
{
	uint64_t wr_value;
	wr_value = wr_addr>>32;
	fpgaWriteMMIO64(accel_handle, 0, ADDR_COPY_WR_ADDR_H, wr_value);
	wr_value = wr_addr & 0xffffffff;
	fpgaWriteMMIO64(accel_handle, 0, ADDR_COPY_WR_ADDR_L, wr_value);
	wr_value = rd_addr>>32;
	fpgaWriteMMIO64(accel_handle, 0, ADDR_COPY_RD_ADDR_H, wr_value);
	wr_value = rd_addr & 0xffffffff;
	fpgaWriteMMIO64(accel_handle, 0, ADDR_COPY_RD_ADDR_L, wr_value);
	wr_value = size;
	fpgaWriteMMIO64(accel_handle, 0, ADDR_COPY_SIZE, wr_value);
	wr_value = seed;
	fpgaWriteMMIO64(accel_handle, 0, ADDR_COPY_SEED, wr_value);
	wr_value = 0x1;
	fpgaWriteMMIO64(accel_handle, 0, ADDR_COPY_MODE, wr_value);
	return 0;
}

static int
bridge_fifo_wr_finish(fpga_handle accel_handle, useconds_t wait_us) 
{
	uint64_t rd_value, cnt;
	cnt = 0;
	rd_value = 0;
	usleep(2);
	while ((rd_value & 0x2) == 0)
	{
		usleep(wait_us);
		fpgaReadMMIO64(accel_handle, 0, ADDR_FIFO_STATUS, &rd_value);
		cnt ++;
		if (cnt == 100) 
		{
			printf("FIFO_MODE write time out.\n");
			return -1;
		}
	}
	return 0;
}

static int
bridge_fifo_rd_finish(fpga_handle accel_handle, useconds_t wait_us) 
{
	uint64_t rd_value, cnt;
	cnt = 0;
	rd_value = 0;
	usleep(2);
	while ((rd_value & 0x1) == 0)
	{
		usleep(wait_us);
		fpgaReadMMIO64(accel_handle, 0, ADDR_FIFO_STATUS, &rd_value);
		cnt ++;
		if (cnt == 100) 
		{
			printf("FIFO_MODE read time out.\n");
			return -1;
		}
	}
	return 0;
}

static int
bridge_copy_finish(fpga_handle accel_handle, useconds_t wait_us) 
{
	uint64_t rd_value, cnt;
	cnt = 0;
	rd_value = 0;
	usleep(2);
	while ((rd_value & 0x1) == 0)
	{
		usleep(wait_us);
		fpgaReadMMIO64(accel_handle, 0, ADDR_COPY_STATUS, &rd_value);
		cnt ++;
		if (cnt == 100) 
		{
			printf("COPY_MODE time out.\n");
			return -1;
		}
	}
	return 0;
}

static int
bridge_fifo_mode_rd_storage(fpga_handle accel_handle, bool enable)
{
	if (enable == 1)
	{
		fpgaWriteMMIO64(accel_handle, 0, ADDR_RD_DATA_STORAGE, 0x1);
	}
	else 
	{
		fpgaWriteMMIO64(accel_handle, 0, ADDR_RD_DATA_STORAGE, 0x0);
	}
	return 0;
}

static int 
bridge_work_mode(fpga_handle accel_handle, uint64_t mode)
{
	uint64_t rd_value;
	int rslt = 0;
	fpgaWriteMMIO64(accel_handle, 0, ADDR_WORK_MODE, mode);
	fpgaReadMMIO64(accel_handle, 0, ADDR_WORK_MODE, &rd_value);
	if (rd_value==FIFO_MODE) {
		printf("Current work mode is FIFO_MODE.\n");
	} else if (rd_value==COPY_MODE)
	{
		rslt = bridge_fifo_mode_rd_storage(accel_handle, 0);
		printf("Current work mode is COPY_MODE.\n");
	} else 
	{
		printf("Current work mode is unknown, is %x.\n", rd_value);
		return -1;
	}
	return rslt;
}

static int 
bridge_work_en(fpga_handle accel_handle)
{
	fpgaWriteMMIO64(accel_handle, 0, ADDR_WORK_EN, 0x1);
	return 0;
}

static int
bridge_fifo_mode_rd_data(fpga_handle accel_handle, uint64_t addr, uint16_t len, uint8_t *rdata)
{
	uint64_t addr_end;
	uint64_t rd_value;
	uint16_t  before_data, cnt, i;
	before_data = (addr>>2) & 0xf;
	addr_end = addr + len;
	for (i=0; i<before_data; i++)
	{
		fpgaReadMMIO64(accel_handle, 0, ADDR_RD_DATA, &rd_value);
		//printf("Read data:%x.\n", rd_value);
	}
	fpgaReadMMIO64(accel_handle, 0, ADDR_RD_DATA, &rd_value);
	//printf("Read data:%x.\n", rd_value);
	switch (addr & 0x3) {
		case 0x0 :
		*rdata = rd_value & 0xff;
		rdata++;
		*rdata = (rd_value>>8) & 0xff;
		rdata++;
		*rdata = (rd_value>>16) & 0xff;
		rdata++;
		*rdata = (rd_value>>24) & 0xff;
		rdata++;
		cnt = 4;
		break;
		case 0x1 :
		*rdata = (rd_value>>8) & 0xff;
		rdata++;
		*rdata = (rd_value>>16) & 0xff;
		rdata++;
		*rdata = (rd_value>>24) & 0xff;
		rdata++;
		cnt = 3;
		break;
		case 0x2 :
		*rdata = (rd_value>>16) & 0xff;
		rdata++;
		*rdata = (rd_value>>24) & 0xff;
		rdata++;
		cnt = 2;
		break;
		case 0x3 :
		*rdata = (rd_value>>24) & 0xff;
		rdata++;
		cnt = 1;
		break;
	}
	for (i=cnt; i<len; i++) 
	{
		if ((i-cnt)%4 == 0) 
		{
			fpgaReadMMIO64(accel_handle, 0, ADDR_RD_DATA, &rd_value);
			//printf("Read data:%x.\n", rd_value);
		}
		*rdata = (rd_value>>(((i-cnt)%4)*8)) & 0xff;
		rdata++;
	}
	before_data = 0x40 - (addr_end & 0x3f);
	before_data = before_data>>2;
	for (i=0; i<before_data; i++)
	{
		fpgaReadMMIO64(accel_handle, 0, ADDR_RD_DATA, &rd_value);
	}
	return 0;
}


__attribute__((unused)) 
static int 
bridge_wr_test_single(fpga_handle accel_handle, uint64_t phy_addr, void* vir_addr)
{
	uint64_t addr, addr_end, cnt;
	uint64_t addr_start;
	uint16_t len;
	uint8_t  data_cnt;
	uint8_t  *chk;
	int 	 run_rslt;
	Bridge_cmd *cmd_set;
	addr_start = phy_addr;
	printf("Single write test starts at %lx.\n", phy_addr);
	run_rslt = bridge_work_mode(accel_handle, FIFO_MODE);
	if (run_rslt!=0) return -1;
	for (addr=0; addr<=4095; addr++)
	{
		for (len=1; len<=4096-addr; len++)
		{
			usleep(1);
			memset(vir_addr, 0xff, sizeof(uint8_t)*4096);
			addr_end = addr + len - 1;
			cmd_set = (Bridge_cmd *) malloc(sizeof(Bridge_cmd));
			cmd_set->cmd_type = WR_CMD;
			cmd_set->addr = addr_start+ (uint64_t) addr;
			cmd_set->len = len;
			cmd_set->cycles = 1;
			run_rslt = bridge_fifo_mode_cmd(accel_handle, cmd_set, 1);
			if (run_rslt!=0) return -1;
			run_rslt = bridge_work_en(accel_handle);
			if (run_rslt!=0) return -1;
			run_rslt = bridge_fifo_wr_finish(accel_handle, 1);
			if (run_rslt!=0) return -1;
			usleep(1);
			data_cnt = 0;
			chk = (uint8_t  *)vir_addr;
			for (cnt = 0; cnt<4096; cnt++) 
			{
				if ((cnt<addr || cnt>addr_end) && *chk!=0xff) 
				{
					printf("Single write over range, addr:%x, len:%d.\n", addr, len);
					printf("addr:%p, data:%x.\n", chk, *chk);
					printf("addr:%p, data:%x.\n", (chk+62), *(chk+62));
					printf("addr:%p, data:%x.\n", (chk+63), *(chk+63));
					printf("vir_addr:%p, phy_addr:%lx.\n", vir_addr, phy_addr);
					printf("cnt:%x, addr:%x, addr_end:%lx.\n", cnt, addr, addr_end);
					return -1;
				}
				else if (cnt>=addr && cnt<=addr_end && *chk!=data_cnt)
				{
					printf("Single write test error, addr:%x, len:%d.\n", addr, len);
					printf("addr:%p, data:%x.\n", chk, *chk);
					printf("addr:%p, data:%x.\n", (chk+1), *(chk+1));
					printf("addr:%p, data:%x.\n", (chk+64), *(chk+64));
					printf("vir_addr:%p, phy_addr:%lx.\n", vir_addr, phy_addr);
					printf("cnt:%x, addr:%x, addr_end:%lx.\n", cnt, addr, addr_end);
					return -1;
				}
				if ((cnt&0x3f) == 0x3f && cnt>=addr) data_cnt++;
				chk ++;
			}
			free(cmd_set);
		}
		printf("Single write test finished, addr:%x, len:%d.\n", addr, len);
	}
	printf("-----------------------\n");
	printf("single write test finished.\n");
	printf("-----------------------\n");
	return 0;
}

static int
bridge_rd_test_single(fpga_handle accel_handle, uint64_t phy_addr, void* vir_addr)
{
	uint8_t *rdata, *phy_data;
	uint16_t len, i;
	uint32_t *random_data;
	uint32_t addr;
	uint64_t addr_start;
	int 	 run_rslt;
	Bridge_cmd *cmd_set;
	addr_start = phy_addr;
	random_data = (uint32_t*) vir_addr;
	printf("Single read test starts at %lx.\n", phy_addr);
	run_rslt = bridge_work_mode(accel_handle, FIFO_MODE);
	if (run_rslt!=0) return -1;
	run_rslt = bridge_fifo_mode_rd_storage(accel_handle, 1);
	if (run_rslt!=0) return -1;
	for (i=0; i<(4096/sizeof(uint32_t)); i++)
	{
		*random_data = rand();
		random_data++;
	}
	for (i=0; i<32; i++) 
	{
		phy_data = (uint8_t *)vir_addr + i;
		//printf("ori[%d]:%x.\n", i, *phy_data);
		phy_data++;
	}
	for (addr=1; addr<=0; addr++)
	{
		for (len=1; len<=4096-addr; len++)
		{
			// usleep(1);
			cmd_set = (Bridge_cmd *) malloc(sizeof(Bridge_cmd));
			cmd_set->cmd_type = RD_CMD;
			cmd_set->addr = addr_start + (uint64_t) addr;
			cmd_set->len = len;
			cmd_set->cycles = 1;
			run_rslt = bridge_fifo_mode_cmd(accel_handle, cmd_set, 1);
			if (run_rslt!=0) return -1;
			run_rslt = bridge_work_en(accel_handle);
			if (run_rslt!=0) return -1;
			run_rslt = bridge_fifo_rd_finish(accel_handle, 1);
			if (run_rslt!=0) return -1;
			usleep(1);
			rdata = (uint8_t *)malloc(sizeof(uint8_t)*len);
			//printf("rdata_ptr:%p.\n", rdata);
			phy_data = (uint8_t *)vir_addr + addr;
			bridge_fifo_mode_rd_data(accel_handle, cmd_set->addr, cmd_set->len, rdata);
			for (i=0; i<len; i++)
			{
				if (*phy_data != *rdata)
				{
					printf("Single read test error, addr:%x, len:%d.\n", addr, len);
					printf("rdata_ptr:%p.\n", rdata);
					printf("addr:%p, reg_data:%x, phy_data:%lx.\n", phy_data, *rdata, *phy_data);
					printf("vir_addr:%p, phy_addr:%lx.\n", vir_addr, phy_addr);
					printf("i:%x, addr:%x.\n", i, addr);
					return -1;
				}
				rdata++;
				phy_data++;
			}
			free(cmd_set);
			rdata = rdata - len;
			free(rdata);
		}
		printf("Single read test finished, addr:%x, len:%d.\n", addr, len);
	}
	printf("-----------------------\n");
	printf("single read test finished.\n");
	printf("-----------------------\n");
	return 0;
}

static int
bridge_wr_performance_test(fpga_handle accel_handle, uint64_t phy_addr)
{
	uint64_t addr_start, rd_value, wr_value;
	uint32_t len, send_cnt_H, send_cnt_L, send_time_H, send_time_L;
	float    send_cnt, send_time, wr_perf;
	int rslt;
	addr_start = phy_addr;
	len = 64;
	printf("Performance write test starts at %lx.\n", phy_addr);
	rslt = bridge_fifo_mode_rd_storage(accel_handle, 0);
	if (rslt!=0) return -1;
	usleep(1);
	for (len=64; len<=1024; len=len+64)
	{
		fpgaWriteMMIO64(accel_handle, 0, ADDR_WORK_MODE, 0x2);
		fpgaWriteMMIO64(accel_handle, 0, ADDR_COPY_SEED, 0xaa30);
		wr_value = addr_start>>32;
		fpgaWriteMMIO64(accel_handle, 0, ADDR_WR_ADDR_H, wr_value);
		wr_value = addr_start & 0xffffffff;
		fpgaWriteMMIO64(accel_handle, 0, ADDR_WR_ADDR_L, wr_value);
		wr_value = len;
		fpgaWriteMMIO64(accel_handle, 0, ADDR_WR_LEN, wr_value);
		fpgaWriteMMIO64(accel_handle, 0, ADDR_WORK_EN, 0x1);
		usleep(1000000);
		fpgaWriteMMIO64(accel_handle, 0, ADDR_WORK_STOP, 0x1);
		usleep(50000);
		fpgaReadMMIO64(accel_handle, 0, ADDR_WR_SEND_CNT_H, &rd_value);
		send_cnt_H = rd_value;
		fpgaReadMMIO64(accel_handle, 0, ADDR_WR_SEND_CNT_L, &rd_value);
		send_cnt_L = rd_value;
		fpgaReadMMIO64(accel_handle, 0, ADDR_WR_TIME_COST_H, &rd_value);
		send_time_H = rd_value;
		fpgaReadMMIO64(accel_handle, 0, ADDR_WR_TIME_COST_L, &rd_value);
		send_time_L = rd_value;
		send_cnt = (send_cnt_H*0x100000000) + send_cnt_L;
		send_time = (send_time_H*0x100000000) + send_time_L;
		wr_perf = (send_cnt*8*len)/(send_time*2.86);
		printf("Performance Test, Write len:%d , pkt cnt:%f, cycles:%f, perf:%f\n", len, send_cnt, send_time, wr_perf);
	}
	return 0;
}

static int
bridge_rd_performance_test(fpga_handle accel_handle, uint64_t phy_addr)
{
	uint64_t addr_start, rd_value, wr_value;
	uint32_t len, send_cnt_H, send_cnt_L, send_time_H, send_time_L, delay_time, total_time_H, total_time_L;
	float    send_cnt, send_time, total_time, rd_perf;
	int run_rslt;
	addr_start = phy_addr;
	len = 64;
	printf("Performance read test starts at %lx.\n", phy_addr);
	run_rslt = bridge_fifo_mode_rd_storage(accel_handle, 0);
	if (run_rslt!=0) return -1;
	usleep(1);
	for (len=64; len<=1024; len=len+64)
	{
		fpgaWriteMMIO64(accel_handle, 0, ADDR_WORK_MODE, 0x5);
		wr_value = addr_start>>32;
		fpgaWriteMMIO64(accel_handle, 0, ADDR_RD_ADDR_H, wr_value);
		wr_value = addr_start & 0xffffffff;
		fpgaWriteMMIO64(accel_handle, 0, ADDR_RD_ADDR_L, wr_value);
		wr_value = len;
		fpgaWriteMMIO64(accel_handle, 0, ADDR_RD_LEN, wr_value);
		fpgaWriteMMIO64(accel_handle, 0, ADDR_WORK_EN, 0x1);
		usleep(1000000);
		fpgaWriteMMIO64(accel_handle, 0, ADDR_WORK_STOP, 0x1);
		usleep(5000);
		run_rslt = bridge_fifo_rd_finish(accel_handle, 20);
		if (run_rslt!=0) return 1;
		fpgaReadMMIO64(accel_handle, 0, ADDR_RD_SEND_CNT_H, &rd_value);
		send_cnt_H = rd_value;
		fpgaReadMMIO64(accel_handle, 0, ADDR_RD_SEND_CNT_L, &rd_value);
		send_cnt_L = rd_value;
		fpgaReadMMIO64(accel_handle, 0, ADDR_RD_TIME_COST_H, &rd_value);
		send_time_H = rd_value;
		fpgaReadMMIO64(accel_handle, 0, ADDR_RD_TIME_COST_L, &rd_value);
		send_time_L = rd_value;
		fpgaReadMMIO64(accel_handle, 0, ADDR_RD_TOTAL_TIME_H, &rd_value);
		total_time_H = rd_value;
		fpgaReadMMIO64(accel_handle, 0, ADDR_RD_TOTAL_TIME_L, &rd_value);
		total_time_L = rd_value;
		fpgaReadMMIO64(accel_handle, 0, ADDR_RD_TIME_DELAY, &rd_value);
		delay_time = rd_value;
		send_cnt = (send_cnt_H*0x100000000) + send_cnt_L;
		send_time = (send_time_H*0x100000000) + send_time_L;
		total_time = (total_time_H*0x100000000) + total_time_L;
		rd_perf = ((float)send_cnt*8*(float)len)/(float)send_time/2.86;
		usleep(5000);
		printf("Performance Test, Read len:%d, pkt cnt:%f, cycles:%f, delay:%d, perf:%f\n", len, send_cnt, total_time, delay_time, rd_perf);
	}
	return 0;
}

__attribute__((unused)) 
static int
bridge_copy_test(fpga_handle accel_handle, uint64_t phy_addr, void* vir_addr)
{
	uint16_t seed;
	uint32_t *random_data, *chk_data;
	uint32_t copy_size, i;
	uint64_t addr_rd, addr_wr;
	int 	 run_rslt;
	printf("Copy test starts at %x.\n", phy_addr);
	run_rslt = bridge_work_mode(accel_handle, COPY_MODE);
	if (run_rslt!=0) return -1;
	for (copy_size = (1<<12); copy_size<=(1<<27); copy_size*=2)
	{
		printf("Copy test, size:%x.\n", copy_size);
		random_data = (uint64_t *)vir_addr;
		for (i=0; i<(copy_size/sizeof(uint32_t)); i++)
		{
			*random_data = rand();
			random_data++;
		}
		addr_rd = phy_addr;
		addr_wr = phy_addr + (uint64_t) copy_size;
		seed = rand();
		printf("Copy test, seed:%x.\n", seed);
		bridge_copy_config(accel_handle, addr_wr, addr_rd, copy_size, seed);
		run_rslt = bridge_work_en(accel_handle);
		if (run_rslt!=0) return -1;
		run_rslt = bridge_copy_finish(accel_handle, 1000);
		if (run_rslt!=0) return -1;
		printf("Copy test, done.\n");
		usleep(10);
		//check
		random_data = (uint32_t *)vir_addr;
		chk_data = (uint32_t *)vir_addr + (uint32_t) (copy_size/sizeof(uint32_t));
		// printf("ori_ptr:%p, chk_ptr:%p.\n", random_data, chk_data);
		for (i=0; i<(copy_size/sizeof(uint32_t)); i++)
		{
			if (*random_data!=*chk_data) 
			{
				printf("copy test error.\n");
				printf("ori_ptr:%p, chk_ptr:%p.\n", random_data, chk_data);
				printf("ori_data:%x, chk_data:%x.\n", *random_data, *chk_data);
				// printf("ori_ptr:%p, chk_ptr:%p.\n", random_data+1, chk_data+1);
				// printf("ori_data:%x, chk_data:%x.\n", *(random_data+1), *(chk_data+1));
				// printf("ori_ptr:%p, chk_ptr:%p.\n", random_data+2, chk_data+2);
				// printf("ori_data:%x, chk_data:%x.\n", *(random_data+2), *(chk_data+2));
				break;
			}
			random_data++;
			chk_data++;
		}
	}
	printf("-----------------------\n");
	printf("copy test finished.\n");
	printf("-----------------------\n");
	return 0;
}
#define TEST_START              0x0020 
#define FIXED_ERROR             0x0040   
#define PRBS_ERROR              0x0048
#define DDR_CAL_DONE            0x0060
#define WR_CYCLE_CNT            0x0080
#define RD_CYCLE_CNT            0x0088
#define ROUND_TIME_L            0x0098
#define ROUND_TIME_H            0x00a0

static int
ddr_write_read_test(fpga_handle accel_handle)
{   
	uint64_t addr_start, rd_value, wr_value;
    uint32_t ddr_cal_status, wr_cycle_init, rd_cycle_init, wr_cycle, rd_cycle, round_time_low_init, roune_time_high_init, round_time_low, roune_time_high,
	         ddr_run_state;
	uint64_t round_time_init,round_time;

	float    run_time,run_size,ddr_perf;
	int rslt;
	len = 64;
	printf("-----------DDR  test --------------");
	//-----------------------------------------------------------
    //Step 1 | Read DDR STAT
	//-----------------------------------------------------------
	fpgaReadMMIO64(accel_handle, 0, DDR_CAL_DONE, &rd_value);
	ddr_cal_status = rd_value;
	if(ddr_cal_status==1)
	{
		printf("DDR CAL Success");
	}
	else
	{
		printf("DDR CAL Failed ");
	}
	//-----------------------------------------------------------
	//Step 2 | Read Stat Init
	//-----------------------------------------------------------	
	fpgaReadMMIO64(accel_handle, 0, WR_CYCLE_CNT, &rd_value);
	wr_cycle_init = rd_value;
	fpgaReadMMIO64(accel_handle, 0, RD_CYCLE_CNT, &rd_value);
	rd_cycle_init = rd_value;
	pgaReadMMIO64(accel_handle, 0, ROUND_TIME_L, &rd_value);
	round_time_low_init = rd_value;
	pgaReadMMIO64(accel_handle, 0, ROUND_TIME_H, &rd_value);
	roune_time_high_init = rd_value;
	round_time_init = (roune_time_high_init*0x100000000) + round_time_low_init 
	//-----------------------------------------------------------
	//Step 3 | Start DDR WRITE and READ
	//-----------------------------------------------------------	
	fpgaWriteMMIO64(accel_handle, 0, TEST_START, 0x1);
	printf("DDR write read test starts ");
	//-----------------------------------------------------------
	//Step 4 | Stop DDR Write and Read
	//-----------------------------------------------------------	
	ddr_run_state = 1;
	while( ddr_run_state == 1 )
    {   
		pgaReadMMIO64(accel_handle, 0, DDR_RUNNING, &rd_value); 
        ddr_run_state = rd_value;
    }
	//-----------------------------------------------------------
	//Step 5 | Read Finish Result
	//-----------------------------------------------------------	
	fpgaReadMMIO64(accel_handle, 0, WR_CYCLE_CNT, &rd_value);
	wr_cycle = rd_value;
	fpgaReadMMIO64(accel_handle, 0, RD_CYCLE_CNT, &rd_value);
	rd_cycle = rd_value;
	pgaReadMMIO64(accel_handle, 0, ROUND_TIME_L, &rd_value);
	round_time_low = rd_value;
	pgaReadMMIO64(accel_handle, 0, ROUND_TIME_H, &rd_value);
	roune_time_high = rd_value;
	round_time = (roune_time_high*0x100000000) + round_time_low 
	//-----------------------------------------------------------
	//Step 6 | Calc DDR BNAD
	//-----------------------------------------------------------	    
    run_time = (round_time-round_time_init)*2.5/1000/1000/1000;
	run_size = ((wr_cycle-wr_cycle_init)+(rd_cycle-rd_cycle_init))*4.5*DDR_CAP;//Gb
	ddr_perf = run_size*1024*1024*1024/1000/1000/1000/run_time;
	printf("DDR Performance is %x Gb/s.\n", ddr_perf);
}

int main(int argc, char *argv[])
{
    fpga_handle accel_handle;
    volatile char *mem_pool;
    uint64_t wsid;
    uint64_t mem_pool_pa;
    uint64_t rdata;
    int rslt;

    // Find and connect to the accelerator
    accel_handle = connect_to_accel(AFU_ACCEL_UUID);
    printf("Found device, size:%d.\n", getpagesize());
 
    ddr_write_read_test(accel_handle)
    //// Allocate a single page memory buffer
    //mem_pool = (volatile char*)alloc_buffer(accel_handle, 1024*1024*1024,
    //                                   &wsid, &mem_pool_pa);
    //assert(NULL != mem_pool);

    //// Set the low byte of the shared buffer to 0.  The FPGA will write
    //// a non-zero value to it.
    //mem_pool[0] = 0;

    //// fpgaWriteMMIO64(accel_handle, 0, 0x20, 1);
	//printf("phy address %lx\n", mem_pool_pa);
	//printf("virtual address %p\n", mem_pool);
	//fpgaWriteMMIO64(accel_handle, 0, ADDR_FUNCTION_NUM, 0x0);


	//rslt = bridge_copy_test(accel_handle, mem_pool_pa, (void *)mem_pool);
	//if (rslt!=0) return 0;

	//rslt = bridge_rd_performance_test(accel_handle, mem_pool_pa);
	//if (rslt!=0) return 0;
	//rslt = bridge_wr_performance_test(accel_handle, mem_pool_pa);
	//if (rslt!=0) return 0;

    //// Done
    //fpgaReleaseBuffer(accel_handle, wsid);
    //fpgaClose(accel_handle);

    return 0;
}
