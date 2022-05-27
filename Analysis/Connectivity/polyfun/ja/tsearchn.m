%TSEARCHN  N-次元最近傍の三角形探索
%
%   T = TSEARCHN(X,TES,XI) は、XI 内の各点に対して囲んだ Delaunay 三角形 
%   TES のシンプレックスのインデックス T を返します。X は、m 行 n 列行列で、
%   N 次元空間の m 点を表わします。XI は、p 行 n 列行列で、N 次元空間の 
%   p 点を表わします。TSEARCHN は、X の凸包の外側のすべての点に対して 
%   NaN を返します。TSEARCHN は、DELAUNAYN から得られる点 X の三角形 
%   TES を必要とします。
%
%   [T,P] = TSEARCHN(X,TES,XI) は、さらに、シンプレックス TES 内の XI の
%   重心座標も返します。P は p 行 n+1 列の行列です。P の各行は、XI 内の
%   対応する点の重心座標です。これは、内挿で役立ちます。
%
%   参考 DelaunayTri, DSEARCHN, TSEARCH, QHULL, GRIDDATAN, DELAUNAYN.


%   Copyright 1984-2009 The MathWorks, Inc.
