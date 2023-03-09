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
	BB_SYSTEM_max7219DIN_Out,
	BB_SYSTEM_max7219NCS_Out,
	BB_SYSTEM_max7219CLK_Out,

	BB_SYSTEM_startButton_Out,
	BB_SYSTEM_upButton_Out,
	BB_SYSTEM_downButton_Out,
	BB_SYSTEM_leftButton_Out,
	BB_SYSTEM_rightButton_Out,
	BB_SYSTEM_TEST0,
	BB_SYSTEM_TEST1,
	BB_SYSTEM_TEST2,

//////////// INPUTS //////////
	BB_SYSTEM_CLOCK_50,
	BB_SYSTEM_RESET_InHigh,
	BB_SYSTEM_startButton_InLow, 
	BB_SYSTEM_upButton_InLow,
	BB_SYSTEM_downButton_InLow,
	BB_SYSTEM_leftButton_InLow,
	BB_SYSTEM_rightButton_InLow
);
//=======================================================
//  PARAMETER declarations
//=======================================================
 parameter DATAWIDTH_BUS = 8;
 parameter DISPLAY_DATAWIDTH = 12; //not used
 
 // Preescalers
 parameter PRESCALER_DATAWIDTH_LVL1 = 25;
 parameter PRESCALER_DATAWIDTH_LVL2 = 24;
 parameter PRESCALER_DATAWIDTH_LVL3 = 23;
 parameter PRESCALER_DATAWIDTH_LVL4 = 23;
 
 //Registro  clear - general
 parameter DATA_CLEAR_REG = 8'b00000000;
 
 /* FROGGER (8 lineas) */
 //Frogger Inicial (Start)
 parameter DATA_FIXED_INITREGFROGGER_7 = 8'b00000000;
 parameter DATA_FIXED_INITREGFROGGER_6 = 8'b00000000;
 parameter DATA_FIXED_INITREGFROGGER_5 = 8'b00000000;
 parameter DATA_FIXED_INITREGFROGGER_4 = 8'b00000000;
 parameter DATA_FIXED_INITREGFROGGER_3 = 8'b00000000;
 parameter DATA_FIXED_INITREGFROGGER_2 = 8'b00000000;
 parameter DATA_FIXED_INITREGFROGGER_1 = 8'b00000000;
 parameter DATA_FIXED_INITREGFROGGER_0 = 8'b00001000;
 
 /* ENTRY (1 linea) */
 parameter DATA_FIXED_REGENTRY_NONE_7  = 8'b11011011;
 parameter DATA_FIXED_REGENTRY_LEFT_7  = 8'b11111011;
 parameter DATA_FIXED_REGENTRY_RIGHT_7 = 8'b11011111;
 
 /* BACKG (6 lineas) */
 /* Niveles (Inicial) */
 //Nivel 1
 parameter DATA_FIXED_REGBACKG_NIVEL1_6 = 8'b00000000;
 parameter DATA_FIXED_REGBACKG_NIVEL1_5 = 8'b00000110;
 parameter DATA_FIXED_REGBACKG_NIVEL1_4 = 8'b00000000;
 parameter DATA_FIXED_REGBACKG_NIVEL1_3 = 8'b01100000;
 parameter DATA_FIXED_REGBACKG_NIVEL1_2 = 8'b00000000;
 parameter DATA_FIXED_REGBACKG_NIVEL1_1 = 8'b00011000;
 
 //Nivel 2
 parameter DATA_FIXED_REGBACKG_NIVEL2_6 = 8'b00111000;
 parameter DATA_FIXED_REGBACKG_NIVEL2_5 = 8'b00000000;
 parameter DATA_FIXED_REGBACKG_NIVEL2_4 = 8'b00000111;
 parameter DATA_FIXED_REGBACKG_NIVEL2_3 = 8'b00000000;
 parameter DATA_FIXED_REGBACKG_NIVEL2_2 = 8'b11100000;
 parameter DATA_FIXED_REGBACKG_NIVEL2_1 = 8'b00001110;
   
 //Nivel 3
 parameter DATA_FIXED_REGBACKG_NIVEL3_6 = 8'b11000001;
 parameter DATA_FIXED_REGBACKG_NIVEL3_5 = 8'b00001110;
 parameter DATA_FIXED_REGBACKG_NIVEL3_4 = 8'b11100000;
 parameter DATA_FIXED_REGBACKG_NIVEL3_3 = 8'b00000000;
 parameter DATA_FIXED_REGBACKG_NIVEL3_2 = 8'b00000111;
 parameter DATA_FIXED_REGBACKG_NIVEL3_1 = 8'b11100000;
   
 //Nivel 4
 parameter DATA_FIXED_REGBACKG_NIVEL4_6 = 8'b11000000;
 parameter DATA_FIXED_REGBACKG_NIVEL4_5 = 8'b00001100;
 parameter DATA_FIXED_REGBACKG_NIVEL4_4 = 8'b01100011;
 parameter DATA_FIXED_REGBACKG_NIVEL4_3 = 8'b11000000;
 parameter DATA_FIXED_REGBACKG_NIVEL4_2 = 8'b00001100;
 parameter DATA_FIXED_REGBACKG_NIVEL4_1 = 8'b01100110;
 
 /* Figuras de paso de nivel */
 //Paso a Nivel 2
 parameter DATA_FIXED_REGBACKG_FIGLVL2_6 = 8'b01111110;
 parameter DATA_FIXED_REGBACKG_FIGLVL2_5 = 8'b00000010;
 parameter DATA_FIXED_REGBACKG_FIGLVL2_4 = 8'b01111110;
 parameter DATA_FIXED_REGBACKG_FIGLVL2_3 = 8'b01000000;
 parameter DATA_FIXED_REGBACKG_FIGLVL2_2 = 8'b01000000;
 parameter DATA_FIXED_REGBACKG_FIGLVL2_1 = 8'b01111110;
 
 //Paso a Nivel 3
 parameter DATA_FIXED_REGBACKG_FIGLVL3_6 = 8'b01111110;
 parameter DATA_FIXED_REGBACKG_FIGLVL3_5 = 8'b00000010;
 parameter DATA_FIXED_REGBACKG_FIGLVL3_4 = 8'b01111110;
 parameter DATA_FIXED_REGBACKG_FIGLVL3_3 = 8'b00000010;
 parameter DATA_FIXED_REGBACKG_FIGLVL3_2 = 8'b00000010;
 parameter DATA_FIXED_REGBACKG_FIGLVL3_1 = 8'b01111110;
 
 //Paso a Nivel 4
 parameter DATA_FIXED_REGBACKG_FIGLVL4_6 = 8'b00001000;
 parameter DATA_FIXED_REGBACKG_FIGLVL4_5 = 8'b00011000;
 parameter DATA_FIXED_REGBACKG_FIGLVL4_4 = 8'b00101000;
 parameter DATA_FIXED_REGBACKG_FIGLVL4_3 = 8'b01111100;
 parameter DATA_FIXED_REGBACKG_FIGLVL4_2 = 8'b00001000;
 parameter DATA_FIXED_REGBACKG_FIGLVL4_1 = 8'b00001000;
 
 /* Figuras de vidas restantes */
 //2 Vidas restantes
 parameter DATA_FIXED_REGBACKG_FIGLIFE2_6 = 8'b00011111;
 parameter DATA_FIXED_REGBACKG_FIGLIFE2_5 = 8'b00000001;
 parameter DATA_FIXED_REGBACKG_FIGLIFE2_4 = 8'b11000001;
 parameter DATA_FIXED_REGBACKG_FIGLIFE2_3 = 8'b00011111;
 parameter DATA_FIXED_REGBACKG_FIGLIFE2_2 = 8'b00010000;
 parameter DATA_FIXED_REGBACKG_FIGLIFE2_1 = 8'b00011111;
 
 //1 Vida restante
 parameter DATA_FIXED_REGBACKG_FIGLIFE1_6 = 8'b00000010;
 parameter DATA_FIXED_REGBACKG_FIGLIFE1_5 = 8'b00000110;
 parameter DATA_FIXED_REGBACKG_FIGLIFE1_4 = 8'b11001010;
 parameter DATA_FIXED_REGBACKG_FIGLIFE1_3 = 8'b00000010;
 parameter DATA_FIXED_REGBACKG_FIGLIFE1_2 = 8'b00000010;
 parameter DATA_FIXED_REGBACKG_FIGLIFE1_1 = 8'b00000010;
 
 /* Figuras de Ganar y Perder */
 //Ganar (w) - paso a nivel 5
 parameter DATA_FIXED_REGBACKG_WIN_6 = 8'b01000010;
 parameter DATA_FIXED_REGBACKG_WIN_5 = 8'b01000010;
 parameter DATA_FIXED_REGBACKG_WIN_4 = 8'b01000010;
 parameter DATA_FIXED_REGBACKG_WIN_3 = 8'b01011010;
 parameter DATA_FIXED_REGBACKG_WIN_2 = 8'b01100110;
 parameter DATA_FIXED_REGBACKG_WIN_1 = 8'b01000010;
 
 //Perder (0) - 0 vidas restantes
 parameter DATA_FIXED_REGBACKG_LOSE_6 = 8'b01111110;
 parameter DATA_FIXED_REGBACKG_LOSE_5 = 8'b01000010;
 parameter DATA_FIXED_REGBACKG_LOSE_4 = 8'b01000010;
 parameter DATA_FIXED_REGBACKG_LOSE_3 = 8'b01000010;
 parameter DATA_FIXED_REGBACKG_LOSE_2 = 8'b01000010;
 parameter DATA_FIXED_REGBACKG_LOSE_1 = 8'b01111110;
 
  
