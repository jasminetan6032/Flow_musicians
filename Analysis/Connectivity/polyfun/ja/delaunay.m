%DELAUNAY  Delaunay 三角形分割
%
%   TRI = DELAUNAY(X,Y) は、三角形の外接円にデータ点が含まれないような
%   三角形の集合を返します。M 行 3 列の行列 TRI の各行は、ベクトル X と 
%   Y のインデックスを含む 1 つの三角形を定義します。
%
%   DELAUNAY は、Qhull を使用します。
%
%   TRI = DELAUNAY(X,Y,OPTIONS) は、DELAUNAYN により Qhull のオプションとして
%   使用されるように、文字列 OPTIONS のセル配列を指定します。デフォルトの
%   オプションは、{'Qt','Qbb','Qc'} です。OPTIONS が [] の場合、デフォルトの
%   オプションが使われます。OPTIONS が {''} の場合、デフォルトも含め、
%   オプションは用いられません。Qhull とそのオプションについての詳細は、
%   http://www.qhull.org を参照してください。
%
%   例:
%      x = [-0.5 -0.5 0.5 0.5];
%      y = [-0.5 0.5 0.5 -0.5];
%      tri = delaunay(x,y,{'Qt','Qbb','Qc','Qz'})
%
%   Delaunay 三角形分割は、GRIDDATA (散布しているデータを内挿), CONVHULL, 
%   VORONOI (VORONOI 線図を計算) と共に使われ、散布しているデータ点に対して、
%   三角グリッドを作成するために有効です。
%
%   関数 DSEARCH と TSEARCH は、それぞれ、最近傍のデータ点や囲んだ三角形を
%   求めるための三角形分割を検索します。
%
%   参考 DelaunayTri, VORONOI, TRIMESH, TRISURF, TRIPLOT, GRIDDATA, CONVHULL,
%        DSEARCH, TSEARCH, DELAUNAY3, DELAUNAYN, QHULL.


%   Copyright 1984-2009 The MathWorks, Inc.
