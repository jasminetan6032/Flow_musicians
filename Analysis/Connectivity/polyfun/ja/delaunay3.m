%DELAUNAY3  3 次元の Delaunay 分割
%
%   T = DELAUNAY3(X,Y,Z) は、四面体の周りの球面に含まれない X のデータ点から
%   なる四面体の集合を返します。T は、num 行 4 列の配列です。T の各行の要素は、
%   (X,Y,Z) のモザイク内で四面体を形成する (X,Y,Z) の点のインデックスです。
%
%   DELAUNAY3 は、Qhull を使用します。
%
%   T = DELAUNAY3(X,Y,Z,OPTIONS) は、DELAUNAY3 により Qhull のオプションと
%   して使われるように、文字列 OPTIONS のセル配列を指定します。デフォルトの
%   オプションは、{'Qt','Qbb','Qc'} です。
%   OPTIONS が [] の場合、デフォルトのオプションが使われます。OPTIONS が 
%   {''} の場合、デフォルトも含め、オプションは用いられません。
%   Qhull オプションの詳細は、http://www.qhull.org を参照してください。
%
%   例:
%      X = [-0.5 -0.5 -0.5 -0.5 0.5 0.5 0.5 0.5];
%      Y = [-0.5 -0.5 0.5 0.5 -0.5 -0.5 0.5 0.5];
%      Z = [-0.5 0.5 -0.5 0.5 -0.5 0.5 -0.5 0.5];
%      T = delaunay3( X, Y, Z, {'Qt', 'Qbb', 'Qc', 'Qz'} )
%
%   参考 DelaunayTri, QHULL, DELAUNAY, DELAUNAYN, GRIDDATA3, GRIDDATAN,
%        VORONOIN, TETRAMESH.


%   Copyright 1984-2009 The MathWorks, Inc.
