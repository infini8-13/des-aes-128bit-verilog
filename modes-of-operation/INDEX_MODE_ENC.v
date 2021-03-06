module INDEX_MODE_ENC(DONE,CLK,RST);

input CLK,RST;
output reg DONE;

parameter [0:19]CELLS=20'b100000000000000000;
reg [0:63]IFILE[0:CELLS-1];
reg [0:19]ADDRESS;
reg [0:63]P;
wire GENERATED;
wire [0:767]RK;
reg [0:63]UK;
reg GENERATE;
reg [0:63]O;
reg [0:63]O1;
reg [0:47]E;
reg [0:31]S[0:63];

integer f;

initial begin $readmemh("sbox.list",S); $readmemh("in1_image.list",IFILE); f = $fopen("out_image_ind.list","w"); end

KEY_GENERATOR M1(RK,GENERATED,UK,GENERATE,RST,CLK);

always @(posedge CLK or negedge RST) 
if(~RST) begin GENERATE=1'b0; ADDRESS=20'b0; DONE=1'b0; P=64'b0; O=64'b0; UK=64'h8DA892B89C9E9F9A;   E=48'b0; end
else begin

GENERATE=1'b1;

if({GENERATED,DONE} == 2'b10) begin 
ADDRESS = ADDRESS + 20'b1; 
if(ADDRESS == CELLS + 1) begin DONE = 1'b1; $fclose(f); end 
P=IFILE[ADDRESS-20'b1];

O[0]=P[57]  ; O[1]=P[49]  ; O[2]=P[41]  ; O[3]=P[33]  ; O[4]=P[25]  ; O[5]=P[17]  ; O[6]=P[9]   ; O[7]=P[1]  ;
O[8]=P[59]  ; O[9]=P[51]  ; O[10]=P[43] ; O[11]=P[35] ; O[12]=P[27] ; O[13]=P[19] ; O[14]=P[11] ; O[15]=P[3] ;
O[16]=P[61] ; O[17]=P[53] ; O[18]=P[45] ; O[19]=P[37] ; O[20]=P[29] ; O[21]=P[21] ; O[22]=P[13] ; O[23]=P[5] ;
O[24]=P[63] ; O[25]=P[55] ; O[26]=P[47] ; O[27]=P[39] ; O[28]=P[31] ; O[29]=P[23] ; O[30]=P[15] ; O[31]=P[7] ;
O[32]=P[56] ; O[33]=P[48] ; O[34]=P[40] ; O[35]=P[32] ; O[36]=P[24] ; O[37]=P[16] ; O[38]=P[8]  ; O[39]=P[0] ;
O[40]=P[58] ; O[41]=P[50] ; O[42]=P[42] ; O[43]=P[34] ; O[44]=P[26] ; O[45]=P[18] ; O[46]=P[10] ; O[47]=P[2] ;
O[48]=P[60] ; O[49]=P[52] ; O[50]=P[44] ; O[51]=P[36] ; O[52]=P[28] ; O[53]=P[20] ; O[54]=P[12] ; O[55]=P[4] ;
O[56]=P[62] ; O[57]=P[54] ; O[58]=P[46] ; O[59]=P[38] ; O[60]=P[30] ; O[61]=P[22] ; O[62]=P[14] ; O[63]=P[6]  ;    
  
E[0]=O[63] ; E[1]=O[32]  ; E[2]=O[33]  ; E[3]=O[34]  ; E[4]=O[35]  ; E[5]=O[36]  ;
E[6]=O[35]  ; E[7]=O[36]  ; E[8]=O[37]  ; E[9]=O[38]  ; E[10]=O[39] ; E[11]=O[40] ;
E[12]=O[39] ; E[13]=O[40] ; E[14]=O[41] ; E[15]=O[42]; E[16]=O[43]; E[17]=O[44];
E[18]=O[43]; E[19]=O[44]; E[20]=O[45]; E[21]=O[46]; E[22]=O[47]; E[23]=O[48];
E[24]=O[47]; E[25]=O[48]; E[26]=O[49]; E[27]=O[50]; E[28]=O[51]; E[29]=O[52];
E[30]=O[51]; E[31]=O[52]; E[32]=O[53]; E[33]=O[54]; E[34]=O[55]; E[35]=O[56];
E[36]=O[55]; E[37]=O[56]; E[38]=O[57]; E[39]=O[58]; E[40]=O[59]; E[41]=O[60];
E[42]=O[59]; E[43]=O[60]; E[44]=O[61]; E[45]=O[62]; E[46]=O[63]; E[47]=O[32] ;
O1[0:31]=O[32:63];
E[0:47] = E[0:47]^RK[0:47];
O[32:35]=S[{{E[0],E[5]},E[1:4]}][0:3];  O[36:39]=S[{{E[6],E[11]},E[7:10]}][4:7];
O[40:43]=S[{{E[12],E[17]},E[13:16]}][8:11];  O[44:47]=S[{{E[18],E[23]},E[19:22]}][12:15];
O[48:51]=S[{{E[24],E[29]},E[25:28]}][16:19];  O[52:55]=S[{{E[30],E[35]},E[31:34]}][20:23];
O[56:59]=S[{{E[36],E[41]},E[37:40]}][24:27];  O[60:63]=S[{{E[42],E[47]},E[43:46]}][28:31];
O1[32]=O[47] ; O1[33]=O[38] ; O1[34]=O[51] ; O1[35]=O[52] ; O1[36]=O[60] ; O1[37]=O[43] ; O1[38]=O[59] ; O1[39]=O[48] ;
O1[40]=O[32] ; O1[41]=O[46] ; O1[42]=O[54] ; O1[43]=O[57] ; O1[44]=O[36] ; O1[45]=O[49] ; O1[46]=O[62] ; O1[47]=O[41] ;
O1[48]=O[33] ; O1[49]=O[39] ; O1[50]=O[55] ; O1[51]=O[45] ; O1[52]=O[63] ; O1[53]=O[58] ; O1[54]=O[34] ; O1[55]=O[40] ;
O1[56]=O[50] ; O1[57]=O[44] ; O1[58]=O[61] ; O1[59]=O[37] ; O1[60]=O[53] ; O1[61]=O[42] ; O1[62]=O[35] ; O1[63]=O[56] ;
O[32:63] = O1[32:63]^O[0:31];
O[0:31] = O1[0:31]; 

E[0]=O[63] ; E[1]=O[32]  ; E[2]=O[33]  ; E[3]=O[34]  ; E[4]=O[35]  ; E[5]=O[36]  ;
E[6]=O[35]  ; E[7]=O[36]  ; E[8]=O[37]  ; E[9]=O[38]  ; E[10]=O[39] ; E[11]=O[40] ;
E[12]=O[39] ; E[13]=O[40] ; E[14]=O[41] ; E[15]=O[42]; E[16]=O[43]; E[17]=O[44];
E[18]=O[43]; E[19]=O[44]; E[20]=O[45]; E[21]=O[46]; E[22]=O[47]; E[23]=O[48];
E[24]=O[47]; E[25]=O[48]; E[26]=O[49]; E[27]=O[50]; E[28]=O[51]; E[29]=O[52];
E[30]=O[51]; E[31]=O[52]; E[32]=O[53]; E[33]=O[54]; E[34]=O[55]; E[35]=O[56];
E[36]=O[55]; E[37]=O[56]; E[38]=O[57]; E[39]=O[58]; E[40]=O[59]; E[41]=O[60];
E[42]=O[59]; E[43]=O[60]; E[44]=O[61]; E[45]=O[62]; E[46]=O[63]; E[47]=O[32] ;
O1[0:31]=O[32:63];
E[0:47] = E[0:47]^RK[48:95];
O[32:35]=S[{{E[0],E[5]},E[1:4]}][0:3];  O[36:39]=S[{{E[6],E[11]},E[7:10]}][4:7];
O[40:43]=S[{{E[12],E[17]},E[13:16]}][8:11];  O[44:47]=S[{{E[18],E[23]},E[19:22]}][12:15];
O[48:51]=S[{{E[24],E[29]},E[25:28]}][16:19];  O[52:55]=S[{{E[30],E[35]},E[31:34]}][20:23];
O[56:59]=S[{{E[36],E[41]},E[37:40]}][24:27];  O[60:63]=S[{{E[42],E[47]},E[43:46]}][28:31];
O1[32]=O[47] ; O1[33]=O[38] ; O1[34]=O[51] ; O1[35]=O[52] ; O1[36]=O[60] ; O1[37]=O[43] ; O1[38]=O[59] ; O1[39]=O[48] ;
O1[40]=O[32] ; O1[41]=O[46] ; O1[42]=O[54] ; O1[43]=O[57] ; O1[44]=O[36] ; O1[45]=O[49] ; O1[46]=O[62] ; O1[47]=O[41] ;
O1[48]=O[33] ; O1[49]=O[39] ; O1[50]=O[55] ; O1[51]=O[45] ; O1[52]=O[63] ; O1[53]=O[58] ; O1[54]=O[34] ; O1[55]=O[40] ;
O1[56]=O[50] ; O1[57]=O[44] ; O1[58]=O[61] ; O1[59]=O[37] ; O1[60]=O[53] ; O1[61]=O[42] ; O1[62]=O[35] ; O1[63]=O[56] ;
O[32:63] = O1[32:63]^O[0:31];
O[0:31] = O1[0:31]; 

E[0]=O[63] ; E[1]=O[32]  ; E[2]=O[33]  ; E[3]=O[34]  ; E[4]=O[35]  ; E[5]=O[36]  ;
E[6]=O[35]  ; E[7]=O[36]  ; E[8]=O[37]  ; E[9]=O[38]  ; E[10]=O[39] ; E[11]=O[40] ;
E[12]=O[39] ; E[13]=O[40] ; E[14]=O[41] ; E[15]=O[42]; E[16]=O[43]; E[17]=O[44];
E[18]=O[43]; E[19]=O[44]; E[20]=O[45]; E[21]=O[46]; E[22]=O[47]; E[23]=O[48];
E[24]=O[47]; E[25]=O[48]; E[26]=O[49]; E[27]=O[50]; E[28]=O[51]; E[29]=O[52];
E[30]=O[51]; E[31]=O[52]; E[32]=O[53]; E[33]=O[54]; E[34]=O[55]; E[35]=O[56];
E[36]=O[55]; E[37]=O[56]; E[38]=O[57]; E[39]=O[58]; E[40]=O[59]; E[41]=O[60];
E[42]=O[59]; E[43]=O[60]; E[44]=O[61]; E[45]=O[62]; E[46]=O[63]; E[47]=O[32] ;
O1[0:31]=O[32:63];
E[0:47] = E[0:47]^RK[96:143];
O[32:35]=S[{{E[0],E[5]},E[1:4]}][0:3];  O[36:39]=S[{{E[6],E[11]},E[7:10]}][4:7];
O[40:43]=S[{{E[12],E[17]},E[13:16]}][8:11];  O[44:47]=S[{{E[18],E[23]},E[19:22]}][12:15];
O[48:51]=S[{{E[24],E[29]},E[25:28]}][16:19];  O[52:55]=S[{{E[30],E[35]},E[31:34]}][20:23];
O[56:59]=S[{{E[36],E[41]},E[37:40]}][24:27];  O[60:63]=S[{{E[42],E[47]},E[43:46]}][28:31];
O1[32]=O[47] ; O1[33]=O[38] ; O1[34]=O[51] ; O1[35]=O[52] ; O1[36]=O[60] ; O1[37]=O[43] ; O1[38]=O[59] ; O1[39]=O[48] ;
O1[40]=O[32] ; O1[41]=O[46] ; O1[42]=O[54] ; O1[43]=O[57] ; O1[44]=O[36] ; O1[45]=O[49] ; O1[46]=O[62] ; O1[47]=O[41] ;
O1[48]=O[33] ; O1[49]=O[39] ; O1[50]=O[55] ; O1[51]=O[45] ; O1[52]=O[63] ; O1[53]=O[58] ; O1[54]=O[34] ; O1[55]=O[40] ;
O1[56]=O[50] ; O1[57]=O[44] ; O1[58]=O[61] ; O1[59]=O[37] ; O1[60]=O[53] ; O1[61]=O[42] ; O1[62]=O[35] ; O1[63]=O[56] ;
O[32:63] = O1[32:63]^O[0:31];
O[0:31] = O1[0:31]; 

E[0]=O[63] ; E[1]=O[32]  ; E[2]=O[33]  ; E[3]=O[34]  ; E[4]=O[35]  ; E[5]=O[36]  ;
E[6]=O[35]  ; E[7]=O[36]  ; E[8]=O[37]  ; E[9]=O[38]  ; E[10]=O[39] ; E[11]=O[40] ;
E[12]=O[39] ; E[13]=O[40] ; E[14]=O[41] ; E[15]=O[42]; E[16]=O[43]; E[17]=O[44];
E[18]=O[43]; E[19]=O[44]; E[20]=O[45]; E[21]=O[46]; E[22]=O[47]; E[23]=O[48];
E[24]=O[47]; E[25]=O[48]; E[26]=O[49]; E[27]=O[50]; E[28]=O[51]; E[29]=O[52];
E[30]=O[51]; E[31]=O[52]; E[32]=O[53]; E[33]=O[54]; E[34]=O[55]; E[35]=O[56];
E[36]=O[55]; E[37]=O[56]; E[38]=O[57]; E[39]=O[58]; E[40]=O[59]; E[41]=O[60];
E[42]=O[59]; E[43]=O[60]; E[44]=O[61]; E[45]=O[62]; E[46]=O[63]; E[47]=O[32] ;
O1[0:31]=O[32:63];
E[0:47] = E[0:47]^RK[144:191];
O[32:35]=S[{{E[0],E[5]},E[1:4]}][0:3];  O[36:39]=S[{{E[6],E[11]},E[7:10]}][4:7];
O[40:43]=S[{{E[12],E[17]},E[13:16]}][8:11];  O[44:47]=S[{{E[18],E[23]},E[19:22]}][12:15];
O[48:51]=S[{{E[24],E[29]},E[25:28]}][16:19];  O[52:55]=S[{{E[30],E[35]},E[31:34]}][20:23];
O[56:59]=S[{{E[36],E[41]},E[37:40]}][24:27];  O[60:63]=S[{{E[42],E[47]},E[43:46]}][28:31];
O1[32]=O[47] ; O1[33]=O[38] ; O1[34]=O[51] ; O1[35]=O[52] ; O1[36]=O[60] ; O1[37]=O[43] ; O1[38]=O[59] ; O1[39]=O[48] ;
O1[40]=O[32] ; O1[41]=O[46] ; O1[42]=O[54] ; O1[43]=O[57] ; O1[44]=O[36] ; O1[45]=O[49] ; O1[46]=O[62] ; O1[47]=O[41] ;
O1[48]=O[33] ; O1[49]=O[39] ; O1[50]=O[55] ; O1[51]=O[45] ; O1[52]=O[63] ; O1[53]=O[58] ; O1[54]=O[34] ; O1[55]=O[40] ;
O1[56]=O[50] ; O1[57]=O[44] ; O1[58]=O[61] ; O1[59]=O[37] ; O1[60]=O[53] ; O1[61]=O[42] ; O1[62]=O[35] ; O1[63]=O[56] ;
O[32:63] = O1[32:63]^O[0:31];
O[0:31] = O1[0:31]; 

E[0]=O[63] ; E[1]=O[32]  ; E[2]=O[33]  ; E[3]=O[34]  ; E[4]=O[35]  ; E[5]=O[36]  ;
E[6]=O[35]  ; E[7]=O[36]  ; E[8]=O[37]  ; E[9]=O[38]  ; E[10]=O[39] ; E[11]=O[40] ;
E[12]=O[39] ; E[13]=O[40] ; E[14]=O[41] ; E[15]=O[42]; E[16]=O[43]; E[17]=O[44];
E[18]=O[43]; E[19]=O[44]; E[20]=O[45]; E[21]=O[46]; E[22]=O[47]; E[23]=O[48];
E[24]=O[47]; E[25]=O[48]; E[26]=O[49]; E[27]=O[50]; E[28]=O[51]; E[29]=O[52];
E[30]=O[51]; E[31]=O[52]; E[32]=O[53]; E[33]=O[54]; E[34]=O[55]; E[35]=O[56];
E[36]=O[55]; E[37]=O[56]; E[38]=O[57]; E[39]=O[58]; E[40]=O[59]; E[41]=O[60];
E[42]=O[59]; E[43]=O[60]; E[44]=O[61]; E[45]=O[62]; E[46]=O[63]; E[47]=O[32] ;
O1[0:31]=O[32:63];
E[0:47] = E[0:47]^RK[192:239];
O[32:35]=S[{{E[0],E[5]},E[1:4]}][0:3];  O[36:39]=S[{{E[6],E[11]},E[7:10]}][4:7];
O[40:43]=S[{{E[12],E[17]},E[13:16]}][8:11];  O[44:47]=S[{{E[18],E[23]},E[19:22]}][12:15];
O[48:51]=S[{{E[24],E[29]},E[25:28]}][16:19];  O[52:55]=S[{{E[30],E[35]},E[31:34]}][20:23];
O[56:59]=S[{{E[36],E[41]},E[37:40]}][24:27];  O[60:63]=S[{{E[42],E[47]},E[43:46]}][28:31];
O1[32]=O[47] ; O1[33]=O[38] ; O1[34]=O[51] ; O1[35]=O[52] ; O1[36]=O[60] ; O1[37]=O[43] ; O1[38]=O[59] ; O1[39]=O[48] ;
O1[40]=O[32] ; O1[41]=O[46] ; O1[42]=O[54] ; O1[43]=O[57] ; O1[44]=O[36] ; O1[45]=O[49] ; O1[46]=O[62] ; O1[47]=O[41] ;
O1[48]=O[33] ; O1[49]=O[39] ; O1[50]=O[55] ; O1[51]=O[45] ; O1[52]=O[63] ; O1[53]=O[58] ; O1[54]=O[34] ; O1[55]=O[40] ;
O1[56]=O[50] ; O1[57]=O[44] ; O1[58]=O[61] ; O1[59]=O[37] ; O1[60]=O[53] ; O1[61]=O[42] ; O1[62]=O[35] ; O1[63]=O[56] ;
O[32:63] = O1[32:63]^O[0:31];
O[0:31] = O1[0:31]; 

E[0]=O[63] ; E[1]=O[32]  ; E[2]=O[33]  ; E[3]=O[34]  ; E[4]=O[35]  ; E[5]=O[36]  ;
E[6]=O[35]  ; E[7]=O[36]  ; E[8]=O[37]  ; E[9]=O[38]  ; E[10]=O[39] ; E[11]=O[40] ;
E[12]=O[39] ; E[13]=O[40] ; E[14]=O[41] ; E[15]=O[42]; E[16]=O[43]; E[17]=O[44];
E[18]=O[43]; E[19]=O[44]; E[20]=O[45]; E[21]=O[46]; E[22]=O[47]; E[23]=O[48];
E[24]=O[47]; E[25]=O[48]; E[26]=O[49]; E[27]=O[50]; E[28]=O[51]; E[29]=O[52];
E[30]=O[51]; E[31]=O[52]; E[32]=O[53]; E[33]=O[54]; E[34]=O[55]; E[35]=O[56];
E[36]=O[55]; E[37]=O[56]; E[38]=O[57]; E[39]=O[58]; E[40]=O[59]; E[41]=O[60];
E[42]=O[59]; E[43]=O[60]; E[44]=O[61]; E[45]=O[62]; E[46]=O[63]; E[47]=O[32] ;
O1[0:31]=O[32:63];
E[0:47] = E[0:47]^RK[240:287];
O[32:35]=S[{{E[0],E[5]},E[1:4]}][0:3];  O[36:39]=S[{{E[6],E[11]},E[7:10]}][4:7];
O[40:43]=S[{{E[12],E[17]},E[13:16]}][8:11];  O[44:47]=S[{{E[18],E[23]},E[19:22]}][12:15];
O[48:51]=S[{{E[24],E[29]},E[25:28]}][16:19];  O[52:55]=S[{{E[30],E[35]},E[31:34]}][20:23];
O[56:59]=S[{{E[36],E[41]},E[37:40]}][24:27];  O[60:63]=S[{{E[42],E[47]},E[43:46]}][28:31];
O1[32]=O[47] ; O1[33]=O[38] ; O1[34]=O[51] ; O1[35]=O[52] ; O1[36]=O[60] ; O1[37]=O[43] ; O1[38]=O[59] ; O1[39]=O[48] ;
O1[40]=O[32] ; O1[41]=O[46] ; O1[42]=O[54] ; O1[43]=O[57] ; O1[44]=O[36] ; O1[45]=O[49] ; O1[46]=O[62] ; O1[47]=O[41] ;
O1[48]=O[33] ; O1[49]=O[39] ; O1[50]=O[55] ; O1[51]=O[45] ; O1[52]=O[63] ; O1[53]=O[58] ; O1[54]=O[34] ; O1[55]=O[40] ;
O1[56]=O[50] ; O1[57]=O[44] ; O1[58]=O[61] ; O1[59]=O[37] ; O1[60]=O[53] ; O1[61]=O[42] ; O1[62]=O[35] ; O1[63]=O[56] ;
O[32:63] = O1[32:63]^O[0:31];
O[0:31] = O1[0:31]; 

E[0]=O[63] ; E[1]=O[32]  ; E[2]=O[33]  ; E[3]=O[34]  ; E[4]=O[35]  ; E[5]=O[36]  ;
E[6]=O[35]  ; E[7]=O[36]  ; E[8]=O[37]  ; E[9]=O[38]  ; E[10]=O[39] ; E[11]=O[40] ;
E[12]=O[39] ; E[13]=O[40] ; E[14]=O[41] ; E[15]=O[42]; E[16]=O[43]; E[17]=O[44];
E[18]=O[43]; E[19]=O[44]; E[20]=O[45]; E[21]=O[46]; E[22]=O[47]; E[23]=O[48];
E[24]=O[47]; E[25]=O[48]; E[26]=O[49]; E[27]=O[50]; E[28]=O[51]; E[29]=O[52];
E[30]=O[51]; E[31]=O[52]; E[32]=O[53]; E[33]=O[54]; E[34]=O[55]; E[35]=O[56];
E[36]=O[55]; E[37]=O[56]; E[38]=O[57]; E[39]=O[58]; E[40]=O[59]; E[41]=O[60];
E[42]=O[59]; E[43]=O[60]; E[44]=O[61]; E[45]=O[62]; E[46]=O[63]; E[47]=O[32] ;
O1[0:31]=O[32:63];
E[0:47] = E[0:47]^RK[288:335];
O[32:35]=S[{{E[0],E[5]},E[1:4]}][0:3];  O[36:39]=S[{{E[6],E[11]},E[7:10]}][4:7];
O[40:43]=S[{{E[12],E[17]},E[13:16]}][8:11];  O[44:47]=S[{{E[18],E[23]},E[19:22]}][12:15];
O[48:51]=S[{{E[24],E[29]},E[25:28]}][16:19];  O[52:55]=S[{{E[30],E[35]},E[31:34]}][20:23];
O[56:59]=S[{{E[36],E[41]},E[37:40]}][24:27];  O[60:63]=S[{{E[42],E[47]},E[43:46]}][28:31];
O1[32]=O[47] ; O1[33]=O[38] ; O1[34]=O[51] ; O1[35]=O[52] ; O1[36]=O[60] ; O1[37]=O[43] ; O1[38]=O[59] ; O1[39]=O[48] ;
O1[40]=O[32] ; O1[41]=O[46] ; O1[42]=O[54] ; O1[43]=O[57] ; O1[44]=O[36] ; O1[45]=O[49] ; O1[46]=O[62] ; O1[47]=O[41] ;
O1[48]=O[33] ; O1[49]=O[39] ; O1[50]=O[55] ; O1[51]=O[45] ; O1[52]=O[63] ; O1[53]=O[58] ; O1[54]=O[34] ; O1[55]=O[40] ;
O1[56]=O[50] ; O1[57]=O[44] ; O1[58]=O[61] ; O1[59]=O[37] ; O1[60]=O[53] ; O1[61]=O[42] ; O1[62]=O[35] ; O1[63]=O[56] ;
O[32:63] = O1[32:63]^O[0:31];
O[0:31] = O1[0:31]; 

E[0]=O[63] ; E[1]=O[32]  ; E[2]=O[33]  ; E[3]=O[34]  ; E[4]=O[35]  ; E[5]=O[36]  ;
E[6]=O[35]  ; E[7]=O[36]  ; E[8]=O[37]  ; E[9]=O[38]  ; E[10]=O[39] ; E[11]=O[40] ;
E[12]=O[39] ; E[13]=O[40] ; E[14]=O[41] ; E[15]=O[42]; E[16]=O[43]; E[17]=O[44];
E[18]=O[43]; E[19]=O[44]; E[20]=O[45]; E[21]=O[46]; E[22]=O[47]; E[23]=O[48];
E[24]=O[47]; E[25]=O[48]; E[26]=O[49]; E[27]=O[50]; E[28]=O[51]; E[29]=O[52];
E[30]=O[51]; E[31]=O[52]; E[32]=O[53]; E[33]=O[54]; E[34]=O[55]; E[35]=O[56];
E[36]=O[55]; E[37]=O[56]; E[38]=O[57]; E[39]=O[58]; E[40]=O[59]; E[41]=O[60];
E[42]=O[59]; E[43]=O[60]; E[44]=O[61]; E[45]=O[62]; E[46]=O[63]; E[47]=O[32] ;
O1[0:31]=O[32:63];
E[0:47] = E[0:47]^RK[336:383];
O[32:35]=S[{{E[0],E[5]},E[1:4]}][0:3];  O[36:39]=S[{{E[6],E[11]},E[7:10]}][4:7];
O[40:43]=S[{{E[12],E[17]},E[13:16]}][8:11];  O[44:47]=S[{{E[18],E[23]},E[19:22]}][12:15];
O[48:51]=S[{{E[24],E[29]},E[25:28]}][16:19];  O[52:55]=S[{{E[30],E[35]},E[31:34]}][20:23];
O[56:59]=S[{{E[36],E[41]},E[37:40]}][24:27];  O[60:63]=S[{{E[42],E[47]},E[43:46]}][28:31];
O1[32]=O[47] ; O1[33]=O[38] ; O1[34]=O[51] ; O1[35]=O[52] ; O1[36]=O[60] ; O1[37]=O[43] ; O1[38]=O[59] ; O1[39]=O[48] ;
O1[40]=O[32] ; O1[41]=O[46] ; O1[42]=O[54] ; O1[43]=O[57] ; O1[44]=O[36] ; O1[45]=O[49] ; O1[46]=O[62] ; O1[47]=O[41] ;
O1[48]=O[33] ; O1[49]=O[39] ; O1[50]=O[55] ; O1[51]=O[45] ; O1[52]=O[63] ; O1[53]=O[58] ; O1[54]=O[34] ; O1[55]=O[40] ;
O1[56]=O[50] ; O1[57]=O[44] ; O1[58]=O[61] ; O1[59]=O[37] ; O1[60]=O[53] ; O1[61]=O[42] ; O1[62]=O[35] ; O1[63]=O[56] ;
O[32:63] = O1[32:63]^O[0:31];
O[0:31] = O1[0:31]; 

E[0]=O[63] ; E[1]=O[32]  ; E[2]=O[33]  ; E[3]=O[34]  ; E[4]=O[35]  ; E[5]=O[36]  ;
E[6]=O[35]  ; E[7]=O[36]  ; E[8]=O[37]  ; E[9]=O[38]  ; E[10]=O[39] ; E[11]=O[40] ;
E[12]=O[39] ; E[13]=O[40] ; E[14]=O[41] ; E[15]=O[42]; E[16]=O[43]; E[17]=O[44];
E[18]=O[43]; E[19]=O[44]; E[20]=O[45]; E[21]=O[46]; E[22]=O[47]; E[23]=O[48];
E[24]=O[47]; E[25]=O[48]; E[26]=O[49]; E[27]=O[50]; E[28]=O[51]; E[29]=O[52];
E[30]=O[51]; E[31]=O[52]; E[32]=O[53]; E[33]=O[54]; E[34]=O[55]; E[35]=O[56];
E[36]=O[55]; E[37]=O[56]; E[38]=O[57]; E[39]=O[58]; E[40]=O[59]; E[41]=O[60];
E[42]=O[59]; E[43]=O[60]; E[44]=O[61]; E[45]=O[62]; E[46]=O[63]; E[47]=O[32] ;
O1[0:31]=O[32:63];
E[0:47] = E[0:47]^RK[384:431];
O[32:35]=S[{{E[0],E[5]},E[1:4]}][0:3];  O[36:39]=S[{{E[6],E[11]},E[7:10]}][4:7];
O[40:43]=S[{{E[12],E[17]},E[13:16]}][8:11];  O[44:47]=S[{{E[18],E[23]},E[19:22]}][12:15];
O[48:51]=S[{{E[24],E[29]},E[25:28]}][16:19];  O[52:55]=S[{{E[30],E[35]},E[31:34]}][20:23];
O[56:59]=S[{{E[36],E[41]},E[37:40]}][24:27];  O[60:63]=S[{{E[42],E[47]},E[43:46]}][28:31];
O1[32]=O[47] ; O1[33]=O[38] ; O1[34]=O[51] ; O1[35]=O[52] ; O1[36]=O[60] ; O1[37]=O[43] ; O1[38]=O[59] ; O1[39]=O[48] ;
O1[40]=O[32] ; O1[41]=O[46] ; O1[42]=O[54] ; O1[43]=O[57] ; O1[44]=O[36] ; O1[45]=O[49] ; O1[46]=O[62] ; O1[47]=O[41] ;
O1[48]=O[33] ; O1[49]=O[39] ; O1[50]=O[55] ; O1[51]=O[45] ; O1[52]=O[63] ; O1[53]=O[58] ; O1[54]=O[34] ; O1[55]=O[40] ;
O1[56]=O[50] ; O1[57]=O[44] ; O1[58]=O[61] ; O1[59]=O[37] ; O1[60]=O[53] ; O1[61]=O[42] ; O1[62]=O[35] ; O1[63]=O[56] ;
O[32:63] = O1[32:63]^O[0:31];
O[0:31] = O1[0:31]; 

E[0]=O[63] ; E[1]=O[32]  ; E[2]=O[33]  ; E[3]=O[34]  ; E[4]=O[35]  ; E[5]=O[36]  ;
E[6]=O[35]  ; E[7]=O[36]  ; E[8]=O[37]  ; E[9]=O[38]  ; E[10]=O[39] ; E[11]=O[40] ;
E[12]=O[39] ; E[13]=O[40] ; E[14]=O[41] ; E[15]=O[42]; E[16]=O[43]; E[17]=O[44];
E[18]=O[43]; E[19]=O[44]; E[20]=O[45]; E[21]=O[46]; E[22]=O[47]; E[23]=O[48];
E[24]=O[47]; E[25]=O[48]; E[26]=O[49]; E[27]=O[50]; E[28]=O[51]; E[29]=O[52];
E[30]=O[51]; E[31]=O[52]; E[32]=O[53]; E[33]=O[54]; E[34]=O[55]; E[35]=O[56];
E[36]=O[55]; E[37]=O[56]; E[38]=O[57]; E[39]=O[58]; E[40]=O[59]; E[41]=O[60];
E[42]=O[59]; E[43]=O[60]; E[44]=O[61]; E[45]=O[62]; E[46]=O[63]; E[47]=O[32] ;
O1[0:31]=O[32:63];
E[0:47] = E[0:47]^RK[432:479];
O[32:35]=S[{{E[0],E[5]},E[1:4]}][0:3];  O[36:39]=S[{{E[6],E[11]},E[7:10]}][4:7];
O[40:43]=S[{{E[12],E[17]},E[13:16]}][8:11];  O[44:47]=S[{{E[18],E[23]},E[19:22]}][12:15];
O[48:51]=S[{{E[24],E[29]},E[25:28]}][16:19];  O[52:55]=S[{{E[30],E[35]},E[31:34]}][20:23];
O[56:59]=S[{{E[36],E[41]},E[37:40]}][24:27];  O[60:63]=S[{{E[42],E[47]},E[43:46]}][28:31];
O1[32]=O[47] ; O1[33]=O[38] ; O1[34]=O[51] ; O1[35]=O[52] ; O1[36]=O[60] ; O1[37]=O[43] ; O1[38]=O[59] ; O1[39]=O[48] ;
O1[40]=O[32] ; O1[41]=O[46] ; O1[42]=O[54] ; O1[43]=O[57] ; O1[44]=O[36] ; O1[45]=O[49] ; O1[46]=O[62] ; O1[47]=O[41] ;
O1[48]=O[33] ; O1[49]=O[39] ; O1[50]=O[55] ; O1[51]=O[45] ; O1[52]=O[63] ; O1[53]=O[58] ; O1[54]=O[34] ; O1[55]=O[40] ;
O1[56]=O[50] ; O1[57]=O[44] ; O1[58]=O[61] ; O1[59]=O[37] ; O1[60]=O[53] ; O1[61]=O[42] ; O1[62]=O[35] ; O1[63]=O[56] ;
O[32:63] = O1[32:63]^O[0:31];
O[0:31] = O1[0:31]; 

E[0]=O[63] ; E[1]=O[32]  ; E[2]=O[33]  ; E[3]=O[34]  ; E[4]=O[35]  ; E[5]=O[36]  ;
E[6]=O[35]  ; E[7]=O[36]  ; E[8]=O[37]  ; E[9]=O[38]  ; E[10]=O[39] ; E[11]=O[40] ;
E[12]=O[39] ; E[13]=O[40] ; E[14]=O[41] ; E[15]=O[42]; E[16]=O[43]; E[17]=O[44];
E[18]=O[43]; E[19]=O[44]; E[20]=O[45]; E[21]=O[46]; E[22]=O[47]; E[23]=O[48];
E[24]=O[47]; E[25]=O[48]; E[26]=O[49]; E[27]=O[50]; E[28]=O[51]; E[29]=O[52];
E[30]=O[51]; E[31]=O[52]; E[32]=O[53]; E[33]=O[54]; E[34]=O[55]; E[35]=O[56];
E[36]=O[55]; E[37]=O[56]; E[38]=O[57]; E[39]=O[58]; E[40]=O[59]; E[41]=O[60];
E[42]=O[59]; E[43]=O[60]; E[44]=O[61]; E[45]=O[62]; E[46]=O[63]; E[47]=O[32] ;
O1[0:31]=O[32:63];
E[0:47] = E[0:47]^RK[480:527];
O[32:35]=S[{{E[0],E[5]},E[1:4]}][0:3];  O[36:39]=S[{{E[6],E[11]},E[7:10]}][4:7];
O[40:43]=S[{{E[12],E[17]},E[13:16]}][8:11];  O[44:47]=S[{{E[18],E[23]},E[19:22]}][12:15];
O[48:51]=S[{{E[24],E[29]},E[25:28]}][16:19];  O[52:55]=S[{{E[30],E[35]},E[31:34]}][20:23];
O[56:59]=S[{{E[36],E[41]},E[37:40]}][24:27];  O[60:63]=S[{{E[42],E[47]},E[43:46]}][28:31];
O1[32]=O[47] ; O1[33]=O[38] ; O1[34]=O[51] ; O1[35]=O[52] ; O1[36]=O[60] ; O1[37]=O[43] ; O1[38]=O[59] ; O1[39]=O[48] ;
O1[40]=O[32] ; O1[41]=O[46] ; O1[42]=O[54] ; O1[43]=O[57] ; O1[44]=O[36] ; O1[45]=O[49] ; O1[46]=O[62] ; O1[47]=O[41] ;
O1[48]=O[33] ; O1[49]=O[39] ; O1[50]=O[55] ; O1[51]=O[45] ; O1[52]=O[63] ; O1[53]=O[58] ; O1[54]=O[34] ; O1[55]=O[40] ;
O1[56]=O[50] ; O1[57]=O[44] ; O1[58]=O[61] ; O1[59]=O[37] ; O1[60]=O[53] ; O1[61]=O[42] ; O1[62]=O[35] ; O1[63]=O[56] ;
O[32:63] = O1[32:63]^O[0:31];
O[0:31] = O1[0:31]; 

E[0]=O[63] ; E[1]=O[32]  ; E[2]=O[33]  ; E[3]=O[34]  ; E[4]=O[35]  ; E[5]=O[36]  ;
E[6]=O[35]  ; E[7]=O[36]  ; E[8]=O[37]  ; E[9]=O[38]  ; E[10]=O[39] ; E[11]=O[40] ;
E[12]=O[39] ; E[13]=O[40] ; E[14]=O[41] ; E[15]=O[42]; E[16]=O[43]; E[17]=O[44];
E[18]=O[43]; E[19]=O[44]; E[20]=O[45]; E[21]=O[46]; E[22]=O[47]; E[23]=O[48];
E[24]=O[47]; E[25]=O[48]; E[26]=O[49]; E[27]=O[50]; E[28]=O[51]; E[29]=O[52];
E[30]=O[51]; E[31]=O[52]; E[32]=O[53]; E[33]=O[54]; E[34]=O[55]; E[35]=O[56];
E[36]=O[55]; E[37]=O[56]; E[38]=O[57]; E[39]=O[58]; E[40]=O[59]; E[41]=O[60];
E[42]=O[59]; E[43]=O[60]; E[44]=O[61]; E[45]=O[62]; E[46]=O[63]; E[47]=O[32] ;
O1[0:31]=O[32:63];
E[0:47] = E[0:47]^RK[528:575];
O[32:35]=S[{{E[0],E[5]},E[1:4]}][0:3];  O[36:39]=S[{{E[6],E[11]},E[7:10]}][4:7];
O[40:43]=S[{{E[12],E[17]},E[13:16]}][8:11];  O[44:47]=S[{{E[18],E[23]},E[19:22]}][12:15];
O[48:51]=S[{{E[24],E[29]},E[25:28]}][16:19];  O[52:55]=S[{{E[30],E[35]},E[31:34]}][20:23];
O[56:59]=S[{{E[36],E[41]},E[37:40]}][24:27];  O[60:63]=S[{{E[42],E[47]},E[43:46]}][28:31];
O1[32]=O[47] ; O1[33]=O[38] ; O1[34]=O[51] ; O1[35]=O[52] ; O1[36]=O[60] ; O1[37]=O[43] ; O1[38]=O[59] ; O1[39]=O[48] ;
O1[40]=O[32] ; O1[41]=O[46] ; O1[42]=O[54] ; O1[43]=O[57] ; O1[44]=O[36] ; O1[45]=O[49] ; O1[46]=O[62] ; O1[47]=O[41] ;
O1[48]=O[33] ; O1[49]=O[39] ; O1[50]=O[55] ; O1[51]=O[45] ; O1[52]=O[63] ; O1[53]=O[58] ; O1[54]=O[34] ; O1[55]=O[40] ;
O1[56]=O[50] ; O1[57]=O[44] ; O1[58]=O[61] ; O1[59]=O[37] ; O1[60]=O[53] ; O1[61]=O[42] ; O1[62]=O[35] ; O1[63]=O[56] ;
O[32:63] = O1[32:63]^O[0:31];
O[0:31] = O1[0:31]; 

E[0]=O[63] ; E[1]=O[32]  ; E[2]=O[33]  ; E[3]=O[34]  ; E[4]=O[35]  ; E[5]=O[36]  ;
E[6]=O[35]  ; E[7]=O[36]  ; E[8]=O[37]  ; E[9]=O[38]  ; E[10]=O[39] ; E[11]=O[40] ;
E[12]=O[39] ; E[13]=O[40] ; E[14]=O[41] ; E[15]=O[42]; E[16]=O[43]; E[17]=O[44];
E[18]=O[43]; E[19]=O[44]; E[20]=O[45]; E[21]=O[46]; E[22]=O[47]; E[23]=O[48];
E[24]=O[47]; E[25]=O[48]; E[26]=O[49]; E[27]=O[50]; E[28]=O[51]; E[29]=O[52];
E[30]=O[51]; E[31]=O[52]; E[32]=O[53]; E[33]=O[54]; E[34]=O[55]; E[35]=O[56];
E[36]=O[55]; E[37]=O[56]; E[38]=O[57]; E[39]=O[58]; E[40]=O[59]; E[41]=O[60];
E[42]=O[59]; E[43]=O[60]; E[44]=O[61]; E[45]=O[62]; E[46]=O[63]; E[47]=O[32] ;
O1[0:31]=O[32:63];
E[0:47] = E[0:47]^RK[576:623];
O[32:35]=S[{{E[0],E[5]},E[1:4]}][0:3];  O[36:39]=S[{{E[6],E[11]},E[7:10]}][4:7];
O[40:43]=S[{{E[12],E[17]},E[13:16]}][8:11];  O[44:47]=S[{{E[18],E[23]},E[19:22]}][12:15];
O[48:51]=S[{{E[24],E[29]},E[25:28]}][16:19];  O[52:55]=S[{{E[30],E[35]},E[31:34]}][20:23];
O[56:59]=S[{{E[36],E[41]},E[37:40]}][24:27];  O[60:63]=S[{{E[42],E[47]},E[43:46]}][28:31];
O1[32]=O[47] ; O1[33]=O[38] ; O1[34]=O[51] ; O1[35]=O[52] ; O1[36]=O[60] ; O1[37]=O[43] ; O1[38]=O[59] ; O1[39]=O[48] ;
O1[40]=O[32] ; O1[41]=O[46] ; O1[42]=O[54] ; O1[43]=O[57] ; O1[44]=O[36] ; O1[45]=O[49] ; O1[46]=O[62] ; O1[47]=O[41] ;
O1[48]=O[33] ; O1[49]=O[39] ; O1[50]=O[55] ; O1[51]=O[45] ; O1[52]=O[63] ; O1[53]=O[58] ; O1[54]=O[34] ; O1[55]=O[40] ;
O1[56]=O[50] ; O1[57]=O[44] ; O1[58]=O[61] ; O1[59]=O[37] ; O1[60]=O[53] ; O1[61]=O[42] ; O1[62]=O[35] ; O1[63]=O[56] ;
O[32:63] = O1[32:63]^O[0:31];
O[0:31] = O1[0:31]; 

E[0]=O[63] ; E[1]=O[32]  ; E[2]=O[33]  ; E[3]=O[34]  ; E[4]=O[35]  ; E[5]=O[36]  ;
E[6]=O[35]  ; E[7]=O[36]  ; E[8]=O[37]  ; E[9]=O[38]  ; E[10]=O[39] ; E[11]=O[40] ;
E[12]=O[39] ; E[13]=O[40] ; E[14]=O[41] ; E[15]=O[42]; E[16]=O[43]; E[17]=O[44];
E[18]=O[43]; E[19]=O[44]; E[20]=O[45]; E[21]=O[46]; E[22]=O[47]; E[23]=O[48];
E[24]=O[47]; E[25]=O[48]; E[26]=O[49]; E[27]=O[50]; E[28]=O[51]; E[29]=O[52];
E[30]=O[51]; E[31]=O[52]; E[32]=O[53]; E[33]=O[54]; E[34]=O[55]; E[35]=O[56];
E[36]=O[55]; E[37]=O[56]; E[38]=O[57]; E[39]=O[58]; E[40]=O[59]; E[41]=O[60];
E[42]=O[59]; E[43]=O[60]; E[44]=O[61]; E[45]=O[62]; E[46]=O[63]; E[47]=O[32] ;
O1[0:31]=O[32:63];
E[0:47] = E[0:47]^RK[624:671];
O[32:35]=S[{{E[0],E[5]},E[1:4]}][0:3];  O[36:39]=S[{{E[6],E[11]},E[7:10]}][4:7];
O[40:43]=S[{{E[12],E[17]},E[13:16]}][8:11];  O[44:47]=S[{{E[18],E[23]},E[19:22]}][12:15];
O[48:51]=S[{{E[24],E[29]},E[25:28]}][16:19];  O[52:55]=S[{{E[30],E[35]},E[31:34]}][20:23];
O[56:59]=S[{{E[36],E[41]},E[37:40]}][24:27];  O[60:63]=S[{{E[42],E[47]},E[43:46]}][28:31];
O1[32]=O[47] ; O1[33]=O[38] ; O1[34]=O[51] ; O1[35]=O[52] ; O1[36]=O[60] ; O1[37]=O[43] ; O1[38]=O[59] ; O1[39]=O[48] ;
O1[40]=O[32] ; O1[41]=O[46] ; O1[42]=O[54] ; O1[43]=O[57] ; O1[44]=O[36] ; O1[45]=O[49] ; O1[46]=O[62] ; O1[47]=O[41] ;
O1[48]=O[33] ; O1[49]=O[39] ; O1[50]=O[55] ; O1[51]=O[45] ; O1[52]=O[63] ; O1[53]=O[58] ; O1[54]=O[34] ; O1[55]=O[40] ;
O1[56]=O[50] ; O1[57]=O[44] ; O1[58]=O[61] ; O1[59]=O[37] ; O1[60]=O[53] ; O1[61]=O[42] ; O1[62]=O[35] ; O1[63]=O[56] ;
O[32:63] = O1[32:63]^O[0:31];
O[0:31] = O1[0:31]; 

E[0]=O[63] ; E[1]=O[32]  ; E[2]=O[33]  ; E[3]=O[34]  ; E[4]=O[35]  ; E[5]=O[36]  ;
E[6]=O[35]  ; E[7]=O[36]  ; E[8]=O[37]  ; E[9]=O[38]  ; E[10]=O[39] ; E[11]=O[40] ;
E[12]=O[39] ; E[13]=O[40] ; E[14]=O[41] ; E[15]=O[42]; E[16]=O[43]; E[17]=O[44];
E[18]=O[43]; E[19]=O[44]; E[20]=O[45]; E[21]=O[46]; E[22]=O[47]; E[23]=O[48];
E[24]=O[47]; E[25]=O[48]; E[26]=O[49]; E[27]=O[50]; E[28]=O[51]; E[29]=O[52];
E[30]=O[51]; E[31]=O[52]; E[32]=O[53]; E[33]=O[54]; E[34]=O[55]; E[35]=O[56];
E[36]=O[55]; E[37]=O[56]; E[38]=O[57]; E[39]=O[58]; E[40]=O[59]; E[41]=O[60];
E[42]=O[59]; E[43]=O[60]; E[44]=O[61]; E[45]=O[62]; E[46]=O[63]; E[47]=O[32] ;
O1[0:31]=O[32:63];
E[0:47] = E[0:47]^RK[672:719];
O[32:35]=S[{{E[0],E[5]},E[1:4]}][0:3];  O[36:39]=S[{{E[6],E[11]},E[7:10]}][4:7];
O[40:43]=S[{{E[12],E[17]},E[13:16]}][8:11];  O[44:47]=S[{{E[18],E[23]},E[19:22]}][12:15];
O[48:51]=S[{{E[24],E[29]},E[25:28]}][16:19];  O[52:55]=S[{{E[30],E[35]},E[31:34]}][20:23];
O[56:59]=S[{{E[36],E[41]},E[37:40]}][24:27];  O[60:63]=S[{{E[42],E[47]},E[43:46]}][28:31];
O1[32]=O[47] ; O1[33]=O[38] ; O1[34]=O[51] ; O1[35]=O[52] ; O1[36]=O[60] ; O1[37]=O[43] ; O1[38]=O[59] ; O1[39]=O[48] ;
O1[40]=O[32] ; O1[41]=O[46] ; O1[42]=O[54] ; O1[43]=O[57] ; O1[44]=O[36] ; O1[45]=O[49] ; O1[46]=O[62] ; O1[47]=O[41] ;
O1[48]=O[33] ; O1[49]=O[39] ; O1[50]=O[55] ; O1[51]=O[45] ; O1[52]=O[63] ; O1[53]=O[58] ; O1[54]=O[34] ; O1[55]=O[40] ;
O1[56]=O[50] ; O1[57]=O[44] ; O1[58]=O[61] ; O1[59]=O[37] ; O1[60]=O[53] ; O1[61]=O[42] ; O1[62]=O[35] ; O1[63]=O[56] ;
O[32:63] = O1[32:63]^O[0:31];
O[0:31] = O1[0:31]; 

E[0]=O[63] ; E[1]=O[32]  ; E[2]=O[33]  ; E[3]=O[34]  ; E[4]=O[35]  ; E[5]=O[36]  ;
E[6]=O[35]  ; E[7]=O[36]  ; E[8]=O[37]  ; E[9]=O[38]  ; E[10]=O[39] ; E[11]=O[40] ;
E[12]=O[39] ; E[13]=O[40] ; E[14]=O[41] ; E[15]=O[42]; E[16]=O[43]; E[17]=O[44];
E[18]=O[43]; E[19]=O[44]; E[20]=O[45]; E[21]=O[46]; E[22]=O[47]; E[23]=O[48];
E[24]=O[47]; E[25]=O[48]; E[26]=O[49]; E[27]=O[50]; E[28]=O[51]; E[29]=O[52];
E[30]=O[51]; E[31]=O[52]; E[32]=O[53]; E[33]=O[54]; E[34]=O[55]; E[35]=O[56];
E[36]=O[55]; E[37]=O[56]; E[38]=O[57]; E[39]=O[58]; E[40]=O[59]; E[41]=O[60];
E[42]=O[59]; E[43]=O[60]; E[44]=O[61]; E[45]=O[62]; E[46]=O[63]; E[47]=O[32] ;
O1[0:31]=O[32:63];
E[0:47] = E[0:47]^RK[720:767];
O[32:35]=S[{{E[0],E[5]},E[1:4]}][0:3];  O[36:39]=S[{{E[6],E[11]},E[7:10]}][4:7];
O[40:43]=S[{{E[12],E[17]},E[13:16]}][8:11];  O[44:47]=S[{{E[18],E[23]},E[19:22]}][12:15];
O[48:51]=S[{{E[24],E[29]},E[25:28]}][16:19];  O[52:55]=S[{{E[30],E[35]},E[31:34]}][20:23];
O[56:59]=S[{{E[36],E[41]},E[37:40]}][24:27];  O[60:63]=S[{{E[42],E[47]},E[43:46]}][28:31];
O1[32]=O[47] ; O1[33]=O[38] ; O1[34]=O[51] ; O1[35]=O[52] ; O1[36]=O[60] ; O1[37]=O[43] ; O1[38]=O[59] ; O1[39]=O[48] ;
O1[40]=O[32] ; O1[41]=O[46] ; O1[42]=O[54] ; O1[43]=O[57] ; O1[44]=O[36] ; O1[45]=O[49] ; O1[46]=O[62] ; O1[47]=O[41] ;
O1[48]=O[33] ; O1[49]=O[39] ; O1[50]=O[55] ; O1[51]=O[45] ; O1[52]=O[63] ; O1[53]=O[58] ; O1[54]=O[34] ; O1[55]=O[40] ;
O1[56]=O[50] ; O1[57]=O[44] ; O1[58]=O[61] ; O1[59]=O[37] ; O1[60]=O[53] ; O1[61]=O[42] ; O1[62]=O[35] ; O1[63]=O[56] ;
O[0:31] = O1[32:63]^O[0:31];
O[32:63] = O1[0:31]; 

O1[0]=O[39]  ; O1[1]=O[7]  ; O1[2]=O[47]  ; O1[3]=O[15]  ; O1[4]=O[55]  ; O1[5]=O[23]  ; O1[6]=O[63]  ; O1[7]=O[31]  ;
O1[8]=O[38]  ; O1[9]=O[6]  ; O1[10]=O[46] ; O1[11]=O[14] ; O1[12]=O[54] ; O1[13]=O[22] ; O1[14]=O[62] ; O1[15]=O[30] ;
O1[16]=O[37] ; O1[17]=O[5] ; O1[18]=O[45] ; O1[19]=O[13] ; O1[20]=O[53] ; O1[21]=O[21] ; O1[22]=O[61] ; O1[23]=O[29] ;
O1[24]=O[36] ; O1[25]=O[4] ; O1[26]=O[44] ; O1[27]=O[12] ; O1[28]=O[52] ; O1[29]=O[20] ; O1[30]=O[60] ; O1[31]=O[28] ;
O1[32]=O[35] ; O1[33]=O[3] ; O1[34]=O[43] ; O1[35]=O[11] ; O1[36]=O[51] ; O1[37]=O[19] ; O1[38]=O[59] ; O1[39]=O[27] ;
O1[40]=O[34] ; O1[41]=O[2] ; O1[42]=O[42] ; O1[43]=O[10] ; O1[44]=O[50] ; O1[45]=O[18] ; O1[46]=O[58] ; O1[47]=O[26] ;
O1[48]=O[33] ; O1[49]=O[1] ; O1[50]=O[41] ; O1[51]=O[9]  ; O1[52]=O[49] ; O1[53]=O[17] ; O1[54]=O[57] ; O1[55]=O[25] ;
O1[56]=O[32] ; O1[57]=O[0] ; O1[58]=O[40] ; O1[59]=O[8]  ; O1[60]=O[48] ; O1[61]=O[16] ; O1[62]=O[56] ; O1[63]=O[24]  ;    

IFILE[ADDRESS-1]=O1; $fwrite(f,"%h\n",O1);   

end

end

endmodule