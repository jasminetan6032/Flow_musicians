%DSEARCHN  N-次元最近傍点の検索
%
%   K = DSEARCHN(X,T,XI) は、XI の中の各点に対する X の最近傍点のインデックス 
%   K を返します。X は、n 次元空間で p 点を表わす p 行 n 列の行列です。
%   XI は、p 行 n 列行列で、N 次元空間の p 点を表わします。T は、numt 行 
%   n+1 列の行列で、DELAUAYN で作成されるデータ X の分割です。出力 K は、
%   長さ p の列ベクトルです。
%
%   K = DSEARCHN(X,T,XI,OUTVAL) は、点が凸包の中に存在する限り、XI の中の
%   各点に対して、X に最近傍点のインデックス K を返します。XI(J,:) が凸包の
%   外に位置する場合は、K(J) は、スカラの double 値である OUTVAL を割り当てます。
%   Inf はしばしば OUTVAL で使われます。OUTVAL が [] の場合、K は、
%   K = DSEARCHN(X,T,XI) と同じです。
%
%   K = DSEARCHN(X,T,XI,OUTVAL,COPTIONS) は、CONVHULLN により Qhull の
%   オプションとして使用されるように、文字列のセル配列 COPTIONS を指定します。
%   OPTIONS が [] の場合、デフォルトの CONVHULLN オプションが使用されます。
%   COPTIONS が {''} の場合、オプションは使用されません。デフォルトのものも
%   使用されません。
%
%   K = DSEARCHN(X,T,XI,OUTVAL,COPTIONS,DOPTIONS) は、DELAUNAYN により Qhull 
%   のオプションとして使用されるように、文字列 DOPTIONS のセル配列を指定します。
%   DOPTIONS が [] の場合、デフォルトの DELAUNAYN オプションが使用されます。
%   DOPTIONS が {''} の場合、オプションは使用されません。デフォルトのものも
%   使用されません。
%
%   K = DSEARCHN(X,XI) は、分割を使わないで検索を行います。大きな X と小さな 
%   XI を使う場合に、このアプローチは速くなり、メモリの使用が少なくなります。
%
%   [K,D] = DSEARCHN(X,...) は、最近傍点までの距離 D に返します。D は、
%   長さ p の列ベクトルです。
%
%   参考 DelaunayTri, TSEARCH, DSEARCH, TSEARCHN, QHULL, GRIDDATAN, 
%        DELAUNAYN, CONVHULLN.


%   Copyright 1984-2009 The MathWorks, Inc.
