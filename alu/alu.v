/*
  16-bit ALU device for xkarna. made by savolla in 2020
*/
module And(x, y, out);
  input [15:0] x, y;
  output [15:0] out;
  assign out = x & y;
endmodule

module Or(x, y, out);
  input [15:0] x, y;
  output [15:0] out;
  assign out = x | y;
endmodule

module Not(x, out);
  input [15:0] x;
  output [15:0] out;
  assign out = ~x;
endmodule

module Xor(x, y, out);
  input x, y;
  output out;
  wire v0, v1, v2, v3;
  assign v0 = ~x;
  assign v1 = ~y;
  assign v2 = v0 & y;
  assign v3 = v1 & x;
  assign out = v2 | v3;
endmodule

module Xor16(x, y, out);
  input [15:0] x, y;
  output [15:0] out;

  Xor x0(x[0], y[0], out[0]);
  Xor x1(x[1], y[1], out[1]);
  Xor x2(x[2], y[2], out[2]);
  Xor x3(x[3], y[3], out[3]);
  Xor x4(x[4], y[4], out[4]);
  Xor x5(x[5], y[5], out[5]);
  Xor x6(x[6], y[6], out[6]);
  Xor x7(x[7], y[7], out[7]);
  Xor x8(x[8], y[8], out[8]);
  Xor x9(x[9], y[9], out[9]);
  Xor x10(x[10], y[10], out[10]);
  Xor x11(x[11], y[11], out[11]);
  Xor x12(x[12], y[12], out[12]);
  Xor x13(x[13], y[13], out[13]);
  Xor x14(x[14], y[14], out[14]);
  Xor x15(x[15], y[15], out[15]);
endmodule

module full_adder( a, b, c, out, carry );
  input a, b, c;
  output out, carry;
  wire v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15;
  assign v0 = ~a;
  assign v1 = ~b;
  assign v2 = ~c;
  assign v3 = v0 & v1;
  assign v4 = v0 & b;
  assign v5 = v1 & a;
  assign v6 = b & a;
  assign v7 = c & v4;
  assign v8 = v3 & c;
  assign v9 = v2 & v4;
  assign v10 = v2 & v5;
  assign v11 = c & v6;
  assign v12 = v6 | v7;
  assign v13 = c & v5;
  assign v14 = v9 | v8;
  assign v15 = v11 | v10;
  assign carry = v13 | v12;
  assign out = v15 | v14;
endmodule

module full_adder16( a, b, c, out, carry );
  input [15:0] a, b;
  input c;
  output [15:0] out;
  output carry;
  wire v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15;

  full_adder m46( a[0], b[0], c, out[0], v1 );
  full_adder m47( a[1], b[1], v1, out[1], v2 );
  full_adder m48( a[2], b[2], v2, out[2], v3 );
  full_adder m49( a[3], b[3], v3, out[3], v4 );
  full_adder m50( a[4], b[4], v4, out[4], v5 );
  full_adder m51( a[5], b[5], v5, out[5], v6 );
  full_adder m52( a[6], b[6], v6, out[6], v7 );
  full_adder m53( a[7], b[7], v7, out[7], v8 );
  full_adder m54( a[8], b[8], v8, out[8], v9 );
  full_adder m55( a[9], b[9], v9, out[9], v10 );
  full_adder m56( a[10], b[10], v10, out[10], v11 );
  full_adder m57( a[11], b[11], v11, out[11], v12 );
  full_adder m58( a[12], b[12], v12, out[12], v13 );
  full_adder m59( a[13], b[13], v13, out[13], v14 );
  full_adder m60( a[14], b[14], v14, out[14], v15 );
  full_adder m61( a[15], b[15], v15, out[15], carry );
endmodule

// mux
module mux(x,y,sel,out);
  input x,y,sel;
  output out;
  wire v0, v1, v2;

  assign v0 = ~sel;
  assign v1 = y & v0;
  assign v2 = sel & x;
  assign out = v1 | v2;
endmodule

module mux16(x,y,sel,out);
  input [15:0] x, y;
  input sel;
  output [15:0] out;

  mux c0(x[0], y[0], sel, out[0]);
  mux c1(x[1], y[1], sel, out[1]);
  mux c2(x[2], y[2], sel, out[2]);
  mux c3(x[3], y[3], sel, out[3]);
  mux c4(x[4], y[4], sel, out[4]);
  mux c5(x[5], y[5], sel, out[5]);
  mux c6(x[6], y[6], sel, out[6]);
  mux c7(x[7], y[7], sel, out[7]);
  mux c8(x[8], y[8], sel, out[8]);
  mux c9(x[9], y[9], sel, out[9]);
  mux c10(x[10], y[10], sel, out[10]);
  mux c11(x[11], y[11], sel, out[11]);
  mux c12(x[12], y[12], sel, out[12]);
  mux c13(x[13], y[13], sel, out[13]);
  mux c14(x[14], y[14], sel, out[14]);
  mux c15(x[15], y[15], sel, out[15]);
endmodule

// null 
module NULL16( x, out );
  input [15:0] x;
  output [15:0] out;
  wire [15:0] v0;
  Not m38( x, v0 );
  And m23( x, v0, out );
endmodule

module ALU16( x, y, zx, nx, zy, ny, f0, f1, no, cin, cout, out );
  input [15:0] x, y;
  input zx, nx, zy, ny, f0, f1, no, cin;
  output cout;
  output [15:0] out;
  wire [15:0] v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15;

  // zx (zero x)
  NULL16 m0( x, v0 );
  mux16 m1( v0, x, zx, v1 );
  
  // nx (negate x)
  Not m39(v1, v2);
  mux16 m2(v2, v1, nx, v3);

  // zy (zero y)
  NULL16 m3( y, v4 );
  mux16 m4(v4, y, zy, v5);

  // ny (negate y)
  Not m40(v5, v6);
  mux16 m5(v6, v5, ny, v7);

  // f0, f1 (add, and, or, xor)
  full_adder16 m6(v7, v3, cin, v11, cout);
  And m24 (v3, v7, v9);
  Or m31 (v3, v7, v10);
  Xor16 m45 (v3, v7, v8);
  mux16 m7(v8, v9, f0, v12); // f0 first
  mux16 m8(v10, v11, f0, v13); // f0 second
  mux16 m9(v12, v13, f1, v14); // f1 second

  // no (negate output)
  Not m41(v14, v15);
  mux16 m10(v15, v14, no, out); // f1 second

endmodule