//=======================================================
//  PORT declarations
//=======================================================
output		BB_SYSTEM_max7219DIN_Out;
output		BB_SYSTEM_max7219NCS_Out;
output		BB_SYSTEM_max7219CLK_Out;

output 		BB_SYSTEM_startButton_Out;
output 		BB_SYSTEM_upButton_Out;
output 		BB_SYSTEM_downButton_Out;
output 		BB_SYSTEM_leftButton_Out;
output 		BB_SYSTEM_rightButton_Out;

output 		BB_SYSTEM_TEST0;
output 		BB_SYSTEM_TEST1;
output 		BB_SYSTEM_TEST2;

input		BB_SYSTEM_CLOCK_50;
input		BB_SYSTEM_RESET_InHigh;
input		BB_SYSTEM_startButton_InLow;
input		BB_SYSTEM_upButton_InLow;
input		BB_SYSTEM_downButton_InLow;
input		BB_SYSTEM_leftButton_InLow;
input		BB_SYSTEM_rightButton_InLow;

//=======================================================
//  REG/WIRE declarations
//=======================================================
// BUTTONs
wire 	BB_SYSTEM_startButton_InLow_cwire;
wire 	BB_SYSTEM_upButton_InLow_cwire;
wire 	BB_SYSTEM_downButton_InLow_cwire;
wire 	BB_SYSTEM_leftButton_InLow_cwire;
wire 	BB_SYSTEM_rightButton_InLow_cwire;

// FROGGER
wire	STATEMACHINEFROGGER_clear_cwire;
wire	STATEMACHINEFROGGER_init_cwire;
wire	STATEMACHINEFROGGER_load0_cwire;
wire	STATEMACHINEFROGGER_load1_cwire;
wire	[1:0] STATEMACHINEFROGGER_shiftselection_cwire;

wire [DATAWIDTH_BUS-1:0] RegFROGGER_2_FROGGERMATRIX_data7_Out;
wire [DATAWIDTH_BUS-1:0] RegFROGGER_2_FROGGERMATRIX_data6_Out;
wire [DATAWIDTH_BUS-1:0] RegFROGGER_2_FROGGERMATRIX_data5_Out;
wire [DATAWIDTH_BUS-1:0] RegFROGGER_2_FROGGERMATRIX_data4_Out;
wire [DATAWIDTH_BUS-1:0] RegFROGGER_2_FROGGERMATRIX_data3_Out;
wire [DATAWIDTH_BUS-1:0] RegFROGGER_2_FROGGERMATRIX_data2_Out;
wire [DATAWIDTH_BUS-1:0] RegFROGGER_2_FROGGERMATRIX_data1_Out;
wire [DATAWIDTH_BUS-1:0] RegFROGGER_2_FROGGERMATRIX_data0_Out;

// BACKGROUND
wire [1:0] STATEMACHINEBACKG_setFrogger_cwire;
wire STATEMACHINEBACKG_clear_cwire;
wire [2:0] STATEMACHINEBACKG_loadLevel_cwire;
wire [2:0] STATEMACHINEBACKG_loadFigure_cwire;
wire [1:0] STATEMACHINEBACKG_loadEntry_cwire;
wire [1:0] STATEMACHINEBACKG_shift_cwire;
wire STATEMACHINEBACKG_upcount_cwire;
wire STATEMACHINEBACKG_resetLevel_cwire;
wire STATEMACHINEBACKG_resetLives_cwire;
wire STATEMACHINEBACKG_resetEntry_cwire;
wire STATEMACHINEBACKG_resetPrescaler_cwire;

wire [DATAWIDTH_BUS-1:0] RegBACKG_2_FROGGERENTRYMATRIX_data7_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKG_2_BACKGMATRIX_data6_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKG_2_BACKGMATRIX_data5_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKG_2_BACKGMATRIX_data4_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKG_2_BACKGMATRIX_data3_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKG_2_BACKGMATRIX_data2_Out;
wire [DATAWIDTH_BUS-1:0] RegBACKG_2_BACKGMATRIX_data1_Out;

//ENTRYCOMPARATOR
wire ENTRYCOMPARATOR_enterLeft_cwire;
wire ENTRYCOMPARATOR_enterRight_cwire;
wire ENTRYCOMPARATOR_lose_cwire;

//COLLISIONCOMPARATOR
wire COLLISIONCOMPARATOR_lose1_cwire;
wire COLLISIONCOMPARATOR_lose2_cwire;
wire COLLISIONCOMPARATOR_lose3_cwire;
wire COLLISIONCOMPARATOR_lose4_cwire;
wire COLLISIONCOMPARATOR_lose5_cwire;
wire COLLISIONCOMPARATOR_lose6_cwire;

//BOTTOMSIDECOMPARATOR
wire BOTTOMSIDECOMPARATOR_bottomside_cwire;

//RegENTRY
wire [1:0] RegENTRY_numEntry_cwire;
wire RegENTRY_chgEntry_cwire;

//RegLEVEL
wire [2:0] RegLEVEL_numLevel_cwire;

//RegLIVES
wire [1:0] RegLIVES_numLives_cwire;

wire TOTAL_lose_InLow_cwire;

//PRESCALER
wire [PRESCALER_DATAWIDTH_LVL1-1:0] upSPEEDCOUNTER_data_BUS_cwire;
wire SPEEDCOMPARATOR_T0_cwire;

