// Generator : SpinalHDL v1.4.2    git head : 804c7bd7b7feaddcc1d25ecef6c208fd5f776f79
// Component : ShellInfcAxi4MMSlice
// Git hash  : 819c646370472bb91f07472c58d49b1c3513f9aa


module ShellInfcAxi4MMSlice (
  input               input_aw_valid,
  output              input_aw_ready,
  input      [63:0]   input_aw_payload_addr,
  input      [3:0]    input_aw_payload_id,
  input      [7:0]    input_aw_payload_len,
  input      [2:0]    input_aw_payload_size,
  input      [1:0]    input_aw_payload_burst,
  input      [0:0]    input_aw_payload_lock,
  input      [3:0]    input_aw_payload_cache,
  input      [3:0]    input_aw_payload_qos,
  input      [63:0]   input_aw_payload_user,
  input      [2:0]    input_aw_payload_prot,
  input               input_w_valid,
  output              input_w_ready,
  input      [511:0]  input_w_payload_data,
  input      [63:0]   input_w_payload_strb,
  input      [3:0]    input_w_payload_user,
  input               input_w_payload_last,
  output              input_b_valid,
  input               input_b_ready,
  output     [3:0]    input_b_payload_id,
  output     [1:0]    input_b_payload_resp,
  output     [63:0]   input_b_payload_user,
  input               input_ar_valid,
  output              input_ar_ready,
  input      [63:0]   input_ar_payload_addr,
  input      [3:0]    input_ar_payload_id,
  input      [7:0]    input_ar_payload_len,
  input      [2:0]    input_ar_payload_size,
  input      [1:0]    input_ar_payload_burst,
  input      [0:0]    input_ar_payload_lock,
  input      [3:0]    input_ar_payload_cache,
  input      [3:0]    input_ar_payload_qos,
  input      [63:0]   input_ar_payload_user,
  input      [2:0]    input_ar_payload_prot,
  output              input_r_valid,
  input               input_r_ready,
  output     [511:0]  input_r_payload_data,
  output     [3:0]    input_r_payload_id,
  output     [1:0]    input_r_payload_resp,
  output              input_r_payload_last,
  output     [63:0]   input_r_payload_user,
  output              output_aw_valid,
  input               output_aw_ready,
  output     [63:0]   output_aw_payload_addr,
  output     [3:0]    output_aw_payload_id,
  output     [7:0]    output_aw_payload_len,
  output     [2:0]    output_aw_payload_size,
  output     [1:0]    output_aw_payload_burst,
  output     [0:0]    output_aw_payload_lock,
  output     [3:0]    output_aw_payload_cache,
  output     [3:0]    output_aw_payload_qos,
  output     [63:0]   output_aw_payload_user,
  output     [2:0]    output_aw_payload_prot,
  output              output_w_valid,
  input               output_w_ready,
  output     [511:0]  output_w_payload_data,
  output     [63:0]   output_w_payload_strb,
  output     [3:0]    output_w_payload_user,
  output              output_w_payload_last,
  input               output_b_valid,
  output              output_b_ready,
  input      [3:0]    output_b_payload_id,
  input      [1:0]    output_b_payload_resp,
  input      [63:0]   output_b_payload_user,
  output              output_ar_valid,
  input               output_ar_ready,
  output     [63:0]   output_ar_payload_addr,
  output     [3:0]    output_ar_payload_id,
  output     [7:0]    output_ar_payload_len,
  output     [2:0]    output_ar_payload_size,
  output     [1:0]    output_ar_payload_burst,
  output     [0:0]    output_ar_payload_lock,
  output     [3:0]    output_ar_payload_cache,
  output     [3:0]    output_ar_payload_qos,
  output     [63:0]   output_ar_payload_user,
  output     [2:0]    output_ar_payload_prot,
  input               output_r_valid,
  output              output_r_ready,
  input      [511:0]  output_r_payload_data,
  input      [3:0]    output_r_payload_id,
  input      [1:0]    output_r_payload_resp,
  input               output_r_payload_last,
  input      [63:0]   output_r_payload_user,
  input               clk,
  input               reset
);
  wire                _zz_1;
  wire                _zz_2;
  wire                _zz_3;
  wire                _zz_4;
  wire                _zz_5;
  wire                input_aw_s2mPipe_valid;
  wire                input_aw_s2mPipe_ready;
  wire       [63:0]   input_aw_s2mPipe_payload_addr;
  wire       [3:0]    input_aw_s2mPipe_payload_id;
  wire       [7:0]    input_aw_s2mPipe_payload_len;
  wire       [2:0]    input_aw_s2mPipe_payload_size;
  wire       [1:0]    input_aw_s2mPipe_payload_burst;
  wire       [0:0]    input_aw_s2mPipe_payload_lock;
  wire       [3:0]    input_aw_s2mPipe_payload_cache;
  wire       [3:0]    input_aw_s2mPipe_payload_qos;
  wire       [31:0]   input_aw_s2mPipe_payload_user;
  wire       [2:0]    input_aw_s2mPipe_payload_prot;
  reg                 input_aw_s2mPipe_rValid;
  reg        [63:0]   input_aw_s2mPipe_rData_addr;
  reg        [3:0]    input_aw_s2mPipe_rData_id;
  reg        [7:0]    input_aw_s2mPipe_rData_len;
  reg        [2:0]    input_aw_s2mPipe_rData_size;
  reg        [1:0]    input_aw_s2mPipe_rData_burst;
  reg        [0:0]    input_aw_s2mPipe_rData_lock;
  reg        [3:0]    input_aw_s2mPipe_rData_cache;
  reg        [3:0]    input_aw_s2mPipe_rData_qos;
  reg        [31:0]   input_aw_s2mPipe_rData_user;
  reg        [2:0]    input_aw_s2mPipe_rData_prot;
  wire                input_aw_s2mPipe_m2sPipe_valid;
  wire                input_aw_s2mPipe_m2sPipe_ready;
  wire       [63:0]   input_aw_s2mPipe_m2sPipe_payload_addr;
  wire       [3:0]    input_aw_s2mPipe_m2sPipe_payload_id;
  wire       [7:0]    input_aw_s2mPipe_m2sPipe_payload_len;
  wire       [2:0]    input_aw_s2mPipe_m2sPipe_payload_size;
  wire       [1:0]    input_aw_s2mPipe_m2sPipe_payload_burst;
  wire       [0:0]    input_aw_s2mPipe_m2sPipe_payload_lock;
  wire       [3:0]    input_aw_s2mPipe_m2sPipe_payload_cache;
  wire       [3:0]    input_aw_s2mPipe_m2sPipe_payload_qos;
  wire       [31:0]   input_aw_s2mPipe_m2sPipe_payload_user;
  wire       [2:0]    input_aw_s2mPipe_m2sPipe_payload_prot;
  reg                 input_aw_s2mPipe_m2sPipe_rValid;
  reg        [63:0]   input_aw_s2mPipe_m2sPipe_rData_addr;
  reg        [3:0]    input_aw_s2mPipe_m2sPipe_rData_id;
  reg        [7:0]    input_aw_s2mPipe_m2sPipe_rData_len;
  reg        [2:0]    input_aw_s2mPipe_m2sPipe_rData_size;
  reg        [1:0]    input_aw_s2mPipe_m2sPipe_rData_burst;
  reg        [0:0]    input_aw_s2mPipe_m2sPipe_rData_lock;
  reg        [3:0]    input_aw_s2mPipe_m2sPipe_rData_cache;
  reg        [3:0]    input_aw_s2mPipe_m2sPipe_rData_qos;
  reg        [31:0]   input_aw_s2mPipe_m2sPipe_rData_user;
  reg        [2:0]    input_aw_s2mPipe_m2sPipe_rData_prot;
  wire                input_w_s2mPipe_valid;
  wire                input_w_s2mPipe_ready;
  wire       [511:0]  input_w_s2mPipe_payload_data;
  wire       [63:0]   input_w_s2mPipe_payload_strb;
  wire       [3:0]    input_w_s2mPipe_payload_user;
  wire                input_w_s2mPipe_payload_last;
  reg                 input_w_s2mPipe_rValid;
  reg        [511:0]  input_w_s2mPipe_rData_data;
  reg        [63:0]   input_w_s2mPipe_rData_strb;
  reg        [3:0]    input_w_s2mPipe_rData_user;
  reg                 input_w_s2mPipe_rData_last;
  wire                input_w_s2mPipe_m2sPipe_valid;
  wire                input_w_s2mPipe_m2sPipe_ready;
  wire       [511:0]  input_w_s2mPipe_m2sPipe_payload_data;
  wire       [63:0]   input_w_s2mPipe_m2sPipe_payload_strb;
  wire       [3:0]    input_w_s2mPipe_m2sPipe_payload_user;
  wire                input_w_s2mPipe_m2sPipe_payload_last;
  reg                 input_w_s2mPipe_m2sPipe_rValid;
  reg        [511:0]  input_w_s2mPipe_m2sPipe_rData_data;
  reg        [63:0]   input_w_s2mPipe_m2sPipe_rData_strb;
  reg        [3:0]    input_w_s2mPipe_m2sPipe_rData_user;
  reg                 input_w_s2mPipe_m2sPipe_rData_last;
  wire                output_b_s2mPipe_valid;
  wire                output_b_s2mPipe_ready;
  wire       [3:0]    output_b_s2mPipe_payload_id;
  wire       [1:0]    output_b_s2mPipe_payload_resp;
  wire       [31:0]   output_b_s2mPipe_payload_user;
  reg                 output_b_s2mPipe_rValid;
  reg        [3:0]    output_b_s2mPipe_rData_id;
  reg        [1:0]    output_b_s2mPipe_rData_resp;
  reg        [31:0]   output_b_s2mPipe_rData_user;
  wire                output_b_s2mPipe_m2sPipe_valid;
  wire                output_b_s2mPipe_m2sPipe_ready;
  wire       [3:0]    output_b_s2mPipe_m2sPipe_payload_id;
  wire       [1:0]    output_b_s2mPipe_m2sPipe_payload_resp;
  wire       [31:0]   output_b_s2mPipe_m2sPipe_payload_user;
  reg                 output_b_s2mPipe_m2sPipe_rValid;
  reg        [3:0]    output_b_s2mPipe_m2sPipe_rData_id;
  reg        [1:0]    output_b_s2mPipe_m2sPipe_rData_resp;
  reg        [31:0]   output_b_s2mPipe_m2sPipe_rData_user;
  wire                input_ar_s2mPipe_valid;
  wire                input_ar_s2mPipe_ready;
  wire       [63:0]   input_ar_s2mPipe_payload_addr;
  wire       [3:0]    input_ar_s2mPipe_payload_id;
  wire       [7:0]    input_ar_s2mPipe_payload_len;
  wire       [2:0]    input_ar_s2mPipe_payload_size;
  wire       [1:0]    input_ar_s2mPipe_payload_burst;
  wire       [0:0]    input_ar_s2mPipe_payload_lock;
  wire       [3:0]    input_ar_s2mPipe_payload_cache;
  wire       [3:0]    input_ar_s2mPipe_payload_qos;
  wire       [31:0]   input_ar_s2mPipe_payload_user;
  wire       [2:0]    input_ar_s2mPipe_payload_prot;
  reg                 input_ar_s2mPipe_rValid;
  reg        [63:0]   input_ar_s2mPipe_rData_addr;
  reg        [3:0]    input_ar_s2mPipe_rData_id;
  reg        [7:0]    input_ar_s2mPipe_rData_len;
  reg        [2:0]    input_ar_s2mPipe_rData_size;
  reg        [1:0]    input_ar_s2mPipe_rData_burst;
  reg        [0:0]    input_ar_s2mPipe_rData_lock;
  reg        [3:0]    input_ar_s2mPipe_rData_cache;
  reg        [3:0]    input_ar_s2mPipe_rData_qos;
  reg        [31:0]   input_ar_s2mPipe_rData_user;
  reg        [2:0]    input_ar_s2mPipe_rData_prot;
  wire                input_ar_s2mPipe_m2sPipe_valid;
  wire                input_ar_s2mPipe_m2sPipe_ready;
  wire       [63:0]   input_ar_s2mPipe_m2sPipe_payload_addr;
  wire       [3:0]    input_ar_s2mPipe_m2sPipe_payload_id;
  wire       [7:0]    input_ar_s2mPipe_m2sPipe_payload_len;
  wire       [2:0]    input_ar_s2mPipe_m2sPipe_payload_size;
  wire       [1:0]    input_ar_s2mPipe_m2sPipe_payload_burst;
  wire       [0:0]    input_ar_s2mPipe_m2sPipe_payload_lock;
  wire       [3:0]    input_ar_s2mPipe_m2sPipe_payload_cache;
  wire       [3:0]    input_ar_s2mPipe_m2sPipe_payload_qos;
  wire       [31:0]   input_ar_s2mPipe_m2sPipe_payload_user;
  wire       [2:0]    input_ar_s2mPipe_m2sPipe_payload_prot;
  reg                 input_ar_s2mPipe_m2sPipe_rValid;
  reg        [63:0]   input_ar_s2mPipe_m2sPipe_rData_addr;
  reg        [3:0]    input_ar_s2mPipe_m2sPipe_rData_id;
  reg        [7:0]    input_ar_s2mPipe_m2sPipe_rData_len;
  reg        [2:0]    input_ar_s2mPipe_m2sPipe_rData_size;
  reg        [1:0]    input_ar_s2mPipe_m2sPipe_rData_burst;
  reg        [0:0]    input_ar_s2mPipe_m2sPipe_rData_lock;
  reg        [3:0]    input_ar_s2mPipe_m2sPipe_rData_cache;
  reg        [3:0]    input_ar_s2mPipe_m2sPipe_rData_qos;
  reg        [31:0]   input_ar_s2mPipe_m2sPipe_rData_user;
  reg        [2:0]    input_ar_s2mPipe_m2sPipe_rData_prot;
  wire                output_r_s2mPipe_valid;
  wire                output_r_s2mPipe_ready;
  wire       [511:0]  output_r_s2mPipe_payload_data;
  wire       [3:0]    output_r_s2mPipe_payload_id;
  wire       [1:0]    output_r_s2mPipe_payload_resp;
  wire                output_r_s2mPipe_payload_last;
  wire       [31:0]   output_r_s2mPipe_payload_user;
  reg                 output_r_s2mPipe_rValid;
  reg        [511:0]  output_r_s2mPipe_rData_data;
  reg        [3:0]    output_r_s2mPipe_rData_id;
  reg        [1:0]    output_r_s2mPipe_rData_resp;
  reg                 output_r_s2mPipe_rData_last;
  reg        [31:0]   output_r_s2mPipe_rData_user;
  wire                output_r_s2mPipe_m2sPipe_valid;
  wire                output_r_s2mPipe_m2sPipe_ready;
  wire       [511:0]  output_r_s2mPipe_m2sPipe_payload_data;
  wire       [3:0]    output_r_s2mPipe_m2sPipe_payload_id;
  wire       [1:0]    output_r_s2mPipe_m2sPipe_payload_resp;
  wire                output_r_s2mPipe_m2sPipe_payload_last;
  wire       [31:0]   output_r_s2mPipe_m2sPipe_payload_user;
  reg                 output_r_s2mPipe_m2sPipe_rValid;
  reg        [511:0]  output_r_s2mPipe_m2sPipe_rData_data;
  reg        [3:0]    output_r_s2mPipe_m2sPipe_rData_id;
  reg        [1:0]    output_r_s2mPipe_m2sPipe_rData_resp;
  reg                 output_r_s2mPipe_m2sPipe_rData_last;
  reg        [31:0]   output_r_s2mPipe_m2sPipe_rData_user;

  assign _zz_1 = (input_aw_ready && (! input_aw_s2mPipe_ready));
  assign _zz_2 = (input_w_ready && (! input_w_s2mPipe_ready));
  assign _zz_3 = (output_b_ready && (! output_b_s2mPipe_ready));
  assign _zz_4 = (input_ar_ready && (! input_ar_s2mPipe_ready));
  assign _zz_5 = (output_r_ready && (! output_r_s2mPipe_ready));
  assign input_aw_s2mPipe_valid = (input_aw_valid || input_aw_s2mPipe_rValid);
  assign input_aw_ready = (! input_aw_s2mPipe_rValid);
  assign input_aw_s2mPipe_payload_addr = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_addr : input_aw_payload_addr);
  assign input_aw_s2mPipe_payload_id = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_id : input_aw_payload_id);
  assign input_aw_s2mPipe_payload_len = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_len : input_aw_payload_len);
  assign input_aw_s2mPipe_payload_size = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_size : input_aw_payload_size);
  assign input_aw_s2mPipe_payload_burst = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_burst : input_aw_payload_burst);
  assign input_aw_s2mPipe_payload_lock = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_lock : input_aw_payload_lock);
  assign input_aw_s2mPipe_payload_cache = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_cache : input_aw_payload_cache);
  assign input_aw_s2mPipe_payload_qos = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_qos : input_aw_payload_qos);
  assign input_aw_s2mPipe_payload_user = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_user : input_aw_payload_user);
  assign input_aw_s2mPipe_payload_prot = (input_aw_s2mPipe_rValid ? input_aw_s2mPipe_rData_prot : input_aw_payload_prot);
  assign input_aw_s2mPipe_ready = ((1'b1 && (! input_aw_s2mPipe_m2sPipe_valid)) || input_aw_s2mPipe_m2sPipe_ready);
  assign input_aw_s2mPipe_m2sPipe_valid = input_aw_s2mPipe_m2sPipe_rValid;
  assign input_aw_s2mPipe_m2sPipe_payload_addr = input_aw_s2mPipe_m2sPipe_rData_addr;
  assign input_aw_s2mPipe_m2sPipe_payload_id = input_aw_s2mPipe_m2sPipe_rData_id;
  assign input_aw_s2mPipe_m2sPipe_payload_len = input_aw_s2mPipe_m2sPipe_rData_len;
  assign input_aw_s2mPipe_m2sPipe_payload_size = input_aw_s2mPipe_m2sPipe_rData_size;
  assign input_aw_s2mPipe_m2sPipe_payload_burst = input_aw_s2mPipe_m2sPipe_rData_burst;
  assign input_aw_s2mPipe_m2sPipe_payload_lock = input_aw_s2mPipe_m2sPipe_rData_lock;
  assign input_aw_s2mPipe_m2sPipe_payload_cache = input_aw_s2mPipe_m2sPipe_rData_cache;
  assign input_aw_s2mPipe_m2sPipe_payload_qos = input_aw_s2mPipe_m2sPipe_rData_qos;
  assign input_aw_s2mPipe_m2sPipe_payload_user = input_aw_s2mPipe_m2sPipe_rData_user;
  assign input_aw_s2mPipe_m2sPipe_payload_prot = input_aw_s2mPipe_m2sPipe_rData_prot;
  assign output_aw_valid = input_aw_s2mPipe_m2sPipe_valid;
  assign input_aw_s2mPipe_m2sPipe_ready = output_aw_ready;
  assign output_aw_payload_addr = input_aw_s2mPipe_m2sPipe_payload_addr;
  assign output_aw_payload_id = input_aw_s2mPipe_m2sPipe_payload_id;
  assign output_aw_payload_len = input_aw_s2mPipe_m2sPipe_payload_len;
  assign output_aw_payload_size = input_aw_s2mPipe_m2sPipe_payload_size;
  assign output_aw_payload_burst = input_aw_s2mPipe_m2sPipe_payload_burst;
  assign output_aw_payload_lock = input_aw_s2mPipe_m2sPipe_payload_lock;
  assign output_aw_payload_cache = input_aw_s2mPipe_m2sPipe_payload_cache;
  assign output_aw_payload_qos = input_aw_s2mPipe_m2sPipe_payload_qos;
  assign output_aw_payload_user = input_aw_s2mPipe_m2sPipe_payload_user;
  assign output_aw_payload_prot = input_aw_s2mPipe_m2sPipe_payload_prot;
  assign input_w_s2mPipe_valid = (input_w_valid || input_w_s2mPipe_rValid);
  assign input_w_ready = (! input_w_s2mPipe_rValid);
  assign input_w_s2mPipe_payload_data = (input_w_s2mPipe_rValid ? input_w_s2mPipe_rData_data : input_w_payload_data);
  assign input_w_s2mPipe_payload_strb = (input_w_s2mPipe_rValid ? input_w_s2mPipe_rData_strb : input_w_payload_strb);
  assign input_w_s2mPipe_payload_user = (input_w_s2mPipe_rValid ? input_w_s2mPipe_rData_user : input_w_payload_user);
  assign input_w_s2mPipe_payload_last = (input_w_s2mPipe_rValid ? input_w_s2mPipe_rData_last : input_w_payload_last);
  assign input_w_s2mPipe_ready = ((1'b1 && (! input_w_s2mPipe_m2sPipe_valid)) || input_w_s2mPipe_m2sPipe_ready);
  assign input_w_s2mPipe_m2sPipe_valid = input_w_s2mPipe_m2sPipe_rValid;
  assign input_w_s2mPipe_m2sPipe_payload_data = input_w_s2mPipe_m2sPipe_rData_data;
  assign input_w_s2mPipe_m2sPipe_payload_strb = input_w_s2mPipe_m2sPipe_rData_strb;
  assign input_w_s2mPipe_m2sPipe_payload_user = input_w_s2mPipe_m2sPipe_rData_user;
  assign input_w_s2mPipe_m2sPipe_payload_last = input_w_s2mPipe_m2sPipe_rData_last;
  assign output_w_valid = input_w_s2mPipe_m2sPipe_valid;
  assign input_w_s2mPipe_m2sPipe_ready = output_w_ready;
  assign output_w_payload_data = input_w_s2mPipe_m2sPipe_payload_data;
  assign output_w_payload_strb = input_w_s2mPipe_m2sPipe_payload_strb;
  assign output_w_payload_user = input_w_s2mPipe_m2sPipe_payload_user;
  assign output_w_payload_last = input_w_s2mPipe_m2sPipe_payload_last;
  assign output_b_s2mPipe_valid = (output_b_valid || output_b_s2mPipe_rValid);
  assign output_b_ready = (! output_b_s2mPipe_rValid);
  assign output_b_s2mPipe_payload_id = (output_b_s2mPipe_rValid ? output_b_s2mPipe_rData_id : output_b_payload_id);
  assign output_b_s2mPipe_payload_resp = (output_b_s2mPipe_rValid ? output_b_s2mPipe_rData_resp : output_b_payload_resp);
  assign output_b_s2mPipe_payload_user = (output_b_s2mPipe_rValid ? output_b_s2mPipe_rData_user : output_b_payload_user);
  assign output_b_s2mPipe_ready = ((1'b1 && (! output_b_s2mPipe_m2sPipe_valid)) || output_b_s2mPipe_m2sPipe_ready);
  assign output_b_s2mPipe_m2sPipe_valid = output_b_s2mPipe_m2sPipe_rValid;
  assign output_b_s2mPipe_m2sPipe_payload_id = output_b_s2mPipe_m2sPipe_rData_id;
  assign output_b_s2mPipe_m2sPipe_payload_resp = output_b_s2mPipe_m2sPipe_rData_resp;
  assign output_b_s2mPipe_m2sPipe_payload_user = output_b_s2mPipe_m2sPipe_rData_user;
  assign input_b_valid = output_b_s2mPipe_m2sPipe_valid;
  assign output_b_s2mPipe_m2sPipe_ready = input_b_ready;
  assign input_b_payload_id = output_b_s2mPipe_m2sPipe_payload_id;
  assign input_b_payload_resp = output_b_s2mPipe_m2sPipe_payload_resp;
  assign input_b_payload_user = output_b_s2mPipe_m2sPipe_payload_user;
  assign input_ar_s2mPipe_valid = (input_ar_valid || input_ar_s2mPipe_rValid);
  assign input_ar_ready = (! input_ar_s2mPipe_rValid);
  assign input_ar_s2mPipe_payload_addr = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_addr : input_ar_payload_addr);
  assign input_ar_s2mPipe_payload_id = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_id : input_ar_payload_id);
  assign input_ar_s2mPipe_payload_len = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_len : input_ar_payload_len);
  assign input_ar_s2mPipe_payload_size = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_size : input_ar_payload_size);
  assign input_ar_s2mPipe_payload_burst = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_burst : input_ar_payload_burst);
  assign input_ar_s2mPipe_payload_lock = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_lock : input_ar_payload_lock);
  assign input_ar_s2mPipe_payload_cache = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_cache : input_ar_payload_cache);
  assign input_ar_s2mPipe_payload_qos = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_qos : input_ar_payload_qos);
  assign input_ar_s2mPipe_payload_user = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_user : input_ar_payload_user);
  assign input_ar_s2mPipe_payload_prot = (input_ar_s2mPipe_rValid ? input_ar_s2mPipe_rData_prot : input_ar_payload_prot);
  assign input_ar_s2mPipe_ready = ((1'b1 && (! input_ar_s2mPipe_m2sPipe_valid)) || input_ar_s2mPipe_m2sPipe_ready);
  assign input_ar_s2mPipe_m2sPipe_valid = input_ar_s2mPipe_m2sPipe_rValid;
  assign input_ar_s2mPipe_m2sPipe_payload_addr = input_ar_s2mPipe_m2sPipe_rData_addr;
  assign input_ar_s2mPipe_m2sPipe_payload_id = input_ar_s2mPipe_m2sPipe_rData_id;
  assign input_ar_s2mPipe_m2sPipe_payload_len = input_ar_s2mPipe_m2sPipe_rData_len;
  assign input_ar_s2mPipe_m2sPipe_payload_size = input_ar_s2mPipe_m2sPipe_rData_size;
  assign input_ar_s2mPipe_m2sPipe_payload_burst = input_ar_s2mPipe_m2sPipe_rData_burst;
  assign input_ar_s2mPipe_m2sPipe_payload_lock = input_ar_s2mPipe_m2sPipe_rData_lock;
  assign input_ar_s2mPipe_m2sPipe_payload_cache = input_ar_s2mPipe_m2sPipe_rData_cache;
  assign input_ar_s2mPipe_m2sPipe_payload_qos = input_ar_s2mPipe_m2sPipe_rData_qos;
  assign input_ar_s2mPipe_m2sPipe_payload_user = input_ar_s2mPipe_m2sPipe_rData_user;
  assign input_ar_s2mPipe_m2sPipe_payload_prot = input_ar_s2mPipe_m2sPipe_rData_prot;
  assign output_ar_valid = input_ar_s2mPipe_m2sPipe_valid;
  assign input_ar_s2mPipe_m2sPipe_ready = output_ar_ready;
  assign output_ar_payload_addr = input_ar_s2mPipe_m2sPipe_payload_addr;
  assign output_ar_payload_id = input_ar_s2mPipe_m2sPipe_payload_id;
  assign output_ar_payload_len = input_ar_s2mPipe_m2sPipe_payload_len;
  assign output_ar_payload_size = input_ar_s2mPipe_m2sPipe_payload_size;
  assign output_ar_payload_burst = input_ar_s2mPipe_m2sPipe_payload_burst;
  assign output_ar_payload_lock = input_ar_s2mPipe_m2sPipe_payload_lock;
  assign output_ar_payload_cache = input_ar_s2mPipe_m2sPipe_payload_cache;
  assign output_ar_payload_qos = input_ar_s2mPipe_m2sPipe_payload_qos;
  assign output_ar_payload_user = input_ar_s2mPipe_m2sPipe_payload_user;
  assign output_ar_payload_prot = input_ar_s2mPipe_m2sPipe_payload_prot;
  assign output_r_s2mPipe_valid = (output_r_valid || output_r_s2mPipe_rValid);
  assign output_r_ready = (! output_r_s2mPipe_rValid);
  assign output_r_s2mPipe_payload_data = (output_r_s2mPipe_rValid ? output_r_s2mPipe_rData_data : output_r_payload_data);
  assign output_r_s2mPipe_payload_id = (output_r_s2mPipe_rValid ? output_r_s2mPipe_rData_id : output_r_payload_id);
  assign output_r_s2mPipe_payload_resp = (output_r_s2mPipe_rValid ? output_r_s2mPipe_rData_resp : output_r_payload_resp);
  assign output_r_s2mPipe_payload_last = (output_r_s2mPipe_rValid ? output_r_s2mPipe_rData_last : output_r_payload_last);
  assign output_r_s2mPipe_payload_user = (output_r_s2mPipe_rValid ? output_r_s2mPipe_rData_user : output_r_payload_user);
  assign output_r_s2mPipe_ready = ((1'b1 && (! output_r_s2mPipe_m2sPipe_valid)) || output_r_s2mPipe_m2sPipe_ready);
  assign output_r_s2mPipe_m2sPipe_valid = output_r_s2mPipe_m2sPipe_rValid;
  assign output_r_s2mPipe_m2sPipe_payload_data = output_r_s2mPipe_m2sPipe_rData_data;
  assign output_r_s2mPipe_m2sPipe_payload_id = output_r_s2mPipe_m2sPipe_rData_id;
  assign output_r_s2mPipe_m2sPipe_payload_resp = output_r_s2mPipe_m2sPipe_rData_resp;
  assign output_r_s2mPipe_m2sPipe_payload_last = output_r_s2mPipe_m2sPipe_rData_last;
  assign output_r_s2mPipe_m2sPipe_payload_user = output_r_s2mPipe_m2sPipe_rData_user;
  assign input_r_valid = output_r_s2mPipe_m2sPipe_valid;
  assign output_r_s2mPipe_m2sPipe_ready = input_r_ready;
  assign input_r_payload_data = output_r_s2mPipe_m2sPipe_payload_data;
  assign input_r_payload_id = output_r_s2mPipe_m2sPipe_payload_id;
  assign input_r_payload_resp = output_r_s2mPipe_m2sPipe_payload_resp;
  assign input_r_payload_last = output_r_s2mPipe_m2sPipe_payload_last;
  assign input_r_payload_user = output_r_s2mPipe_m2sPipe_payload_user;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      input_aw_s2mPipe_rValid <= 1'b0;
      input_aw_s2mPipe_m2sPipe_rValid <= 1'b0;
      input_w_s2mPipe_rValid <= 1'b0;
      input_w_s2mPipe_m2sPipe_rValid <= 1'b0;
      output_b_s2mPipe_rValid <= 1'b0;
      output_b_s2mPipe_m2sPipe_rValid <= 1'b0;
      input_ar_s2mPipe_rValid <= 1'b0;
      input_ar_s2mPipe_m2sPipe_rValid <= 1'b0;
      output_r_s2mPipe_rValid <= 1'b0;
      output_r_s2mPipe_m2sPipe_rValid <= 1'b0;
    end else begin
      if(input_aw_s2mPipe_ready)begin
        input_aw_s2mPipe_rValid <= 1'b0;
      end
      if(_zz_1)begin
        input_aw_s2mPipe_rValid <= input_aw_valid;
      end
      if(input_aw_s2mPipe_ready)begin
        input_aw_s2mPipe_m2sPipe_rValid <= input_aw_s2mPipe_valid;
      end
      if(input_w_s2mPipe_ready)begin
        input_w_s2mPipe_rValid <= 1'b0;
      end
      if(_zz_2)begin
        input_w_s2mPipe_rValid <= input_w_valid;
      end
      if(input_w_s2mPipe_ready)begin
        input_w_s2mPipe_m2sPipe_rValid <= input_w_s2mPipe_valid;
      end
      if(output_b_s2mPipe_ready)begin
        output_b_s2mPipe_rValid <= 1'b0;
      end
      if(_zz_3)begin
        output_b_s2mPipe_rValid <= output_b_valid;
      end
      if(output_b_s2mPipe_ready)begin
        output_b_s2mPipe_m2sPipe_rValid <= output_b_s2mPipe_valid;
      end
      if(input_ar_s2mPipe_ready)begin
        input_ar_s2mPipe_rValid <= 1'b0;
      end
      if(_zz_4)begin
        input_ar_s2mPipe_rValid <= input_ar_valid;
      end
      if(input_ar_s2mPipe_ready)begin
        input_ar_s2mPipe_m2sPipe_rValid <= input_ar_s2mPipe_valid;
      end
      if(output_r_s2mPipe_ready)begin
        output_r_s2mPipe_rValid <= 1'b0;
      end
      if(_zz_5)begin
        output_r_s2mPipe_rValid <= output_r_valid;
      end
      if(output_r_s2mPipe_ready)begin
        output_r_s2mPipe_m2sPipe_rValid <= output_r_s2mPipe_valid;
      end
    end
  end

  always @ (posedge clk) begin
    if(_zz_1)begin
      input_aw_s2mPipe_rData_addr <= input_aw_payload_addr;
      input_aw_s2mPipe_rData_id <= input_aw_payload_id;
      input_aw_s2mPipe_rData_len <= input_aw_payload_len;
      input_aw_s2mPipe_rData_size <= input_aw_payload_size;
      input_aw_s2mPipe_rData_burst <= input_aw_payload_burst;
      input_aw_s2mPipe_rData_lock <= input_aw_payload_lock;
      input_aw_s2mPipe_rData_cache <= input_aw_payload_cache;
      input_aw_s2mPipe_rData_qos <= input_aw_payload_qos;
      input_aw_s2mPipe_rData_user <= input_aw_payload_user;
      input_aw_s2mPipe_rData_prot <= input_aw_payload_prot;
    end
    if(input_aw_s2mPipe_ready)begin
      input_aw_s2mPipe_m2sPipe_rData_addr <= input_aw_s2mPipe_payload_addr;
      input_aw_s2mPipe_m2sPipe_rData_id <= input_aw_s2mPipe_payload_id;
      input_aw_s2mPipe_m2sPipe_rData_len <= input_aw_s2mPipe_payload_len;
      input_aw_s2mPipe_m2sPipe_rData_size <= input_aw_s2mPipe_payload_size;
      input_aw_s2mPipe_m2sPipe_rData_burst <= input_aw_s2mPipe_payload_burst;
      input_aw_s2mPipe_m2sPipe_rData_lock <= input_aw_s2mPipe_payload_lock;
      input_aw_s2mPipe_m2sPipe_rData_cache <= input_aw_s2mPipe_payload_cache;
      input_aw_s2mPipe_m2sPipe_rData_qos <= input_aw_s2mPipe_payload_qos;
      input_aw_s2mPipe_m2sPipe_rData_user <= input_aw_s2mPipe_payload_user;
      input_aw_s2mPipe_m2sPipe_rData_prot <= input_aw_s2mPipe_payload_prot;
    end
    if(_zz_2)begin
      input_w_s2mPipe_rData_data <= input_w_payload_data;
      input_w_s2mPipe_rData_strb <= input_w_payload_strb;
      input_w_s2mPipe_rData_user <= input_w_payload_user;
      input_w_s2mPipe_rData_last <= input_w_payload_last;
    end
    if(input_w_s2mPipe_ready)begin
      input_w_s2mPipe_m2sPipe_rData_data <= input_w_s2mPipe_payload_data;
      input_w_s2mPipe_m2sPipe_rData_strb <= input_w_s2mPipe_payload_strb;
      input_w_s2mPipe_m2sPipe_rData_user <= input_w_s2mPipe_payload_user;
      input_w_s2mPipe_m2sPipe_rData_last <= input_w_s2mPipe_payload_last;
    end
    if(_zz_3)begin
      output_b_s2mPipe_rData_id <= output_b_payload_id;
      output_b_s2mPipe_rData_resp <= output_b_payload_resp;
      output_b_s2mPipe_rData_user <= output_b_payload_user;
    end
    if(output_b_s2mPipe_ready)begin
      output_b_s2mPipe_m2sPipe_rData_id <= output_b_s2mPipe_payload_id;
      output_b_s2mPipe_m2sPipe_rData_resp <= output_b_s2mPipe_payload_resp;
      output_b_s2mPipe_m2sPipe_rData_user <= output_b_s2mPipe_payload_user;
    end
    if(_zz_4)begin
      input_ar_s2mPipe_rData_addr <= input_ar_payload_addr;
      input_ar_s2mPipe_rData_id <= input_ar_payload_id;
      input_ar_s2mPipe_rData_len <= input_ar_payload_len;
      input_ar_s2mPipe_rData_size <= input_ar_payload_size;
      input_ar_s2mPipe_rData_burst <= input_ar_payload_burst;
      input_ar_s2mPipe_rData_lock <= input_ar_payload_lock;
      input_ar_s2mPipe_rData_cache <= input_ar_payload_cache;
      input_ar_s2mPipe_rData_qos <= input_ar_payload_qos;
      input_ar_s2mPipe_rData_user <= input_ar_payload_user;
      input_ar_s2mPipe_rData_prot <= input_ar_payload_prot;
    end
    if(input_ar_s2mPipe_ready)begin
      input_ar_s2mPipe_m2sPipe_rData_addr <= input_ar_s2mPipe_payload_addr;
      input_ar_s2mPipe_m2sPipe_rData_id <= input_ar_s2mPipe_payload_id;
      input_ar_s2mPipe_m2sPipe_rData_len <= input_ar_s2mPipe_payload_len;
      input_ar_s2mPipe_m2sPipe_rData_size <= input_ar_s2mPipe_payload_size;
      input_ar_s2mPipe_m2sPipe_rData_burst <= input_ar_s2mPipe_payload_burst;
      input_ar_s2mPipe_m2sPipe_rData_lock <= input_ar_s2mPipe_payload_lock;
      input_ar_s2mPipe_m2sPipe_rData_cache <= input_ar_s2mPipe_payload_cache;
      input_ar_s2mPipe_m2sPipe_rData_qos <= input_ar_s2mPipe_payload_qos;
      input_ar_s2mPipe_m2sPipe_rData_user <= input_ar_s2mPipe_payload_user;
      input_ar_s2mPipe_m2sPipe_rData_prot <= input_ar_s2mPipe_payload_prot;
    end
    if(_zz_5)begin
      output_r_s2mPipe_rData_data <= output_r_payload_data;
      output_r_s2mPipe_rData_id <= output_r_payload_id;
      output_r_s2mPipe_rData_resp <= output_r_payload_resp;
      output_r_s2mPipe_rData_last <= output_r_payload_last;
      output_r_s2mPipe_rData_user <= output_r_payload_user;
    end
    if(output_r_s2mPipe_ready)begin
      output_r_s2mPipe_m2sPipe_rData_data <= output_r_s2mPipe_payload_data;
      output_r_s2mPipe_m2sPipe_rData_id <= output_r_s2mPipe_payload_id;
      output_r_s2mPipe_m2sPipe_rData_resp <= output_r_s2mPipe_payload_resp;
      output_r_s2mPipe_m2sPipe_rData_last <= output_r_s2mPipe_payload_last;
      output_r_s2mPipe_m2sPipe_rData_user <= output_r_s2mPipe_payload_user;
    end
  end


endmodule