/*######################################################################
//#	G0B1T: HDL EXAMPLES. 2018.
//######################################################################
//# Copyright (C) 2018. F.E.Segura-Quijano (FES) fsegura@uniandes.edu.co
//# 
//# This program is free software: you can redistribute it and/or modify
//# it under the terms of the GNU General Public License as published by
//# the Free Software Foundation, version 3 of the License.
//#
//# This program is distributed in the hope that it will be useful,
//# but WITHOUT ANY WARRANTY; without even the implied warranty of
//# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//# GNU General Public License for more details.
//#
//# You should have received a copy of the GNU General Public License
//# along with this program.  If not, see <http://www.gnu.org/licenses/>
//####################################################################*/
//=======================================================
//  MODULE Definition
//=======================================================
module BB_SYSTEM (
//////////// OUTPUTS //////////
	BB_SYSTEM_data_OutBUS,
//////////// INPUTS //////////
	BB_SYSTEM_CLOCK_50,
	BB_SYSTEM_RESET_InHigh
);
//=======================================================
//  PARAMETER declarations
//=======================================================
// uDATAPATH WIDTH BUS.
parameter DATAWIDTH_BUS = 8;
// SHIFTREGISTER CONTROL BUS.
parameter DATAWIDTH_REGSHIFTER_SELECTION = 2;
// DECODER CONTROL INPUT BUS.
parameter DATAWIDTH_DECODER_SELECTION = 3;
// DECODER CONTROL OUTPUT BUS.
parameter DATAWIDTH_DECODER_OUT = 4;
// ALU CONTROL BUS.
parameter DATAWIDTH_ALU_SELECTION = 4;
// MUX CONTROL BUS.
parameter DATAWIDTH_MUX_SELECTION = 3;
// FIXED_REGISTERS INIT DATA.
parameter DATA_REGFIXED_INIT_0 = 8'b00000000;
parameter DATA_REGFIXED_INIT_1 = 8'b00000001;
//=======================================================
//  PORT declarations
//=======================================================
output	[DATAWIDTH_BUS-1:0] BB_SYSTEM_data_OutBUS;
input 	BB_SYSTEM_CLOCK_50;
input 	BB_SYSTEM_RESET_InHigh;
//=======================================================
//  REG/WIRE declarations
//=======================================================
// FLAGS
wire uDATAPATH_2_STATEMACHINE_overflow_wireCONTROL;
wire uDATAPATH_2_STATEMACHINE_carry_wireCONTROL;
wire uDATAPATH_2_STATEMACHINE_negative_wireCONTROL;
wire uDATAPATH_2_STATEMACHINE_zero_wireCONTROL;
// DECODER CONTROL BUS: TO SELECT GENERAL_REGISTER TO CLEAR DATA. ¡ONE BY ONE, NOT AT SAME TIME!
wire [DATAWIDTH_DECODER_SELECTION-1:0] STATEMACHINE_2_uDATAPATH_decoderclearselection_wireCONTROL; 
// DECODER CONTROL BUS: TO SELECT GENERAL_REGISTER TO LOAD DATA FROM DATA_BUS_C. ¡ONE BY ONE, NOT AT SAME TIME!
wire [DATAWIDTH_DECODER_SELECTION-1:0] STATEMACHINE_2_uDATAPATH_decoderloadselection_wireCONTROL; 
// MUX CONTROL: TO SELECT OUTPUT REGISTER TO BUS_A, BUS_B OR BOTH OF THEM
wire [DATAWIDTH_MUX_SELECTION-1:0] STATEMACHINE_2_uDATAPATH_muxselectionBUSA_wireCONTROL;
wire [DATAWIDTH_MUX_SELECTION-1:0] STATEMACHINE_2_uDATAPATH_muxselectionBUSB_wireCONTROL;
//ALU CONTROL. TO SELECT ALU OPERATION.
wire [DATAWIDTH_ALU_SELECTION-1:0] STATEMACHINE_2_uDATAPATH_aluselection_wireCONTROL;
// SHIFT_REGISTER CONTROL. TO CLEAR DATA
wire STATEMACHINE_2_uDATAPATH_regSHIFTERclear_wireCONTROL;
// SHIFT_REGISTER CONTROL. TO LOAD DATA
wire STATEMACHINE_2_uDATAPATH_regSHIFTERload_wireCONTROL;
// SHIFT_REGISTER CONTROL. TO SHIFT DATA
wire [DATAWIDTH_REGSHIFTER_SELECTION-1:0] STATEMACHINE_2_uDATAPATH_regSHIFTERshiftselection_wireCONTROL;