// GAME
wire [DATAWIDTH_BUS-1:0] regGAME_data7_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data6_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data5_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data4_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data3_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data2_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data1_wire;
wire [DATAWIDTH_BUS-1:0] regGAME_data0_wire;

wire 	[7:0] data_max;
wire 	[2:0] add;

//=======================================================
//  Structural coding
//=======================================================

//######################################################################
//#	INPUTS
//######################################################################
SC_DEBOUNCE1 SC_DEBOUNCE1_u0 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_startButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_startButton_InLow)
);
SC_DEBOUNCE1 SC_DEBOUNCE_u1 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_upButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_upButton_InLow)
);
SC_DEBOUNCE1 SC_DEBOUNCE_u2 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_downButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_downButton_InLow)
);
SC_DEBOUNCE1 SC_DEBOUNCE_u3 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_leftButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_leftButton_InLow)
);
SC_DEBOUNCE1 SC_DEBOUNCE_u4 (
// port map - connection between master ports and signals/registers   
	.SC_DEBOUNCE1_button_Out(BB_SYSTEM_rightButton_InLow_cwire),
	.SC_DEBOUNCE1_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_DEBOUNCE1_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_DEBOUNCE1_button_In(~BB_SYSTEM_rightButton_InLow)
);

//######################################################################
//#	FROGGER
//######################################################################

//STATEMACHINE
SC_STATEMACHINEFROGGER SC_STATEMACHINEFROGGER_u0 (
	.SC_STATEMACHINEFROGGER_clear_OutLow(STATEMACHINEFROGGER_clear_cwire),
	.SC_STATEMACHINEFROGGER_init_OutLow(STATEMACHINEFROGGER_init_cwire),
	.SC_STATEMACHINEFROGGER_load0_OutLow(STATEMACHINEFROGGER_load0_cwire),
	.SC_STATEMACHINEFROGGER_load1_OutLow(STATEMACHINEFROGGER_load1_cwire),
	.SC_STATEMACHINEFROGGER_shiftselection_Out(STATEMACHINEFROGGER_shiftselection_cwire),
	.SC_STATEMACHINEFROGGER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_STATEMACHINEFROGGER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_STATEMACHINEFROGGER_setFrogger_In(STATEMACHINEBACKG_setFrogger_cwire),
	.SC_STATEMACHINEFROGGER_upButton_InLow(BB_SYSTEM_upButton_InLow_cwire),
	.SC_STATEMACHINEFROGGER_downButton_InLow(BB_SYSTEM_downButton_InLow_cwire),
	.SC_STATEMACHINEFROGGER_leftButton_InLow(BB_SYSTEM_leftButton_InLow_cwire),
	.SC_STATEMACHINEFROGGER_rightButton_InLow(BB_SYSTEM_rightButton_InLow_cwire),
	.SC_STATEMACHINEFROGGER_bottomsidecomparator_InLow(BOTTOMSIDECOMPARATOR_bottomside_cwire)
);

//REGISTROS
SC_RegFROGGER #(.RegFROGGER_DATAWIDTH(DATAWIDTH_BUS), 
					 .DATA_CLEARFROGGER(DATA_CLEAR_REG),
					 .DATA_FIXED_INITREGFROGGER(DATA_FIXED_INITREGFROGGER_7)) SC_RegFROGGER_u7 (
// port map - connection between master ports and signals/registers   
	.SC_RegFROGGER_data_OutBUS(RegFROGGER_2_FROGGERMATRIX_data7_Out),
	.SC_RegFROGGER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegFROGGER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegFROGGER_clear_InLow(STATEMACHINEFROGGER_clear_cwire),
	.SC_RegFROGGER_init_InLow(STATEMACHINEFROGGER_init_cwire),
	.SC_RegFROGGER_load0_InLow(STATEMACHINEFROGGER_load0_cwire),
	.SC_RegFROGGER_load1_InLow(STATEMACHINEFROGGER_load1_cwire),
	.SC_RegFROGGER_shiftselection_In(STATEMACHINEFROGGER_shiftselection_cwire),
	.SC_RegFROGGER_data0_InBUS(RegFROGGER_2_FROGGERMATRIX_data6_Out),
	.SC_RegFROGGER_data1_InBUS(RegFROGGER_2_FROGGERMATRIX_data0_Out)
);

SC_RegFROGGER #(.RegFROGGER_DATAWIDTH(DATAWIDTH_BUS), 
					 .DATA_CLEARFROGGER(DATA_CLEAR_REG),
					 .DATA_FIXED_INITREGFROGGER(DATA_FIXED_INITREGFROGGER_6)) SC_RegFROGGER_u6 (
// port map - connection between master ports and signals/registers   
	.SC_RegFROGGER_data_OutBUS(RegFROGGER_2_FROGGERMATRIX_data6_Out),
	.SC_RegFROGGER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegFROGGER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegFROGGER_clear_InLow(STATEMACHINEFROGGER_clear_cwire),
	.SC_RegFROGGER_init_InLow(STATEMACHINEFROGGER_init_cwire),
	.SC_RegFROGGER_load0_InLow(STATEMACHINEFROGGER_load0_cwire),
	.SC_RegFROGGER_load1_InLow(STATEMACHINEFROGGER_load1_cwire),
	.SC_RegFROGGER_shiftselection_In(STATEMACHINEFROGGER_shiftselection_cwire),
	.SC_RegFROGGER_data0_InBUS(RegFROGGER_2_FROGGERMATRIX_data5_Out),
	.SC_RegFROGGER_data1_InBUS(RegFROGGER_2_FROGGERMATRIX_data7_Out)
);

SC_RegFROGGER #(.RegFROGGER_DATAWIDTH(DATAWIDTH_BUS), 
					 .DATA_CLEARFROGGER(DATA_CLEAR_REG),
					 .DATA_FIXED_INITREGFROGGER(DATA_FIXED_INITREGFROGGER_5)) SC_RegFROGGER_u5 (
// port map - connection between master ports and signals/registers   
	.SC_RegFROGGER_data_OutBUS(RegFROGGER_2_FROGGERMATRIX_data5_Out),
	.SC_RegFROGGER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegFROGGER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegFROGGER_clear_InLow(STATEMACHINEFROGGER_clear_cwire),
	.SC_RegFROGGER_init_InLow(STATEMACHINEFROGGER_init_cwire),
	.SC_RegFROGGER_load0_InLow(STATEMACHINEFROGGER_load0_cwire),
	.SC_RegFROGGER_load1_InLow(STATEMACHINEFROGGER_load1_cwire),
	.SC_RegFROGGER_shiftselection_In(STATEMACHINEFROGGER_shiftselection_cwire),
	.SC_RegFROGGER_data0_InBUS(RegFROGGER_2_FROGGERMATRIX_data4_Out),
	.SC_RegFROGGER_data1_InBUS(RegFROGGER_2_FROGGERMATRIX_data6_Out)
);

