// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : Aes

`timescale 1ns/1ps

module Aes (
  input               io_clk,
  input               io_reset,
  input               io_enable,
  input               io_pt_valid,
  output reg          io_pt_ready,
  input      [31:0]   io_pt_payload,
  input               io_key_valid,
  output reg          io_key_ready,
  input      [31:0]   io_key_payload,
  output reg          io_ct_valid,
  input               io_ct_ready,
  output     [31:0]   io_ct_payload,
  output reg          io_done
);
  localparam States2_sIdle = 2'd0;
  localparam States2_sInit = 2'd1;
  localparam States2_sRound = 2'd2;
  localparam States2_sDone = 2'd3;

  reg        [7:0]    r_sbox_io_subBytesInput;
  wire       [7:0]    r_addroundkey_io_b;
  wire       [7:0]    r_sbox_io_subBytesOutput;
  wire       [7:0]    r_mixcolumns_io_mcOut1;
  wire       [7:0]    r_mixcolumns_io_mcOut2;
  wire       [7:0]    r_mixcolumns_io_mcOut3;
  wire       [7:0]    r_mixcolumns_io_mcOut4;
  wire       [3:0]    _zz_r_round_valueNext;
  wire       [0:0]    _zz_r_round_valueNext_1;
  wire       [4:0]    _zz_r_control_valueNext;
  wire       [0:0]    _zz_r_control_valueNext_1;
  wire       [7:0]    _zz_r_roundConstant;
  reg        [7:0]    r_stateReg_0_0;
  reg        [7:0]    r_stateReg_0_1;
  reg        [7:0]    r_stateReg_0_2;
  reg        [7:0]    r_stateReg_0_3;
  reg        [7:0]    r_stateReg_1_0;
  reg        [7:0]    r_stateReg_1_1;
  reg        [7:0]    r_stateReg_1_2;
  reg        [7:0]    r_stateReg_1_3;
  reg        [7:0]    r_stateReg_2_0;
  reg        [7:0]    r_stateReg_2_1;
  reg        [7:0]    r_stateReg_2_2;
  reg        [7:0]    r_stateReg_2_3;
  reg        [7:0]    r_stateReg_3_0;
  reg        [7:0]    r_stateReg_3_1;
  reg        [7:0]    r_stateReg_3_2;
  reg        [7:0]    r_stateReg_3_3;
  reg        [7:0]    r_keyReg_0_0;
  reg        [7:0]    r_keyReg_0_1;
  reg        [7:0]    r_keyReg_0_2;
  reg        [7:0]    r_keyReg_0_3;
  reg        [7:0]    r_keyReg_1_0;
  reg        [7:0]    r_keyReg_1_1;
  reg        [7:0]    r_keyReg_1_2;
  reg        [7:0]    r_keyReg_1_3;
  reg        [7:0]    r_keyReg_2_0;
  reg        [7:0]    r_keyReg_2_1;
  reg        [7:0]    r_keyReg_2_2;
  reg        [7:0]    r_keyReg_2_3;
  reg        [7:0]    r_keyReg_3_0;
  reg        [7:0]    r_keyReg_3_1;
  reg        [7:0]    r_keyReg_3_2;
  reg        [7:0]    r_keyReg_3_3;
  reg        [1:0]    r_aesState;
  reg                 r_round_willIncrement;
  reg                 r_round_willClear;
  reg        [3:0]    r_round_valueNext;
  reg        [3:0]    r_round_value;
  wire                r_round_willOverflowIfInc;
  wire                r_round_willOverflow;
  reg                 r_control_willIncrement;
  reg                 r_control_willClear;
  reg        [4:0]    r_control_valueNext;
  reg        [4:0]    r_control_value;
  wire                r_control_willOverflowIfInc;
  wire                r_control_willOverflow;
  reg        [7:0]    r_roundConstant;
  reg        [7:0]    r_rc;
  reg                 r_finalKeyAdd;
  reg                 r_finalRound;
  reg                 r_initRotation;
  reg                 r_initKeyRotation;
  reg                 r_stateRotation;
  reg                 r_shiftRowsRotation;
  reg                 r_mixColumnsRotation;
  reg                 r_keyRotation;
  reg                 r_keyRotation2;
  reg                 r_keyRCRotation;
  reg                 r_finalRotation;
  wire                when_AES_l55;
  wire                when_AES_l67;
  wire                when_AES_l224;
  wire                when_AES_l272;
  wire                when_AES_l274;
  wire                io_key_fire;
  wire                io_pt_fire;
  wire                when_AES_l279;
  wire                when_AES_l282;
  wire                io_key_fire_1;
  wire                io_pt_fire_1;
  wire                when_AES_l308;
  wire                when_AES_l314;
  wire                when_AES_l320;
  wire                when_AES_l326;
  wire                when_AES_l328;
  wire                when_AES_l338;
  wire                when_AES_l345;
  wire                io_ct_fire;
  wire                when_AES_l372;
  `ifndef SYNTHESIS
  reg [47:0] r_aesState_string;
  `endif


  assign _zz_r_round_valueNext_1 = r_round_willIncrement;
  assign _zz_r_round_valueNext = {3'd0, _zz_r_round_valueNext_1};
  assign _zz_r_control_valueNext_1 = r_control_willIncrement;
  assign _zz_r_control_valueNext = {4'd0, _zz_r_control_valueNext_1};
  assign _zz_r_roundConstant = (r_roundConstant <<< 1);
  AddRoundKey r_addroundkey (
    .io_a (r_stateReg_0_0[7:0]    ), //i
    .io_k (r_keyReg_0_0[7:0]      ), //i
    .io_b (r_addroundkey_io_b[7:0])  //o
  );
  CanrightSBox r_sbox (
    .io_subBytesInput  (r_sbox_io_subBytesInput[7:0] ), //i
    .io_subBytesOutput (r_sbox_io_subBytesOutput[7:0]), //o
    .io_clk            (io_clk                       ), //i
    .io_reset          (io_reset                     )  //i
  );
  MixColumns r_mixcolumns (
    .io_mcIn1  (r_stateReg_0_0[7:0]        ), //i
    .io_mcIn2  (r_stateReg_1_0[7:0]        ), //i
    .io_mcIn3  (r_stateReg_2_0[7:0]        ), //i
    .io_mcIn4  (r_stateReg_3_0[7:0]        ), //i
    .io_mcOut1 (r_mixcolumns_io_mcOut1[7:0]), //o
    .io_mcOut2 (r_mixcolumns_io_mcOut2[7:0]), //o
    .io_mcOut3 (r_mixcolumns_io_mcOut3[7:0]), //o
    .io_mcOut4 (r_mixcolumns_io_mcOut4[7:0])  //o
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(r_aesState)
      States2_sIdle : r_aesState_string = "sIdle ";
      States2_sInit : r_aesState_string = "sInit ";
      States2_sRound : r_aesState_string = "sRound";
      States2_sDone : r_aesState_string = "sDone ";
      default : r_aesState_string = "??????";
    endcase
  end
  `endif

  always @(*) begin
    r_round_willIncrement = 1'b0; // @[Utils.scala 536:23]
    if(r_control_willOverflow) begin
      r_round_willIncrement = 1'b1; // @[Utils.scala 540:41]
    end
  end

  always @(*) begin
    r_round_willClear = 1'b0; // @[Utils.scala 537:19]
    case(r_aesState)
      States2_sIdle : begin
        r_round_willClear = 1'b1; // @[Utils.scala 539:33]
      end
      States2_sInit : begin
      end
      States2_sRound : begin
      end
      default : begin
      end
    endcase
  end

  assign r_round_willOverflowIfInc = (r_round_value == 4'b1011); // @[BaseType.scala 305:24]
  assign r_round_willOverflow = (r_round_willOverflowIfInc && r_round_willIncrement); // @[BaseType.scala 305:24]
  always @(*) begin
    if(r_round_willOverflow) begin
      r_round_valueNext = 4'b0001; // @[Utils.scala 552:17]
    end else begin
      r_round_valueNext = (r_round_value + _zz_r_round_valueNext); // @[Utils.scala 554:17]
    end
    if(r_round_willClear) begin
      r_round_valueNext = 4'b0001; // @[Utils.scala 558:15]
    end
  end

  always @(*) begin
    r_control_willIncrement = 1'b0; // @[Utils.scala 536:23]
    case(r_aesState)
      States2_sIdle : begin
      end
      States2_sInit : begin
        if(when_AES_l279) begin
          r_control_willIncrement = 1'b1; // @[Utils.scala 540:41]
        end
      end
      States2_sRound : begin
        r_control_willIncrement = 1'b1; // @[Utils.scala 540:41]
      end
      default : begin
        if(io_ct_fire) begin
          r_control_willIncrement = 1'b1; // @[Utils.scala 540:41]
        end
      end
    endcase
  end

  always @(*) begin
    r_control_willClear = 1'b0; // @[Utils.scala 537:19]
    case(r_aesState)
      States2_sIdle : begin
        r_control_willClear = 1'b1; // @[Utils.scala 539:33]
      end
      States2_sInit : begin
        if(when_AES_l279) begin
          if(when_AES_l282) begin
            r_control_willClear = 1'b1; // @[Utils.scala 539:33]
          end
        end
      end
      States2_sRound : begin
        if(when_AES_l345) begin
          r_control_willClear = 1'b1; // @[Utils.scala 539:33]
        end
      end
      default : begin
      end
    endcase
  end

  assign r_control_willOverflowIfInc = (r_control_value == 5'h14); // @[BaseType.scala 305:24]
  assign r_control_willOverflow = (r_control_willOverflowIfInc && r_control_willIncrement); // @[BaseType.scala 305:24]
  always @(*) begin
    if(r_control_willOverflow) begin
      r_control_valueNext = 5'h0; // @[Utils.scala 552:17]
    end else begin
      r_control_valueNext = (r_control_value + _zz_r_control_valueNext); // @[Utils.scala 554:17]
    end
    if(r_control_willClear) begin
      r_control_valueNext = 5'h0; // @[Utils.scala 558:15]
    end
  end

  assign when_AES_l55 = (r_control_value < 5'h10); // @[BaseType.scala 305:24]
  always @(*) begin
    if(when_AES_l55) begin
      r_sbox_io_subBytesInput = r_addroundkey_io_b; // @[AES.scala 56:47]
    end else begin
      r_sbox_io_subBytesInput = r_keyReg_1_3; // @[AES.scala 58:47]
    end
  end

  assign when_AES_l67 = (r_control_value == 5'h11); // @[BaseType.scala 305:24]
  always @(*) begin
    if(when_AES_l67) begin
      r_rc = r_roundConstant; // @[AES.scala 68:28]
    end else begin
      r_rc = 8'h0; // @[AES.scala 70:28]
    end
  end

  always @(*) begin
    io_pt_ready = 1'b0; // @[AES.scala 217:29]
    case(r_aesState)
      States2_sIdle : begin
      end
      States2_sInit : begin
        if(!when_AES_l272) begin
          if(when_AES_l274) begin
            io_pt_ready = 1'b1; // @[AES.scala 275:53]
          end
        end
      end
      States2_sRound : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_key_ready = 1'b0; // @[AES.scala 218:30]
    case(r_aesState)
      States2_sIdle : begin
      end
      States2_sInit : begin
        if(when_AES_l272) begin
          io_key_ready = 1'b1; // @[AES.scala 273:54]
        end
      end
      States2_sRound : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_ct_valid = 1'b0; // @[AES.scala 219:29]
    case(r_aesState)
      States2_sIdle : begin
      end
      States2_sInit : begin
      end
      States2_sRound : begin
      end
      default : begin
        io_ct_valid = 1'b1; // @[AES.scala 367:45]
      end
    endcase
  end

  assign io_ct_payload = {{{r_stateReg_0_0,r_stateReg_1_0},r_stateReg_2_0},r_stateReg_3_0}; // @[AES.scala 220:31]
  always @(*) begin
    io_done = 1'b0; // @[AES.scala 221:25]
    case(r_aesState)
      States2_sIdle : begin
      end
      States2_sInit : begin
      end
      States2_sRound : begin
      end
      default : begin
        io_done = 1'b1; // @[AES.scala 352:41]
      end
    endcase
  end

  assign when_AES_l224 = (r_roundConstant < 8'h80); // @[BaseType.scala 305:24]
  always @(*) begin
    case(r_aesState)
      States2_sIdle : begin
        r_initRotation = 1'b0; // @[AES.scala 235:46]
      end
      States2_sInit : begin
        r_initRotation = 1'b0; // @[AES.scala 260:46]
        if(io_pt_fire_1) begin
          r_initRotation = 1'b1; // @[AES.scala 293:54]
        end
      end
      States2_sRound : begin
        r_initRotation = 1'b0; // @[AES.scala 302:46]
      end
      default : begin
        r_initRotation = 1'b0; // @[AES.scala 355:46]
        if(io_ct_fire) begin
          r_initRotation = 1'b1; // @[AES.scala 369:54]
        end
      end
    endcase
  end

  always @(*) begin
    case(r_aesState)
      States2_sIdle : begin
        r_initKeyRotation = 1'b0; // @[AES.scala 236:49]
      end
      States2_sInit : begin
        r_initKeyRotation = 1'b0; // @[AES.scala 261:49]
        if(io_key_fire_1) begin
          r_initKeyRotation = 1'b1; // @[AES.scala 289:57]
        end
      end
      States2_sRound : begin
        r_initKeyRotation = 1'b0; // @[AES.scala 303:49]
      end
      default : begin
        r_initKeyRotation = 1'b0; // @[AES.scala 356:49]
      end
    endcase
  end

  always @(*) begin
    case(r_aesState)
      States2_sIdle : begin
        r_stateRotation = 1'b0; // @[AES.scala 237:47]
      end
      States2_sInit : begin
        r_stateRotation = 1'b0; // @[AES.scala 262:47]
      end
      States2_sRound : begin
        if(when_AES_l308) begin
          r_stateRotation = 1'b1; // @[AES.scala 309:55]
        end else begin
          r_stateRotation = 1'b0; // @[AES.scala 311:55]
        end
      end
      default : begin
        r_stateRotation = 1'b0; // @[AES.scala 357:47]
      end
    endcase
  end

  always @(*) begin
    case(r_aesState)
      States2_sIdle : begin
        r_shiftRowsRotation = 1'b0; // @[AES.scala 238:51]
      end
      States2_sInit : begin
        r_shiftRowsRotation = 1'b0; // @[AES.scala 263:51]
      end
      States2_sRound : begin
        if(when_AES_l314) begin
          r_shiftRowsRotation = 1'b1; // @[AES.scala 315:59]
        end else begin
          r_shiftRowsRotation = 1'b0; // @[AES.scala 317:59]
        end
      end
      default : begin
        r_shiftRowsRotation = 1'b0; // @[AES.scala 358:51]
      end
    endcase
  end

  always @(*) begin
    case(r_aesState)
      States2_sIdle : begin
        r_mixColumnsRotation = 1'b0; // @[AES.scala 239:52]
      end
      States2_sInit : begin
        r_mixColumnsRotation = 1'b0; // @[AES.scala 264:52]
      end
      States2_sRound : begin
        if(when_AES_l320) begin
          r_mixColumnsRotation = 1'b1; // @[AES.scala 321:60]
        end else begin
          r_mixColumnsRotation = 1'b0; // @[AES.scala 323:60]
        end
      end
      default : begin
        r_mixColumnsRotation = 1'b0; // @[AES.scala 359:52]
      end
    endcase
  end

  always @(*) begin
    case(r_aesState)
      States2_sIdle : begin
        r_keyRotation = 1'b0; // @[AES.scala 240:45]
      end
      States2_sInit : begin
        r_keyRotation = 1'b0; // @[AES.scala 265:45]
      end
      States2_sRound : begin
        if(when_AES_l326) begin
          r_keyRotation = 1'b1; // @[AES.scala 327:53]
        end else begin
          r_keyRotation = 1'b0; // @[AES.scala 334:53]
        end
      end
      default : begin
        r_keyRotation = 1'b0; // @[AES.scala 360:45]
      end
    endcase
  end

  always @(*) begin
    case(r_aesState)
      States2_sIdle : begin
        r_keyRotation2 = 1'b0; // @[AES.scala 241:46]
      end
      States2_sInit : begin
        r_keyRotation2 = 1'b0; // @[AES.scala 266:46]
      end
      States2_sRound : begin
        if(when_AES_l326) begin
          if(when_AES_l328) begin
            r_keyRotation2 = 1'b1; // @[AES.scala 329:62]
          end else begin
            r_keyRotation2 = 1'b0; // @[AES.scala 331:62]
          end
        end else begin
          r_keyRotation2 = 1'b0; // @[AES.scala 335:54]
        end
      end
      default : begin
        r_keyRotation2 = 1'b0; // @[AES.scala 361:46]
      end
    endcase
  end

  always @(*) begin
    case(r_aesState)
      States2_sIdle : begin
        r_keyRCRotation = 1'b0; // @[AES.scala 242:47]
      end
      States2_sInit : begin
        r_keyRCRotation = 1'b0; // @[AES.scala 267:47]
      end
      States2_sRound : begin
        if(when_AES_l338) begin
          r_keyRCRotation = 1'b1; // @[AES.scala 339:55]
        end else begin
          r_keyRCRotation = 1'b0; // @[AES.scala 341:55]
        end
      end
      default : begin
        r_keyRCRotation = 1'b0; // @[AES.scala 362:47]
      end
    endcase
  end

  always @(*) begin
    case(r_aesState)
      States2_sIdle : begin
        r_finalRotation = 1'b0; // @[AES.scala 243:47]
      end
      States2_sInit : begin
        r_finalRotation = 1'b0; // @[AES.scala 268:47]
      end
      States2_sRound : begin
        r_finalRotation = 1'b0; // @[AES.scala 304:47]
      end
      default : begin
        r_finalRotation = 1'b0; // @[AES.scala 363:47]
        if(io_ct_fire) begin
          r_finalRotation = 1'b1; // @[AES.scala 370:55]
        end
      end
    endcase
  end

  always @(*) begin
    case(r_aesState)
      States2_sIdle : begin
        r_finalRound = 1'b0; // @[AES.scala 244:44]
      end
      States2_sInit : begin
        r_finalRound = 1'b0; // @[AES.scala 269:44]
      end
      States2_sRound : begin
        r_finalRound = (r_round_value == 4'b1010); // @[AES.scala 305:44]
      end
      default : begin
        r_finalRound = 1'b0; // @[AES.scala 364:44]
      end
    endcase
  end

  always @(*) begin
    case(r_aesState)
      States2_sIdle : begin
        r_finalKeyAdd = 1'b0; // @[AES.scala 245:45]
      end
      States2_sInit : begin
        r_finalKeyAdd = 1'b0; // @[AES.scala 270:45]
      end
      States2_sRound : begin
        r_finalKeyAdd = (r_round_value == 4'b1011); // @[AES.scala 306:45]
      end
      default : begin
        r_finalKeyAdd = 1'b0; // @[AES.scala 365:45]
      end
    endcase
  end

  assign when_AES_l272 = (r_control_value < 5'h04); // @[BaseType.scala 305:24]
  assign when_AES_l274 = (r_control_value < 5'h08); // @[BaseType.scala 305:24]
  assign io_key_fire = (io_key_valid && io_key_ready); // @[BaseType.scala 305:24]
  assign io_pt_fire = (io_pt_valid && io_pt_ready); // @[BaseType.scala 305:24]
  assign when_AES_l279 = (io_key_fire || io_pt_fire); // @[BaseType.scala 305:24]
  assign when_AES_l282 = (r_control_value == 5'h07); // @[BaseType.scala 305:24]
  assign io_key_fire_1 = (io_key_valid && io_key_ready); // @[BaseType.scala 305:24]
  assign io_pt_fire_1 = (io_pt_valid && io_pt_ready); // @[BaseType.scala 305:24]
  assign when_AES_l308 = (r_control_value < 5'h10); // @[BaseType.scala 305:24]
  assign when_AES_l314 = (r_control_value == 5'h10); // @[BaseType.scala 305:24]
  assign when_AES_l320 = (5'h10 < r_control_value); // @[BaseType.scala 305:24]
  assign when_AES_l326 = (r_control_value < 5'h10); // @[BaseType.scala 305:24]
  assign when_AES_l328 = ((r_control_value < 5'h0c) && (4'b0001 < r_round_value)); // @[BaseType.scala 305:24]
  assign when_AES_l338 = (5'h11 <= r_control_value); // @[BaseType.scala 305:24]
  assign when_AES_l345 = ((r_round_value == 4'b1011) && (r_control_value == 5'h0f)); // @[BaseType.scala 305:24]
  assign io_ct_fire = (io_ct_valid && io_ct_ready); // @[BaseType.scala 305:24]
  assign when_AES_l372 = (r_control_value == 5'h03); // @[BaseType.scala 305:24]
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      r_stateReg_0_0 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_1 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_2 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_3 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_0 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_1 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_2 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_3 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_2_0 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_2_1 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_2_2 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_2_3 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_3_0 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_3_1 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_3_2 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_3_3 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_0 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_1 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_2 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_3 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_0 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_1 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_2 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_3 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_2_0 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_2_1 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_2_2 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_2_3 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_3_0 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_3_1 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_3_2 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_3_3 <= 8'h0; // @[Data.scala 400:33]
      r_aesState <= States2_sIdle; // @[Data.scala 400:33]
      r_round_value <= 4'b0001; // @[Data.scala 400:33]
      r_control_value <= 5'h0; // @[Data.scala 400:33]
      r_roundConstant <= 8'h01; // @[Data.scala 400:33]
    end else begin
      r_round_value <= r_round_valueNext; // @[Reg.scala 39:30]
      r_control_value <= r_control_valueNext; // @[Reg.scala 39:30]
      if(r_initRotation) begin
        r_stateReg_0_0 <= r_stateReg_0_1; // @[AES.scala 75:40]
        r_stateReg_0_1 <= r_stateReg_0_2; // @[AES.scala 76:40]
        r_stateReg_0_2 <= r_stateReg_0_3; // @[AES.scala 77:40]
        r_stateReg_0_3 <= io_pt_payload[31 : 24]; // @[AES.scala 78:40]
        r_stateReg_1_0 <= r_stateReg_1_1; // @[AES.scala 79:40]
        r_stateReg_1_1 <= r_stateReg_1_2; // @[AES.scala 80:40]
        r_stateReg_1_2 <= r_stateReg_1_3; // @[AES.scala 81:40]
        r_stateReg_1_3 <= io_pt_payload[23 : 16]; // @[AES.scala 82:40]
        r_stateReg_2_0 <= r_stateReg_2_1; // @[AES.scala 83:40]
        r_stateReg_2_1 <= r_stateReg_2_2; // @[AES.scala 84:40]
        r_stateReg_2_2 <= r_stateReg_2_3; // @[AES.scala 85:40]
        r_stateReg_2_3 <= io_pt_payload[15 : 8]; // @[AES.scala 86:40]
        r_stateReg_3_0 <= r_stateReg_3_1; // @[AES.scala 87:40]
        r_stateReg_3_1 <= r_stateReg_3_2; // @[AES.scala 88:40]
        r_stateReg_3_2 <= r_stateReg_3_3; // @[AES.scala 89:40]
        r_stateReg_3_3 <= io_pt_payload[7 : 0]; // @[AES.scala 90:40]
        if(r_finalRotation) begin
          r_stateReg_0_3 <= r_stateReg_0_0; // @[AES.scala 92:48]
          r_stateReg_1_3 <= r_stateReg_1_0; // @[AES.scala 93:48]
          r_stateReg_2_3 <= r_stateReg_2_0; // @[AES.scala 94:48]
          r_stateReg_3_3 <= r_stateReg_3_0; // @[AES.scala 95:48]
        end
      end else begin
        if(r_stateRotation) begin
          r_stateReg_0_0 <= r_stateReg_1_0; // @[AES.scala 99:40]
          r_stateReg_1_0 <= r_stateReg_2_0; // @[AES.scala 100:40]
          r_stateReg_2_0 <= r_stateReg_3_0; // @[AES.scala 101:40]
          r_stateReg_3_0 <= r_stateReg_0_1; // @[AES.scala 102:40]
          r_stateReg_0_1 <= r_stateReg_1_1; // @[AES.scala 103:40]
          r_stateReg_1_1 <= r_stateReg_2_1; // @[AES.scala 104:40]
          r_stateReg_2_1 <= r_stateReg_3_1; // @[AES.scala 105:40]
          r_stateReg_3_1 <= r_stateReg_0_2; // @[AES.scala 106:40]
          r_stateReg_0_2 <= r_stateReg_1_2; // @[AES.scala 107:40]
          r_stateReg_1_2 <= r_stateReg_2_2; // @[AES.scala 108:40]
          r_stateReg_2_2 <= r_stateReg_3_2; // @[AES.scala 109:40]
          r_stateReg_3_2 <= r_stateReg_0_3; // @[AES.scala 110:40]
          r_stateReg_0_3 <= r_stateReg_1_3; // @[AES.scala 111:40]
          r_stateReg_1_3 <= r_stateReg_2_3; // @[AES.scala 112:40]
          r_stateReg_2_3 <= r_stateReg_3_3; // @[AES.scala 113:40]
          r_stateReg_3_3 <= r_sbox_io_subBytesOutput; // @[AES.scala 114:40]
          if(r_finalKeyAdd) begin
            r_stateReg_3_3 <= r_addroundkey_io_b; // @[AES.scala 116:48]
          end
        end else begin
          if(r_shiftRowsRotation) begin
            r_stateReg_0_0 <= r_stateReg_0_0; // @[AES.scala 120:40]
            r_stateReg_0_1 <= r_stateReg_0_1; // @[AES.scala 121:40]
            r_stateReg_0_2 <= r_stateReg_0_2; // @[AES.scala 122:40]
            r_stateReg_0_3 <= r_stateReg_0_3; // @[AES.scala 123:40]
            r_stateReg_1_0 <= r_stateReg_1_1; // @[AES.scala 124:40]
            r_stateReg_1_1 <= r_stateReg_1_2; // @[AES.scala 125:40]
            r_stateReg_1_2 <= r_stateReg_1_3; // @[AES.scala 126:40]
            r_stateReg_1_3 <= r_stateReg_1_0; // @[AES.scala 127:40]
            r_stateReg_2_0 <= r_stateReg_2_2; // @[AES.scala 128:40]
            r_stateReg_2_1 <= r_stateReg_2_3; // @[AES.scala 129:40]
            r_stateReg_2_2 <= r_stateReg_2_0; // @[AES.scala 130:40]
            r_stateReg_2_3 <= r_stateReg_2_1; // @[AES.scala 131:40]
            r_stateReg_3_0 <= r_stateReg_3_3; // @[AES.scala 132:40]
            r_stateReg_3_1 <= r_stateReg_3_0; // @[AES.scala 133:40]
            r_stateReg_3_2 <= r_stateReg_3_1; // @[AES.scala 134:40]
            r_stateReg_3_3 <= r_stateReg_3_2; // @[AES.scala 135:40]
          end else begin
            if(r_mixColumnsRotation) begin
              r_stateReg_0_0 <= r_stateReg_0_1; // @[AES.scala 138:40]
              r_stateReg_1_0 <= r_stateReg_1_1; // @[AES.scala 139:40]
              r_stateReg_2_0 <= r_stateReg_2_1; // @[AES.scala 140:40]
              r_stateReg_3_0 <= r_stateReg_3_1; // @[AES.scala 141:40]
              r_stateReg_0_1 <= r_stateReg_0_2; // @[AES.scala 142:40]
              r_stateReg_1_1 <= r_stateReg_1_2; // @[AES.scala 143:40]
              r_stateReg_2_1 <= r_stateReg_2_2; // @[AES.scala 144:40]
              r_stateReg_3_1 <= r_stateReg_3_2; // @[AES.scala 145:40]
              r_stateReg_0_2 <= r_stateReg_0_3; // @[AES.scala 146:40]
              r_stateReg_1_2 <= r_stateReg_1_3; // @[AES.scala 147:40]
              r_stateReg_2_2 <= r_stateReg_2_3; // @[AES.scala 148:40]
              r_stateReg_3_2 <= r_stateReg_3_3; // @[AES.scala 149:40]
              r_stateReg_0_3 <= r_mixcolumns_io_mcOut1; // @[AES.scala 150:40]
              r_stateReg_1_3 <= r_mixcolumns_io_mcOut2; // @[AES.scala 151:40]
              r_stateReg_2_3 <= r_mixcolumns_io_mcOut3; // @[AES.scala 152:40]
              r_stateReg_3_3 <= r_mixcolumns_io_mcOut4; // @[AES.scala 153:40]
              if(r_finalRound) begin
                r_stateReg_0_3 <= r_stateReg_0_0; // @[AES.scala 155:48]
                r_stateReg_1_3 <= r_stateReg_1_0; // @[AES.scala 156:48]
                r_stateReg_2_3 <= r_stateReg_2_0; // @[AES.scala 157:48]
                r_stateReg_3_3 <= r_stateReg_3_0; // @[AES.scala 158:48]
              end
            end
          end
        end
      end
      if(r_initKeyRotation) begin
        r_keyReg_0_0 <= r_keyReg_0_1; // @[AES.scala 164:38]
        r_keyReg_0_1 <= r_keyReg_0_2; // @[AES.scala 165:38]
        r_keyReg_0_2 <= r_keyReg_0_3; // @[AES.scala 166:38]
        r_keyReg_0_3 <= io_key_payload[31 : 24]; // @[AES.scala 167:38]
        r_keyReg_1_0 <= r_keyReg_1_1; // @[AES.scala 168:38]
        r_keyReg_1_1 <= r_keyReg_1_2; // @[AES.scala 169:38]
        r_keyReg_1_2 <= r_keyReg_1_3; // @[AES.scala 170:38]
        r_keyReg_1_3 <= io_key_payload[23 : 16]; // @[AES.scala 171:38]
        r_keyReg_2_0 <= r_keyReg_2_1; // @[AES.scala 172:38]
        r_keyReg_2_1 <= r_keyReg_2_2; // @[AES.scala 173:38]
        r_keyReg_2_2 <= r_keyReg_2_3; // @[AES.scala 174:38]
        r_keyReg_2_3 <= io_key_payload[15 : 8]; // @[AES.scala 175:38]
        r_keyReg_3_0 <= r_keyReg_3_1; // @[AES.scala 176:38]
        r_keyReg_3_1 <= r_keyReg_3_2; // @[AES.scala 177:38]
        r_keyReg_3_2 <= r_keyReg_3_3; // @[AES.scala 178:38]
        r_keyReg_3_3 <= io_key_payload[7 : 0]; // @[AES.scala 179:38]
      end else begin
        if(r_keyRotation) begin
          r_keyReg_0_0 <= r_keyReg_1_0; // @[AES.scala 182:38]
          r_keyReg_1_0 <= r_keyReg_2_0; // @[AES.scala 183:38]
          r_keyReg_2_0 <= r_keyReg_3_0; // @[AES.scala 184:38]
          r_keyReg_0_1 <= r_keyReg_1_1; // @[AES.scala 185:38]
          r_keyReg_1_1 <= r_keyReg_2_1; // @[AES.scala 186:38]
          r_keyReg_2_1 <= r_keyReg_3_1; // @[AES.scala 187:38]
          r_keyReg_0_2 <= r_keyReg_1_2; // @[AES.scala 188:38]
          r_keyReg_1_2 <= r_keyReg_2_2; // @[AES.scala 189:38]
          r_keyReg_2_2 <= r_keyReg_3_2; // @[AES.scala 190:38]
          r_keyReg_0_3 <= r_keyReg_1_3; // @[AES.scala 191:38]
          r_keyReg_1_3 <= r_keyReg_2_3; // @[AES.scala 192:38]
          r_keyReg_2_3 <= r_keyReg_3_3; // @[AES.scala 193:38]
          r_keyReg_3_0 <= r_keyReg_0_1; // @[AES.scala 194:38]
          r_keyReg_3_1 <= r_keyReg_0_2; // @[AES.scala 195:38]
          r_keyReg_3_2 <= r_keyReg_0_3; // @[AES.scala 196:38]
          r_keyReg_3_3 <= r_keyReg_0_0; // @[AES.scala 197:38]
          if(r_keyRotation2) begin
            r_keyReg_3_0 <= (r_keyReg_0_0 ^ r_keyReg_0_1); // @[AES.scala 200:46]
            r_keyReg_3_1 <= r_keyReg_0_2; // @[AES.scala 201:46]
            r_keyReg_3_2 <= r_keyReg_0_3; // @[AES.scala 202:46]
            r_keyReg_3_3 <= r_keyReg_0_0; // @[AES.scala 203:46]
          end
        end else begin
          if(r_keyRCRotation) begin
            r_keyReg_0_0 <= r_keyReg_1_0; // @[AES.scala 207:38]
            r_keyReg_1_0 <= r_keyReg_2_0; // @[AES.scala 208:38]
            r_keyReg_2_0 <= r_keyReg_3_0; // @[AES.scala 209:38]
            r_keyReg_3_0 <= ((r_sbox_io_subBytesOutput ^ r_keyReg_0_0) ^ r_rc); // @[AES.scala 210:38]
            r_keyReg_1_3 <= r_keyReg_2_3; // @[AES.scala 211:38]
            r_keyReg_2_3 <= r_keyReg_3_3; // @[AES.scala 212:38]
            r_keyReg_3_3 <= r_keyReg_0_3; // @[AES.scala 213:38]
            r_keyReg_0_3 <= r_keyReg_1_3; // @[AES.scala 214:38]
          end
        end
      end
      if(r_control_willOverflow) begin
        if(when_AES_l224) begin
          r_roundConstant <= (r_roundConstant <<< 1); // @[AES.scala 225:47]
        end else begin
          r_roundConstant <= (_zz_r_roundConstant ^ 8'h1b); // @[AES.scala 227:47]
        end
      end
      case(r_aesState)
        States2_sIdle : begin
          r_aesState <= States2_sIdle; // @[Enum.scala 148:67]
          r_stateReg_0_0 <= 8'h0; // @[AES.scala 247:72]
          r_stateReg_0_1 <= 8'h0; // @[AES.scala 247:72]
          r_stateReg_0_2 <= 8'h0; // @[AES.scala 247:72]
          r_stateReg_0_3 <= 8'h0; // @[AES.scala 247:72]
          r_stateReg_1_0 <= 8'h0; // @[AES.scala 247:72]
          r_stateReg_1_1 <= 8'h0; // @[AES.scala 247:72]
          r_stateReg_1_2 <= 8'h0; // @[AES.scala 247:72]
          r_stateReg_1_3 <= 8'h0; // @[AES.scala 247:72]
          r_stateReg_2_0 <= 8'h0; // @[AES.scala 247:72]
          r_stateReg_2_1 <= 8'h0; // @[AES.scala 247:72]
          r_stateReg_2_2 <= 8'h0; // @[AES.scala 247:72]
          r_stateReg_2_3 <= 8'h0; // @[AES.scala 247:72]
          r_stateReg_3_0 <= 8'h0; // @[AES.scala 247:72]
          r_stateReg_3_1 <= 8'h0; // @[AES.scala 247:72]
          r_stateReg_3_2 <= 8'h0; // @[AES.scala 247:72]
          r_stateReg_3_3 <= 8'h0; // @[AES.scala 247:72]
          r_keyReg_0_0 <= 8'h0; // @[AES.scala 248:70]
          r_keyReg_0_1 <= 8'h0; // @[AES.scala 248:70]
          r_keyReg_0_2 <= 8'h0; // @[AES.scala 248:70]
          r_keyReg_0_3 <= 8'h0; // @[AES.scala 248:70]
          r_keyReg_1_0 <= 8'h0; // @[AES.scala 248:70]
          r_keyReg_1_1 <= 8'h0; // @[AES.scala 248:70]
          r_keyReg_1_2 <= 8'h0; // @[AES.scala 248:70]
          r_keyReg_1_3 <= 8'h0; // @[AES.scala 248:70]
          r_keyReg_2_0 <= 8'h0; // @[AES.scala 248:70]
          r_keyReg_2_1 <= 8'h0; // @[AES.scala 248:70]
          r_keyReg_2_2 <= 8'h0; // @[AES.scala 248:70]
          r_keyReg_2_3 <= 8'h0; // @[AES.scala 248:70]
          r_keyReg_3_0 <= 8'h0; // @[AES.scala 248:70]
          r_keyReg_3_1 <= 8'h0; // @[AES.scala 248:70]
          r_keyReg_3_2 <= 8'h0; // @[AES.scala 248:70]
          r_keyReg_3_3 <= 8'h0; // @[AES.scala 248:70]
          r_roundConstant <= 8'h01; // @[AES.scala 251:47]
          if(io_enable) begin
            r_aesState <= States2_sInit; // @[Enum.scala 148:67]
          end
        end
        States2_sInit : begin
          r_aesState <= States2_sInit; // @[Enum.scala 148:67]
          if(when_AES_l279) begin
            if(when_AES_l282) begin
              r_aesState <= States2_sRound; // @[Enum.scala 148:67]
            end
          end
        end
        States2_sRound : begin
          r_aesState <= States2_sRound; // @[Enum.scala 148:67]
          if(when_AES_l345) begin
            r_aesState <= States2_sDone; // @[Enum.scala 148:67]
          end
        end
        default : begin
          r_aesState <= States2_sDone; // @[Enum.scala 148:67]
          if(io_ct_fire) begin
            if(when_AES_l372) begin
              r_aesState <= States2_sIdle; // @[Enum.scala 148:67]
            end
          end
        end
      endcase
    end
  end


endmodule

module MixColumns (
  input      [7:0]    io_mcIn1,
  input      [7:0]    io_mcIn2,
  input      [7:0]    io_mcIn3,
  input      [7:0]    io_mcIn4,
  output     [7:0]    io_mcOut1,
  output     [7:0]    io_mcOut2,
  output     [7:0]    io_mcOut3,
  output     [7:0]    io_mcOut4
);

  wire       [8:0]    _zz__zz_io_mcOut1;
  wire       [8:0]    _zz__zz_io_mcOut1_1;
  wire       [8:0]    _zz__zz_io_mcOut2;
  wire       [8:0]    _zz__zz_io_mcOut2_1;
  wire       [8:0]    _zz__zz_io_mcOut3;
  wire       [8:0]    _zz__zz_io_mcOut3_1;
  wire       [8:0]    _zz__zz_io_mcOut4;
  wire       [8:0]    _zz__zz_io_mcOut4_1;
  wire       [7:0]    a1;
  wire       [7:0]    a2;
  wire       [7:0]    a3;
  wire       [7:0]    a0;
  reg        [8:0]    _zz_io_mcOut1;
  wire                when_MixColumns_l24;
  reg        [8:0]    _zz_io_mcOut1_1;
  wire                when_MixColumns_l24_1;
  reg        [8:0]    _zz_io_mcOut2;
  wire                when_MixColumns_l24_2;
  reg        [8:0]    _zz_io_mcOut2_1;
  wire                when_MixColumns_l24_3;
  reg        [8:0]    _zz_io_mcOut3;
  wire                when_MixColumns_l24_4;
  reg        [8:0]    _zz_io_mcOut3_1;
  wire                when_MixColumns_l24_5;
  reg        [8:0]    _zz_io_mcOut4;
  wire                when_MixColumns_l24_6;
  reg        [8:0]    _zz_io_mcOut4_1;
  wire                when_MixColumns_l24_7;

  assign _zz__zz_io_mcOut1 = ({1'd0,a0} <<< 1);
  assign _zz__zz_io_mcOut1_1 = ({1'd0,a1} <<< 1);
  assign _zz__zz_io_mcOut2 = ({1'd0,a1} <<< 1);
  assign _zz__zz_io_mcOut2_1 = ({1'd0,a2} <<< 1);
  assign _zz__zz_io_mcOut3 = ({1'd0,a2} <<< 1);
  assign _zz__zz_io_mcOut3_1 = ({1'd0,a3} <<< 1);
  assign _zz__zz_io_mcOut4 = ({1'd0,a0} <<< 1);
  assign _zz__zz_io_mcOut4_1 = ({1'd0,a3} <<< 1);
  assign a0 = io_mcIn1; // @[MixColumns.scala 17:12]
  assign a1 = io_mcIn2; // @[MixColumns.scala 18:12]
  assign a2 = io_mcIn3; // @[MixColumns.scala 19:12]
  assign a3 = io_mcIn4; // @[MixColumns.scala 20:12]
  assign when_MixColumns_l24 = a0[7]; // @[BaseType.scala 305:24]
  always @(*) begin
    if(when_MixColumns_l24) begin
      _zz_io_mcOut1 = (_zz__zz_io_mcOut1 ^ 9'h11b); // @[MixColumns.scala 25:27]
    end else begin
      _zz_io_mcOut1 = ({1'd0,a0} <<< 1); // @[MixColumns.scala 27:27]
    end
  end

  assign when_MixColumns_l24_1 = a1[7]; // @[BaseType.scala 305:24]
  always @(*) begin
    if(when_MixColumns_l24_1) begin
      _zz_io_mcOut1_1 = (_zz__zz_io_mcOut1_1 ^ 9'h11b); // @[MixColumns.scala 25:27]
    end else begin
      _zz_io_mcOut1_1 = ({1'd0,a1} <<< 1); // @[MixColumns.scala 27:27]
    end
  end

  assign io_mcOut1 = (((_zz_io_mcOut1[7 : 0] ^ (_zz_io_mcOut1_1[7 : 0] ^ a1)) ^ a2) ^ a3); // @[MixColumns.scala 36:19]
  assign when_MixColumns_l24_2 = a1[7]; // @[BaseType.scala 305:24]
  always @(*) begin
    if(when_MixColumns_l24_2) begin
      _zz_io_mcOut2 = (_zz__zz_io_mcOut2 ^ 9'h11b); // @[MixColumns.scala 25:27]
    end else begin
      _zz_io_mcOut2 = ({1'd0,a1} <<< 1); // @[MixColumns.scala 27:27]
    end
  end

  assign when_MixColumns_l24_3 = a2[7]; // @[BaseType.scala 305:24]
  always @(*) begin
    if(when_MixColumns_l24_3) begin
      _zz_io_mcOut2_1 = (_zz__zz_io_mcOut2_1 ^ 9'h11b); // @[MixColumns.scala 25:27]
    end else begin
      _zz_io_mcOut2_1 = ({1'd0,a2} <<< 1); // @[MixColumns.scala 27:27]
    end
  end

  assign io_mcOut2 = (((a0 ^ _zz_io_mcOut2[7 : 0]) ^ (_zz_io_mcOut2_1[7 : 0] ^ a2)) ^ a3); // @[MixColumns.scala 37:19]
  assign when_MixColumns_l24_4 = a2[7]; // @[BaseType.scala 305:24]
  always @(*) begin
    if(when_MixColumns_l24_4) begin
      _zz_io_mcOut3 = (_zz__zz_io_mcOut3 ^ 9'h11b); // @[MixColumns.scala 25:27]
    end else begin
      _zz_io_mcOut3 = ({1'd0,a2} <<< 1); // @[MixColumns.scala 27:27]
    end
  end

  assign when_MixColumns_l24_5 = a3[7]; // @[BaseType.scala 305:24]
  always @(*) begin
    if(when_MixColumns_l24_5) begin
      _zz_io_mcOut3_1 = (_zz__zz_io_mcOut3_1 ^ 9'h11b); // @[MixColumns.scala 25:27]
    end else begin
      _zz_io_mcOut3_1 = ({1'd0,a3} <<< 1); // @[MixColumns.scala 27:27]
    end
  end

  assign io_mcOut3 = (((a0 ^ a1) ^ _zz_io_mcOut3[7 : 0]) ^ (_zz_io_mcOut3_1[7 : 0] ^ a3)); // @[MixColumns.scala 38:19]
  assign when_MixColumns_l24_6 = a0[7]; // @[BaseType.scala 305:24]
  always @(*) begin
    if(when_MixColumns_l24_6) begin
      _zz_io_mcOut4 = (_zz__zz_io_mcOut4 ^ 9'h11b); // @[MixColumns.scala 25:27]
    end else begin
      _zz_io_mcOut4 = ({1'd0,a0} <<< 1); // @[MixColumns.scala 27:27]
    end
  end

  assign when_MixColumns_l24_7 = a3[7]; // @[BaseType.scala 305:24]
  always @(*) begin
    if(when_MixColumns_l24_7) begin
      _zz_io_mcOut4_1 = (_zz__zz_io_mcOut4_1 ^ 9'h11b); // @[MixColumns.scala 25:27]
    end else begin
      _zz_io_mcOut4_1 = ({1'd0,a3} <<< 1); // @[MixColumns.scala 27:27]
    end
  end

  assign io_mcOut4 = ((((_zz_io_mcOut4[7 : 0] ^ a0) ^ a1) ^ a2) ^ _zz_io_mcOut4_1[7 : 0]); // @[MixColumns.scala 39:19]

endmodule

module CanrightSBox (
  input      [7:0]    io_subBytesInput,
  output     [7:0]    io_subBytesOutput,
  input               io_clk,
  input               io_reset
);

  wire       [7:0]    convertBasis1_io_output;
  wire       [7:0]    convertBasis2_io_output;
  wire       [7:0]    inv_io_x;
  wire                dummy;
  wire       [7:0]    t;
  wire       [7:0]    x;

  NewBasis_1 convertBasis1 (
    .io_input     (io_subBytesInput[7:0]       ), //i
    .io_direction (1'b0                        ), //i
    .io_output    (convertBasis1_io_output[7:0])  //o
  );
  NewBasis_1 convertBasis2 (
    .io_input     (x[7:0]                      ), //i
    .io_direction (1'b1                        ), //i
    .io_output    (convertBasis2_io_output[7:0])  //o
  );
  G256Inv inv (
    .io_t (t[7:0]       ), //i
    .io_x (inv_io_x[7:0])  //o
  );
  assign dummy = 1'b0;
  assign t = convertBasis1_io_output; // @[SBox.scala 15:11]
  assign x = inv_io_x; // @[SBox.scala 19:11]
  assign io_subBytesOutput = (convertBasis2_io_output ^ 8'h63); // @[SBox.scala 24:27]

endmodule

module AddRoundKey (
  input      [7:0]    io_a,
  input      [7:0]    io_k,
  output     [7:0]    io_b
);


  assign io_b = (io_a ^ io_k); // @[AddRoundKey.scala 10:14]

endmodule

module G256Inv (
  input      [7:0]    io_t,
  output     [7:0]    io_x
);

  wire       [3:0]    sqSc_io_t;
  wire       [3:0]    inv_io_t;
  wire       [3:0]    sqSc_io_x;
  wire       [3:0]    mul1_io_x;
  wire       [3:0]    mul2_io_x;
  wire       [3:0]    mul3_io_x;
  wire       [3:0]    inv_io_x;
  wire       [3:0]    a;
  wire       [3:0]    b;
  wire       [3:0]    c;
  wire       [3:0]    d;
  wire       [3:0]    e;
  wire       [3:0]    p;
  wire       [3:0]    q;

  G16SqSc sqSc (
    .io_t (sqSc_io_t[3:0]), //i
    .io_x (sqSc_io_x[3:0])  //o
  );
  G16Mul_2 mul1 (
    .io_a (a[3:0]        ), //i
    .io_b (b[3:0]        ), //i
    .io_x (mul1_io_x[3:0])  //o
  );
  G16Mul_2 mul2 (
    .io_a (e[3:0]        ), //i
    .io_b (b[3:0]        ), //i
    .io_x (mul2_io_x[3:0])  //o
  );
  G16Mul_2 mul3 (
    .io_a (e[3:0]        ), //i
    .io_b (a[3:0]        ), //i
    .io_x (mul3_io_x[3:0])  //o
  );
  G16Inv inv (
    .io_t (inv_io_t[3:0]), //i
    .io_x (inv_io_x[3:0])  //o
  );
  assign sqSc_io_t = (a ^ b); // @[Polynomial.scala 403:19]
  assign c = sqSc_io_x; // @[Polynomial.scala 404:11]
  assign d = mul1_io_x; // @[Polynomial.scala 408:11]
  assign inv_io_t = (c ^ d); // @[Polynomial.scala 410:18]
  assign e = inv_io_x; // @[Polynomial.scala 411:11]
  assign p = mul2_io_x; // @[Polynomial.scala 415:11]
  assign q = mul3_io_x; // @[Polynomial.scala 419:11]
  assign a = io_t[7 : 4]; // @[Polynomial.scala 421:11]
  assign b = io_t[3 : 0]; // @[Polynomial.scala 422:11]
  assign io_x = {p,q}; // @[Polynomial.scala 424:14]

endmodule

//NewBasis_1 replaced by NewBasis_1

module NewBasis_1 (
  input      [7:0]    io_input,
  input               io_direction,
  output reg [7:0]    io_output
);

  wire       [7:0]    a;
  reg        [7:0]    b;
  reg        [7:0]    c;
  wire                when_NewBasis_l31;

  assign a = io_input; // @[NewBasis.scala 11:11]
  always @(*) begin
    b[7] = (((((a[7] ^ a[6]) ^ a[5]) ^ a[2]) ^ a[1]) ^ a[0]); // @[NewBasis.scala 13:14]
    b[6] = (((a[6] ^ a[5]) ^ a[4]) ^ a[0]); // @[NewBasis.scala 14:14]
    b[5] = (((a[6] ^ a[5]) ^ a[1]) ^ a[0]); // @[NewBasis.scala 15:14]
    b[4] = (((a[7] ^ a[6]) ^ a[5]) ^ a[0]); // @[NewBasis.scala 16:14]
    b[3] = ((((a[7] ^ a[4]) ^ a[3]) ^ a[1]) ^ a[0]); // @[NewBasis.scala 17:14]
    b[2] = a[0]; // @[NewBasis.scala 18:14]
    b[1] = ((a[6] ^ a[5]) ^ a[0]); // @[NewBasis.scala 19:14]
    b[0] = ((((a[6] ^ a[3]) ^ a[2]) ^ a[1]) ^ a[0]); // @[NewBasis.scala 20:14]
  end

  always @(*) begin
    c[7] = (a[5] ^ a[3]); // @[NewBasis.scala 22:14]
    c[6] = (a[7] ^ a[3]); // @[NewBasis.scala 23:14]
    c[5] = (a[6] ^ a[0]); // @[NewBasis.scala 24:14]
    c[4] = ((a[7] ^ a[5]) ^ a[3]); // @[NewBasis.scala 25:14]
    c[3] = ((((a[7] ^ a[6]) ^ a[5]) ^ a[4]) ^ a[3]); // @[NewBasis.scala 26:14]
    c[2] = ((((a[6] ^ a[5]) ^ a[3]) ^ a[2]) ^ a[0]); // @[NewBasis.scala 27:14]
    c[1] = ((a[5] ^ a[4]) ^ a[1]); // @[NewBasis.scala 28:14]
    c[0] = ((a[6] ^ a[4]) ^ a[1]); // @[NewBasis.scala 29:14]
  end

  assign when_NewBasis_l31 = (! io_direction); // @[BaseType.scala 299:24]
  always @(*) begin
    if(when_NewBasis_l31) begin
      io_output = b; // @[NewBasis.scala 32:27]
    end else begin
      io_output = c; // @[NewBasis.scala 34:27]
    end
  end


endmodule

module G16Inv (
  input      [3:0]    io_t,
  output     [3:0]    io_x
);

  wire       [1:0]    square1_io_t;
  wire       [1:0]    square2_io_t;
  wire       [1:0]    scale_io_x;
  wire       [1:0]    square1_io_x;
  wire       [1:0]    square2_io_x;
  wire       [1:0]    mul1_io_x;
  wire       [1:0]    mul2_io_x;
  wire       [1:0]    mul3_io_x;
  wire       [1:0]    a;
  wire       [1:0]    b;
  wire       [1:0]    c;
  wire       [1:0]    d;
  wire       [1:0]    e;
  wire       [1:0]    p;
  wire       [1:0]    q;
  wire       [1:0]    x;

  G4ScaleN_3 scale (
    .io_t (square1_io_x[1:0]), //i
    .io_x (scale_io_x[1:0]  )  //o
  );
  G4Sq_3 square1 (
    .io_t (square1_io_t[1:0]), //i
    .io_x (square1_io_x[1:0])  //o
  );
  G4Sq_3 square2 (
    .io_t (square2_io_t[1:0]), //i
    .io_x (square2_io_x[1:0])  //o
  );
  G4Mul_11 mul1 (
    .io_a (a[1:0]        ), //i
    .io_b (b[1:0]        ), //i
    .io_x (mul1_io_x[1:0])  //o
  );
  G4Mul_11 mul2 (
    .io_a (e[1:0]        ), //i
    .io_b (b[1:0]        ), //i
    .io_x (mul2_io_x[1:0])  //o
  );
  G4Mul_11 mul3 (
    .io_a (e[1:0]        ), //i
    .io_b (a[1:0]        ), //i
    .io_x (mul3_io_x[1:0])  //o
  );
  assign square1_io_t = (a ^ b); // @[Polynomial.scala 471:22]
  assign c = scale_io_x; // @[Polynomial.scala 474:11]
  assign d = mul1_io_x; // @[Polynomial.scala 478:11]
  assign square2_io_t = (c ^ d); // @[Polynomial.scala 480:22]
  assign e = square2_io_x; // @[Polynomial.scala 481:11]
  assign p = mul2_io_x; // @[Polynomial.scala 485:11]
  assign q = mul3_io_x; // @[Polynomial.scala 489:11]
  assign a = io_t[3 : 2]; // @[Polynomial.scala 491:11]
  assign b = io_t[1 : 0]; // @[Polynomial.scala 492:11]
  assign io_x = {p,q}; // @[Polynomial.scala 494:14]

endmodule

//G16Mul_2 replaced by G16Mul_2

//G16Mul_2 replaced by G16Mul_2

module G16Mul_2 (
  input      [3:0]    io_a,
  input      [3:0]    io_b,
  output     [3:0]    io_x
);

  wire       [1:0]    mul1_io_a;
  wire       [1:0]    mul1_io_b;
  wire       [1:0]    mul1_io_x;
  wire       [1:0]    mul2_io_x;
  wire       [1:0]    mul3_io_x;
  wire       [1:0]    scale_io_x;
  wire       [1:0]    a;
  wire       [1:0]    b;
  wire       [1:0]    c;
  wire       [1:0]    d;
  wire       [1:0]    e;
  wire       [1:0]    f;
  wire       [1:0]    p;
  wire       [1:0]    q;

  G4Mul_11 mul1 (
    .io_a (mul1_io_a[1:0]), //i
    .io_b (mul1_io_b[1:0]), //i
    .io_x (mul1_io_x[1:0])  //o
  );
  G4Mul_11 mul2 (
    .io_a (a[1:0]        ), //i
    .io_b (c[1:0]        ), //i
    .io_x (mul2_io_x[1:0])  //o
  );
  G4Mul_11 mul3 (
    .io_a (b[1:0]        ), //i
    .io_b (d[1:0]        ), //i
    .io_x (mul3_io_x[1:0])  //o
  );
  G4ScaleN_3 scale (
    .io_t (e[1:0]         ), //i
    .io_x (scale_io_x[1:0])  //o
  );
  assign mul1_io_a = (a ^ b); // @[Polynomial.scala 437:19]
  assign mul1_io_b = (c ^ d); // @[Polynomial.scala 438:19]
  assign e = mul1_io_x; // @[Polynomial.scala 439:11]
  assign f = scale_io_x; // @[Polynomial.scala 442:11]
  assign p = (mul2_io_x ^ f); // @[Polynomial.scala 446:11]
  assign q = (mul3_io_x ^ f); // @[Polynomial.scala 450:11]
  assign a = io_a[3 : 2]; // @[Polynomial.scala 452:11]
  assign b = io_a[1 : 0]; // @[Polynomial.scala 453:11]
  assign c = io_b[3 : 2]; // @[Polynomial.scala 454:11]
  assign d = io_b[1 : 0]; // @[Polynomial.scala 455:11]
  assign io_x = {p,q}; // @[Polynomial.scala 457:14]

endmodule

module G16SqSc (
  input      [3:0]    io_t,
  output     [3:0]    io_x
);

  wire       [1:0]    square1_io_t;
  wire       [1:0]    square1_io_x;
  wire       [1:0]    square2_io_x;
  wire       [1:0]    scale_io_x;
  wire       [1:0]    a;
  wire       [1:0]    b;
  wire       [1:0]    c;
  wire       [1:0]    p;
  wire       [1:0]    q;

  G4Sq_3 square1 (
    .io_t (square1_io_t[1:0]), //i
    .io_x (square1_io_x[1:0])  //o
  );
  G4Sq_3 square2 (
    .io_t (b[1:0]           ), //i
    .io_x (square2_io_x[1:0])  //o
  );
  G4ScaleN2 scale (
    .io_t (c[1:0]         ), //i
    .io_x (scale_io_x[1:0])  //o
  );
  assign square1_io_t = (a ^ b); // @[Polynomial.scala 507:22]
  assign p = square1_io_x; // @[Polynomial.scala 508:11]
  assign c = square2_io_x; // @[Polynomial.scala 511:11]
  assign q = scale_io_x; // @[Polynomial.scala 514:11]
  assign a = io_t[3 : 2]; // @[Polynomial.scala 516:11]
  assign b = io_t[1 : 0]; // @[Polynomial.scala 517:11]
  assign io_x = {p,q}; // @[Polynomial.scala 519:14]

endmodule

//G4Mul_11 replaced by G4Mul_11

//G4Mul_11 replaced by G4Mul_11

//G4Mul_11 replaced by G4Mul_11

//G4Sq_3 replaced by G4Sq_3

//G4Sq_3 replaced by G4Sq_3

//G4ScaleN_3 replaced by G4ScaleN_3

//G4ScaleN_3 replaced by G4ScaleN_3

//G4Mul_11 replaced by G4Mul_11

//G4Mul_11 replaced by G4Mul_11

//G4Mul_11 replaced by G4Mul_11

//G4ScaleN_3 replaced by G4ScaleN_3

//G4Mul_11 replaced by G4Mul_11

//G4Mul_11 replaced by G4Mul_11

//G4Mul_11 replaced by G4Mul_11

module G4ScaleN_3 (
  input      [1:0]    io_t,
  output     [1:0]    io_x
);


  assign io_x = {io_t[0],(io_t[1] ^ io_t[0])}; // @[Polynomial.scala 537:14]

endmodule

//G4Mul_11 replaced by G4Mul_11

//G4Mul_11 replaced by G4Mul_11

module G4Mul_11 (
  input      [1:0]    io_a,
  input      [1:0]    io_b,
  output     [1:0]    io_x
);

  wire       [0:0]    a;
  wire       [0:0]    b;
  wire       [0:0]    c;
  wire       [0:0]    d;
  wire       [0:0]    e;
  wire       [0:0]    p;
  wire       [0:0]    q;

  assign a = io_a[1]; // @[Polynomial.scala 557:11]
  assign b = io_a[0]; // @[Polynomial.scala 558:11]
  assign c = io_b[1]; // @[Polynomial.scala 559:11]
  assign d = io_b[0]; // @[Polynomial.scala 560:11]
  assign e = ((a ^ b) & (c ^ d)); // @[Polynomial.scala 562:11]
  assign p = ((a & c) ^ e); // @[Polynomial.scala 563:11]
  assign q = ((b & d) ^ e); // @[Polynomial.scala 564:11]
  assign io_x = {p,q}; // @[Polynomial.scala 566:14]

endmodule

module G4ScaleN2 (
  input      [1:0]    io_t,
  output     [1:0]    io_x
);


  assign io_x = {(io_t[1] ^ io_t[0]),io_t[1]}; // @[Polynomial.scala 546:14]

endmodule

//G4Sq_3 replaced by G4Sq_3

module G4Sq_3 (
  input      [1:0]    io_t,
  output     [1:0]    io_x
);


  assign io_x = {io_t[0],io_t[1]}; // @[Polynomial.scala 528:14]

endmodule