//=======================================================
//  Structural coding
//=======================================================
uDATAPATH #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT), .DATAWIDTH_ALU_SELECTION(DATAWIDTH_ALU_SELECTION), .DATAWIDTH_MUX_SELECTION(DATAWIDTH_MUX_SELECTION), .DATA_REGFIXED_INIT_0(DATA_REGFIXED_INIT_0), .DATA_REGFIXED_INIT_1(DATA_REGFIXED_INIT_1)) uDATAPATH_u0 (
// port map - connection between master ports and signals/registers   
	.uDATAPATH_data_OutBUS(BB_SYSTEM_data_OutBUS),
	.uDATAPATH_overflow_OutLow(uDATAPATH_2_STATEMACHINE_overflow_wireCONTROL),
	.uDATAPATH_carry_OutLow(uDATAPATH_2_STATEMACHINE_carry_wireCONTROL),
	.uDATAPATH_negative_OutLow(uDATAPATH_2_STATEMACHINE_negative_wireCONTROL),
	.uDATAPATH_zero_OutLow(uDATAPATH_2_STATEMACHINE_zero_wireCONTROL),
	.uDATAPATH_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.uDATAPATH_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.uDATAPATH_decoderclearselection_InBUS(STATEMACHINE_2_uDATAPATH_decoderclearselection_wireCONTROL), 
	.uDATAPATH_decoderloadselection_InBUS(STATEMACHINE_2_uDATAPATH_decoderloadselection_wireCONTROL), 
	.uDATAPATH_muxselectionBUSA_InBUS(STATEMACHINE_2_uDATAPATH_muxselectionBUSA_wireCONTROL),
	.uDATAPATH_muxselectionBUSB_InBUS(STATEMACHINE_2_uDATAPATH_muxselectionBUSB_wireCONTROL),
	.uDATAPATH_aluselection_InBUS(STATEMACHINE_2_uDATAPATH_aluselection_wireCONTROL),
	.uDATAPATH_regSHIFTERclear_InLow(STATEMACHINE_2_uDATAPATH_regSHIFTERclear_wireCONTROL),
	.uDATAPATH_regSHIFTERload_InLow(STATEMACHINE_2_uDATAPATH_regSHIFTERload_wireCONTROL),
	.uDATAPATH_regSHIFTERshiftselection_InLow(STATEMACHINE_2_uDATAPATH_regSHIFTERshiftselection_wireCONTROL)
);
SC_STATEMACHINE #(.DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_ALU_SELECTION(DATAWIDTH_ALU_SELECTION), .DATAWIDTH_REGSHIFTER_SELECTION(DATAWIDTH_REGSHIFTER_SELECTION)) SC_STATEMACHINE_u0 (
// port map - connection between master ports and signals/registers   
	.SC_STATEMACHINE_decoderclearselection_OutBUS(STATEMACHINE_2_uDATAPATH_decoderclearselection_wireCONTROL), 
	.SC_STATEMACHINE_decoderloadselection_OutBUS(STATEMACHINE_2_uDATAPATH_decoderloadselection_wireCONTROL), 
	.SC_STATEMACHINE_muxselectionBUSA_OutBUS(STATEMACHINE_2_uDATAPATH_muxselectionBUSA_wireCONTROL),
	.SC_STATEMACHINE_muxselectionBUSB_OutBUS(STATEMACHINE_2_uDATAPATH_muxselectionBUSB_wireCONTROL),
	.SC_STATEMACHINE_aluselection_OutBUS(STATEMACHINE_2_uDATAPATH_aluselection_wireCONTROL),
	.SC_STATEMACHINE_regSHIFTERclear_OutLow(STATEMACHINE_2_uDATAPATH_regSHIFTERclear_wireCONTROL),
	.SC_STATEMACHINE_regSHIFTERload_OutLow(STATEMACHINE_2_uDATAPATH_regSHIFTERload_wireCONTROL),
	.SC_STATEMACHINE_regSHIFTERshiftselection_OutLow(STATEMACHINE_2_uDATAPATH_regSHIFTERshiftselection_wireCONTROL),
	.SC_STATEMACHINE_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_STATEMACHINE_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_STATEMACHINE_overflow_InLow(uDATAPATH_2_STATEMACHINE_overflow_wireCONTROL),
	.SC_STATEMACHINE_carry_InLow(uDATAPATH_2_STATEMACHINE_carry_wireCONTROL),
	.SC_STATEMACHINE_negative_InLow(uDATAPATH_2_STATEMACHINE_negative_wireCONTROL),
	.SC_STATEMACHINE_zero_InLow(uDATAPATH_2_STATEMACHINE_zero_wireCONTROL)	
);
endmodule