SC_RegFROGGER #(.RegFROGGER_DATAWIDTH(DATAWIDTH_BUS), 
					 .DATA_CLEARFROGGER(DATA_CLEAR_REG),
					 .DATA_FIXED_INITREGFROGGER(DATA_FIXED_INITREGFROGGER_4)) SC_RegFROGGER_u4 (
// port map - connection between master ports and signals/registers   
	.SC_RegFROGGER_data_OutBUS(RegFROGGER_2_FROGGERMATRIX_data4_Out),
	.SC_RegFROGGER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegFROGGER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegFROGGER_clear_InLow(STATEMACHINEFROGGER_clear_cwire),
	.SC_RegFROGGER_init_InLow(STATEMACHINEFROGGER_init_cwire),
	.SC_RegFROGGER_load0_InLow(STATEMACHINEFROGGER_load0_cwire),
	.SC_RegFROGGER_load1_InLow(STATEMACHINEFROGGER_load1_cwire),
	.SC_RegFROGGER_shiftselection_In(STATEMACHINEFROGGER_shiftselection_cwire),
	.SC_RegFROGGER_data0_InBUS(RegFROGGER_2_FROGGERMATRIX_data3_Out),
	.SC_RegFROGGER_data1_InBUS(RegFROGGER_2_FROGGERMATRIX_data5_Out)
);

SC_RegFROGGER #(.RegFROGGER_DATAWIDTH(DATAWIDTH_BUS), 
					 .DATA_CLEARFROGGER(DATA_CLEAR_REG),
					 .DATA_FIXED_INITREGFROGGER(DATA_FIXED_INITREGFROGGER_3)) SC_RegFROGGER_u3 (
// port map - connection between master ports and signals/registers   
	.SC_RegFROGGER_data_OutBUS(RegFROGGER_2_FROGGERMATRIX_data3_Out),
	.SC_RegFROGGER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegFROGGER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegFROGGER_clear_InLow(STATEMACHINEFROGGER_clear_cwire),
	.SC_RegFROGGER_init_InLow(STATEMACHINEFROGGER_init_cwire),
	.SC_RegFROGGER_load0_InLow(STATEMACHINEFROGGER_load0_cwire),
	.SC_RegFROGGER_load1_InLow(STATEMACHINEFROGGER_load1_cwire),
	.SC_RegFROGGER_shiftselection_In(STATEMACHINEFROGGER_shiftselection_cwire),
	.SC_RegFROGGER_data0_InBUS(RegFROGGER_2_FROGGERMATRIX_data2_Out),
	.SC_RegFROGGER_data1_InBUS(RegFROGGER_2_FROGGERMATRIX_data4_Out)
);

SC_RegFROGGER #(.RegFROGGER_DATAWIDTH(DATAWIDTH_BUS), 
					 .DATA_CLEARFROGGER(DATA_CLEAR_REG),
					 .DATA_FIXED_INITREGFROGGER(DATA_FIXED_INITREGFROGGER_2)) SC_RegFROGGER_u2 (
// port map - connection between master ports and signals/registers   
	.SC_RegFROGGER_data_OutBUS(RegFROGGER_2_FROGGERMATRIX_data2_Out),
	.SC_RegFROGGER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegFROGGER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegFROGGER_clear_InLow(STATEMACHINEFROGGER_clear_cwire),
	.SC_RegFROGGER_init_InLow(STATEMACHINEFROGGER_init_cwire),
	.SC_RegFROGGER_load0_InLow(STATEMACHINEFROGGER_load0_cwire),
	.SC_RegFROGGER_load1_InLow(STATEMACHINEFROGGER_load1_cwire),
	.SC_RegFROGGER_shiftselection_In(STATEMACHINEFROGGER_shiftselection_cwire),
	.SC_RegFROGGER_data0_InBUS(RegFROGGER_2_FROGGERMATRIX_data1_Out),
	.SC_RegFROGGER_data1_InBUS(RegFROGGER_2_FROGGERMATRIX_data3_Out)
);

SC_RegFROGGER #(.RegFROGGER_DATAWIDTH(DATAWIDTH_BUS), 
					 .DATA_CLEARFROGGER(DATA_CLEAR_REG),
					 .DATA_FIXED_INITREGFROGGER(DATA_FIXED_INITREGFROGGER_1)) SC_RegFROGGER_u1 (
// port map - connection between master ports and signals/registers   
	.SC_RegFROGGER_data_OutBUS(RegFROGGER_2_FROGGERMATRIX_data1_Out),
	.SC_RegFROGGER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegFROGGER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegFROGGER_clear_InLow(STATEMACHINEFROGGER_clear_cwire),
	.SC_RegFROGGER_init_InLow(STATEMACHINEFROGGER_init_cwire),
	.SC_RegFROGGER_load0_InLow(STATEMACHINEFROGGER_load0_cwire),
	.SC_RegFROGGER_load1_InLow(STATEMACHINEFROGGER_load1_cwire),
	.SC_RegFROGGER_shiftselection_In(STATEMACHINEFROGGER_shiftselection_cwire),
	.SC_RegFROGGER_data0_InBUS(RegFROGGER_2_FROGGERMATRIX_data0_Out),
	.SC_RegFROGGER_data1_InBUS(RegFROGGER_2_FROGGERMATRIX_data2_Out)
);

SC_RegFROGGER #(.RegFROGGER_DATAWIDTH(DATAWIDTH_BUS), 
					 .DATA_CLEARFROGGER(DATA_CLEAR_REG),
					 .DATA_FIXED_INITREGFROGGER(DATA_FIXED_INITREGFROGGER_0)) SC_RegFROGGER_u0 (
// port map - connection between master ports and signals/registers   
	.SC_RegFROGGER_data_OutBUS(RegFROGGER_2_FROGGERMATRIX_data0_Out),
	.SC_RegFROGGER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegFROGGER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegFROGGER_clear_InLow(STATEMACHINEFROGGER_clear_cwire),
	.SC_RegFROGGER_init_InLow(STATEMACHINEFROGGER_init_cwire),
	.SC_RegFROGGER_load0_InLow(STATEMACHINEFROGGER_load0_cwire),
	.SC_RegFROGGER_load1_InLow(STATEMACHINEFROGGER_load1_cwire),
	.SC_RegFROGGER_shiftselection_In(STATEMACHINEFROGGER_shiftselection_cwire),
	.SC_RegFROGGER_data0_InBUS(RegFROGGER_2_FROGGERMATRIX_data7_Out),
	.SC_RegFROGGER_data1_InBUS(RegFROGGER_2_FROGGERMATRIX_data1_Out)
);


//######################################################################
//#	ENTRYFROGGER
//######################################################################

//REGISTRO
SC_RegENTRYFROGGER #(.RegENTRYFROGGER_DATAWIDTH(DATAWIDTH_BUS), 
							.DATA_CLEARENTRYFROGGER(DATA_CLEAR_REG),
							.DATA_FIXED_REGENTRY_NONE(DATA_FIXED_REGENTRY_NONE_7), 
							.DATA_FIXED_REGENTRY_LEFT(DATA_FIXED_REGENTRY_LEFT_7),
							.DATA_FIXED_REGENTRY_RIGHT(DATA_FIXED_REGENTRY_RIGHT_7)) SC_RegENTRYFROGGER_u7(
	.SC_RegENTRYFROGGER_data_OutBUS(RegBACKG_2_FROGGERENTRYMATRIX_data7_Out),
	.SC_RegENTRYFROGGER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegENTRYFROGGER_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegENTRYFROGGER_loadEntry_In(STATEMACHINEBACKG_loadEntry_cwire)
);

//######################################################################
//#	BACKGROUND
//######################################################################

