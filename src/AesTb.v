// Generator : SpinalHDL v1.10.1    git head : 2527c7c6b0fb0f95e5e1a5722a0be732b364ce43
// Component : AesTb
// Git hash  : 7d71b394980eea21c4797418cfad392826f876d0

`timescale 1ns/1ps

module AesTb (
  input  wire          io_clk,
  input  wire          io_reset,
  output wire          io_tx,
  input  wire          io_rx,
  output reg           io_done,
  input  wire          clk,
  input  wire          reset
);
  localparam UartParityType_NONE = 2'd0;
  localparam UartParityType_EVEN = 2'd1;
  localparam UartParityType_ODD = 2'd2;
  localparam UartStopType_ONE = 1'd0;
  localparam UartStopType_TWO = 1'd1;

  wire       [2:0]    uartCtrl_1_io_config_frame_dataLength;
  wire       [0:0]    uartCtrl_1_io_config_frame_stop;
  wire       [1:0]    uartCtrl_1_io_config_frame_parity;
  wire       [19:0]   uartCtrl_1_io_config_clockDivider;
  reg                 uartCtrl_1_io_write_valid;
  reg        [7:0]    uartCtrl_1_io_write_payload;
  wire                uartCtrl_1_io_read_ready;
  wire                uartCtrl_1_io_writeBreak;
  wire                aESMaskedBlackBox_io_enable;
  reg        [31:0]   aESMaskedBlackBox_io_pt1_payload;
  reg                 aESMaskedBlackBox_io_pt1_valid;
  reg        [31:0]   aESMaskedBlackBox_io_pt2_payload;
  reg                 aESMaskedBlackBox_io_pt2_valid;
  reg        [31:0]   aESMaskedBlackBox_io_key1_payload;
  reg                 aESMaskedBlackBox_io_key1_valid;
  reg        [31:0]   aESMaskedBlackBox_io_key2_payload;
  reg                 aESMaskedBlackBox_io_key2_valid;
  reg                 aESMaskedBlackBox_io_ct1_ready;
  reg                 aESMaskedBlackBox_io_ct2_ready;
  wire                uartCtrl_1_io_write_ready;
  wire                uartCtrl_1_io_read_valid;
  wire       [7:0]    uartCtrl_1_io_read_payload;
  wire                uartCtrl_1_io_uart_txd;
  wire                uartCtrl_1_io_readError;
  wire                uartCtrl_1_io_readBreak;
  wire                aESMaskedBlackBox_io_pt1_ready;
  wire                aESMaskedBlackBox_io_pt2_ready;
  wire                aESMaskedBlackBox_io_key1_ready;
  wire                aESMaskedBlackBox_io_key2_ready;
  wire       [31:0]   aESMaskedBlackBox_io_ct1_payload;
  wire                aESMaskedBlackBox_io_ct1_valid;
  wire       [31:0]   aESMaskedBlackBox_io_ct2_payload;
  wire                aESMaskedBlackBox_io_ct2_valid;
  wire                aESMaskedBlackBox_io_done;
  wire       [27:0]   lFSRArray_1_io_output;
  wire                aesIsDone;
  reg        [31:0]   trexbuffer;
  reg        [2:0]    bytecount;
  reg        [2:0]    wordcount;
  reg        [2:0]    fsmstate;
  reg                 waiting;
  wire                when_AesTb_l113;
  wire                when_AesTb_l120;
  wire                when_AesTb_l128;
  wire                when_AesTb_l129;
  wire                when_AesTb_l140;
  wire                when_AesTb_l144;
  wire                when_AesTb_l153;
  wire                when_AesTb_l159;
  wire                when_AesTb_l165;
  wire                when_AesTb_l171;
  wire                when_AesTb_l185;
  wire                when_AesTb_l192;

  UartCtrl uartCtrl_1 (
    .io_config_frame_dataLength (uartCtrl_1_io_config_frame_dataLength[2:0]), //i
    .io_config_frame_stop       (uartCtrl_1_io_config_frame_stop           ), //i
    .io_config_frame_parity     (uartCtrl_1_io_config_frame_parity[1:0]    ), //i
    .io_config_clockDivider     (uartCtrl_1_io_config_clockDivider[19:0]   ), //i
    .io_write_valid             (uartCtrl_1_io_write_valid                 ), //i
    .io_write_ready             (uartCtrl_1_io_write_ready                 ), //o
    .io_write_payload           (uartCtrl_1_io_write_payload[7:0]          ), //i
    .io_read_valid              (uartCtrl_1_io_read_valid                  ), //o
    .io_read_ready              (uartCtrl_1_io_read_ready                  ), //i
    .io_read_payload            (uartCtrl_1_io_read_payload[7:0]           ), //o
    .io_uart_txd                (uartCtrl_1_io_uart_txd                    ), //o
    .io_uart_rxd                (io_rx                                     ), //i
    .io_readError               (uartCtrl_1_io_readError                   ), //o
    .io_writeBreak              (uartCtrl_1_io_writeBreak                  ), //i
    .io_readBreak               (uartCtrl_1_io_readBreak                   ), //o
    .io_clk                     (io_clk                                    ), //i
    .io_reset                   (io_reset                                  )  //i
  );
  AES_Masked aESMaskedBlackBox (
    .io_clk          (io_clk                                 ), //i
    .io_reset        (io_reset                               ), //i
    .io_enable       (aESMaskedBlackBox_io_enable            ), //i
    .io_pt1_payload  (aESMaskedBlackBox_io_pt1_payload[31:0] ), //i
    .io_pt1_valid    (aESMaskedBlackBox_io_pt1_valid         ), //i
    .io_pt1_ready    (aESMaskedBlackBox_io_pt1_ready         ), //o
    .io_pt2_payload  (aESMaskedBlackBox_io_pt2_payload[31:0] ), //i
    .io_pt2_valid    (aESMaskedBlackBox_io_pt2_valid         ), //i
    .io_pt2_ready    (aESMaskedBlackBox_io_pt2_ready         ), //o
    .io_key1_payload (aESMaskedBlackBox_io_key1_payload[31:0]), //i
    .io_key1_valid   (aESMaskedBlackBox_io_key1_valid        ), //i
    .io_key1_ready   (aESMaskedBlackBox_io_key1_ready        ), //o
    .io_key2_payload (aESMaskedBlackBox_io_key2_payload[31:0]), //i
    .io_key2_valid   (aESMaskedBlackBox_io_key2_valid        ), //i
    .io_key2_ready   (aESMaskedBlackBox_io_key2_ready        ), //o
    .io_ct1_payload  (aESMaskedBlackBox_io_ct1_payload[31:0] ), //o
    .io_ct1_valid    (aESMaskedBlackBox_io_ct1_valid         ), //o
    .io_ct1_ready    (aESMaskedBlackBox_io_ct1_ready         ), //i
    .io_ct2_payload  (aESMaskedBlackBox_io_ct2_payload[31:0] ), //o
    .io_ct2_valid    (aESMaskedBlackBox_io_ct2_valid         ), //o
    .io_ct2_ready    (aESMaskedBlackBox_io_ct2_ready         ), //i
    .io_m            (lFSRArray_1_io_output[27:0]            ), //i
    .io_done         (aESMaskedBlackBox_io_done              )  //o
  );
  LFSRArray lFSRArray_1 (
    .io_output (lFSRArray_1_io_output[27:0]), //o
    .io_clk    (io_clk                     ), //i
    .io_reset  (io_reset                   )  //i
  );
  assign aesIsDone = 1'b0;
  assign uartCtrl_1_io_config_clockDivider = 20'h00033;
  assign uartCtrl_1_io_config_frame_dataLength = 3'b111;
  assign uartCtrl_1_io_config_frame_parity = UartParityType_NONE;
  assign uartCtrl_1_io_config_frame_stop = UartStopType_ONE;
  assign uartCtrl_1_io_writeBreak = 1'b0;
  assign io_tx = uartCtrl_1_io_uart_txd;
  always @(*) begin
    uartCtrl_1_io_write_payload = 8'h00;
    if(when_AesTb_l128) begin
      uartCtrl_1_io_write_payload = trexbuffer[31 : 24];
    end
  end

  always @(*) begin
    uartCtrl_1_io_write_valid = 1'b0;
    if(when_AesTb_l128) begin
      uartCtrl_1_io_write_valid = 1'b1;
    end
  end

  assign aESMaskedBlackBox_io_enable = 1'b1;
  always @(*) begin
    aESMaskedBlackBox_io_pt1_payload = 32'h00000000;
    case(fsmstate)
      3'b000 : begin
      end
      3'b001 : begin
      end
      3'b010 : begin
        if(when_AesTb_l165) begin
          aESMaskedBlackBox_io_pt1_payload = trexbuffer;
        end
      end
      3'b011 : begin
      end
      3'b100 : begin
      end
      3'b101 : begin
      end
      3'b110 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    aESMaskedBlackBox_io_pt2_payload = 32'h00000000;
    case(fsmstate)
      3'b000 : begin
      end
      3'b001 : begin
      end
      3'b010 : begin
      end
      3'b011 : begin
        if(when_AesTb_l171) begin
          aESMaskedBlackBox_io_pt2_payload = trexbuffer;
        end
      end
      3'b100 : begin
      end
      3'b101 : begin
      end
      3'b110 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    aESMaskedBlackBox_io_key1_payload = 32'h00000000;
    case(fsmstate)
      3'b000 : begin
        if(when_AesTb_l153) begin
          aESMaskedBlackBox_io_key1_payload = trexbuffer;
        end
      end
      3'b001 : begin
      end
      3'b010 : begin
      end
      3'b011 : begin
      end
      3'b100 : begin
      end
      3'b101 : begin
      end
      3'b110 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    aESMaskedBlackBox_io_key2_payload = 32'h00000000;
    case(fsmstate)
      3'b000 : begin
      end
      3'b001 : begin
        if(when_AesTb_l159) begin
          aESMaskedBlackBox_io_key2_payload = trexbuffer;
        end
      end
      3'b010 : begin
      end
      3'b011 : begin
      end
      3'b100 : begin
      end
      3'b101 : begin
      end
      3'b110 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    aESMaskedBlackBox_io_pt1_valid = 1'b0;
    case(fsmstate)
      3'b000 : begin
      end
      3'b001 : begin
      end
      3'b010 : begin
        if(when_AesTb_l165) begin
          aESMaskedBlackBox_io_pt1_valid = 1'b1;
        end
      end
      3'b011 : begin
      end
      3'b100 : begin
      end
      3'b101 : begin
      end
      3'b110 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    aESMaskedBlackBox_io_pt2_valid = 1'b0;
    case(fsmstate)
      3'b000 : begin
      end
      3'b001 : begin
      end
      3'b010 : begin
      end
      3'b011 : begin
        if(when_AesTb_l171) begin
          aESMaskedBlackBox_io_pt2_valid = 1'b1;
        end
      end
      3'b100 : begin
      end
      3'b101 : begin
      end
      3'b110 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    aESMaskedBlackBox_io_key1_valid = 1'b0;
    case(fsmstate)
      3'b000 : begin
        if(when_AesTb_l153) begin
          aESMaskedBlackBox_io_key1_valid = 1'b1;
        end
      end
      3'b001 : begin
      end
      3'b010 : begin
      end
      3'b011 : begin
      end
      3'b100 : begin
      end
      3'b101 : begin
      end
      3'b110 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    aESMaskedBlackBox_io_key2_valid = 1'b0;
    case(fsmstate)
      3'b000 : begin
      end
      3'b001 : begin
        if(when_AesTb_l159) begin
          aESMaskedBlackBox_io_key2_valid = 1'b1;
        end
      end
      3'b010 : begin
      end
      3'b011 : begin
      end
      3'b100 : begin
      end
      3'b101 : begin
      end
      3'b110 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    aESMaskedBlackBox_io_ct1_ready = 1'b0;
    case(fsmstate)
      3'b000 : begin
      end
      3'b001 : begin
      end
      3'b010 : begin
      end
      3'b011 : begin
      end
      3'b100 : begin
      end
      3'b101 : begin
        if(when_AesTb_l185) begin
          aESMaskedBlackBox_io_ct1_ready = 1'b1;
        end
      end
      3'b110 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    aESMaskedBlackBox_io_ct2_ready = 1'b0;
    case(fsmstate)
      3'b000 : begin
      end
      3'b001 : begin
      end
      3'b010 : begin
      end
      3'b011 : begin
      end
      3'b100 : begin
      end
      3'b101 : begin
      end
      3'b110 : begin
        if(when_AesTb_l192) begin
          aESMaskedBlackBox_io_ct2_ready = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_AesTb_l113 = (fsmstate == 3'b111);
  always @(*) begin
    if(when_AesTb_l113) begin
      io_done = 1'b1;
    end else begin
      io_done = 1'b0;
    end
  end

  assign when_AesTb_l120 = (uartCtrl_1_io_read_valid && (fsmstate < 3'b100));
  assign when_AesTb_l128 = (3'b100 < fsmstate);
  assign when_AesTb_l129 = (uartCtrl_1_io_write_ready && waiting);
  assign when_AesTb_l140 = (bytecount == 3'b100);
  assign when_AesTb_l144 = (wordcount == 3'b011);
  assign when_AesTb_l153 = (bytecount == 3'b100);
  assign when_AesTb_l159 = (bytecount == 3'b100);
  assign when_AesTb_l165 = (bytecount == 3'b100);
  assign when_AesTb_l171 = (bytecount == 3'b100);
  assign when_AesTb_l185 = (aESMaskedBlackBox_io_ct1_valid && (! waiting));
  assign when_AesTb_l192 = (aESMaskedBlackBox_io_ct2_valid && (! waiting));
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      trexbuffer <= 32'h00000000;
      bytecount <= 3'b000;
      wordcount <= 3'b000;
      fsmstate <= 3'b000;
      waiting <= 1'b0;
    end else begin
      if(when_AesTb_l120) begin
        bytecount <= (bytecount + 3'b001);
        trexbuffer[31 : 8] <= trexbuffer[23 : 0];
        trexbuffer[7 : 0] <= uartCtrl_1_io_read_payload;
      end
      if(when_AesTb_l128) begin
        if(when_AesTb_l129) begin
          bytecount <= (bytecount + 3'b001);
          trexbuffer[31 : 8] <= trexbuffer[23 : 0];
        end
      end
      if(when_AesTb_l140) begin
        waiting <= 1'b0;
        bytecount <= 3'b000;
        wordcount <= (wordcount + 3'b001);
        if(when_AesTb_l144) begin
          fsmstate <= (fsmstate + 3'b001);
          wordcount <= 3'b000;
        end
      end
      case(fsmstate)
        3'b000 : begin
        end
        3'b001 : begin
        end
        3'b010 : begin
        end
        3'b011 : begin
        end
        3'b100 : begin
          if(aESMaskedBlackBox_io_done) begin
            fsmstate <= 3'b101;
            bytecount <= 3'b000;
            waiting <= 1'b0;
          end
        end
        3'b101 : begin
          if(when_AesTb_l185) begin
            trexbuffer <= aESMaskedBlackBox_io_ct1_payload;
            waiting <= 1'b1;
          end
        end
        3'b110 : begin
          if(when_AesTb_l192) begin
            trexbuffer <= aESMaskedBlackBox_io_ct2_payload;
            waiting <= 1'b1;
          end
        end
        default : begin
          fsmstate <= 3'b000;
        end
      endcase
    end
  end


endmodule

module LFSRArray (
  output reg  [27:0]   io_output,
  input  wire          io_clk,
  input  wire          io_reset
);

  wire                lfsrs_0_io_feed;
  wire                lfsrs_1_io_feed;
  wire                lfsrs_2_io_feed;
  wire                lfsrs_3_io_feed;
  wire                lfsrs_4_io_feed;
  wire                lfsrs_5_io_feed;
  wire                lfsrs_6_io_feed;
  wire                lfsrs_7_io_feed;
  wire                lfsrs_8_io_feed;
  wire                lfsrs_9_io_feed;
  wire                lfsrs_10_io_feed;
  wire                lfsrs_11_io_feed;
  wire                lfsrs_12_io_feed;
  wire                lfsrs_13_io_feed;
  wire                lfsrs_14_io_feed;
  wire                lfsrs_15_io_feed;
  wire                lfsrs_16_io_feed;
  wire                lfsrs_17_io_feed;
  wire                lfsrs_18_io_feed;
  wire                lfsrs_19_io_feed;
  wire                lfsrs_20_io_feed;
  wire                lfsrs_21_io_feed;
  wire                lfsrs_22_io_feed;
  wire                lfsrs_23_io_feed;
  wire                lfsrs_24_io_feed;
  wire                lfsrs_25_io_feed;
  wire                lfsrs_26_io_feed;
  wire                lfsrs_27_io_feed;

  LFSR lfsrs_0 (
    .io_feed  (lfsrs_0_io_feed), //o
    .io_clk   (io_clk         ), //i
    .io_reset (io_reset       )  //i
  );
  LFSR_1 lfsrs_1 (
    .io_feed  (lfsrs_1_io_feed), //o
    .io_clk   (io_clk         ), //i
    .io_reset (io_reset       )  //i
  );
  LFSR_2 lfsrs_2 (
    .io_feed  (lfsrs_2_io_feed), //o
    .io_clk   (io_clk         ), //i
    .io_reset (io_reset       )  //i
  );
  LFSR_3 lfsrs_3 (
    .io_feed  (lfsrs_3_io_feed), //o
    .io_clk   (io_clk         ), //i
    .io_reset (io_reset       )  //i
  );
  LFSR_4 lfsrs_4 (
    .io_feed  (lfsrs_4_io_feed), //o
    .io_clk   (io_clk         ), //i
    .io_reset (io_reset       )  //i
  );
  LFSR_5 lfsrs_5 (
    .io_feed  (lfsrs_5_io_feed), //o
    .io_clk   (io_clk         ), //i
    .io_reset (io_reset       )  //i
  );
  LFSR_6 lfsrs_6 (
    .io_feed  (lfsrs_6_io_feed), //o
    .io_clk   (io_clk         ), //i
    .io_reset (io_reset       )  //i
  );
  LFSR_7 lfsrs_7 (
    .io_feed  (lfsrs_7_io_feed), //o
    .io_clk   (io_clk         ), //i
    .io_reset (io_reset       )  //i
  );
  LFSR_8 lfsrs_8 (
    .io_feed  (lfsrs_8_io_feed), //o
    .io_clk   (io_clk         ), //i
    .io_reset (io_reset       )  //i
  );
  LFSR_9 lfsrs_9 (
    .io_feed  (lfsrs_9_io_feed), //o
    .io_clk   (io_clk         ), //i
    .io_reset (io_reset       )  //i
  );
  LFSR_10 lfsrs_10 (
    .io_feed  (lfsrs_10_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_11 lfsrs_11 (
    .io_feed  (lfsrs_11_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_12 lfsrs_12 (
    .io_feed  (lfsrs_12_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_13 lfsrs_13 (
    .io_feed  (lfsrs_13_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_14 lfsrs_14 (
    .io_feed  (lfsrs_14_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_15 lfsrs_15 (
    .io_feed  (lfsrs_15_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_16 lfsrs_16 (
    .io_feed  (lfsrs_16_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_17 lfsrs_17 (
    .io_feed  (lfsrs_17_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_18 lfsrs_18 (
    .io_feed  (lfsrs_18_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_19 lfsrs_19 (
    .io_feed  (lfsrs_19_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_20 lfsrs_20 (
    .io_feed  (lfsrs_20_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_21 lfsrs_21 (
    .io_feed  (lfsrs_21_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_22 lfsrs_22 (
    .io_feed  (lfsrs_22_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_23 lfsrs_23 (
    .io_feed  (lfsrs_23_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_24 lfsrs_24 (
    .io_feed  (lfsrs_24_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_25 lfsrs_25 (
    .io_feed  (lfsrs_25_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_26 lfsrs_26 (
    .io_feed  (lfsrs_26_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  LFSR_27 lfsrs_27 (
    .io_feed  (lfsrs_27_io_feed), //o
    .io_clk   (io_clk          ), //i
    .io_reset (io_reset        )  //i
  );
  always @(*) begin
    io_output[0] = lfsrs_0_io_feed;
    io_output[1] = lfsrs_1_io_feed;
    io_output[2] = lfsrs_2_io_feed;
    io_output[3] = lfsrs_3_io_feed;
    io_output[4] = lfsrs_4_io_feed;
    io_output[5] = lfsrs_5_io_feed;
    io_output[6] = lfsrs_6_io_feed;
    io_output[7] = lfsrs_7_io_feed;
    io_output[8] = lfsrs_8_io_feed;
    io_output[9] = lfsrs_9_io_feed;
    io_output[10] = lfsrs_10_io_feed;
    io_output[11] = lfsrs_11_io_feed;
    io_output[12] = lfsrs_12_io_feed;
    io_output[13] = lfsrs_13_io_feed;
    io_output[14] = lfsrs_14_io_feed;
    io_output[15] = lfsrs_15_io_feed;
    io_output[16] = lfsrs_16_io_feed;
    io_output[17] = lfsrs_17_io_feed;
    io_output[18] = lfsrs_18_io_feed;
    io_output[19] = lfsrs_19_io_feed;
    io_output[20] = lfsrs_20_io_feed;
    io_output[21] = lfsrs_21_io_feed;
    io_output[22] = lfsrs_22_io_feed;
    io_output[23] = lfsrs_23_io_feed;
    io_output[24] = lfsrs_24_io_feed;
    io_output[25] = lfsrs_25_io_feed;
    io_output[26] = lfsrs_26_io_feed;
    io_output[27] = lfsrs_27_io_feed;
  end


endmodule

module UartCtrl (
  input  wire [2:0]    io_config_frame_dataLength,
  input  wire [0:0]    io_config_frame_stop,
  input  wire [1:0]    io_config_frame_parity,
  input  wire [19:0]   io_config_clockDivider,
  input  wire          io_write_valid,
  output reg           io_write_ready,
  input  wire [7:0]    io_write_payload,
  output wire          io_read_valid,
  input  wire          io_read_ready,
  output wire [7:0]    io_read_payload,
  output wire          io_uart_txd,
  input  wire          io_uart_rxd,
  output wire          io_readError,
  input  wire          io_writeBreak,
  output wire          io_readBreak,
  input  wire          io_clk,
  input  wire          io_reset
);
  localparam UartStopType_ONE = 1'd0;
  localparam UartStopType_TWO = 1'd1;
  localparam UartParityType_NONE = 2'd0;
  localparam UartParityType_EVEN = 2'd1;
  localparam UartParityType_ODD = 2'd2;

  wire                tx_io_cts;
  wire                tx_io_write_ready;
  wire                tx_io_txd;
  wire                rx_io_read_valid;
  wire       [7:0]    rx_io_read_payload;
  wire                rx_io_rts;
  wire                rx_io_error;
  wire                rx_io_break;
  reg        [19:0]   clockDivider_counter;
  wire                clockDivider_tick;
  reg                 clockDivider_tickReg;
  reg                 io_write_thrown_valid;
  wire                io_write_thrown_ready;
  wire       [7:0]    io_write_thrown_payload;
  `ifndef SYNTHESIS
  reg [23:0] io_config_frame_stop_string;
  reg [31:0] io_config_frame_parity_string;
  `endif


  UartCtrlTx tx (
    .io_configFrame_dataLength (io_config_frame_dataLength[2:0]), //i
    .io_configFrame_stop       (io_config_frame_stop           ), //i
    .io_configFrame_parity     (io_config_frame_parity[1:0]    ), //i
    .io_samplingTick           (clockDivider_tickReg           ), //i
    .io_write_valid            (io_write_thrown_valid          ), //i
    .io_write_ready            (tx_io_write_ready              ), //o
    .io_write_payload          (io_write_thrown_payload[7:0]   ), //i
    .io_cts                    (tx_io_cts                      ), //i
    .io_txd                    (tx_io_txd                      ), //o
    .io_break                  (io_writeBreak                  ), //i
    .io_clk                    (io_clk                         ), //i
    .io_reset                  (io_reset                       )  //i
  );
  UartCtrlRx rx (
    .io_configFrame_dataLength (io_config_frame_dataLength[2:0]), //i
    .io_configFrame_stop       (io_config_frame_stop           ), //i
    .io_configFrame_parity     (io_config_frame_parity[1:0]    ), //i
    .io_samplingTick           (clockDivider_tickReg           ), //i
    .io_read_valid             (rx_io_read_valid               ), //o
    .io_read_ready             (io_read_ready                  ), //i
    .io_read_payload           (rx_io_read_payload[7:0]        ), //o
    .io_rxd                    (io_uart_rxd                    ), //i
    .io_rts                    (rx_io_rts                      ), //o
    .io_error                  (rx_io_error                    ), //o
    .io_break                  (rx_io_break                    ), //o
    .io_clk                    (io_clk                         ), //i
    .io_reset                  (io_reset                       )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_config_frame_stop)
      UartStopType_ONE : io_config_frame_stop_string = "ONE";
      UartStopType_TWO : io_config_frame_stop_string = "TWO";
      default : io_config_frame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_config_frame_parity)
      UartParityType_NONE : io_config_frame_parity_string = "NONE";
      UartParityType_EVEN : io_config_frame_parity_string = "EVEN";
      UartParityType_ODD : io_config_frame_parity_string = "ODD ";
      default : io_config_frame_parity_string = "????";
    endcase
  end
  `endif

  assign clockDivider_tick = (clockDivider_counter == 20'h00000);
  always @(*) begin
    io_write_thrown_valid = io_write_valid;
    if(rx_io_break) begin
      io_write_thrown_valid = 1'b0;
    end
  end

  always @(*) begin
    io_write_ready = io_write_thrown_ready;
    if(rx_io_break) begin
      io_write_ready = 1'b1;
    end
  end

  assign io_write_thrown_payload = io_write_payload;
  assign io_write_thrown_ready = tx_io_write_ready;
  assign io_read_valid = rx_io_read_valid;
  assign io_read_payload = rx_io_read_payload;
  assign io_uart_txd = tx_io_txd;
  assign io_readError = rx_io_error;
  assign tx_io_cts = 1'b0;
  assign io_readBreak = rx_io_break;
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      clockDivider_counter <= 20'h00000;
      clockDivider_tickReg <= 1'b0;
    end else begin
      clockDivider_tickReg <= clockDivider_tick;
      clockDivider_counter <= (clockDivider_counter - 20'h00001);
      if(clockDivider_tick) begin
        clockDivider_counter <= io_config_clockDivider;
      end
    end
  end


endmodule

module LFSR_27 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h539;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_26 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h53a;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_25 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h53b;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_24 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h53c;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_23 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h53d;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_22 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h53e;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_21 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h53f;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_20 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h540;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_19 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h541;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_18 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h542;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_17 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h543;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_16 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h544;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_15 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h545;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_14 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h546;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_13 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h547;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_12 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h548;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_11 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h549;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_10 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h54a;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_9 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h54b;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_8 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h54c;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_7 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h54d;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_6 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h54e;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_5 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h54f;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_4 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h550;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_3 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h551;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_2 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h552;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR_1 (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h553;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module LFSR (
  output wire          io_feed,
  input  wire          io_clk,
  input  wire          io_reset
);

  reg        [11:0]   state;

  assign io_feed = state[0];
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      state <= 12'h554;
    end else begin
      state <= {state[10 : 0],((((state[0] ^ state[3]) ^ state[5]) ^ state[7]) ^ state[11])};
    end
  end


endmodule

module UartCtrlRx (
  input  wire [2:0]    io_configFrame_dataLength,
  input  wire [0:0]    io_configFrame_stop,
  input  wire [1:0]    io_configFrame_parity,
  input  wire          io_samplingTick,
  output wire          io_read_valid,
  input  wire          io_read_ready,
  output wire [7:0]    io_read_payload,
  input  wire          io_rxd,
  output wire          io_rts,
  output reg           io_error,
  output wire          io_break,
  input  wire          io_clk,
  input  wire          io_reset
);
  localparam UartStopType_ONE = 1'd0;
  localparam UartStopType_TWO = 1'd1;
  localparam UartParityType_NONE = 2'd0;
  localparam UartParityType_EVEN = 2'd1;
  localparam UartParityType_ODD = 2'd2;
  localparam UartCtrlRxState_IDLE = 3'd0;
  localparam UartCtrlRxState_START = 3'd1;
  localparam UartCtrlRxState_DATA = 3'd2;
  localparam UartCtrlRxState_PARITY = 3'd3;
  localparam UartCtrlRxState_STOP = 3'd4;

  wire                io_rxd_buffercc_io_dataOut;
  wire                _zz_sampler_value;
  wire                _zz_sampler_value_1;
  wire                _zz_sampler_value_2;
  wire                _zz_sampler_value_3;
  wire                _zz_sampler_value_4;
  wire                _zz_sampler_value_5;
  wire                _zz_sampler_value_6;
  wire       [2:0]    _zz_when_UartCtrlRx_l139;
  wire       [0:0]    _zz_when_UartCtrlRx_l139_1;
  reg                 _zz_io_rts;
  wire                sampler_synchroniser;
  wire                sampler_samples_0;
  reg                 sampler_samples_1;
  reg                 sampler_samples_2;
  reg                 sampler_samples_3;
  reg                 sampler_samples_4;
  reg                 sampler_value;
  reg                 sampler_tick;
  reg        [2:0]    bitTimer_counter;
  reg                 bitTimer_tick;
  wire                when_UartCtrlRx_l43;
  reg        [2:0]    bitCounter_value;
  reg        [6:0]    break_counter;
  wire                break_valid;
  wire                when_UartCtrlRx_l69;
  reg        [2:0]    stateMachine_state;
  reg                 stateMachine_parity;
  reg        [7:0]    stateMachine_shifter;
  reg                 stateMachine_validReg;
  wire                when_UartCtrlRx_l93;
  wire                when_UartCtrlRx_l103;
  wire                when_UartCtrlRx_l111;
  wire                when_UartCtrlRx_l113;
  wire                when_UartCtrlRx_l125;
  wire                when_UartCtrlRx_l136;
  wire                when_UartCtrlRx_l139;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  `endif


  assign _zz_when_UartCtrlRx_l139_1 = ((io_configFrame_stop == UartStopType_ONE) ? 1'b0 : 1'b1);
  assign _zz_when_UartCtrlRx_l139 = {2'd0, _zz_when_UartCtrlRx_l139_1};
  assign _zz_sampler_value = ((((1'b0 || ((_zz_sampler_value_1 && sampler_samples_1) && sampler_samples_2)) || (((_zz_sampler_value_2 && sampler_samples_0) && sampler_samples_1) && sampler_samples_3)) || (((1'b1 && sampler_samples_0) && sampler_samples_2) && sampler_samples_3)) || (((1'b1 && sampler_samples_1) && sampler_samples_2) && sampler_samples_3));
  assign _zz_sampler_value_3 = (((1'b1 && sampler_samples_0) && sampler_samples_1) && sampler_samples_4);
  assign _zz_sampler_value_4 = ((1'b1 && sampler_samples_0) && sampler_samples_2);
  assign _zz_sampler_value_5 = (1'b1 && sampler_samples_1);
  assign _zz_sampler_value_6 = 1'b1;
  assign _zz_sampler_value_1 = (1'b1 && sampler_samples_0);
  assign _zz_sampler_value_2 = 1'b1;
  BufferCC io_rxd_buffercc (
    .io_dataIn  (io_rxd                    ), //i
    .io_dataOut (io_rxd_buffercc_io_dataOut), //o
    .io_clk     (io_clk                    ), //i
    .io_reset   (io_reset                  )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_configFrame_stop)
      UartStopType_ONE : io_configFrame_stop_string = "ONE";
      UartStopType_TWO : io_configFrame_stop_string = "TWO";
      default : io_configFrame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_configFrame_parity)
      UartParityType_NONE : io_configFrame_parity_string = "NONE";
      UartParityType_EVEN : io_configFrame_parity_string = "EVEN";
      UartParityType_ODD : io_configFrame_parity_string = "ODD ";
      default : io_configFrame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(stateMachine_state)
      UartCtrlRxState_IDLE : stateMachine_state_string = "IDLE  ";
      UartCtrlRxState_START : stateMachine_state_string = "START ";
      UartCtrlRxState_DATA : stateMachine_state_string = "DATA  ";
      UartCtrlRxState_PARITY : stateMachine_state_string = "PARITY";
      UartCtrlRxState_STOP : stateMachine_state_string = "STOP  ";
      default : stateMachine_state_string = "??????";
    endcase
  end
  `endif

  always @(*) begin
    io_error = 1'b0;
    case(stateMachine_state)
      UartCtrlRxState_IDLE : begin
      end
      UartCtrlRxState_START : begin
      end
      UartCtrlRxState_DATA : begin
      end
      UartCtrlRxState_PARITY : begin
        if(bitTimer_tick) begin
          if(!when_UartCtrlRx_l125) begin
            io_error = 1'b1;
          end
        end
      end
      default : begin
        if(bitTimer_tick) begin
          if(when_UartCtrlRx_l136) begin
            io_error = 1'b1;
          end
        end
      end
    endcase
  end

  assign io_rts = _zz_io_rts;
  assign sampler_synchroniser = io_rxd_buffercc_io_dataOut;
  assign sampler_samples_0 = sampler_synchroniser;
  always @(*) begin
    bitTimer_tick = 1'b0;
    if(sampler_tick) begin
      if(when_UartCtrlRx_l43) begin
        bitTimer_tick = 1'b1;
      end
    end
  end

  assign when_UartCtrlRx_l43 = (bitTimer_counter == 3'b000);
  assign break_valid = (break_counter == 7'h68);
  assign when_UartCtrlRx_l69 = (io_samplingTick && (! break_valid));
  assign io_break = break_valid;
  assign io_read_valid = stateMachine_validReg;
  assign when_UartCtrlRx_l93 = ((sampler_tick && (! sampler_value)) && (! break_valid));
  assign when_UartCtrlRx_l103 = (sampler_value == 1'b1);
  assign when_UartCtrlRx_l111 = (bitCounter_value == io_configFrame_dataLength);
  assign when_UartCtrlRx_l113 = (io_configFrame_parity == UartParityType_NONE);
  assign when_UartCtrlRx_l125 = (stateMachine_parity == sampler_value);
  assign when_UartCtrlRx_l136 = (! sampler_value);
  assign when_UartCtrlRx_l139 = (bitCounter_value == _zz_when_UartCtrlRx_l139);
  assign io_read_payload = stateMachine_shifter;
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      _zz_io_rts <= 1'b0;
      sampler_samples_1 <= 1'b1;
      sampler_samples_2 <= 1'b1;
      sampler_samples_3 <= 1'b1;
      sampler_samples_4 <= 1'b1;
      sampler_value <= 1'b1;
      sampler_tick <= 1'b0;
      break_counter <= 7'h00;
      stateMachine_state <= UartCtrlRxState_IDLE;
      stateMachine_validReg <= 1'b0;
    end else begin
      _zz_io_rts <= (! io_read_ready);
      if(io_samplingTick) begin
        sampler_samples_1 <= sampler_samples_0;
      end
      if(io_samplingTick) begin
        sampler_samples_2 <= sampler_samples_1;
      end
      if(io_samplingTick) begin
        sampler_samples_3 <= sampler_samples_2;
      end
      if(io_samplingTick) begin
        sampler_samples_4 <= sampler_samples_3;
      end
      sampler_value <= ((((((_zz_sampler_value || _zz_sampler_value_3) || (_zz_sampler_value_4 && sampler_samples_4)) || ((_zz_sampler_value_5 && sampler_samples_2) && sampler_samples_4)) || (((_zz_sampler_value_6 && sampler_samples_0) && sampler_samples_3) && sampler_samples_4)) || (((1'b1 && sampler_samples_1) && sampler_samples_3) && sampler_samples_4)) || (((1'b1 && sampler_samples_2) && sampler_samples_3) && sampler_samples_4));
      sampler_tick <= io_samplingTick;
      if(sampler_value) begin
        break_counter <= 7'h00;
      end else begin
        if(when_UartCtrlRx_l69) begin
          break_counter <= (break_counter + 7'h01);
        end
      end
      stateMachine_validReg <= 1'b0;
      case(stateMachine_state)
        UartCtrlRxState_IDLE : begin
          if(when_UartCtrlRx_l93) begin
            stateMachine_state <= UartCtrlRxState_START;
          end
        end
        UartCtrlRxState_START : begin
          if(bitTimer_tick) begin
            stateMachine_state <= UartCtrlRxState_DATA;
            if(when_UartCtrlRx_l103) begin
              stateMachine_state <= UartCtrlRxState_IDLE;
            end
          end
        end
        UartCtrlRxState_DATA : begin
          if(bitTimer_tick) begin
            if(when_UartCtrlRx_l111) begin
              if(when_UartCtrlRx_l113) begin
                stateMachine_state <= UartCtrlRxState_STOP;
                stateMachine_validReg <= 1'b1;
              end else begin
                stateMachine_state <= UartCtrlRxState_PARITY;
              end
            end
          end
        end
        UartCtrlRxState_PARITY : begin
          if(bitTimer_tick) begin
            if(when_UartCtrlRx_l125) begin
              stateMachine_state <= UartCtrlRxState_STOP;
              stateMachine_validReg <= 1'b1;
            end else begin
              stateMachine_state <= UartCtrlRxState_IDLE;
            end
          end
        end
        default : begin
          if(bitTimer_tick) begin
            if(when_UartCtrlRx_l136) begin
              stateMachine_state <= UartCtrlRxState_IDLE;
            end else begin
              if(when_UartCtrlRx_l139) begin
                stateMachine_state <= UartCtrlRxState_IDLE;
              end
            end
          end
        end
      endcase
    end
  end

  always @(posedge io_clk) begin
    if(sampler_tick) begin
      bitTimer_counter <= (bitTimer_counter - 3'b001);
    end
    if(bitTimer_tick) begin
      bitCounter_value <= (bitCounter_value + 3'b001);
    end
    if(bitTimer_tick) begin
      stateMachine_parity <= (stateMachine_parity ^ sampler_value);
    end
    case(stateMachine_state)
      UartCtrlRxState_IDLE : begin
        if(when_UartCtrlRx_l93) begin
          bitTimer_counter <= 3'b010;
        end
      end
      UartCtrlRxState_START : begin
        if(bitTimer_tick) begin
          bitCounter_value <= 3'b000;
          stateMachine_parity <= (io_configFrame_parity == UartParityType_ODD);
        end
      end
      UartCtrlRxState_DATA : begin
        if(bitTimer_tick) begin
          stateMachine_shifter[bitCounter_value] <= sampler_value;
          if(when_UartCtrlRx_l111) begin
            bitCounter_value <= 3'b000;
          end
        end
      end
      UartCtrlRxState_PARITY : begin
        if(bitTimer_tick) begin
          bitCounter_value <= 3'b000;
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module UartCtrlTx (
  input  wire [2:0]    io_configFrame_dataLength,
  input  wire [0:0]    io_configFrame_stop,
  input  wire [1:0]    io_configFrame_parity,
  input  wire          io_samplingTick,
  input  wire          io_write_valid,
  output reg           io_write_ready,
  input  wire [7:0]    io_write_payload,
  input  wire          io_cts,
  output wire          io_txd,
  input  wire          io_break,
  input  wire          io_clk,
  input  wire          io_reset
);
  localparam UartStopType_ONE = 1'd0;
  localparam UartStopType_TWO = 1'd1;
  localparam UartParityType_NONE = 2'd0;
  localparam UartParityType_EVEN = 2'd1;
  localparam UartParityType_ODD = 2'd2;
  localparam UartCtrlTxState_IDLE = 3'd0;
  localparam UartCtrlTxState_START = 3'd1;
  localparam UartCtrlTxState_DATA = 3'd2;
  localparam UartCtrlTxState_PARITY = 3'd3;
  localparam UartCtrlTxState_STOP = 3'd4;

  wire       [2:0]    _zz_clockDivider_counter_valueNext;
  wire       [0:0]    _zz_clockDivider_counter_valueNext_1;
  wire       [2:0]    _zz_when_UartCtrlTx_l93;
  wire       [0:0]    _zz_when_UartCtrlTx_l93_1;
  reg                 clockDivider_counter_willIncrement;
  wire                clockDivider_counter_willClear;
  reg        [2:0]    clockDivider_counter_valueNext;
  reg        [2:0]    clockDivider_counter_value;
  wire                clockDivider_counter_willOverflowIfInc;
  wire                clockDivider_counter_willOverflow;
  reg        [2:0]    tickCounter_value;
  reg        [2:0]    stateMachine_state;
  reg                 stateMachine_parity;
  reg                 stateMachine_txd;
  wire                when_UartCtrlTx_l58;
  wire                when_UartCtrlTx_l73;
  wire                when_UartCtrlTx_l76;
  wire                when_UartCtrlTx_l93;
  wire       [2:0]    _zz_stateMachine_state;
  reg                 _zz_io_txd;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  reg [47:0] _zz_stateMachine_state_string;
  `endif


  assign _zz_clockDivider_counter_valueNext_1 = clockDivider_counter_willIncrement;
  assign _zz_clockDivider_counter_valueNext = {2'd0, _zz_clockDivider_counter_valueNext_1};
  assign _zz_when_UartCtrlTx_l93_1 = ((io_configFrame_stop == UartStopType_ONE) ? 1'b0 : 1'b1);
  assign _zz_when_UartCtrlTx_l93 = {2'd0, _zz_when_UartCtrlTx_l93_1};
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_configFrame_stop)
      UartStopType_ONE : io_configFrame_stop_string = "ONE";
      UartStopType_TWO : io_configFrame_stop_string = "TWO";
      default : io_configFrame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_configFrame_parity)
      UartParityType_NONE : io_configFrame_parity_string = "NONE";
      UartParityType_EVEN : io_configFrame_parity_string = "EVEN";
      UartParityType_ODD : io_configFrame_parity_string = "ODD ";
      default : io_configFrame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(stateMachine_state)
      UartCtrlTxState_IDLE : stateMachine_state_string = "IDLE  ";
      UartCtrlTxState_START : stateMachine_state_string = "START ";
      UartCtrlTxState_DATA : stateMachine_state_string = "DATA  ";
      UartCtrlTxState_PARITY : stateMachine_state_string = "PARITY";
      UartCtrlTxState_STOP : stateMachine_state_string = "STOP  ";
      default : stateMachine_state_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_stateMachine_state)
      UartCtrlTxState_IDLE : _zz_stateMachine_state_string = "IDLE  ";
      UartCtrlTxState_START : _zz_stateMachine_state_string = "START ";
      UartCtrlTxState_DATA : _zz_stateMachine_state_string = "DATA  ";
      UartCtrlTxState_PARITY : _zz_stateMachine_state_string = "PARITY";
      UartCtrlTxState_STOP : _zz_stateMachine_state_string = "STOP  ";
      default : _zz_stateMachine_state_string = "??????";
    endcase
  end
  `endif

  always @(*) begin
    clockDivider_counter_willIncrement = 1'b0;
    if(io_samplingTick) begin
      clockDivider_counter_willIncrement = 1'b1;
    end
  end

  assign clockDivider_counter_willClear = 1'b0;
  assign clockDivider_counter_willOverflowIfInc = (clockDivider_counter_value == 3'b111);
  assign clockDivider_counter_willOverflow = (clockDivider_counter_willOverflowIfInc && clockDivider_counter_willIncrement);
  always @(*) begin
    clockDivider_counter_valueNext = (clockDivider_counter_value + _zz_clockDivider_counter_valueNext);
    if(clockDivider_counter_willClear) begin
      clockDivider_counter_valueNext = 3'b000;
    end
  end

  always @(*) begin
    stateMachine_txd = 1'b1;
    case(stateMachine_state)
      UartCtrlTxState_IDLE : begin
      end
      UartCtrlTxState_START : begin
        stateMachine_txd = 1'b0;
      end
      UartCtrlTxState_DATA : begin
        stateMachine_txd = io_write_payload[tickCounter_value];
      end
      UartCtrlTxState_PARITY : begin
        stateMachine_txd = stateMachine_parity;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_write_ready = io_break;
    case(stateMachine_state)
      UartCtrlTxState_IDLE : begin
      end
      UartCtrlTxState_START : begin
      end
      UartCtrlTxState_DATA : begin
        if(clockDivider_counter_willOverflow) begin
          if(when_UartCtrlTx_l73) begin
            io_write_ready = 1'b1;
          end
        end
      end
      UartCtrlTxState_PARITY : begin
      end
      default : begin
      end
    endcase
  end

  assign when_UartCtrlTx_l58 = ((io_write_valid && (! io_cts)) && clockDivider_counter_willOverflow);
  assign when_UartCtrlTx_l73 = (tickCounter_value == io_configFrame_dataLength);
  assign when_UartCtrlTx_l76 = (io_configFrame_parity == UartParityType_NONE);
  assign when_UartCtrlTx_l93 = (tickCounter_value == _zz_when_UartCtrlTx_l93);
  assign _zz_stateMachine_state = (io_write_valid ? UartCtrlTxState_START : UartCtrlTxState_IDLE);
  assign io_txd = _zz_io_txd;
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      clockDivider_counter_value <= 3'b000;
      stateMachine_state <= UartCtrlTxState_IDLE;
      _zz_io_txd <= 1'b1;
    end else begin
      clockDivider_counter_value <= clockDivider_counter_valueNext;
      case(stateMachine_state)
        UartCtrlTxState_IDLE : begin
          if(when_UartCtrlTx_l58) begin
            stateMachine_state <= UartCtrlTxState_START;
          end
        end
        UartCtrlTxState_START : begin
          if(clockDivider_counter_willOverflow) begin
            stateMachine_state <= UartCtrlTxState_DATA;
          end
        end
        UartCtrlTxState_DATA : begin
          if(clockDivider_counter_willOverflow) begin
            if(when_UartCtrlTx_l73) begin
              if(when_UartCtrlTx_l76) begin
                stateMachine_state <= UartCtrlTxState_STOP;
              end else begin
                stateMachine_state <= UartCtrlTxState_PARITY;
              end
            end
          end
        end
        UartCtrlTxState_PARITY : begin
          if(clockDivider_counter_willOverflow) begin
            stateMachine_state <= UartCtrlTxState_STOP;
          end
        end
        default : begin
          if(clockDivider_counter_willOverflow) begin
            if(when_UartCtrlTx_l93) begin
              stateMachine_state <= _zz_stateMachine_state;
            end
          end
        end
      endcase
      _zz_io_txd <= (stateMachine_txd && (! io_break));
    end
  end

  always @(posedge io_clk) begin
    if(clockDivider_counter_willOverflow) begin
      tickCounter_value <= (tickCounter_value + 3'b001);
    end
    if(clockDivider_counter_willOverflow) begin
      stateMachine_parity <= (stateMachine_parity ^ stateMachine_txd);
    end
    case(stateMachine_state)
      UartCtrlTxState_IDLE : begin
      end
      UartCtrlTxState_START : begin
        if(clockDivider_counter_willOverflow) begin
          stateMachine_parity <= (io_configFrame_parity == UartParityType_ODD);
          tickCounter_value <= 3'b000;
        end
      end
      UartCtrlTxState_DATA : begin
        if(clockDivider_counter_willOverflow) begin
          if(when_UartCtrlTx_l73) begin
            tickCounter_value <= 3'b000;
          end
        end
      end
      UartCtrlTxState_PARITY : begin
        if(clockDivider_counter_willOverflow) begin
          tickCounter_value <= 3'b000;
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module BufferCC (
  input  wire          io_dataIn,
  output wire          io_dataOut,
  input  wire          io_clk,
  input  wire          io_reset
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge io_clk or posedge io_reset) begin
    if(io_reset) begin
      buffers_0 <= 1'b0;
      buffers_1 <= 1'b0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule
