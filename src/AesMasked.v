// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : AesMasked

`timescale 1ns/1ps

module AesMasked (
  input               io_clk,
  input               io_reset,
  input               io_enable,
  input               io_pt1_valid,
  output reg          io_pt1_ready,
  input      [31:0]   io_pt1_payload,
  input               io_pt2_valid,
  output reg          io_pt2_ready,
  input      [31:0]   io_pt2_payload,
  input               io_key1_valid,
  output reg          io_key1_ready,
  input      [31:0]   io_key1_payload,
  input               io_key2_valid,
  output reg          io_key2_ready,
  input      [31:0]   io_key2_payload,
  input      [27:0]   io_m,
  output reg          io_ct1_valid,
  input               io_ct1_ready,
  output     [31:0]   io_ct1_payload,
  output reg          io_ct2_valid,
  input               io_ct2_ready,
  output     [31:0]   io_ct2_payload,
  output reg          io_done
);
  localparam AESState_sIdle = 2'd0;
  localparam AESState_sInit = 2'd1;
  localparam AESState_sRound = 2'd2;
  localparam AESState_sDone = 2'd3;

  reg        [7:0]    r_sbox_io_sbIn0;
  reg        [7:0]    r_sbox_io_sbIn1;
  wire       [7:0]    r_addroundkey1_io_b;
  wire       [7:0]    r_addroundkey2_io_b;
  wire       [7:0]    r_sbox_io_sbOut0;
  wire       [7:0]    r_sbox_io_sbOut1;
  wire       [7:0]    r_mixcolumns1_io_mcOut1;
  wire       [7:0]    r_mixcolumns1_io_mcOut2;
  wire       [7:0]    r_mixcolumns1_io_mcOut3;
  wire       [7:0]    r_mixcolumns1_io_mcOut4;
  wire       [7:0]    r_mixcolumns2_io_mcOut1;
  wire       [7:0]    r_mixcolumns2_io_mcOut2;
  wire       [7:0]    r_mixcolumns2_io_mcOut3;
  wire       [7:0]    r_mixcolumns2_io_mcOut4;
  wire       [3:0]    _zz_r_round_valueNext;
  wire       [0:0]    _zz_r_round_valueNext_1;
  wire       [4:0]    _zz_r_control_valueNext;
  wire       [0:0]    _zz_r_control_valueNext_1;
  wire       [7:0]    _zz_r_roundConstant;
  reg        [7:0]    r_stateReg_0_0_0;
  reg        [7:0]    r_stateReg_0_0_1;
  reg        [7:0]    r_stateReg_0_0_2;
  reg        [7:0]    r_stateReg_0_0_3;
  reg        [7:0]    r_stateReg_0_1_0;
  reg        [7:0]    r_stateReg_0_1_1;
  reg        [7:0]    r_stateReg_0_1_2;
  reg        [7:0]    r_stateReg_0_1_3;
  reg        [7:0]    r_stateReg_0_2_0;
  reg        [7:0]    r_stateReg_0_2_1;
  reg        [7:0]    r_stateReg_0_2_2;
  reg        [7:0]    r_stateReg_0_2_3;
  reg        [7:0]    r_stateReg_0_3_0;
  reg        [7:0]    r_stateReg_0_3_1;
  reg        [7:0]    r_stateReg_0_3_2;
  reg        [7:0]    r_stateReg_0_3_3;
  reg        [7:0]    r_stateReg_1_0_0;
  reg        [7:0]    r_stateReg_1_0_1;
  reg        [7:0]    r_stateReg_1_0_2;
  reg        [7:0]    r_stateReg_1_0_3;
  reg        [7:0]    r_stateReg_1_1_0;
  reg        [7:0]    r_stateReg_1_1_1;
  reg        [7:0]    r_stateReg_1_1_2;
  reg        [7:0]    r_stateReg_1_1_3;
  reg        [7:0]    r_stateReg_1_2_0;
  reg        [7:0]    r_stateReg_1_2_1;
  reg        [7:0]    r_stateReg_1_2_2;
  reg        [7:0]    r_stateReg_1_2_3;
  reg        [7:0]    r_stateReg_1_3_0;
  reg        [7:0]    r_stateReg_1_3_1;
  reg        [7:0]    r_stateReg_1_3_2;
  reg        [7:0]    r_stateReg_1_3_3;
  reg        [7:0]    r_keyReg_0_0_0;
  reg        [7:0]    r_keyReg_0_0_1;
  reg        [7:0]    r_keyReg_0_0_2;
  reg        [7:0]    r_keyReg_0_0_3;
  reg        [7:0]    r_keyReg_0_1_0;
  reg        [7:0]    r_keyReg_0_1_1;
  reg        [7:0]    r_keyReg_0_1_2;
  reg        [7:0]    r_keyReg_0_1_3;
  reg        [7:0]    r_keyReg_0_2_0;
  reg        [7:0]    r_keyReg_0_2_1;
  reg        [7:0]    r_keyReg_0_2_2;
  reg        [7:0]    r_keyReg_0_2_3;
  reg        [7:0]    r_keyReg_0_3_0;
  reg        [7:0]    r_keyReg_0_3_1;
  reg        [7:0]    r_keyReg_0_3_2;
  reg        [7:0]    r_keyReg_0_3_3;
  reg        [7:0]    r_keyReg_1_0_0;
  reg        [7:0]    r_keyReg_1_0_1;
  reg        [7:0]    r_keyReg_1_0_2;
  reg        [7:0]    r_keyReg_1_0_3;
  reg        [7:0]    r_keyReg_1_1_0;
  reg        [7:0]    r_keyReg_1_1_1;
  reg        [7:0]    r_keyReg_1_1_2;
  reg        [7:0]    r_keyReg_1_1_3;
  reg        [7:0]    r_keyReg_1_2_0;
  reg        [7:0]    r_keyReg_1_2_1;
  reg        [7:0]    r_keyReg_1_2_2;
  reg        [7:0]    r_keyReg_1_2_3;
  reg        [7:0]    r_keyReg_1_3_0;
  reg        [7:0]    r_keyReg_1_3_1;
  reg        [7:0]    r_keyReg_1_3_2;
  reg        [7:0]    r_keyReg_1_3_3;
  reg        [1:0]    r_fsmState;
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
  wire                when_AES_Masked_l32;
  reg        [7:0]    r_roundConstant;
  wire                when_AES_Masked_l36;
  wire                when_AES_Masked_l37;
  reg        [7:0]    r_rc;
  reg                 r_initRotation;
  reg                 r_keyInitRotation;
  reg                 r_stateRotation;
  reg                 r_shiftRowsRotation;
  reg                 r_mixColumnsRotation;
  reg                 r_mixColumnsRotation1;
  reg                 r_mixColumnsRotation2;
  reg                 r_keyRotation;
  reg                 r_keyRotation2;
  reg                 r_keySboxRotation;
  reg                 r_keyRCRotation;
  reg                 r_finalKeyAdd;
  reg                 r_finalRound;
  wire                when_AES_Masked_l67;
  wire                when_AES_Masked_l390;
  wire                when_AES_Masked_l393;
  wire                when_AES_Masked_l395;
  wire                when_AES_Masked_l397;
  wire                io_key1_fire;
  wire                io_key2_fire;
  wire                io_pt1_fire;
  wire                io_pt2_fire;
  wire                when_AES_Masked_l404;
  wire                when_AES_Masked_l406;
  wire                io_key1_fire_1;
  wire                io_key2_fire_1;
  wire                io_pt1_fire_1;
  wire                io_pt2_fire_1;
  wire                when_AES_Masked_l464;
  wire                when_AES_Masked_l466;
  wire                when_AES_Masked_l474;
  wire                when_AES_Masked_l480;
  wire                when_AES_Masked_l490;
  wire                when_AES_Masked_l492;
  wire                when_AES_Masked_l502;
  wire                when_AES_Masked_l508;
  wire                when_AES_Masked_l514;
  wire                when_AES_Masked_l541;
  wire                io_ct1_fire;
  wire                io_ct2_fire;
  wire                when_AES_Masked_l562;
  `ifndef SYNTHESIS
  reg [47:0] r_fsmState_string;
  `endif


  assign _zz_r_round_valueNext_1 = r_round_willIncrement;
  assign _zz_r_round_valueNext = {3'd0, _zz_r_round_valueNext_1};
  assign _zz_r_control_valueNext_1 = r_control_willIncrement;
  assign _zz_r_control_valueNext = {4'd0, _zz_r_control_valueNext_1};
  assign _zz_r_roundConstant = (r_roundConstant <<< 1);
  AddRoundKey_1 r_addroundkey1 (
    .io_a (r_stateReg_0_0_0[7:0]   ), //i
    .io_k (r_keyReg_0_0_0[7:0]     ), //i
    .io_b (r_addroundkey1_io_b[7:0])  //o
  );
  AddRoundKey_1 r_addroundkey2 (
    .io_a (r_stateReg_1_0_0[7:0]   ), //i
    .io_k (r_keyReg_1_0_0[7:0]     ), //i
    .io_b (r_addroundkey2_io_b[7:0])  //o
  );
  SBoxMasked r_sbox (
    .io_clk    (io_clk               ), //i
    .io_reset  (io_reset             ), //i
    .io_sbIn0  (r_sbox_io_sbIn0[7:0] ), //i
    .io_sbIn1  (r_sbox_io_sbIn1[7:0] ), //i
    .io_m      (io_m[27:0]           ), //i
    .io_sbOut0 (r_sbox_io_sbOut0[7:0]), //o
    .io_sbOut1 (r_sbox_io_sbOut1[7:0])  //o
  );
  MixColumns_1 r_mixcolumns1 (
    .io_mcIn1  (r_stateReg_0_0_0[7:0]       ), //i
    .io_mcIn2  (r_stateReg_0_1_0[7:0]       ), //i
    .io_mcIn3  (r_stateReg_0_2_0[7:0]       ), //i
    .io_mcIn4  (r_stateReg_0_3_0[7:0]       ), //i
    .io_mcOut1 (r_mixcolumns1_io_mcOut1[7:0]), //o
    .io_mcOut2 (r_mixcolumns1_io_mcOut2[7:0]), //o
    .io_mcOut3 (r_mixcolumns1_io_mcOut3[7:0]), //o
    .io_mcOut4 (r_mixcolumns1_io_mcOut4[7:0])  //o
  );
  MixColumns_1 r_mixcolumns2 (
    .io_mcIn1  (r_stateReg_1_0_0[7:0]       ), //i
    .io_mcIn2  (r_stateReg_1_1_0[7:0]       ), //i
    .io_mcIn3  (r_stateReg_1_2_0[7:0]       ), //i
    .io_mcIn4  (r_stateReg_1_3_0[7:0]       ), //i
    .io_mcOut1 (r_mixcolumns2_io_mcOut1[7:0]), //o
    .io_mcOut2 (r_mixcolumns2_io_mcOut2[7:0]), //o
    .io_mcOut3 (r_mixcolumns2_io_mcOut3[7:0]), //o
    .io_mcOut4 (r_mixcolumns2_io_mcOut4[7:0])  //o
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(r_fsmState)
      AESState_sIdle : r_fsmState_string = "sIdle ";
      AESState_sInit : r_fsmState_string = "sInit ";
      AESState_sRound : r_fsmState_string = "sRound";
      AESState_sDone : r_fsmState_string = "sDone ";
      default : r_fsmState_string = "??????";
    endcase
  end
  `endif

  always @(*) begin
    r_round_willIncrement = 1'b0; // @[Utils.scala 536:23]
    if(when_AES_Masked_l32) begin
      r_round_willIncrement = 1'b1; // @[Utils.scala 540:41]
    end
  end

  always @(*) begin
    r_round_willClear = 1'b0; // @[Utils.scala 537:19]
    case(r_fsmState)
      AESState_sIdle : begin
        r_round_willClear = 1'b1; // @[Utils.scala 539:33]
      end
      AESState_sInit : begin
      end
      AESState_sRound : begin
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
    case(r_fsmState)
      AESState_sIdle : begin
      end
      AESState_sInit : begin
        if(when_AES_Masked_l404) begin
          r_control_willIncrement = 1'b1; // @[Utils.scala 540:41]
        end
      end
      AESState_sRound : begin
        r_control_willIncrement = 1'b1; // @[Utils.scala 540:41]
      end
      default : begin
        if(io_ct1_fire) begin
          r_control_willIncrement = 1'b1; // @[Utils.scala 540:41]
        end
        if(io_ct2_fire) begin
          r_control_willIncrement = 1'b1; // @[Utils.scala 540:41]
        end
      end
    endcase
  end

  always @(*) begin
    r_control_willClear = 1'b0; // @[Utils.scala 537:19]
    case(r_fsmState)
      AESState_sIdle : begin
        r_control_willClear = 1'b1; // @[Utils.scala 539:33]
      end
      AESState_sInit : begin
        if(when_AES_Masked_l404) begin
          if(when_AES_Masked_l406) begin
            r_control_willClear = 1'b1; // @[Utils.scala 539:33]
          end
        end
      end
      AESState_sRound : begin
        if(when_AES_Masked_l464) begin
          if(when_AES_Masked_l466) begin
            r_control_willClear = 1'b1; // @[Utils.scala 539:33]
          end
        end
      end
      default : begin
      end
    endcase
  end

  assign r_control_willOverflowIfInc = (r_control_value == 5'h18); // @[BaseType.scala 305:24]
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

  assign when_AES_Masked_l32 = (r_control_value == 5'h18); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l36 = (r_control_value == 5'h18); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l37 = (r_roundConstant < 8'h80); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l67 = (r_control_value < 5'h10); // @[BaseType.scala 305:24]
  always @(*) begin
    if(when_AES_Masked_l67) begin
      r_sbox_io_sbIn0 = r_addroundkey1_io_b; // @[AES_Masked.scala 68:39]
    end else begin
      r_sbox_io_sbIn0 = r_keyReg_0_1_3; // @[AES_Masked.scala 71:39]
    end
  end

  always @(*) begin
    if(when_AES_Masked_l67) begin
      r_sbox_io_sbIn1 = r_addroundkey2_io_b; // @[AES_Masked.scala 69:39]
    end else begin
      r_sbox_io_sbIn1 = r_keyReg_1_1_3; // @[AES_Masked.scala 72:39]
    end
  end

  always @(*) begin
    io_pt1_ready = 1'b0; // @[AES_Masked.scala 330:30]
    case(r_fsmState)
      AESState_sIdle : begin
      end
      AESState_sInit : begin
        if(!when_AES_Masked_l390) begin
          if(!when_AES_Masked_l393) begin
            if(when_AES_Masked_l395) begin
              io_pt1_ready = 1'b1; // @[AES_Masked.scala 396:54]
            end
          end
        end
      end
      AESState_sRound : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_pt2_ready = 1'b0; // @[AES_Masked.scala 331:30]
    case(r_fsmState)
      AESState_sIdle : begin
      end
      AESState_sInit : begin
        if(!when_AES_Masked_l390) begin
          if(!when_AES_Masked_l393) begin
            if(!when_AES_Masked_l395) begin
              if(when_AES_Masked_l397) begin
                io_pt2_ready = 1'b1; // @[AES_Masked.scala 398:54]
              end
            end
          end
        end
      end
      AESState_sRound : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_key1_ready = 1'b0; // @[AES_Masked.scala 332:31]
    case(r_fsmState)
      AESState_sIdle : begin
      end
      AESState_sInit : begin
        if(when_AES_Masked_l390) begin
          io_key1_ready = 1'b1; // @[AES_Masked.scala 392:55]
        end
      end
      AESState_sRound : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_key2_ready = 1'b0; // @[AES_Masked.scala 333:31]
    case(r_fsmState)
      AESState_sIdle : begin
      end
      AESState_sInit : begin
        if(!when_AES_Masked_l390) begin
          if(when_AES_Masked_l393) begin
            io_key2_ready = 1'b1; // @[AES_Masked.scala 394:55]
          end
        end
      end
      AESState_sRound : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_ct1_valid = 1'b0; // @[AES_Masked.scala 334:30]
    case(r_fsmState)
      AESState_sIdle : begin
      end
      AESState_sInit : begin
      end
      AESState_sRound : begin
      end
      default : begin
        if(when_AES_Masked_l541) begin
          io_ct1_valid = 1'b1; // @[AES_Masked.scala 542:54]
        end
      end
    endcase
  end

  always @(*) begin
    io_ct2_valid = 1'b0; // @[AES_Masked.scala 335:30]
    case(r_fsmState)
      AESState_sIdle : begin
      end
      AESState_sInit : begin
      end
      AESState_sRound : begin
      end
      default : begin
        if(!when_AES_Masked_l541) begin
          io_ct2_valid = 1'b1; // @[AES_Masked.scala 544:54]
        end
      end
    endcase
  end

  assign io_ct1_payload = {{{r_stateReg_0_0_0,r_stateReg_0_1_0},r_stateReg_0_2_0},r_stateReg_0_3_0}; // @[AES_Masked.scala 336:32]
  assign io_ct2_payload = {{{r_stateReg_1_0_0,r_stateReg_1_1_0},r_stateReg_1_2_0},r_stateReg_1_3_0}; // @[AES_Masked.scala 337:32]
  always @(*) begin
    io_done = 1'b0; // @[AES_Masked.scala 338:25]
    case(r_fsmState)
      AESState_sIdle : begin
      end
      AESState_sInit : begin
      end
      AESState_sRound : begin
      end
      default : begin
        io_done = 1'b1; // @[AES_Masked.scala 539:41]
      end
    endcase
  end

  always @(*) begin
    case(r_fsmState)
      AESState_sIdle : begin
        r_initRotation = 1'b0; // @[AES_Masked.scala 352:46]
      end
      AESState_sInit : begin
        r_initRotation = 1'b0; // @[AES_Masked.scala 375:46]
        if(io_pt1_fire_1) begin
          r_initRotation = 1'b1; // @[AES_Masked.scala 423:54]
        end
        if(io_pt2_fire_1) begin
          r_initRotation = 1'b1; // @[AES_Masked.scala 429:54]
        end
      end
      AESState_sRound : begin
        r_initRotation = 1'b0; // @[AES_Masked.scala 458:46]
      end
      default : begin
        r_initRotation = 1'b0; // @[AES_Masked.scala 524:46]
      end
    endcase
  end

  always @(*) begin
    case(r_fsmState)
      AESState_sIdle : begin
        r_keyInitRotation = 1'b0; // @[AES_Masked.scala 353:49]
      end
      AESState_sInit : begin
        r_keyInitRotation = 1'b0; // @[AES_Masked.scala 376:49]
        if(io_key1_fire_1) begin
          r_keyInitRotation = 1'b1; // @[AES_Masked.scala 413:57]
        end
        if(io_key2_fire_1) begin
          r_keyInitRotation = 1'b1; // @[AES_Masked.scala 418:57]
        end
      end
      AESState_sRound : begin
        r_keyInitRotation = 1'b0; // @[AES_Masked.scala 459:49]
      end
      default : begin
        r_keyInitRotation = 1'b0; // @[AES_Masked.scala 525:49]
      end
    endcase
  end

  always @(*) begin
    case(r_fsmState)
      AESState_sIdle : begin
        r_stateRotation = 1'b0; // @[AES_Masked.scala 354:47]
      end
      AESState_sInit : begin
        r_stateRotation = 1'b0; // @[AES_Masked.scala 377:47]
      end
      AESState_sRound : begin
        if(when_AES_Masked_l464) begin
          r_stateRotation = 1'b1; // @[AES_Masked.scala 465:55]
        end else begin
          r_stateRotation = 1'b0; // @[AES_Masked.scala 471:55]
        end
      end
      default : begin
        r_stateRotation = 1'b0; // @[AES_Masked.scala 526:47]
      end
    endcase
  end

  always @(*) begin
    case(r_fsmState)
      AESState_sIdle : begin
        r_shiftRowsRotation = 1'b0; // @[AES_Masked.scala 355:51]
      end
      AESState_sInit : begin
        r_shiftRowsRotation = 1'b0; // @[AES_Masked.scala 378:51]
      end
      AESState_sRound : begin
        if(when_AES_Masked_l474) begin
          r_shiftRowsRotation = 1'b1; // @[AES_Masked.scala 475:59]
        end else begin
          r_shiftRowsRotation = 1'b0; // @[AES_Masked.scala 477:59]
        end
      end
      default : begin
        r_shiftRowsRotation = 1'b0; // @[AES_Masked.scala 527:51]
      end
    endcase
  end

  always @(*) begin
    case(r_fsmState)
      AESState_sIdle : begin
        r_mixColumnsRotation = 1'b0; // @[AES_Masked.scala 356:52]
      end
      AESState_sInit : begin
        r_mixColumnsRotation = 1'b0; // @[AES_Masked.scala 379:52]
        if(io_pt1_fire_1) begin
          r_mixColumnsRotation = 1'b1; // @[AES_Masked.scala 424:60]
        end
        if(io_pt2_fire_1) begin
          r_mixColumnsRotation = 1'b1; // @[AES_Masked.scala 430:60]
        end
      end
      AESState_sRound : begin
        if(when_AES_Masked_l480) begin
          r_mixColumnsRotation = 1'b1; // @[AES_Masked.scala 481:60]
        end else begin
          r_mixColumnsRotation = 1'b0; // @[AES_Masked.scala 485:60]
        end
      end
      default : begin
        r_mixColumnsRotation = 1'b0; // @[AES_Masked.scala 528:52]
        if(io_ct1_fire) begin
          r_mixColumnsRotation = 1'b1; // @[AES_Masked.scala 549:60]
        end
        if(io_ct2_fire) begin
          r_mixColumnsRotation = 1'b1; // @[AES_Masked.scala 557:60]
        end
      end
    endcase
  end

  always @(*) begin
    case(r_fsmState)
      AESState_sIdle : begin
        r_mixColumnsRotation1 = 1'b0; // @[AES_Masked.scala 357:53]
      end
      AESState_sInit : begin
        r_mixColumnsRotation1 = 1'b0; // @[AES_Masked.scala 380:53]
        if(io_key1_fire_1) begin
          r_mixColumnsRotation1 = 1'b1; // @[AES_Masked.scala 414:61]
        end
        if(io_pt1_fire_1) begin
          r_mixColumnsRotation1 = 1'b1; // @[AES_Masked.scala 425:61]
        end
      end
      AESState_sRound : begin
        if(when_AES_Masked_l480) begin
          r_mixColumnsRotation1 = 1'b1; // @[AES_Masked.scala 482:61]
        end else begin
          r_mixColumnsRotation1 = 1'b0; // @[AES_Masked.scala 486:61]
        end
      end
      default : begin
        r_mixColumnsRotation1 = 1'b0; // @[AES_Masked.scala 529:53]
        if(io_ct1_fire) begin
          r_mixColumnsRotation1 = 1'b1; // @[AES_Masked.scala 550:61]
        end
      end
    endcase
  end

  always @(*) begin
    case(r_fsmState)
      AESState_sIdle : begin
        r_mixColumnsRotation2 = 1'b0; // @[AES_Masked.scala 358:53]
      end
      AESState_sInit : begin
        r_mixColumnsRotation2 = 1'b0; // @[AES_Masked.scala 381:53]
        if(io_key2_fire_1) begin
          r_mixColumnsRotation2 = 1'b1; // @[AES_Masked.scala 419:61]
        end
        if(io_pt2_fire_1) begin
          r_mixColumnsRotation2 = 1'b1; // @[AES_Masked.scala 431:61]
        end
      end
      AESState_sRound : begin
        if(when_AES_Masked_l480) begin
          r_mixColumnsRotation2 = 1'b1; // @[AES_Masked.scala 483:61]
        end else begin
          r_mixColumnsRotation2 = 1'b0; // @[AES_Masked.scala 487:61]
        end
      end
      default : begin
        r_mixColumnsRotation2 = 1'b0; // @[AES_Masked.scala 530:53]
        if(io_ct2_fire) begin
          r_mixColumnsRotation2 = 1'b1; // @[AES_Masked.scala 558:61]
        end
      end
    endcase
  end

  always @(*) begin
    case(r_fsmState)
      AESState_sIdle : begin
        r_keyRotation = 1'b0; // @[AES_Masked.scala 359:45]
      end
      AESState_sInit : begin
        r_keyRotation = 1'b0; // @[AES_Masked.scala 382:45]
      end
      AESState_sRound : begin
        if(when_AES_Masked_l490) begin
          r_keyRotation = 1'b1; // @[AES_Masked.scala 491:53]
        end else begin
          r_keyRotation = 1'b0; // @[AES_Masked.scala 498:53]
        end
      end
      default : begin
        r_keyRotation = 1'b0; // @[AES_Masked.scala 531:45]
      end
    endcase
  end

  always @(*) begin
    case(r_fsmState)
      AESState_sIdle : begin
        r_keyRotation2 = 1'b0; // @[AES_Masked.scala 360:46]
      end
      AESState_sInit : begin
        r_keyRotation2 = 1'b0; // @[AES_Masked.scala 383:46]
      end
      AESState_sRound : begin
        if(when_AES_Masked_l490) begin
          if(when_AES_Masked_l492) begin
            r_keyRotation2 = 1'b1; // @[AES_Masked.scala 493:62]
          end else begin
            r_keyRotation2 = 1'b0; // @[AES_Masked.scala 495:62]
          end
        end else begin
          r_keyRotation2 = 1'b0; // @[AES_Masked.scala 499:54]
        end
      end
      default : begin
        r_keyRotation2 = 1'b0; // @[AES_Masked.scala 532:46]
      end
    endcase
  end

  always @(*) begin
    case(r_fsmState)
      AESState_sIdle : begin
        r_keySboxRotation = 1'b0; // @[AES_Masked.scala 361:49]
      end
      AESState_sInit : begin
        r_keySboxRotation = 1'b0; // @[AES_Masked.scala 384:49]
      end
      AESState_sRound : begin
        if(when_AES_Masked_l502) begin
          r_keySboxRotation = 1'b1; // @[AES_Masked.scala 503:57]
        end else begin
          r_keySboxRotation = 1'b0; // @[AES_Masked.scala 505:57]
        end
      end
      default : begin
        r_keySboxRotation = 1'b0; // @[AES_Masked.scala 533:49]
      end
    endcase
  end

  always @(*) begin
    case(r_fsmState)
      AESState_sIdle : begin
        r_keyRCRotation = 1'b0; // @[AES_Masked.scala 362:47]
      end
      AESState_sInit : begin
        r_keyRCRotation = 1'b0; // @[AES_Masked.scala 385:47]
      end
      AESState_sRound : begin
        if(when_AES_Masked_l514) begin
          r_keyRCRotation = 1'b1; // @[AES_Masked.scala 515:55]
        end else begin
          r_keyRCRotation = 1'b0; // @[AES_Masked.scala 517:55]
        end
      end
      default : begin
        r_keyRCRotation = 1'b0; // @[AES_Masked.scala 534:47]
      end
    endcase
  end

  always @(*) begin
    case(r_fsmState)
      AESState_sIdle : begin
        r_rc = 8'h0; // @[AES_Masked.scala 363:36]
      end
      AESState_sInit : begin
        r_rc = 8'h0; // @[AES_Masked.scala 386:36]
      end
      AESState_sRound : begin
        if(when_AES_Masked_l508) begin
          r_rc = r_roundConstant; // @[AES_Masked.scala 509:44]
        end else begin
          r_rc = 8'h0; // @[AES_Masked.scala 511:44]
        end
      end
      default : begin
        r_rc = 8'h0; // @[AES_Masked.scala 535:36]
      end
    endcase
  end

  always @(*) begin
    case(r_fsmState)
      AESState_sIdle : begin
        r_finalRound = 1'b0; // @[AES_Masked.scala 364:44]
      end
      AESState_sInit : begin
        r_finalRound = 1'b0; // @[AES_Masked.scala 387:44]
      end
      AESState_sRound : begin
        r_finalRound = (r_round_value == 4'b1010); // @[AES_Masked.scala 461:44]
      end
      default : begin
        r_finalRound = 1'b0; // @[AES_Masked.scala 536:44]
        if(io_ct1_fire) begin
          r_finalRound = 1'b1; // @[AES_Masked.scala 551:52]
        end
        if(io_ct2_fire) begin
          r_finalRound = 1'b1; // @[AES_Masked.scala 559:52]
        end
      end
    endcase
  end

  always @(*) begin
    case(r_fsmState)
      AESState_sIdle : begin
        r_finalKeyAdd = 1'b0; // @[AES_Masked.scala 365:45]
      end
      AESState_sInit : begin
        r_finalKeyAdd = 1'b0; // @[AES_Masked.scala 388:45]
      end
      AESState_sRound : begin
        r_finalKeyAdd = (r_round_value == 4'b1011); // @[AES_Masked.scala 462:45]
      end
      default : begin
        r_finalKeyAdd = 1'b0; // @[AES_Masked.scala 537:45]
      end
    endcase
  end

  assign when_AES_Masked_l390 = (r_control_value < 5'h04); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l393 = (r_control_value < 5'h08); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l395 = (r_control_value < 5'h0c); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l397 = (r_control_value < 5'h10); // @[BaseType.scala 305:24]
  assign io_key1_fire = (io_key1_valid && io_key1_ready); // @[BaseType.scala 305:24]
  assign io_key2_fire = (io_key2_valid && io_key2_ready); // @[BaseType.scala 305:24]
  assign io_pt1_fire = (io_pt1_valid && io_pt1_ready); // @[BaseType.scala 305:24]
  assign io_pt2_fire = (io_pt2_valid && io_pt2_ready); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l404 = (((io_key1_fire || io_key2_fire) || io_pt1_fire) || io_pt2_fire); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l406 = (r_control_value == 5'h0f); // @[BaseType.scala 305:24]
  assign io_key1_fire_1 = (io_key1_valid && io_key1_ready); // @[BaseType.scala 305:24]
  assign io_key2_fire_1 = (io_key2_valid && io_key2_ready); // @[BaseType.scala 305:24]
  assign io_pt1_fire_1 = (io_pt1_valid && io_pt1_ready); // @[BaseType.scala 305:24]
  assign io_pt2_fire_1 = (io_pt2_valid && io_pt2_ready); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l464 = (r_control_value < 5'h14); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l466 = ((r_control_value == 5'h0f) && (r_round_value == 4'b1011)); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l474 = (r_control_value == 5'h14); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l480 = (5'h14 < r_control_value); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l490 = (r_control_value < 5'h10); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l492 = ((r_control_value < 5'h0c) && (4'b0001 < r_round_value)); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l502 = ((5'h10 <= r_control_value) && (r_control_value < 5'h14)); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l508 = (r_control_value == 5'h14); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l514 = ((5'h14 <= r_control_value) && (r_control_value < 5'h18)); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l541 = (r_control_value < 5'h04); // @[BaseType.scala 305:24]
  assign io_ct1_fire = (io_ct1_valid && io_ct1_ready); // @[BaseType.scala 305:24]
  assign io_ct2_fire = (io_ct2_valid && io_ct2_ready); // @[BaseType.scala 305:24]
  assign when_AES_Masked_l562 = (r_control_value == 5'h08); // @[BaseType.scala 305:24]
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      r_stateReg_0_0_0 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_0_1 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_0_2 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_0_3 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_1_0 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_1_1 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_1_2 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_1_3 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_2_0 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_2_1 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_2_2 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_2_3 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_3_0 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_3_1 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_3_2 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_0_3_3 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_0_0 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_0_1 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_0_2 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_0_3 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_1_0 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_1_1 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_1_2 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_1_3 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_2_0 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_2_1 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_2_2 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_2_3 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_3_0 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_3_1 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_3_2 <= 8'h0; // @[Data.scala 400:33]
      r_stateReg_1_3_3 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_0_0 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_0_1 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_0_2 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_0_3 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_1_0 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_1_1 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_1_2 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_1_3 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_2_0 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_2_1 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_2_2 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_2_3 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_3_0 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_3_1 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_3_2 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_0_3_3 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_0_0 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_0_1 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_0_2 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_0_3 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_1_0 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_1_1 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_1_2 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_1_3 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_2_0 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_2_1 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_2_2 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_2_3 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_3_0 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_3_1 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_3_2 <= 8'h0; // @[Data.scala 400:33]
      r_keyReg_1_3_3 <= 8'h0; // @[Data.scala 400:33]
      r_fsmState <= AESState_sIdle; // @[Data.scala 400:33]
      r_round_value <= 4'b0001; // @[Data.scala 400:33]
      r_control_value <= 5'h0; // @[Data.scala 400:33]
      r_roundConstant <= 8'h01; // @[Data.scala 400:33]
    end else begin
      r_round_value <= r_round_valueNext; // @[Reg.scala 39:30]
      r_control_value <= r_control_valueNext; // @[Reg.scala 39:30]
      if(when_AES_Masked_l36) begin
        if(when_AES_Masked_l37) begin
          r_roundConstant <= (r_roundConstant <<< 1); // @[AES_Masked.scala 38:47]
        end else begin
          r_roundConstant <= (_zz_r_roundConstant ^ 8'h1b); // @[AES_Masked.scala 40:47]
        end
      end
      if(r_stateRotation) begin
        r_stateReg_0_0_0 <= r_stateReg_0_1_0; // @[AES_Masked.scala 88:43]
        r_stateReg_0_1_0 <= r_stateReg_0_2_0; // @[AES_Masked.scala 89:43]
        r_stateReg_0_2_0 <= r_stateReg_0_3_0; // @[AES_Masked.scala 90:43]
        r_stateReg_0_3_0 <= r_stateReg_0_0_1; // @[AES_Masked.scala 91:43]
        r_stateReg_0_0_1 <= r_stateReg_0_1_1; // @[AES_Masked.scala 92:43]
        r_stateReg_0_1_1 <= r_stateReg_0_2_1; // @[AES_Masked.scala 93:43]
        r_stateReg_0_2_1 <= r_stateReg_0_3_1; // @[AES_Masked.scala 94:43]
        r_stateReg_0_3_1 <= r_stateReg_0_0_2; // @[AES_Masked.scala 95:43]
        r_stateReg_0_0_2 <= r_stateReg_0_1_2; // @[AES_Masked.scala 96:43]
        r_stateReg_0_1_2 <= r_stateReg_0_2_2; // @[AES_Masked.scala 97:43]
        r_stateReg_0_2_2 <= r_stateReg_0_3_2; // @[AES_Masked.scala 98:43]
        r_stateReg_0_3_2 <= r_stateReg_0_0_3; // @[AES_Masked.scala 99:43]
        r_stateReg_0_0_3 <= r_stateReg_0_1_3; // @[AES_Masked.scala 100:43]
        r_stateReg_0_1_3 <= r_stateReg_0_2_3; // @[AES_Masked.scala 101:43]
        r_stateReg_0_2_3 <= r_stateReg_0_3_3; // @[AES_Masked.scala 102:43]
        r_stateReg_0_3_3 <= r_sbox_io_sbOut0; // @[AES_Masked.scala 103:43]
        if(r_finalKeyAdd) begin
          r_stateReg_0_3_3 <= r_addroundkey1_io_b; // @[AES_Masked.scala 105:51]
        end
        r_stateReg_1_0_0 <= r_stateReg_1_1_0; // @[AES_Masked.scala 108:43]
        r_stateReg_1_1_0 <= r_stateReg_1_2_0; // @[AES_Masked.scala 109:43]
        r_stateReg_1_2_0 <= r_stateReg_1_3_0; // @[AES_Masked.scala 110:43]
        r_stateReg_1_3_0 <= r_stateReg_1_0_1; // @[AES_Masked.scala 111:43]
        r_stateReg_1_0_1 <= r_stateReg_1_1_1; // @[AES_Masked.scala 112:43]
        r_stateReg_1_1_1 <= r_stateReg_1_2_1; // @[AES_Masked.scala 113:43]
        r_stateReg_1_2_1 <= r_stateReg_1_3_1; // @[AES_Masked.scala 114:43]
        r_stateReg_1_3_1 <= r_stateReg_1_0_2; // @[AES_Masked.scala 115:43]
        r_stateReg_1_0_2 <= r_stateReg_1_1_2; // @[AES_Masked.scala 116:43]
        r_stateReg_1_1_2 <= r_stateReg_1_2_2; // @[AES_Masked.scala 117:43]
        r_stateReg_1_2_2 <= r_stateReg_1_3_2; // @[AES_Masked.scala 118:43]
        r_stateReg_1_3_2 <= r_stateReg_1_0_3; // @[AES_Masked.scala 119:43]
        r_stateReg_1_0_3 <= r_stateReg_1_1_3; // @[AES_Masked.scala 120:43]
        r_stateReg_1_1_3 <= r_stateReg_1_2_3; // @[AES_Masked.scala 121:43]
        r_stateReg_1_2_3 <= r_stateReg_1_3_3; // @[AES_Masked.scala 122:43]
        r_stateReg_1_3_3 <= r_sbox_io_sbOut1; // @[AES_Masked.scala 123:43]
        if(r_finalKeyAdd) begin
          r_stateReg_1_3_3 <= r_addroundkey2_io_b; // @[AES_Masked.scala 125:51]
        end
      end else begin
        if(r_shiftRowsRotation) begin
          r_stateReg_0_0_0 <= r_stateReg_0_0_0; // @[AES_Masked.scala 128:43]
          r_stateReg_0_0_1 <= r_stateReg_0_0_1; // @[AES_Masked.scala 129:43]
          r_stateReg_0_0_2 <= r_stateReg_0_0_2; // @[AES_Masked.scala 130:43]
          r_stateReg_0_0_3 <= r_stateReg_0_0_3; // @[AES_Masked.scala 131:43]
          r_stateReg_0_1_0 <= r_stateReg_0_1_1; // @[AES_Masked.scala 132:43]
          r_stateReg_0_1_1 <= r_stateReg_0_1_2; // @[AES_Masked.scala 133:43]
          r_stateReg_0_1_2 <= r_stateReg_0_1_3; // @[AES_Masked.scala 134:43]
          r_stateReg_0_1_3 <= r_stateReg_0_1_0; // @[AES_Masked.scala 135:43]
          r_stateReg_0_2_0 <= r_stateReg_0_2_2; // @[AES_Masked.scala 136:43]
          r_stateReg_0_2_1 <= r_stateReg_0_2_3; // @[AES_Masked.scala 137:43]
          r_stateReg_0_2_2 <= r_stateReg_0_2_0; // @[AES_Masked.scala 138:43]
          r_stateReg_0_2_3 <= r_stateReg_0_2_1; // @[AES_Masked.scala 139:43]
          r_stateReg_0_3_0 <= r_stateReg_0_3_3; // @[AES_Masked.scala 140:43]
          r_stateReg_0_3_1 <= r_stateReg_0_3_0; // @[AES_Masked.scala 141:43]
          r_stateReg_0_3_2 <= r_stateReg_0_3_1; // @[AES_Masked.scala 142:43]
          r_stateReg_0_3_3 <= r_stateReg_0_3_2; // @[AES_Masked.scala 143:43]
          r_stateReg_1_0_0 <= r_stateReg_1_0_0; // @[AES_Masked.scala 145:43]
          r_stateReg_1_0_1 <= r_stateReg_1_0_1; // @[AES_Masked.scala 146:43]
          r_stateReg_1_0_2 <= r_stateReg_1_0_2; // @[AES_Masked.scala 147:43]
          r_stateReg_1_0_3 <= r_stateReg_1_0_3; // @[AES_Masked.scala 148:43]
          r_stateReg_1_1_0 <= r_stateReg_1_1_1; // @[AES_Masked.scala 149:43]
          r_stateReg_1_1_1 <= r_stateReg_1_1_2; // @[AES_Masked.scala 150:43]
          r_stateReg_1_1_2 <= r_stateReg_1_1_3; // @[AES_Masked.scala 151:43]
          r_stateReg_1_1_3 <= r_stateReg_1_1_0; // @[AES_Masked.scala 152:43]
          r_stateReg_1_2_0 <= r_stateReg_1_2_2; // @[AES_Masked.scala 153:43]
          r_stateReg_1_2_1 <= r_stateReg_1_2_3; // @[AES_Masked.scala 154:43]
          r_stateReg_1_2_2 <= r_stateReg_1_2_0; // @[AES_Masked.scala 155:43]
          r_stateReg_1_2_3 <= r_stateReg_1_2_1; // @[AES_Masked.scala 156:43]
          r_stateReg_1_3_0 <= r_stateReg_1_3_3; // @[AES_Masked.scala 157:43]
          r_stateReg_1_3_1 <= r_stateReg_1_3_0; // @[AES_Masked.scala 158:43]
          r_stateReg_1_3_2 <= r_stateReg_1_3_1; // @[AES_Masked.scala 159:43]
          r_stateReg_1_3_3 <= r_stateReg_1_3_2; // @[AES_Masked.scala 160:43]
        end else begin
          if(r_mixColumnsRotation) begin
            if(r_mixColumnsRotation1) begin
              r_stateReg_0_0_0 <= r_stateReg_0_0_1; // @[AES_Masked.scala 163:51]
              r_stateReg_0_1_0 <= r_stateReg_0_1_1; // @[AES_Masked.scala 164:51]
              r_stateReg_0_2_0 <= r_stateReg_0_2_1; // @[AES_Masked.scala 165:51]
              r_stateReg_0_3_0 <= r_stateReg_0_3_1; // @[AES_Masked.scala 166:51]
              r_stateReg_0_0_1 <= r_stateReg_0_0_2; // @[AES_Masked.scala 167:51]
              r_stateReg_0_1_1 <= r_stateReg_0_1_2; // @[AES_Masked.scala 168:51]
              r_stateReg_0_2_1 <= r_stateReg_0_2_2; // @[AES_Masked.scala 169:51]
              r_stateReg_0_3_1 <= r_stateReg_0_3_2; // @[AES_Masked.scala 170:51]
              r_stateReg_0_0_2 <= r_stateReg_0_0_3; // @[AES_Masked.scala 171:51]
              r_stateReg_0_1_2 <= r_stateReg_0_1_3; // @[AES_Masked.scala 172:51]
              r_stateReg_0_2_2 <= r_stateReg_0_2_3; // @[AES_Masked.scala 173:51]
              r_stateReg_0_3_2 <= r_stateReg_0_3_3; // @[AES_Masked.scala 174:51]
              r_stateReg_0_0_3 <= r_mixcolumns1_io_mcOut1; // @[AES_Masked.scala 175:51]
              r_stateReg_0_1_3 <= r_mixcolumns1_io_mcOut2; // @[AES_Masked.scala 176:51]
              r_stateReg_0_2_3 <= r_mixcolumns1_io_mcOut3; // @[AES_Masked.scala 177:51]
              r_stateReg_0_3_3 <= r_mixcolumns1_io_mcOut4; // @[AES_Masked.scala 178:51]
              if(r_initRotation) begin
                r_stateReg_0_0_3 <= io_pt1_payload[31 : 24]; // @[AES_Masked.scala 180:59]
                r_stateReg_0_1_3 <= io_pt1_payload[23 : 16]; // @[AES_Masked.scala 181:59]
                r_stateReg_0_2_3 <= io_pt1_payload[15 : 8]; // @[AES_Masked.scala 182:59]
                r_stateReg_0_3_3 <= io_pt1_payload[7 : 0]; // @[AES_Masked.scala 183:59]
              end
              if(r_finalRound) begin
                r_stateReg_0_0_3 <= r_stateReg_0_0_0; // @[AES_Masked.scala 186:59]
                r_stateReg_0_1_3 <= r_stateReg_0_1_0; // @[AES_Masked.scala 187:59]
                r_stateReg_0_2_3 <= r_stateReg_0_2_0; // @[AES_Masked.scala 188:59]
                r_stateReg_0_3_3 <= r_stateReg_0_3_0; // @[AES_Masked.scala 189:59]
              end
            end
            if(r_mixColumnsRotation2) begin
              r_stateReg_1_0_0 <= r_stateReg_1_0_1; // @[AES_Masked.scala 194:51]
              r_stateReg_1_1_0 <= r_stateReg_1_1_1; // @[AES_Masked.scala 195:51]
              r_stateReg_1_2_0 <= r_stateReg_1_2_1; // @[AES_Masked.scala 196:51]
              r_stateReg_1_3_0 <= r_stateReg_1_3_1; // @[AES_Masked.scala 197:51]
              r_stateReg_1_0_1 <= r_stateReg_1_0_2; // @[AES_Masked.scala 198:51]
              r_stateReg_1_1_1 <= r_stateReg_1_1_2; // @[AES_Masked.scala 199:51]
              r_stateReg_1_2_1 <= r_stateReg_1_2_2; // @[AES_Masked.scala 200:51]
              r_stateReg_1_3_1 <= r_stateReg_1_3_2; // @[AES_Masked.scala 201:51]
              r_stateReg_1_0_2 <= r_stateReg_1_0_3; // @[AES_Masked.scala 202:51]
              r_stateReg_1_1_2 <= r_stateReg_1_1_3; // @[AES_Masked.scala 203:51]
              r_stateReg_1_2_2 <= r_stateReg_1_2_3; // @[AES_Masked.scala 204:51]
              r_stateReg_1_3_2 <= r_stateReg_1_3_3; // @[AES_Masked.scala 205:51]
              r_stateReg_1_0_3 <= r_mixcolumns2_io_mcOut1; // @[AES_Masked.scala 206:51]
              r_stateReg_1_1_3 <= r_mixcolumns2_io_mcOut2; // @[AES_Masked.scala 207:51]
              r_stateReg_1_2_3 <= r_mixcolumns2_io_mcOut3; // @[AES_Masked.scala 208:51]
              r_stateReg_1_3_3 <= r_mixcolumns2_io_mcOut4; // @[AES_Masked.scala 209:51]
              if(r_initRotation) begin
                r_stateReg_1_0_3 <= io_pt2_payload[31 : 24]; // @[AES_Masked.scala 211:59]
                r_stateReg_1_1_3 <= io_pt2_payload[23 : 16]; // @[AES_Masked.scala 212:59]
                r_stateReg_1_2_3 <= io_pt2_payload[15 : 8]; // @[AES_Masked.scala 213:59]
                r_stateReg_1_3_3 <= io_pt2_payload[7 : 0]; // @[AES_Masked.scala 214:59]
              end
              if(r_finalRound) begin
                r_stateReg_1_0_3 <= r_stateReg_1_0_0; // @[AES_Masked.scala 216:59]
                r_stateReg_1_1_3 <= r_stateReg_1_1_0; // @[AES_Masked.scala 217:59]
                r_stateReg_1_2_3 <= r_stateReg_1_2_0; // @[AES_Masked.scala 218:59]
                r_stateReg_1_3_3 <= r_stateReg_1_3_0; // @[AES_Masked.scala 219:59]
              end
            end
          end
        end
      end
      if(r_keyInitRotation) begin
        if(r_mixColumnsRotation1) begin
          r_keyReg_0_0_3 <= io_key1_payload[31 : 24]; // @[AES_Masked.scala 226:49]
          r_keyReg_0_1_3 <= io_key1_payload[23 : 16]; // @[AES_Masked.scala 227:49]
          r_keyReg_0_2_3 <= io_key1_payload[15 : 8]; // @[AES_Masked.scala 228:49]
          r_keyReg_0_3_3 <= io_key1_payload[7 : 0]; // @[AES_Masked.scala 229:49]
          r_keyReg_0_0_0 <= r_keyReg_0_0_1; // @[AES_Masked.scala 230:49]
          r_keyReg_0_0_1 <= r_keyReg_0_0_2; // @[AES_Masked.scala 231:49]
          r_keyReg_0_0_2 <= r_keyReg_0_0_3; // @[AES_Masked.scala 232:49]
          r_keyReg_0_1_0 <= r_keyReg_0_1_1; // @[AES_Masked.scala 233:49]
          r_keyReg_0_1_1 <= r_keyReg_0_1_2; // @[AES_Masked.scala 234:49]
          r_keyReg_0_1_2 <= r_keyReg_0_1_3; // @[AES_Masked.scala 235:49]
          r_keyReg_0_2_0 <= r_keyReg_0_2_1; // @[AES_Masked.scala 236:49]
          r_keyReg_0_2_1 <= r_keyReg_0_2_2; // @[AES_Masked.scala 237:49]
          r_keyReg_0_2_2 <= r_keyReg_0_2_3; // @[AES_Masked.scala 238:49]
          r_keyReg_0_3_0 <= r_keyReg_0_3_1; // @[AES_Masked.scala 239:49]
          r_keyReg_0_3_1 <= r_keyReg_0_3_2; // @[AES_Masked.scala 240:49]
          r_keyReg_0_3_2 <= r_keyReg_0_3_3; // @[AES_Masked.scala 241:49]
        end
        if(r_mixColumnsRotation2) begin
          r_keyReg_1_0_3 <= io_key2_payload[31 : 24]; // @[AES_Masked.scala 245:49]
          r_keyReg_1_1_3 <= io_key2_payload[23 : 16]; // @[AES_Masked.scala 246:49]
          r_keyReg_1_2_3 <= io_key2_payload[15 : 8]; // @[AES_Masked.scala 247:49]
          r_keyReg_1_3_3 <= io_key2_payload[7 : 0]; // @[AES_Masked.scala 248:49]
          r_keyReg_1_0_0 <= r_keyReg_1_0_1; // @[AES_Masked.scala 249:49]
          r_keyReg_1_0_1 <= r_keyReg_1_0_2; // @[AES_Masked.scala 250:49]
          r_keyReg_1_0_2 <= r_keyReg_1_0_3; // @[AES_Masked.scala 251:49]
          r_keyReg_1_1_0 <= r_keyReg_1_1_1; // @[AES_Masked.scala 252:49]
          r_keyReg_1_1_1 <= r_keyReg_1_1_2; // @[AES_Masked.scala 253:49]
          r_keyReg_1_1_2 <= r_keyReg_1_1_3; // @[AES_Masked.scala 254:49]
          r_keyReg_1_2_0 <= r_keyReg_1_2_1; // @[AES_Masked.scala 255:49]
          r_keyReg_1_2_1 <= r_keyReg_1_2_2; // @[AES_Masked.scala 256:49]
          r_keyReg_1_2_2 <= r_keyReg_1_2_3; // @[AES_Masked.scala 257:49]
          r_keyReg_1_3_0 <= r_keyReg_1_3_1; // @[AES_Masked.scala 258:49]
          r_keyReg_1_3_1 <= r_keyReg_1_3_2; // @[AES_Masked.scala 259:49]
          r_keyReg_1_3_2 <= r_keyReg_1_3_3; // @[AES_Masked.scala 260:49]
        end
      end else begin
        if(r_keyRotation) begin
          r_keyReg_0_0_0 <= r_keyReg_0_1_0; // @[AES_Masked.scala 263:41]
          r_keyReg_0_1_0 <= r_keyReg_0_2_0; // @[AES_Masked.scala 264:41]
          r_keyReg_0_2_0 <= r_keyReg_0_3_0; // @[AES_Masked.scala 265:41]
          r_keyReg_0_0_1 <= r_keyReg_0_1_1; // @[AES_Masked.scala 266:41]
          r_keyReg_0_1_1 <= r_keyReg_0_2_1; // @[AES_Masked.scala 267:41]
          r_keyReg_0_2_1 <= r_keyReg_0_3_1; // @[AES_Masked.scala 268:41]
          r_keyReg_0_0_2 <= r_keyReg_0_1_2; // @[AES_Masked.scala 269:41]
          r_keyReg_0_1_2 <= r_keyReg_0_2_2; // @[AES_Masked.scala 270:41]
          r_keyReg_0_2_2 <= r_keyReg_0_3_2; // @[AES_Masked.scala 271:41]
          r_keyReg_0_0_3 <= r_keyReg_0_1_3; // @[AES_Masked.scala 272:41]
          r_keyReg_0_1_3 <= r_keyReg_0_2_3; // @[AES_Masked.scala 273:41]
          r_keyReg_0_2_3 <= r_keyReg_0_3_3; // @[AES_Masked.scala 274:41]
          r_keyReg_0_3_0 <= r_keyReg_0_0_1; // @[AES_Masked.scala 275:41]
          r_keyReg_0_3_1 <= r_keyReg_0_0_2; // @[AES_Masked.scala 276:41]
          r_keyReg_0_3_2 <= r_keyReg_0_0_3; // @[AES_Masked.scala 277:41]
          r_keyReg_0_3_3 <= r_keyReg_0_0_0; // @[AES_Masked.scala 278:41]
          r_keyReg_1_0_0 <= r_keyReg_1_1_0; // @[AES_Masked.scala 280:41]
          r_keyReg_1_1_0 <= r_keyReg_1_2_0; // @[AES_Masked.scala 281:41]
          r_keyReg_1_2_0 <= r_keyReg_1_3_0; // @[AES_Masked.scala 282:41]
          r_keyReg_1_0_1 <= r_keyReg_1_1_1; // @[AES_Masked.scala 283:41]
          r_keyReg_1_1_1 <= r_keyReg_1_2_1; // @[AES_Masked.scala 284:41]
          r_keyReg_1_2_1 <= r_keyReg_1_3_1; // @[AES_Masked.scala 285:41]
          r_keyReg_1_0_2 <= r_keyReg_1_1_2; // @[AES_Masked.scala 286:41]
          r_keyReg_1_1_2 <= r_keyReg_1_2_2; // @[AES_Masked.scala 287:41]
          r_keyReg_1_2_2 <= r_keyReg_1_3_2; // @[AES_Masked.scala 288:41]
          r_keyReg_1_0_3 <= r_keyReg_1_1_3; // @[AES_Masked.scala 289:41]
          r_keyReg_1_1_3 <= r_keyReg_1_2_3; // @[AES_Masked.scala 290:41]
          r_keyReg_1_2_3 <= r_keyReg_1_3_3; // @[AES_Masked.scala 291:41]
          r_keyReg_1_3_0 <= r_keyReg_1_0_1; // @[AES_Masked.scala 292:41]
          r_keyReg_1_3_1 <= r_keyReg_1_0_2; // @[AES_Masked.scala 293:41]
          r_keyReg_1_3_2 <= r_keyReg_1_0_3; // @[AES_Masked.scala 294:41]
          r_keyReg_1_3_3 <= r_keyReg_1_0_0; // @[AES_Masked.scala 295:41]
          if(r_keyRotation2) begin
            r_keyReg_0_3_0 <= (r_keyReg_0_0_0 ^ r_keyReg_0_0_1); // @[AES_Masked.scala 298:49]
            r_keyReg_0_3_1 <= r_keyReg_0_0_2; // @[AES_Masked.scala 299:49]
            r_keyReg_0_3_2 <= r_keyReg_0_0_3; // @[AES_Masked.scala 300:49]
            r_keyReg_0_3_3 <= r_keyReg_0_0_0; // @[AES_Masked.scala 301:49]
            r_keyReg_1_3_0 <= (r_keyReg_1_0_0 ^ r_keyReg_1_0_1); // @[AES_Masked.scala 303:49]
            r_keyReg_1_3_1 <= r_keyReg_1_0_2; // @[AES_Masked.scala 304:49]
            r_keyReg_1_3_2 <= r_keyReg_1_0_3; // @[AES_Masked.scala 305:49]
            r_keyReg_1_3_3 <= r_keyReg_1_0_0; // @[AES_Masked.scala 306:49]
          end
        end else begin
          if(r_keySboxRotation) begin
            r_keyReg_0_1_3 <= r_keyReg_0_2_3; // @[AES_Masked.scala 309:41]
            r_keyReg_0_2_3 <= r_keyReg_0_3_3; // @[AES_Masked.scala 310:41]
            r_keyReg_0_3_3 <= r_keyReg_0_0_3; // @[AES_Masked.scala 311:41]
            r_keyReg_0_0_3 <= r_keyReg_0_1_3; // @[AES_Masked.scala 312:41]
            r_keyReg_1_1_3 <= r_keyReg_1_2_3; // @[AES_Masked.scala 314:41]
            r_keyReg_1_2_3 <= r_keyReg_1_3_3; // @[AES_Masked.scala 315:41]
            r_keyReg_1_3_3 <= r_keyReg_1_0_3; // @[AES_Masked.scala 316:41]
            r_keyReg_1_0_3 <= r_keyReg_1_1_3; // @[AES_Masked.scala 317:41]
          end else begin
            if(r_keyRCRotation) begin
              r_keyReg_0_0_0 <= r_keyReg_0_1_0; // @[AES_Masked.scala 319:41]
              r_keyReg_0_1_0 <= r_keyReg_0_2_0; // @[AES_Masked.scala 320:41]
              r_keyReg_0_2_0 <= r_keyReg_0_3_0; // @[AES_Masked.scala 321:41]
              r_keyReg_0_3_0 <= ((r_sbox_io_sbOut0 ^ r_keyReg_0_0_0) ^ r_rc); // @[AES_Masked.scala 322:41]
              r_keyReg_1_0_0 <= r_keyReg_1_1_0; // @[AES_Masked.scala 324:41]
              r_keyReg_1_1_0 <= r_keyReg_1_2_0; // @[AES_Masked.scala 325:41]
              r_keyReg_1_2_0 <= r_keyReg_1_3_0; // @[AES_Masked.scala 326:41]
              r_keyReg_1_3_0 <= (r_sbox_io_sbOut1 ^ r_keyReg_1_0_0); // @[AES_Masked.scala 327:41]
            end
          end
        end
      end
      case(r_fsmState)
        AESState_sIdle : begin
          r_fsmState <= AESState_sIdle; // @[Enum.scala 148:67]
          r_stateReg_0_0_0 <= 8'h0; // @[AES_Masked.scala 344:75]
          r_stateReg_0_0_1 <= 8'h0; // @[AES_Masked.scala 344:75]
          r_stateReg_0_0_2 <= 8'h0; // @[AES_Masked.scala 344:75]
          r_stateReg_0_0_3 <= 8'h0; // @[AES_Masked.scala 344:75]
          r_stateReg_0_1_0 <= 8'h0; // @[AES_Masked.scala 344:75]
          r_stateReg_0_1_1 <= 8'h0; // @[AES_Masked.scala 344:75]
          r_stateReg_0_1_2 <= 8'h0; // @[AES_Masked.scala 344:75]
          r_stateReg_0_1_3 <= 8'h0; // @[AES_Masked.scala 344:75]
          r_stateReg_0_2_0 <= 8'h0; // @[AES_Masked.scala 344:75]
          r_stateReg_0_2_1 <= 8'h0; // @[AES_Masked.scala 344:75]
          r_stateReg_0_2_2 <= 8'h0; // @[AES_Masked.scala 344:75]
          r_stateReg_0_2_3 <= 8'h0; // @[AES_Masked.scala 344:75]
          r_stateReg_0_3_0 <= 8'h0; // @[AES_Masked.scala 344:75]
          r_stateReg_0_3_1 <= 8'h0; // @[AES_Masked.scala 344:75]
          r_stateReg_0_3_2 <= 8'h0; // @[AES_Masked.scala 344:75]
          r_stateReg_0_3_3 <= 8'h0; // @[AES_Masked.scala 344:75]
          r_stateReg_1_0_0 <= 8'h0; // @[AES_Masked.scala 345:75]
          r_stateReg_1_0_1 <= 8'h0; // @[AES_Masked.scala 345:75]
          r_stateReg_1_0_2 <= 8'h0; // @[AES_Masked.scala 345:75]
          r_stateReg_1_0_3 <= 8'h0; // @[AES_Masked.scala 345:75]
          r_stateReg_1_1_0 <= 8'h0; // @[AES_Masked.scala 345:75]
          r_stateReg_1_1_1 <= 8'h0; // @[AES_Masked.scala 345:75]
          r_stateReg_1_1_2 <= 8'h0; // @[AES_Masked.scala 345:75]
          r_stateReg_1_1_3 <= 8'h0; // @[AES_Masked.scala 345:75]
          r_stateReg_1_2_0 <= 8'h0; // @[AES_Masked.scala 345:75]
          r_stateReg_1_2_1 <= 8'h0; // @[AES_Masked.scala 345:75]
          r_stateReg_1_2_2 <= 8'h0; // @[AES_Masked.scala 345:75]
          r_stateReg_1_2_3 <= 8'h0; // @[AES_Masked.scala 345:75]
          r_stateReg_1_3_0 <= 8'h0; // @[AES_Masked.scala 345:75]
          r_stateReg_1_3_1 <= 8'h0; // @[AES_Masked.scala 345:75]
          r_stateReg_1_3_2 <= 8'h0; // @[AES_Masked.scala 345:75]
          r_stateReg_1_3_3 <= 8'h0; // @[AES_Masked.scala 345:75]
          r_keyReg_0_0_0 <= 8'h0; // @[AES_Masked.scala 346:73]
          r_keyReg_0_0_1 <= 8'h0; // @[AES_Masked.scala 346:73]
          r_keyReg_0_0_2 <= 8'h0; // @[AES_Masked.scala 346:73]
          r_keyReg_0_0_3 <= 8'h0; // @[AES_Masked.scala 346:73]
          r_keyReg_0_1_0 <= 8'h0; // @[AES_Masked.scala 346:73]
          r_keyReg_0_1_1 <= 8'h0; // @[AES_Masked.scala 346:73]
          r_keyReg_0_1_2 <= 8'h0; // @[AES_Masked.scala 346:73]
          r_keyReg_0_1_3 <= 8'h0; // @[AES_Masked.scala 346:73]
          r_keyReg_0_2_0 <= 8'h0; // @[AES_Masked.scala 346:73]
          r_keyReg_0_2_1 <= 8'h0; // @[AES_Masked.scala 346:73]
          r_keyReg_0_2_2 <= 8'h0; // @[AES_Masked.scala 346:73]
          r_keyReg_0_2_3 <= 8'h0; // @[AES_Masked.scala 346:73]
          r_keyReg_0_3_0 <= 8'h0; // @[AES_Masked.scala 346:73]
          r_keyReg_0_3_1 <= 8'h0; // @[AES_Masked.scala 346:73]
          r_keyReg_0_3_2 <= 8'h0; // @[AES_Masked.scala 346:73]
          r_keyReg_0_3_3 <= 8'h0; // @[AES_Masked.scala 346:73]
          r_keyReg_1_0_0 <= 8'h0; // @[AES_Masked.scala 347:73]
          r_keyReg_1_0_1 <= 8'h0; // @[AES_Masked.scala 347:73]
          r_keyReg_1_0_2 <= 8'h0; // @[AES_Masked.scala 347:73]
          r_keyReg_1_0_3 <= 8'h0; // @[AES_Masked.scala 347:73]
          r_keyReg_1_1_0 <= 8'h0; // @[AES_Masked.scala 347:73]
          r_keyReg_1_1_1 <= 8'h0; // @[AES_Masked.scala 347:73]
          r_keyReg_1_1_2 <= 8'h0; // @[AES_Masked.scala 347:73]
          r_keyReg_1_1_3 <= 8'h0; // @[AES_Masked.scala 347:73]
          r_keyReg_1_2_0 <= 8'h0; // @[AES_Masked.scala 347:73]
          r_keyReg_1_2_1 <= 8'h0; // @[AES_Masked.scala 347:73]
          r_keyReg_1_2_2 <= 8'h0; // @[AES_Masked.scala 347:73]
          r_keyReg_1_2_3 <= 8'h0; // @[AES_Masked.scala 347:73]
          r_keyReg_1_3_0 <= 8'h0; // @[AES_Masked.scala 347:73]
          r_keyReg_1_3_1 <= 8'h0; // @[AES_Masked.scala 347:73]
          r_keyReg_1_3_2 <= 8'h0; // @[AES_Masked.scala 347:73]
          r_keyReg_1_3_3 <= 8'h0; // @[AES_Masked.scala 347:73]
          r_roundConstant <= 8'h01; // @[AES_Masked.scala 350:47]
          if(io_enable) begin
            r_fsmState <= AESState_sInit; // @[Enum.scala 148:67]
          end
        end
        AESState_sInit : begin
          r_fsmState <= AESState_sInit; // @[Enum.scala 148:67]
          if(when_AES_Masked_l404) begin
            if(when_AES_Masked_l406) begin
              r_fsmState <= AESState_sRound; // @[Enum.scala 148:67]
            end
          end
        end
        AESState_sRound : begin
          r_fsmState <= AESState_sRound; // @[Enum.scala 148:67]
          if(when_AES_Masked_l464) begin
            if(when_AES_Masked_l466) begin
              r_fsmState <= AESState_sDone; // @[Enum.scala 148:67]
            end
          end
        end
        default : begin
          r_fsmState <= AESState_sDone; // @[Enum.scala 148:67]
          if(when_AES_Masked_l562) begin
            r_fsmState <= AESState_sIdle; // @[Enum.scala 148:67]
          end
        end
      endcase
    end
  end


endmodule

//MixColumns_1 replaced by MixColumns_1

module MixColumns_1 (
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

module SBoxMasked (
  input               io_clk,
  input               io_reset,
  input      [7:0]    io_sbIn0,
  input      [7:0]    io_sbIn1,
  input      [27:0]   io_m,
  output     [7:0]    io_sbOut0,
  output     [7:0]    io_sbOut1
);

  wire       [7:0]    convert0_io_output;
  wire       [7:0]    convert1_io_output;
  wire       [7:0]    convert2_io_output;
  wire       [7:0]    convert3_io_output;
  wire       [7:0]    inv_io_z_0;
  wire       [7:0]    inv_io_z_1;

  NewBasis_3 convert0 (
    .io_input     (io_sbIn0[7:0]          ), //i
    .io_direction (1'b0                   ), //i
    .io_output    (convert0_io_output[7:0])  //o
  );
  NewBasis_3 convert1 (
    .io_input     (io_sbIn1[7:0]          ), //i
    .io_direction (1'b0                   ), //i
    .io_output    (convert1_io_output[7:0])  //o
  );
  NewBasis_3 convert2 (
    .io_input     (inv_io_z_0[7:0]        ), //i
    .io_direction (1'b1                   ), //i
    .io_output    (convert2_io_output[7:0])  //o
  );
  NewBasis_3 convert3 (
    .io_input     (inv_io_z_1[7:0]        ), //i
    .io_direction (1'b1                   ), //i
    .io_output    (convert3_io_output[7:0])  //o
  );
  G256Inv2Shares5Stages inv (
    .io_clk   (io_clk                 ), //i
    .io_reset (io_reset               ), //i
    .io_x_0   (convert0_io_output[7:0]), //i
    .io_x_1   (convert1_io_output[7:0]), //i
    .io_m     (io_m[27:0]             ), //i
    .io_z_0   (inv_io_z_0[7:0]        ), //o
    .io_z_1   (inv_io_z_1[7:0]        )  //o
  );
  assign io_sbOut0 = (convert2_io_output ^ 8'h63); // @[SBoxMasked.scala 34:19]
  assign io_sbOut1 = convert3_io_output; // @[SBoxMasked.scala 35:19]

endmodule

//AddRoundKey_1 replaced by AddRoundKey_1

module AddRoundKey_1 (
  input      [7:0]    io_a,
  input      [7:0]    io_k,
  output     [7:0]    io_b
);


  assign io_b = (io_a ^ io_k); // @[AddRoundKey.scala 10:14]

endmodule

module G256Inv2Shares5Stages (
  input               io_clk,
  input               io_reset,
  input      [7:0]    io_x_0,
  input      [7:0]    io_x_1,
  input      [27:0]   io_m,
  output     [7:0]    io_z_0,
  output     [7:0]    io_z_1
);

  wire       [7:0]    r_mul1_io_m;
  wire       [3:0]    r_mul2_io_m;
  wire       [3:0]    r_mul3_io_m;
  wire       [3:0]    r_inv_io_x_0;
  wire       [3:0]    r_inv_io_x_1;
  wire       [11:0]   r_inv_io_m;
  wire       [3:0]    g16SqSc_2_io_t;
  wire       [3:0]    g16SqSc_3_io_t;
  wire       [3:0]    r_mul1_io_z_0;
  wire       [3:0]    r_mul1_io_z_1;
  wire       [3:0]    r_mul2_io_z_0;
  wire       [3:0]    r_mul2_io_z_1;
  wire       [3:0]    r_mul3_io_z_0;
  wire       [3:0]    r_mul3_io_z_1;
  wire       [3:0]    r_inv_io_z_0;
  wire       [3:0]    r_inv_io_z_1;
  wire       [3:0]    g16SqSc_2_io_x;
  wire       [3:0]    g16SqSc_3_io_x;
  wire       [3:0]    r_a_0;
  wire       [3:0]    r_a_1;
  wire       [3:0]    r_b_0;
  wire       [3:0]    r_b_1;
  wire       [3:0]    r_d_0;
  wire       [3:0]    r_d_1;
  wire       [3:0]    r_e_0;
  wire       [3:0]    r_e_1;
  wire       [3:0]    r_f_0;
  wire       [3:0]    r_f_1;
  wire       [3:0]    r_p_0;
  wire       [3:0]    r_p_1;
  wire       [3:0]    r_q_0;
  wire       [3:0]    r_q_1;
  reg        [3:0]    r_a1_0;
  reg        [3:0]    r_a1_1;
  reg        [3:0]    r_a2_0;
  reg        [3:0]    r_a2_1;
  reg        [3:0]    r_a3_0;
  reg        [3:0]    r_a3_1;
  reg        [3:0]    r_b1_0;
  reg        [3:0]    r_b1_1;
  reg        [3:0]    r_b2_0;
  reg        [3:0]    r_b2_1;
  reg        [3:0]    r_b3_0;
  reg        [3:0]    r_b3_1;
  reg        [3:0]    r_c_0;
  reg        [3:0]    r_c_1;

  G16Mul2SharesDepMul r_mul1 (
    .io_clk   (io_clk            ), //i
    .io_reset (io_reset          ), //i
    .io_x_0   (r_a_0[3:0]        ), //i
    .io_x_1   (r_a_1[3:0]        ), //i
    .io_y_0   (r_b_0[3:0]        ), //i
    .io_y_1   (r_b_1[3:0]        ), //i
    .io_m     (r_mul1_io_m[7:0]  ), //i
    .io_z_0   (r_mul1_io_z_0[3:0]), //o
    .io_z_1   (r_mul1_io_z_1[3:0])  //o
  );
  G16Mul2SharesIndepMul_1 r_mul2 (
    .io_clk   (io_clk            ), //i
    .io_reset (io_reset          ), //i
    .io_x_0   (r_b3_0[3:0]       ), //i
    .io_x_1   (r_b3_1[3:0]       ), //i
    .io_y_0   (r_f_0[3:0]        ), //i
    .io_y_1   (r_f_1[3:0]        ), //i
    .io_m     (r_mul2_io_m[3:0]  ), //i
    .io_z_0   (r_mul2_io_z_0[3:0]), //o
    .io_z_1   (r_mul2_io_z_1[3:0])  //o
  );
  G16Mul2SharesIndepMul_1 r_mul3 (
    .io_clk   (io_clk            ), //i
    .io_reset (io_reset          ), //i
    .io_x_0   (r_a3_0[3:0]       ), //i
    .io_x_1   (r_a3_1[3:0]       ), //i
    .io_y_0   (r_f_0[3:0]        ), //i
    .io_y_1   (r_f_1[3:0]        ), //i
    .io_m     (r_mul3_io_m[3:0]  ), //i
    .io_z_0   (r_mul3_io_z_0[3:0]), //o
    .io_z_1   (r_mul3_io_z_1[3:0])  //o
  );
  G16Inv2SharesDep r_inv (
    .io_clk   (io_clk           ), //i
    .io_reset (io_reset         ), //i
    .io_x_0   (r_inv_io_x_0[3:0]), //i
    .io_x_1   (r_inv_io_x_1[3:0]), //i
    .io_m     (r_inv_io_m[11:0] ), //i
    .io_z_0   (r_inv_io_z_0[3:0]), //o
    .io_z_1   (r_inv_io_z_1[3:0])  //o
  );
  G16SqSc_1 g16SqSc_2 (
    .io_t (g16SqSc_2_io_t[3:0]), //i
    .io_x (g16SqSc_2_io_x[3:0])  //o
  );
  G16SqSc_1 g16SqSc_3 (
    .io_t (g16SqSc_3_io_t[3:0]), //i
    .io_x (g16SqSc_3_io_x[3:0])  //o
  );
  assign r_a_0 = io_x_0[7 : 4]; // @[Galois_Field.scala 70:30]
  assign r_b_0 = io_x_0[3 : 0]; // @[Galois_Field.scala 71:30]
  assign r_a_1 = io_x_1[7 : 4]; // @[Galois_Field.scala 70:30]
  assign r_b_1 = io_x_1[3 : 0]; // @[Galois_Field.scala 71:30]
  assign g16SqSc_2_io_t = (r_a_0 ^ r_b_0); // @[Galois_Field.scala 82:35]
  assign g16SqSc_3_io_t = (r_a_1 ^ r_b_1); // @[Galois_Field.scala 82:35]
  assign r_mul1_io_m = io_m[27 : 20]; // @[Galois_Field.scala 90:27]
  assign r_d_0 = r_mul1_io_z_0; // @[Galois_Field.scala 91:19]
  assign r_d_1 = r_mul1_io_z_1; // @[Galois_Field.scala 91:19]
  assign r_inv_io_x_0 = (r_c_0 ^ r_d_0); // @[Galois_Field.scala 96:29]
  assign r_inv_io_x_1 = (r_c_1 ^ r_d_1); // @[Galois_Field.scala 97:29]
  assign r_inv_io_m = io_m[19 : 8]; // @[Galois_Field.scala 98:26]
  assign r_f_0 = r_inv_io_z_0; // @[Galois_Field.scala 99:19]
  assign r_f_1 = r_inv_io_z_1; // @[Galois_Field.scala 99:19]
  assign r_mul2_io_m = io_m[7 : 4]; // @[Galois_Field.scala 105:27]
  assign r_p_0 = r_mul2_io_z_0; // @[Galois_Field.scala 106:19]
  assign r_p_1 = r_mul2_io_z_1; // @[Galois_Field.scala 106:19]
  assign r_mul3_io_m = io_m[3 : 0]; // @[Galois_Field.scala 112:27]
  assign r_q_0 = r_mul3_io_z_0; // @[Galois_Field.scala 113:19]
  assign r_q_1 = r_mul3_io_z_1; // @[Galois_Field.scala 113:19]
  assign io_z_0 = {r_p_0,r_q_0}; // @[Galois_Field.scala 116:25]
  assign io_z_1 = {r_p_1,r_q_1}; // @[Galois_Field.scala 117:25]
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      r_a1_0 <= 4'b0000; // @[Data.scala 400:33]
      r_a1_1 <= 4'b0000; // @[Data.scala 400:33]
      r_a2_0 <= 4'b0000; // @[Data.scala 400:33]
      r_a2_1 <= 4'b0000; // @[Data.scala 400:33]
      r_a3_0 <= 4'b0000; // @[Data.scala 400:33]
      r_a3_1 <= 4'b0000; // @[Data.scala 400:33]
      r_b1_0 <= 4'b0000; // @[Data.scala 400:33]
      r_b1_1 <= 4'b0000; // @[Data.scala 400:33]
      r_b2_0 <= 4'b0000; // @[Data.scala 400:33]
      r_b2_1 <= 4'b0000; // @[Data.scala 400:33]
      r_b3_0 <= 4'b0000; // @[Data.scala 400:33]
      r_b3_1 <= 4'b0000; // @[Data.scala 400:33]
      r_c_0 <= 4'b0000; // @[Data.scala 400:33]
      r_c_1 <= 4'b0000; // @[Data.scala 400:33]
    end else begin
      r_a1_0 <= r_a_0; // @[Galois_Field.scala 72:31]
      r_a2_0 <= r_a1_0; // @[Galois_Field.scala 73:31]
      r_a3_0 <= r_a2_0; // @[Galois_Field.scala 74:31]
      r_b1_0 <= r_b_0; // @[Galois_Field.scala 75:31]
      r_b2_0 <= r_b1_0; // @[Galois_Field.scala 76:31]
      r_b3_0 <= r_b2_0; // @[Galois_Field.scala 77:31]
      r_a1_1 <= r_a_1; // @[Galois_Field.scala 72:31]
      r_a2_1 <= r_a1_1; // @[Galois_Field.scala 73:31]
      r_a3_1 <= r_a2_1; // @[Galois_Field.scala 74:31]
      r_b1_1 <= r_b_1; // @[Galois_Field.scala 75:31]
      r_b2_1 <= r_b1_1; // @[Galois_Field.scala 76:31]
      r_b3_1 <= r_b2_1; // @[Galois_Field.scala 77:31]
      r_c_0 <= g16SqSc_2_io_x; // @[Galois_Field.scala 83:30]
      r_c_1 <= g16SqSc_3_io_x; // @[Galois_Field.scala 83:30]
    end
  end


endmodule

//NewBasis_3 replaced by NewBasis_3

//NewBasis_3 replaced by NewBasis_3

//NewBasis_3 replaced by NewBasis_3

module NewBasis_3 (
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

//G16SqSc_1 replaced by G16SqSc_1

module G16SqSc_1 (
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

  G4Sq_7 square1 (
    .io_t (square1_io_t[1:0]), //i
    .io_x (square1_io_x[1:0])  //o
  );
  G4Sq_7 square2 (
    .io_t (b[1:0]           ), //i
    .io_x (square2_io_x[1:0])  //o
  );
  G4ScaleN2_1 scale (
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

module G16Inv2SharesDep (
  input               io_clk,
  input               io_reset,
  input      [3:0]    io_x_0,
  input      [3:0]    io_x_1,
  input      [11:0]   io_m,
  output     [3:0]    io_z_0,
  output     [3:0]    io_z_1
);

  wire       [3:0]    r_mul1_io_m;
  wire       [3:0]    r_mul2_io_m;
  wire       [3:0]    r_mul3_io_m;
  wire       [1:0]    g4Sq_8_io_t;
  wire       [1:0]    g4Sq_9_io_t;
  wire       [1:0]    g4Sq_10_io_t;
  wire       [1:0]    g4Sq_11_io_t;
  wire       [1:0]    r_mul1_io_z_0;
  wire       [1:0]    r_mul1_io_z_1;
  wire       [1:0]    r_mul2_io_z_0;
  wire       [1:0]    r_mul2_io_z_1;
  wire       [1:0]    r_mul3_io_z_0;
  wire       [1:0]    r_mul3_io_z_1;
  wire       [1:0]    g4Sq_8_io_x;
  wire       [1:0]    g4ScaleN_16_io_x;
  wire       [1:0]    g4Sq_9_io_x;
  wire       [1:0]    g4Sq_10_io_x;
  wire       [1:0]    g4ScaleN_17_io_x;
  wire       [1:0]    g4Sq_11_io_x;
  wire       [1:0]    r_a_0;
  wire       [1:0]    r_a_1;
  wire       [1:0]    r_b_0;
  wire       [1:0]    r_b_1;
  wire       [1:0]    r_d_0;
  wire       [1:0]    r_d_1;
  wire       [1:0]    r_e_0;
  wire       [1:0]    r_e_1;
  wire       [1:0]    r_p_0;
  wire       [1:0]    r_p_1;
  wire       [1:0]    r_q_0;
  wire       [1:0]    r_q_1;
  reg        [1:0]    r_c_0;
  reg        [1:0]    r_c_1;
  reg        [1:0]    r_a1_0;
  reg        [1:0]    r_a1_1;
  reg        [1:0]    r_b1_0;
  reg        [1:0]    r_b1_1;

  G4Mul2SharesDepMul_2 r_mul1 (
    .io_clk   (io_clk            ), //i
    .io_reset (io_reset          ), //i
    .io_x_0   (r_a_0[1:0]        ), //i
    .io_x_1   (r_a_1[1:0]        ), //i
    .io_y_0   (r_b_0[1:0]        ), //i
    .io_y_1   (r_b_1[1:0]        ), //i
    .io_m     (r_mul1_io_m[3:0]  ), //i
    .io_z_0   (r_mul1_io_z_0[1:0]), //o
    .io_z_1   (r_mul1_io_z_1[1:0])  //o
  );
  G4Mul2SharesDepMul_2 r_mul2 (
    .io_clk   (io_clk            ), //i
    .io_reset (io_reset          ), //i
    .io_x_0   (r_b1_0[1:0]       ), //i
    .io_x_1   (r_b1_1[1:0]       ), //i
    .io_y_0   (r_e_0[1:0]        ), //i
    .io_y_1   (r_e_1[1:0]        ), //i
    .io_m     (r_mul2_io_m[3:0]  ), //i
    .io_z_0   (r_mul2_io_z_0[1:0]), //o
    .io_z_1   (r_mul2_io_z_1[1:0])  //o
  );
  G4Mul2SharesDepMul_2 r_mul3 (
    .io_clk   (io_clk            ), //i
    .io_reset (io_reset          ), //i
    .io_x_0   (r_a1_0[1:0]       ), //i
    .io_x_1   (r_a1_1[1:0]       ), //i
    .io_y_0   (r_e_0[1:0]        ), //i
    .io_y_1   (r_e_1[1:0]        ), //i
    .io_m     (r_mul3_io_m[3:0]  ), //i
    .io_z_0   (r_mul3_io_z_0[1:0]), //o
    .io_z_1   (r_mul3_io_z_1[1:0])  //o
  );
  G4Sq_7 g4Sq_8 (
    .io_t (g4Sq_8_io_t[1:0]), //i
    .io_x (g4Sq_8_io_x[1:0])  //o
  );
  G4ScaleN_15 g4ScaleN_16 (
    .io_t (g4Sq_8_io_x[1:0]     ), //i
    .io_x (g4ScaleN_16_io_x[1:0])  //o
  );
  G4Sq_7 g4Sq_9 (
    .io_t (g4Sq_9_io_t[1:0]), //i
    .io_x (g4Sq_9_io_x[1:0])  //o
  );
  G4Sq_7 g4Sq_10 (
    .io_t (g4Sq_10_io_t[1:0]), //i
    .io_x (g4Sq_10_io_x[1:0])  //o
  );
  G4ScaleN_15 g4ScaleN_17 (
    .io_t (g4Sq_10_io_x[1:0]    ), //i
    .io_x (g4ScaleN_17_io_x[1:0])  //o
  );
  G4Sq_7 g4Sq_11 (
    .io_t (g4Sq_11_io_t[1:0]), //i
    .io_x (g4Sq_11_io_x[1:0])  //o
  );
  assign r_a_0 = io_x_0[3 : 2]; // @[Galois_Field.scala 136:30]
  assign r_b_0 = io_x_0[1 : 0]; // @[Galois_Field.scala 137:30]
  assign g4Sq_8_io_t = (r_a_0 ^ r_b_0); // @[Galois_Field.scala 143:37]
  assign g4Sq_9_io_t = (r_c_0 ^ r_d_0); // @[Galois_Field.scala 148:34]
  assign r_e_0 = g4Sq_9_io_x; // @[Galois_Field.scala 149:30]
  assign r_a_1 = io_x_1[3 : 2]; // @[Galois_Field.scala 136:30]
  assign r_b_1 = io_x_1[1 : 0]; // @[Galois_Field.scala 137:30]
  assign g4Sq_10_io_t = (r_a_1 ^ r_b_1); // @[Galois_Field.scala 143:37]
  assign g4Sq_11_io_t = (r_c_1 ^ r_d_1); // @[Galois_Field.scala 148:34]
  assign r_e_1 = g4Sq_11_io_x; // @[Galois_Field.scala 149:30]
  assign r_mul1_io_m = io_m[11 : 8]; // @[Galois_Field.scala 156:27]
  assign r_d_0 = r_mul1_io_z_0; // @[Galois_Field.scala 157:19]
  assign r_d_1 = r_mul1_io_z_1; // @[Galois_Field.scala 157:19]
  assign r_mul2_io_m = io_m[7 : 4]; // @[Galois_Field.scala 163:27]
  assign r_p_0 = r_mul2_io_z_0; // @[Galois_Field.scala 164:19]
  assign r_p_1 = r_mul2_io_z_1; // @[Galois_Field.scala 164:19]
  assign r_mul3_io_m = io_m[3 : 0]; // @[Galois_Field.scala 170:27]
  assign r_q_0 = r_mul3_io_z_0; // @[Galois_Field.scala 171:19]
  assign r_q_1 = r_mul3_io_z_1; // @[Galois_Field.scala 171:19]
  assign io_z_0 = {r_p_0,r_q_0}; // @[Galois_Field.scala 174:25]
  assign io_z_1 = {r_p_1,r_q_1}; // @[Galois_Field.scala 175:25]
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      r_c_0 <= 2'b00; // @[Data.scala 400:33]
      r_c_1 <= 2'b00; // @[Data.scala 400:33]
      r_a1_0 <= 2'b00; // @[Data.scala 400:33]
      r_a1_1 <= 2'b00; // @[Data.scala 400:33]
      r_b1_0 <= 2'b00; // @[Data.scala 400:33]
      r_b1_1 <= 2'b00; // @[Data.scala 400:33]
    end else begin
      r_a1_0 <= r_a_0; // @[Galois_Field.scala 138:31]
      r_b1_0 <= r_b_0; // @[Galois_Field.scala 139:31]
      r_c_0 <= g4ScaleN_16_io_x; // @[Galois_Field.scala 145:30]
      r_a1_1 <= r_a_1; // @[Galois_Field.scala 138:31]
      r_b1_1 <= r_b_1; // @[Galois_Field.scala 139:31]
      r_c_1 <= g4ScaleN_17_io_x; // @[Galois_Field.scala 145:30]
    end
  end


endmodule

//G16Mul2SharesIndepMul_1 replaced by G16Mul2SharesIndepMul_1

module G16Mul2SharesIndepMul_1 (
  input               io_clk,
  input               io_reset,
  input      [3:0]    io_x_0,
  input      [3:0]    io_x_1,
  input      [3:0]    io_y_0,
  input      [3:0]    io_y_1,
  input      [3:0]    io_m,
  output     [3:0]    io_z_0,
  output     [3:0]    io_z_1
);

  wire       [3:0]    r_mul1_io_x;
  wire       [3:0]    r_mul2_io_x;
  wire       [3:0]    r_mul3_io_x;
  wire       [3:0]    r_mul4_io_x;
  reg        [3:0]    r_r0;
  reg        [3:0]    r_r1;
  reg        [3:0]    r_r2;
  reg        [3:0]    r_r3;

  G16Mul_13 r_mul1 (
    .io_a (io_x_0[3:0]     ), //i
    .io_b (io_y_0[3:0]     ), //i
    .io_x (r_mul1_io_x[3:0])  //o
  );
  G16Mul_13 r_mul2 (
    .io_a (io_x_0[3:0]     ), //i
    .io_b (io_y_1[3:0]     ), //i
    .io_x (r_mul2_io_x[3:0])  //o
  );
  G16Mul_13 r_mul3 (
    .io_a (io_x_1[3:0]     ), //i
    .io_b (io_y_0[3:0]     ), //i
    .io_x (r_mul3_io_x[3:0])  //o
  );
  G16Mul_13 r_mul4 (
    .io_a (io_x_1[3:0]     ), //i
    .io_b (io_y_1[3:0]     ), //i
    .io_x (r_mul4_io_x[3:0])  //o
  );
  assign io_z_0 = (r_r0 ^ r_r1); // @[Galois_Field.scala 419:25]
  assign io_z_1 = (r_r2 ^ r_r3); // @[Galois_Field.scala 420:25]
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      r_r0 <= 4'b0000; // @[Data.scala 400:33]
      r_r1 <= 4'b0000; // @[Data.scala 400:33]
      r_r2 <= 4'b0000; // @[Data.scala 400:33]
      r_r3 <= 4'b0000; // @[Data.scala 400:33]
    end else begin
      r_r0 <= r_mul1_io_x; // @[Galois_Field.scala 405:20]
      r_r1 <= (r_mul2_io_x ^ io_m); // @[Galois_Field.scala 409:20]
      r_r2 <= (r_mul3_io_x ^ io_m); // @[Galois_Field.scala 413:20]
      r_r3 <= r_mul4_io_x; // @[Galois_Field.scala 417:20]
    end
  end


endmodule

module G16Mul2SharesDepMul (
  input               io_clk,
  input               io_reset,
  input      [3:0]    io_x_0,
  input      [3:0]    io_x_1,
  input      [3:0]    io_y_0,
  input      [3:0]    io_y_1,
  input      [7:0]    io_m,
  output     [3:0]    io_z_0,
  output     [3:0]    io_z_1
);

  wire       [3:0]    g16Mul_18_io_b;
  wire       [3:0]    g16Mul_19_io_b;
  wire       [3:0]    g16Mul_14_io_x;
  wire       [3:0]    g16Mul_15_io_x;
  wire       [3:0]    g16Mul_16_io_x;
  wire       [3:0]    g16Mul_17_io_x;
  wire       [3:0]    g16Mul_18_io_x;
  wire       [3:0]    g16Mul_19_io_x;
  wire       [3:0]    r_xTimesBlindedY_0;
  wire       [3:0]    r_xTimesBlindedY_1;
  wire       [3:0]    r_xTimesM_0;
  wire       [3:0]    r_xTimesM_1;
  wire       [3:0]    r_xTimesY_0;
  wire       [3:0]    r_xTimesY_1;
  reg        [3:0]    r_blindedY_0;
  reg        [3:0]    r_blindedY_1;
  reg        [3:0]    r_xTimesMBlinded_0;
  reg        [3:0]    r_xTimesMBlinded_1;
  reg        [3:0]    r_X_0;
  reg        [3:0]    r_X_1;
  reg        [3:0]    r_Y_0;
  reg        [3:0]    r_Y_1;

  G16Mul_13 g16Mul_14 (
    .io_a (r_X_0[3:0]         ), //i
    .io_b (r_blindedY_0[3:0]  ), //i
    .io_x (g16Mul_14_io_x[3:0])  //o
  );
  G16Mul_13 g16Mul_15 (
    .io_a (r_X_1[3:0]         ), //i
    .io_b (r_blindedY_1[3:0]  ), //i
    .io_x (g16Mul_15_io_x[3:0])  //o
  );
  G16Mul_13 g16Mul_16 (
    .io_a (r_X_0[3:0]         ), //i
    .io_b (r_Y_0[3:0]         ), //i
    .io_x (g16Mul_16_io_x[3:0])  //o
  );
  G16Mul_13 g16Mul_17 (
    .io_a (r_X_1[3:0]         ), //i
    .io_b (r_Y_1[3:0]         ), //i
    .io_x (g16Mul_17_io_x[3:0])  //o
  );
  G16Mul_13 g16Mul_18 (
    .io_a (io_x_0[3:0]        ), //i
    .io_b (g16Mul_18_io_b[3:0]), //i
    .io_x (g16Mul_18_io_x[3:0])  //o
  );
  G16Mul_13 g16Mul_19 (
    .io_a (io_x_1[3:0]        ), //i
    .io_b (g16Mul_19_io_b[3:0]), //i
    .io_x (g16Mul_19_io_x[3:0])  //o
  );
  assign io_z_0 = ((r_xTimesY_0 ^ r_xTimesBlindedY_0) ^ r_xTimesMBlinded_0); // @[Galois_Field.scala 230:25]
  assign io_z_1 = ((r_xTimesY_1 ^ r_xTimesBlindedY_1) ^ r_xTimesMBlinded_1); // @[Galois_Field.scala 231:25]
  assign r_xTimesBlindedY_0 = g16Mul_14_io_x; // @[Galois_Field.scala 237:43]
  assign r_xTimesBlindedY_1 = g16Mul_15_io_x; // @[Galois_Field.scala 237:43]
  assign r_xTimesY_0 = g16Mul_16_io_x; // @[Galois_Field.scala 244:36]
  assign r_xTimesY_1 = g16Mul_17_io_x; // @[Galois_Field.scala 244:36]
  assign g16Mul_18_io_b = io_m[7 : 4]; // @[Galois_Field.scala 250:34]
  assign r_xTimesM_0 = g16Mul_18_io_x; // @[Galois_Field.scala 251:36]
  assign g16Mul_19_io_b = io_m[7 : 4]; // @[Galois_Field.scala 250:34]
  assign r_xTimesM_1 = g16Mul_19_io_x; // @[Galois_Field.scala 251:36]
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      r_blindedY_0 <= 4'b0000; // @[Data.scala 400:33]
      r_blindedY_1 <= 4'b0000; // @[Data.scala 400:33]
      r_xTimesMBlinded_0 <= 4'b0000; // @[Data.scala 400:33]
      r_xTimesMBlinded_1 <= 4'b0000; // @[Data.scala 400:33]
      r_X_0 <= 4'b0000; // @[Data.scala 400:33]
      r_X_1 <= 4'b0000; // @[Data.scala 400:33]
      r_Y_0 <= 4'b0000; // @[Data.scala 400:33]
      r_Y_1 <= 4'b0000; // @[Data.scala 400:33]
    end else begin
      r_X_0 <= io_x_0; // @[Galois_Field.scala 221:19]
      r_X_1 <= io_x_1; // @[Galois_Field.scala 221:19]
      r_Y_0 <= io_y_0; // @[Galois_Field.scala 222:19]
      r_Y_1 <= io_y_1; // @[Galois_Field.scala 222:19]
      r_blindedY_0 <= (io_y_1 ^ io_m[7 : 4]); // @[Galois_Field.scala 224:29]
      r_blindedY_1 <= (io_y_0 ^ io_m[7 : 4]); // @[Galois_Field.scala 225:29]
      r_xTimesMBlinded_0 <= (r_xTimesM_0 ^ io_m[3 : 0]); // @[Galois_Field.scala 227:35]
      r_xTimesMBlinded_1 <= (r_xTimesM_1 ^ io_m[3 : 0]); // @[Galois_Field.scala 228:35]
    end
  end


endmodule

//G4ScaleN2_1 replaced by G4ScaleN2_1

//G4Sq_7 replaced by G4Sq_7

//G4Sq_7 replaced by G4Sq_7

module G4ScaleN2_1 (
  input      [1:0]    io_t,
  output     [1:0]    io_x
);


  assign io_x = {(io_t[1] ^ io_t[0]),io_t[1]}; // @[Polynomial.scala 546:14]

endmodule

//G4Sq_7 replaced by G4Sq_7

//G4Sq_7 replaced by G4Sq_7

//G4Sq_7 replaced by G4Sq_7

//G4ScaleN_15 replaced by G4ScaleN_15

//G4Sq_7 replaced by G4Sq_7

//G4Sq_7 replaced by G4Sq_7

//G4ScaleN_15 replaced by G4ScaleN_15

module G4Sq_7 (
  input      [1:0]    io_t,
  output     [1:0]    io_x
);


  assign io_x = {io_t[0],io_t[1]}; // @[Polynomial.scala 528:14]

endmodule

//G4Mul2SharesDepMul_2 replaced by G4Mul2SharesDepMul_2

//G4Mul2SharesDepMul_2 replaced by G4Mul2SharesDepMul_2

module G4Mul2SharesDepMul_2 (
  input               io_clk,
  input               io_reset,
  input      [1:0]    io_x_0,
  input      [1:0]    io_x_1,
  input      [1:0]    io_y_0,
  input      [1:0]    io_y_1,
  input      [3:0]    io_m,
  output     [1:0]    io_z_0,
  output     [1:0]    io_z_1
);

  wire       [1:0]    g4Mul_64_io_b;
  wire       [1:0]    g4Mul_65_io_b;
  wire       [1:0]    g4Mul_60_io_x;
  wire       [1:0]    g4Mul_61_io_x;
  wire       [1:0]    g4Mul_62_io_x;
  wire       [1:0]    g4Mul_63_io_x;
  wire       [1:0]    g4Mul_64_io_x;
  wire       [1:0]    g4Mul_65_io_x;
  wire       [1:0]    r_xTimesBlindedY_0;
  wire       [1:0]    r_xTimesBlindedY_1;
  wire       [1:0]    r_xTimesM_0;
  wire       [1:0]    r_xTimesM_1;
  wire       [1:0]    r_xTimesY_0;
  wire       [1:0]    r_xTimesY_1;
  reg        [1:0]    r_blindedY_0;
  reg        [1:0]    r_blindedY_1;
  reg        [1:0]    r_xTimesMBlinded_0;
  reg        [1:0]    r_xTimesMBlinded_1;
  reg        [1:0]    r_X_0;
  reg        [1:0]    r_X_1;
  reg        [1:0]    r_Y_0;
  reg        [1:0]    r_Y_1;

  G4Mul_59 g4Mul_60 (
    .io_a (r_X_0[1:0]        ), //i
    .io_b (r_blindedY_0[1:0] ), //i
    .io_x (g4Mul_60_io_x[1:0])  //o
  );
  G4Mul_59 g4Mul_61 (
    .io_a (r_X_1[1:0]        ), //i
    .io_b (r_blindedY_1[1:0] ), //i
    .io_x (g4Mul_61_io_x[1:0])  //o
  );
  G4Mul_59 g4Mul_62 (
    .io_a (r_X_0[1:0]        ), //i
    .io_b (r_Y_0[1:0]        ), //i
    .io_x (g4Mul_62_io_x[1:0])  //o
  );
  G4Mul_59 g4Mul_63 (
    .io_a (r_X_1[1:0]        ), //i
    .io_b (r_Y_1[1:0]        ), //i
    .io_x (g4Mul_63_io_x[1:0])  //o
  );
  G4Mul_59 g4Mul_64 (
    .io_a (io_x_0[1:0]       ), //i
    .io_b (g4Mul_64_io_b[1:0]), //i
    .io_x (g4Mul_64_io_x[1:0])  //o
  );
  G4Mul_59 g4Mul_65 (
    .io_a (io_x_1[1:0]       ), //i
    .io_b (g4Mul_65_io_b[1:0]), //i
    .io_x (g4Mul_65_io_x[1:0])  //o
  );
  assign io_z_0 = ((r_xTimesY_0 ^ r_xTimesBlindedY_0) ^ r_xTimesMBlinded_0); // @[Galois_Field.scala 306:25]
  assign io_z_1 = ((r_xTimesY_1 ^ r_xTimesBlindedY_1) ^ r_xTimesMBlinded_1); // @[Galois_Field.scala 307:25]
  assign r_xTimesBlindedY_0 = g4Mul_60_io_x; // @[Galois_Field.scala 313:43]
  assign r_xTimesBlindedY_1 = g4Mul_61_io_x; // @[Galois_Field.scala 313:43]
  assign r_xTimesY_0 = g4Mul_62_io_x; // @[Galois_Field.scala 320:36]
  assign r_xTimesY_1 = g4Mul_63_io_x; // @[Galois_Field.scala 320:36]
  assign g4Mul_64_io_b = io_m[3 : 2]; // @[Galois_Field.scala 326:34]
  assign r_xTimesM_0 = g4Mul_64_io_x; // @[Galois_Field.scala 327:36]
  assign g4Mul_65_io_b = io_m[3 : 2]; // @[Galois_Field.scala 326:34]
  assign r_xTimesM_1 = g4Mul_65_io_x; // @[Galois_Field.scala 327:36]
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      r_blindedY_0 <= 2'b00; // @[Data.scala 400:33]
      r_blindedY_1 <= 2'b00; // @[Data.scala 400:33]
      r_xTimesMBlinded_0 <= 2'b00; // @[Data.scala 400:33]
      r_xTimesMBlinded_1 <= 2'b00; // @[Data.scala 400:33]
      r_X_0 <= 2'b00; // @[Data.scala 400:33]
      r_X_1 <= 2'b00; // @[Data.scala 400:33]
      r_Y_0 <= 2'b00; // @[Data.scala 400:33]
      r_Y_1 <= 2'b00; // @[Data.scala 400:33]
    end else begin
      r_X_0 <= io_x_0; // @[Galois_Field.scala 297:19]
      r_X_1 <= io_x_1; // @[Galois_Field.scala 297:19]
      r_Y_0 <= io_y_0; // @[Galois_Field.scala 298:19]
      r_Y_1 <= io_y_1; // @[Galois_Field.scala 298:19]
      r_blindedY_0 <= (io_y_1 ^ io_m[3 : 2]); // @[Galois_Field.scala 300:29]
      r_blindedY_1 <= (io_y_0 ^ io_m[3 : 2]); // @[Galois_Field.scala 301:29]
      r_xTimesMBlinded_0 <= (r_xTimesM_0 ^ io_m[1 : 0]); // @[Galois_Field.scala 303:35]
      r_xTimesMBlinded_1 <= (r_xTimesM_1 ^ io_m[1 : 0]); // @[Galois_Field.scala 304:35]
    end
  end


endmodule

//G16Mul_13 replaced by G16Mul_13

//G16Mul_13 replaced by G16Mul_13

//G16Mul_13 replaced by G16Mul_13

//G16Mul_13 replaced by G16Mul_13

//G16Mul_13 replaced by G16Mul_13

//G16Mul_13 replaced by G16Mul_13

//G16Mul_13 replaced by G16Mul_13

//G16Mul_13 replaced by G16Mul_13

//G16Mul_13 replaced by G16Mul_13

//G16Mul_13 replaced by G16Mul_13

//G16Mul_13 replaced by G16Mul_13

//G16Mul_13 replaced by G16Mul_13

//G16Mul_13 replaced by G16Mul_13

module G16Mul_13 (
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

  G4Mul_59 mul1 (
    .io_a (mul1_io_a[1:0]), //i
    .io_b (mul1_io_b[1:0]), //i
    .io_x (mul1_io_x[1:0])  //o
  );
  G4Mul_59 mul2 (
    .io_a (a[1:0]        ), //i
    .io_b (c[1:0]        ), //i
    .io_x (mul2_io_x[1:0])  //o
  );
  G4Mul_59 mul3 (
    .io_a (b[1:0]        ), //i
    .io_b (d[1:0]        ), //i
    .io_x (mul3_io_x[1:0])  //o
  );
  G4ScaleN_15 scale (
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

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4ScaleN_15 replaced by G4ScaleN_15

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4ScaleN_15 replaced by G4ScaleN_15

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4ScaleN_15 replaced by G4ScaleN_15

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4ScaleN_15 replaced by G4ScaleN_15

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4ScaleN_15 replaced by G4ScaleN_15

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4ScaleN_15 replaced by G4ScaleN_15

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4ScaleN_15 replaced by G4ScaleN_15

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4ScaleN_15 replaced by G4ScaleN_15

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4ScaleN_15 replaced by G4ScaleN_15

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4ScaleN_15 replaced by G4ScaleN_15

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4ScaleN_15 replaced by G4ScaleN_15

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4ScaleN_15 replaced by G4ScaleN_15

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4ScaleN_15 replaced by G4ScaleN_15

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

module G4ScaleN_15 (
  input      [1:0]    io_t,
  output     [1:0]    io_x
);


  assign io_x = {io_t[0],(io_t[1] ^ io_t[0])}; // @[Polynomial.scala 537:14]

endmodule

//G4Mul_59 replaced by G4Mul_59

//G4Mul_59 replaced by G4Mul_59

module G4Mul_59 (
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