//STATEMACHINE
SC_STATEMACHINEBACKG SC_STATEMACHINEBACKG_u0 (
	.SC_STATEMACHINEBACKG_setFrogger_Out(STATEMACHINEBACKG_setFrogger_cwire),
	.SC_STATEMACHINEBACKG_clearBackg_OutLow(STATEMACHINEBACKG_clear_cwire),
	.SC_STATEMACHINEBACKG_loadLevel_Out(STATEMACHINEBACKG_loadLevel_cwire),
	.SC_STATEMACHINEBACKG_loadFigure_Out(STATEMACHINEBACKG_loadFigure_cwire),
	.SC_STATEMACHINEBACKG_loadEntry_Out(STATEMACHINEBACKG_loadEntry_cwire),
	.SC_STATEMACHINEBACKG_shift_Out(STATEMACHINEBACKG_shift_cwire),
	.SC_STATEMACHINEBACKG_upCount_OutLow(STATEMACHINEBACKG_upcount_cwire),
	.SC_STATEMACHINEBACKG_resetLevel_OutHigh(STATEMACHINEBACKG_resetLevel_cwire),
	.SC_STATEMACHINEBACKG_resetLives_OutHigh(STATEMACHINEBACKG_resetLives_cwire),
	.SC_STATEMACHINEBACKG_resetEntry_OutHigh(STATEMACHINEBACKG_resetEntry_cwire),
	.SC_STATEMACHINEBACKG_resetPrescaler_OutHigh(STATEMACHINEBACKG_resetPrescaler_cwire),
	.SC_STATEMACHINEBACKG_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_STATEMACHINEBACKG_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_STATEMACHINEBACKG_startButton_InLow(BB_SYSTEM_startButton_InLow_cwire),
	.SC_STATEMACHINEBACKG_T0_InLow(SPEEDCOMPARATOR_T0_cwire),
	.SC_STATEMACHINEBACKG_lose_InLow(TOTAL_lose_InLow_cwire),
	.SC_STATEMACHINEBACKG_chgEntry_InLow(RegENTRY_chgEntry_cwire),
	.SC_STATEMACHINEBACKG_numEntry_In(RegENTRY_numEntry_cwire),
	.SC_STATEMACHINEBACKG_numLives_In(RegLIVES_numLives_cwire),
	.SC_STATEMACHINEBACKG_numLevel_In(RegLEVEL_numLevel_cwire)
);

//Registros
SC_RegBACKG #(.RegBACKG_DATAWIDTH(DATAWIDTH_BUS), 
				  .DATA_CLEARBACKG(DATA_CLEAR_REG),
				  .DATA_FIXED_REGBACKG_NIVEL1(DATA_FIXED_REGBACKG_NIVEL1_6), 
				  .DATA_FIXED_REGBACKG_NIVEL2(DATA_FIXED_REGBACKG_NIVEL2_6),
				  .DATA_FIXED_REGBACKG_NIVEL3(DATA_FIXED_REGBACKG_NIVEL3_6), 
				  .DATA_FIXED_REGBACKG_NIVEL4(DATA_FIXED_REGBACKG_NIVEL4_6),
				  .DATA_FIXED_REGBACKG_FIGLVL2(DATA_FIXED_REGBACKG_FIGLVL2_6), 
				  .DATA_FIXED_REGBACKG_FIGLVL3(DATA_FIXED_REGBACKG_FIGLVL3_6),
				  .DATA_FIXED_REGBACKG_FIGLVL4(DATA_FIXED_REGBACKG_FIGLVL4_6), 
				  .DATA_FIXED_REGBACKG_WIN(DATA_FIXED_REGBACKG_WIN_6),
				  .DATA_FIXED_REGBACKG_FIGLIFE2(DATA_FIXED_REGBACKG_FIGLIFE2_6),
				  .DATA_FIXED_REGBACKG_FIGLIFE1(DATA_FIXED_REGBACKG_FIGLIFE1_6),
				  .DATA_FIXED_REGBACKG_LOSE(DATA_FIXED_REGBACKG_LOSE_6)) SC_RegBACKG_u6(
	.SC_RegBACKG_data_OutBUS(RegBACKG_2_BACKGMATRIX_data6_Out),
	.SC_RegBACKG_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKG_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKG_clear_InLow(STATEMACHINEBACKG_clear_cwire), 
	.SC_RegBACKG_loadLevel_In(STATEMACHINEBACKG_loadLevel_cwire),
	.SC_RegBACKG_loadFigure_In(STATEMACHINEBACKG_loadFigure_cwire),
	.SC_RegBACKG_shift_In(STATEMACHINEBACKG_shift_cwire)
);

SC_RegBACKG #(.RegBACKG_DATAWIDTH(DATAWIDTH_BUS), 
				  .DATA_CLEARBACKG(DATA_CLEAR_REG),
				  .DATA_FIXED_REGBACKG_NIVEL1(DATA_FIXED_REGBACKG_NIVEL1_5), 
				  .DATA_FIXED_REGBACKG_NIVEL2(DATA_FIXED_REGBACKG_NIVEL2_5),
				  .DATA_FIXED_REGBACKG_NIVEL3(DATA_FIXED_REGBACKG_NIVEL3_5), 
				  .DATA_FIXED_REGBACKG_NIVEL4(DATA_FIXED_REGBACKG_NIVEL4_5),
				  .DATA_FIXED_REGBACKG_FIGLVL2(DATA_FIXED_REGBACKG_FIGLVL2_5), 
				  .DATA_FIXED_REGBACKG_FIGLVL3(DATA_FIXED_REGBACKG_FIGLVL3_5),
				  .DATA_FIXED_REGBACKG_FIGLVL4(DATA_FIXED_REGBACKG_FIGLVL4_5), 
				  .DATA_FIXED_REGBACKG_WIN(DATA_FIXED_REGBACKG_WIN_5),
				  .DATA_FIXED_REGBACKG_FIGLIFE2(DATA_FIXED_REGBACKG_FIGLIFE2_5),
				  .DATA_FIXED_REGBACKG_FIGLIFE1(DATA_FIXED_REGBACKG_FIGLIFE1_5),
				  .DATA_FIXED_REGBACKG_LOSE(DATA_FIXED_REGBACKG_LOSE_5)) SC_RegBACKG_u5(
	.SC_RegBACKG_data_OutBUS(RegBACKG_2_BACKGMATRIX_data5_Out),
	.SC_RegBACKG_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKG_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKG_clear_InLow(STATEMACHINEBACKG_clear_cwire), 
	.SC_RegBACKG_loadLevel_In(STATEMACHINEBACKG_loadLevel_cwire),
	.SC_RegBACKG_loadFigure_In(STATEMACHINEBACKG_loadFigure_cwire),
	.SC_RegBACKG_shift_In(STATEMACHINEBACKG_shift_cwire)
);

SC_RegBACKG #(.RegBACKG_DATAWIDTH(DATAWIDTH_BUS), 
				  .DATA_CLEARBACKG(DATA_CLEAR_REG),
				  .DATA_FIXED_REGBACKG_NIVEL1(DATA_FIXED_REGBACKG_NIVEL1_4), 
				  .DATA_FIXED_REGBACKG_NIVEL2(DATA_FIXED_REGBACKG_NIVEL2_4),
				  .DATA_FIXED_REGBACKG_NIVEL3(DATA_FIXED_REGBACKG_NIVEL3_4), 
				  .DATA_FIXED_REGBACKG_NIVEL4(DATA_FIXED_REGBACKG_NIVEL4_4),
				  .DATA_FIXED_REGBACKG_FIGLVL2(DATA_FIXED_REGBACKG_FIGLVL2_4), 
				  .DATA_FIXED_REGBACKG_FIGLVL3(DATA_FIXED_REGBACKG_FIGLVL3_4),
				  .DATA_FIXED_REGBACKG_FIGLVL4(DATA_FIXED_REGBACKG_FIGLVL4_4), 
				  .DATA_FIXED_REGBACKG_WIN(DATA_FIXED_REGBACKG_WIN_4),
				  .DATA_FIXED_REGBACKG_FIGLIFE2(DATA_FIXED_REGBACKG_FIGLIFE2_4),
				  .DATA_FIXED_REGBACKG_FIGLIFE1(DATA_FIXED_REGBACKG_FIGLIFE1_4),
				  .DATA_FIXED_REGBACKG_LOSE(DATA_FIXED_REGBACKG_LOSE_4)) SC_RegBACKG_u4(
	.SC_RegBACKG_data_OutBUS(RegBACKG_2_BACKGMATRIX_data4_Out),
	.SC_RegBACKG_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKG_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKG_clear_InLow(STATEMACHINEBACKG_clear_cwire), 
	.SC_RegBACKG_loadLevel_In(STATEMACHINEBACKG_loadLevel_cwire),
	.SC_RegBACKG_loadFigure_In(STATEMACHINEBACKG_loadFigure_cwire),
	.SC_RegBACKG_shift_In(STATEMACHINEBACKG_shift_cwire)
);

SC_RegBACKG #(.RegBACKG_DATAWIDTH(DATAWIDTH_BUS), 
				  .DATA_CLEARBACKG(DATA_CLEAR_REG),
				  .DATA_FIXED_REGBACKG_NIVEL1(DATA_FIXED_REGBACKG_NIVEL1_3), 
				  .DATA_FIXED_REGBACKG_NIVEL2(DATA_FIXED_REGBACKG_NIVEL2_3),
				  .DATA_FIXED_REGBACKG_NIVEL3(DATA_FIXED_REGBACKG_NIVEL3_3), 
				  .DATA_FIXED_REGBACKG_NIVEL4(DATA_FIXED_REGBACKG_NIVEL4_3),
				  .DATA_FIXED_REGBACKG_FIGLVL2(DATA_FIXED_REGBACKG_FIGLVL2_3), 
				  .DATA_FIXED_REGBACKG_FIGLVL3(DATA_FIXED_REGBACKG_FIGLVL3_3),
				  .DATA_FIXED_REGBACKG_FIGLVL4(DATA_FIXED_REGBACKG_FIGLVL4_3), 
				  .DATA_FIXED_REGBACKG_WIN(DATA_FIXED_REGBACKG_WIN_3),
				  .DATA_FIXED_REGBACKG_FIGLIFE2(DATA_FIXED_REGBACKG_FIGLIFE2_3),
				  .DATA_FIXED_REGBACKG_FIGLIFE1(DATA_FIXED_REGBACKG_FIGLIFE1_3),
				  .DATA_FIXED_REGBACKG_LOSE(DATA_FIXED_REGBACKG_LOSE_3)) SC_RegBACKG_u3(
	.SC_RegBACKG_data_OutBUS(RegBACKG_2_BACKGMATRIX_data3_Out),
	.SC_RegBACKG_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKG_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKG_clear_InLow(STATEMACHINEBACKG_clear_cwire), 
	.SC_RegBACKG_loadLevel_In(STATEMACHINEBACKG_loadLevel_cwire),
	.SC_RegBACKG_loadFigure_In(STATEMACHINEBACKG_loadFigure_cwire),
	.SC_RegBACKG_shift_In(STATEMACHINEBACKG_shift_cwire)
);

SC_RegBACKG #(.RegBACKG_DATAWIDTH(DATAWIDTH_BUS), 
				  .DATA_CLEARBACKG(DATA_CLEAR_REG),
				  .DATA_FIXED_REGBACKG_NIVEL1(DATA_FIXED_REGBACKG_NIVEL1_2), 
				  .DATA_FIXED_REGBACKG_NIVEL2(DATA_FIXED_REGBACKG_NIVEL2_2),
				  .DATA_FIXED_REGBACKG_NIVEL3(DATA_FIXED_REGBACKG_NIVEL3_2), 
				  .DATA_FIXED_REGBACKG_NIVEL4(DATA_FIXED_REGBACKG_NIVEL4_2),
				  .DATA_FIXED_REGBACKG_FIGLVL2(DATA_FIXED_REGBACKG_FIGLVL2_2), 
				  .DATA_FIXED_REGBACKG_FIGLVL3(DATA_FIXED_REGBACKG_FIGLVL3_2),
				  .DATA_FIXED_REGBACKG_FIGLVL4(DATA_FIXED_REGBACKG_FIGLVL4_2), 
				  .DATA_FIXED_REGBACKG_WIN(DATA_FIXED_REGBACKG_WIN_2),
				  .DATA_FIXED_REGBACKG_FIGLIFE2(DATA_FIXED_REGBACKG_FIGLIFE2_2),
				  .DATA_FIXED_REGBACKG_FIGLIFE1(DATA_FIXED_REGBACKG_FIGLIFE1_2),
				  .DATA_FIXED_REGBACKG_LOSE(DATA_FIXED_REGBACKG_LOSE_2)) SC_RegBACKG_u2(
	.SC_RegBACKG_data_OutBUS(RegBACKG_2_BACKGMATRIX_data2_Out),
	.SC_RegBACKG_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKG_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKG_clear_InLow(STATEMACHINEBACKG_clear_cwire), 
	.SC_RegBACKG_loadLevel_In(STATEMACHINEBACKG_loadLevel_cwire),
	.SC_RegBACKG_loadFigure_In(STATEMACHINEBACKG_loadFigure_cwire),
	.SC_RegBACKG_shift_In(STATEMACHINEBACKG_shift_cwire)
);

SC_RegBACKG #(.RegBACKG_DATAWIDTH(DATAWIDTH_BUS), 
				  .DATA_CLEARBACKG(DATA_CLEAR_REG),
				  .DATA_FIXED_REGBACKG_NIVEL1(DATA_FIXED_REGBACKG_NIVEL1_1), 
				  .DATA_FIXED_REGBACKG_NIVEL2(DATA_FIXED_REGBACKG_NIVEL2_1),
				  .DATA_FIXED_REGBACKG_NIVEL3(DATA_FIXED_REGBACKG_NIVEL3_1), 
				  .DATA_FIXED_REGBACKG_NIVEL4(DATA_FIXED_REGBACKG_NIVEL4_1),
				  .DATA_FIXED_REGBACKG_FIGLVL2(DATA_FIXED_REGBACKG_FIGLVL2_1), 
				  .DATA_FIXED_REGBACKG_FIGLVL3(DATA_FIXED_REGBACKG_FIGLVL3_1),
				  .DATA_FIXED_REGBACKG_FIGLVL4(DATA_FIXED_REGBACKG_FIGLVL4_1), 
				  .DATA_FIXED_REGBACKG_WIN(DATA_FIXED_REGBACKG_WIN_1),
				  .DATA_FIXED_REGBACKG_FIGLIFE2(DATA_FIXED_REGBACKG_FIGLIFE2_1),
				  .DATA_FIXED_REGBACKG_FIGLIFE1(DATA_FIXED_REGBACKG_FIGLIFE1_1),
				  .DATA_FIXED_REGBACKG_LOSE(DATA_FIXED_REGBACKG_LOSE_1)) SC_RegBACKG_u1(
	.SC_RegBACKG_data_OutBUS(RegBACKG_2_BACKGMATRIX_data1_Out),
	.SC_RegBACKG_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegBACKG_RESET_InHigh(BB_SYSTEM_RESET_InHigh),
	.SC_RegBACKG_clear_InLow(STATEMACHINEBACKG_clear_cwire), 
	.SC_RegBACKG_loadLevel_In(STATEMACHINEBACKG_loadLevel_cwire),
	.SC_RegBACKG_loadFigure_In(STATEMACHINEBACKG_loadFigure_cwire),
	.SC_RegBACKG_shift_In(STATEMACHINEBACKG_shift_cwire)
);

//######################################################################
//#	COMPARATORS
//######################################################################

CC_ENTRYCOMPARATOR #(.ENTRYCOMPARATOR_DATAWIDTH(DATAWIDTH_BUS)) CC_ENTRYCOMPARATOR_u7(
	.CC_ENTRYCOMPARATOR_lose_OutLow(ENTRYCOMPARATOR_lose_cwire),
	.CC_ENTRYCOMPARATOR_enterLeft_OutLow(ENTRYCOMPARATOR_enterLeft_cwire),
	.CC_ENTRYCOMPARATOR_enterRight_OutLow(ENTRYCOMPARATOR_enterRight_cwire),
	.CC_ENTRYCOMPARATOR_entryBUS(RegBACKG_2_FROGGERENTRYMATRIX_data7_Out),
	.CC_ENTRYCOMPARATOR_froggerBUS(RegFROGGER_2_FROGGERMATRIX_data7_Out)
);

CC_COLLISIONCOMPARATOR #(.COLLISIONCOMPARATOR_DATAWIDTH(DATAWIDTH_BUS)) CC_COLLISIONCOMPARATOR_u6(
	.CC_COLLISIONCOMPARATOR_lose_OutLow(COLLISIONCOMPARATOR_lose6_cwire),
	.CC_COLLISIONCOMPARATOR_backgBUS(RegBACKG_2_BACKGMATRIX_data6_Out),
	.CC_COLLISIONCOMPARATOR_froggerBUS(RegFROGGER_2_FROGGERMATRIX_data6_Out)
);

CC_COLLISIONCOMPARATOR #(.COLLISIONCOMPARATOR_DATAWIDTH(DATAWIDTH_BUS)) CC_COLLISIONCOMPARATOR_u5(
	.CC_COLLISIONCOMPARATOR_lose_OutLow(COLLISIONCOMPARATOR_lose5_cwire),
	.CC_COLLISIONCOMPARATOR_backgBUS(RegBACKG_2_BACKGMATRIX_data5_Out),
	.CC_COLLISIONCOMPARATOR_froggerBUS(RegFROGGER_2_FROGGERMATRIX_data5_Out)
);

CC_COLLISIONCOMPARATOR #(.COLLISIONCOMPARATOR_DATAWIDTH(DATAWIDTH_BUS)) CC_COLLISIONCOMPARATOR_u4(
	.CC_COLLISIONCOMPARATOR_lose_OutLow(COLLISIONCOMPARATOR_lose4_cwire),
	.CC_COLLISIONCOMPARATOR_backgBUS(RegBACKG_2_BACKGMATRIX_data4_Out),
	.CC_COLLISIONCOMPARATOR_froggerBUS(RegFROGGER_2_FROGGERMATRIX_data4_Out)
);

CC_COLLISIONCOMPARATOR #(.COLLISIONCOMPARATOR_DATAWIDTH(DATAWIDTH_BUS)) CC_COLLISIONCOMPARATOR_u3(
	.CC_COLLISIONCOMPARATOR_lose_OutLow(COLLISIONCOMPARATOR_lose3_cwire),
	.CC_COLLISIONCOMPARATOR_backgBUS(RegBACKG_2_BACKGMATRIX_data3_Out),
	.CC_COLLISIONCOMPARATOR_froggerBUS(RegFROGGER_2_FROGGERMATRIX_data3_Out)
);

CC_COLLISIONCOMPARATOR #(.COLLISIONCOMPARATOR_DATAWIDTH(DATAWIDTH_BUS)) CC_COLLISIONCOMPARATOR_u2(
	.CC_COLLISIONCOMPARATOR_lose_OutLow(COLLISIONCOMPARATOR_lose2_cwire),
	.CC_COLLISIONCOMPARATOR_backgBUS(RegBACKG_2_BACKGMATRIX_data2_Out),
	.CC_COLLISIONCOMPARATOR_froggerBUS(RegFROGGER_2_FROGGERMATRIX_data2_Out)
);

CC_COLLISIONCOMPARATOR #(.COLLISIONCOMPARATOR_DATAWIDTH(DATAWIDTH_BUS)) CC_COLLISIONCOMPARATOR_u1(
	.CC_COLLISIONCOMPARATOR_lose_OutLow(COLLISIONCOMPARATOR_lose1_cwire),
	.CC_COLLISIONCOMPARATOR_backgBUS(RegBACKG_2_BACKGMATRIX_data1_Out),
	.CC_COLLISIONCOMPARATOR_froggerBUS(RegFROGGER_2_FROGGERMATRIX_data1_Out)
);

CC_BOTTOMSIDECOMPARATOR #(.BOTTOMSIDECOMPARATOR_DATAWIDTH(DATAWIDTH_BUS)) CC_BOTTOMSIDECOMPARATOR_u0(
	.CC_BOTTOMSIDECOMPARATOR_bottomside_OutLow(BOTTOMSIDECOMPARATOR_bottomside_cwire),
	.CC_BOTTOMSIDECOMPARATOR_data_InBUS(RegFROGGER_2_FROGGERMATRIX_data0_Out)
);

//######################################################################
//#	REGISTRO VIDAS, ENTRADAS, NIVEL
//######################################################################

SC_RegENTRY SC_RegENTRY_u0(
	.SC_RegENTRY_numEntry_Out(RegENTRY_numEntry_cwire),
	.SC_RegENTRY_chgEntry_OutLow(RegENTRY_chgEntry_cwire),
	.SC_RegENTRY_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegENTRY_RESET_InHigh(STATEMACHINEBACKG_resetEntry_cwire),
	.SC_RegENTRY_enterLeft_InLow(ENTRYCOMPARATOR_enterLeft_cwire),
	.SC_RegENTRY_enterRight_InLow(ENTRYCOMPARATOR_enterRight_cwire)
);

SC_RegLEVEL SC_RegLEVEL_u0(
	.SC_RegLEVEL_numLevel_Out(RegLEVEL_numLevel_cwire),
	.SC_RegLEVEL_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegLEVEL_RESET_InHigh(STATEMACHINEBACKG_resetLevel_cwire),
	.SC_RegLEVEL_chgEntry_InLow(RegENTRY_chgEntry_cwire),
	.SC_RegLEVEL_numEntry_In(RegENTRY_numEntry_cwire)
);

SC_RegLIVES SC_RegLIVES_u0(
	.SC_RegLIVES_numLives_Out(RegLIVES_numLives_cwire),
	.SC_RegLIVES_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_RegLIVES_RESET_InHigh(STATEMACHINEBACKG_resetLives_cwire),
	.SC_RegLIVES_lose_InLow(TOTAL_lose_InLow_cwire)
);

//######################################################################
//#	PRESCALER
//######################################################################

SC_upSPEEDCOUNTER #(.upSPEEDCOUNTER_DATAWIDTH_LVL1(PRESCALER_DATAWIDTH_LVL1),
					.upSPEEDCOUNTER_DATAWIDTH_LVL2(PRESCALER_DATAWIDTH_LVL2),
					.upSPEEDCOUNTER_DATAWIDTH_LVL3(PRESCALER_DATAWIDTH_LVL3),
					.upSPEEDCOUNTER_DATAWIDTH_LVL4(PRESCALER_DATAWIDTH_LVL4)) SC_upSPEEDCOUNTER_u0(
	.SC_upSPEEDCOUNTER_data_OutBUS(upSPEEDCOUNTER_data_BUS_cwire),
	.SC_upSPEEDCOUNTER_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.SC_upSPEEDCOUNTER_RESET_InHigh(STATEMACHINEBACKG_resetPrescaler_cwire),
	.SC_upSPEEDCOUNTER_upcount_InLow(STATEMACHINEBACKG_upcount_cwire)
);

CC_SPEEDCOMPARATOR #(.SPEEDCOMPARATOR_DATAWIDTH_LVL1(PRESCALER_DATAWIDTH_LVL1),
					.SPEEDCOMPARATOR_DATAWIDTH_LVL2(PRESCALER_DATAWIDTH_LVL2),
					.SPEEDCOMPARATOR_DATAWIDTH_LVL3(PRESCALER_DATAWIDTH_LVL3),
					.SPEEDCOMPARATOR_DATAWIDTH_LVL4(PRESCALER_DATAWIDTH_LVL4)) SC_SPEEDCOMPARATOR_u0(
	.CC_SPEEDCOMPARATOR_T0_OutLow(SPEEDCOMPARATOR_T0_cwire),
	.CC_SPEEDCOMPARATOR_data_InBUS(upSPEEDCOUNTER_data_BUS_cwire),
	.CC_SPEEDCOMPARATOR_numLevel_In(RegLEVEL_numLevel_cwire)
);

//######################################################################
//#	TO LED MATRIZ: VISUALIZATION
//######################################################################
assign regGAME_data0_wire = RegFROGGER_2_FROGGERMATRIX_data0_Out;
assign regGAME_data1_wire = RegFROGGER_2_FROGGERMATRIX_data1_Out | RegBACKG_2_BACKGMATRIX_data1_Out;
assign regGAME_data2_wire = RegFROGGER_2_FROGGERMATRIX_data2_Out | RegBACKG_2_BACKGMATRIX_data2_Out;
assign regGAME_data3_wire = RegFROGGER_2_FROGGERMATRIX_data3_Out | RegBACKG_2_BACKGMATRIX_data3_Out;
assign regGAME_data4_wire = RegFROGGER_2_FROGGERMATRIX_data4_Out | RegBACKG_2_BACKGMATRIX_data4_Out;
assign regGAME_data5_wire = RegFROGGER_2_FROGGERMATRIX_data5_Out | RegBACKG_2_BACKGMATRIX_data5_Out;
assign regGAME_data6_wire = RegFROGGER_2_FROGGERMATRIX_data6_Out | RegBACKG_2_BACKGMATRIX_data6_Out;
assign regGAME_data7_wire = RegFROGGER_2_FROGGERMATRIX_data7_Out | RegBACKG_2_FROGGERENTRYMATRIX_data7_Out;

assign data_max =(add==3'b000)?{regGAME_data0_wire[7],regGAME_data1_wire[7],regGAME_data2_wire[7],regGAME_data3_wire[7],regGAME_data4_wire[7],regGAME_data5_wire[7],regGAME_data6_wire[7],regGAME_data7_wire[7]}:
					  (add==3'b001)?{regGAME_data0_wire[6],regGAME_data1_wire[6],regGAME_data2_wire[6],regGAME_data3_wire[6],regGAME_data4_wire[6],regGAME_data5_wire[6],regGAME_data6_wire[6],regGAME_data7_wire[6]}:
					  (add==3'b010)?{regGAME_data0_wire[5],regGAME_data1_wire[5],regGAME_data2_wire[5],regGAME_data3_wire[5],regGAME_data4_wire[5],regGAME_data5_wire[5],regGAME_data6_wire[5],regGAME_data7_wire[5]}:
					  (add==3'b011)?{regGAME_data0_wire[4],regGAME_data1_wire[4],regGAME_data2_wire[4],regGAME_data3_wire[4],regGAME_data4_wire[4],regGAME_data5_wire[4],regGAME_data6_wire[4],regGAME_data7_wire[4]}:
					  (add==3'b100)?{regGAME_data0_wire[3],regGAME_data1_wire[3],regGAME_data2_wire[3],regGAME_data3_wire[3],regGAME_data4_wire[3],regGAME_data5_wire[3],regGAME_data6_wire[3],regGAME_data7_wire[3]}:
					  (add==3'b101)?{regGAME_data0_wire[2],regGAME_data1_wire[2],regGAME_data2_wire[2],regGAME_data3_wire[2],regGAME_data4_wire[2],regGAME_data5_wire[2],regGAME_data6_wire[2],regGAME_data7_wire[2]}:
					  (add==3'b110)?{regGAME_data0_wire[1],regGAME_data1_wire[1],regGAME_data2_wire[1],regGAME_data3_wire[1],regGAME_data4_wire[1],regGAME_data5_wire[1],regGAME_data6_wire[1],regGAME_data7_wire[1]}:
						{regGAME_data0_wire[0],regGAME_data1_wire[0],regGAME_data2_wire[0],regGAME_data3_wire[0],regGAME_data4_wire[0],regGAME_data5_wire[0],regGAME_data6_wire[0],regGAME_data7_wire[0]};
				
assign TOTAL_lose_InLow_cwire = ENTRYCOMPARATOR_lose_cwire & COLLISIONCOMPARATOR_lose1_cwire & COLLISIONCOMPARATOR_lose2_cwire &
								  COLLISIONCOMPARATOR_lose3_cwire & COLLISIONCOMPARATOR_lose4_cwire & COLLISIONCOMPARATOR_lose5_cwire &
								  COLLISIONCOMPARATOR_lose6_cwire;
				
matrix_ctrl matrix_ctrl_unit_0( 
	.max7219_din(BB_SYSTEM_max7219DIN_Out),//max7219_din 
	.max7219_ncs(BB_SYSTEM_max7219NCS_Out),//max7219_ncs 
	.max7219_clk(BB_SYSTEM_max7219CLK_Out),//max7219_clk
	.disp_data(data_max), 
	.disp_addr(add),
	.intensity(4'hA),
	.clk(BB_SYSTEM_CLOCK_50),
	.reset(BB_SYSTEM_RESET_InHigh) //~lowRst_System
 ); 
 
//######################################################################
//#	TO TEST
//######################################################################

assign BB_SYSTEM_startButton_Out = BB_SYSTEM_startButton_InLow_cwire;
assign BB_SYSTEM_upButton_Out = BB_SYSTEM_upButton_InLow_cwire;
assign BB_SYSTEM_downButton_Out = BB_SYSTEM_downButton_InLow_cwire;
assign BB_SYSTEM_leftButton_Out = BB_SYSTEM_leftButton_InLow_cwire;
assign BB_SYSTEM_rightButton_Out = BB_SYSTEM_rightButton_InLow_cwire;
//TO TEST
assign BB_SYSTEM_TEST0 = BB_SYSTEM_startButton_InLow_cwire;
assign BB_SYSTEM_TEST1 = BB_SYSTEM_startButton_InLow_cwire;
assign BB_SYSTEM_TEST2 = BB_SYSTEM_startButton_InLow_cwire;



endmodule