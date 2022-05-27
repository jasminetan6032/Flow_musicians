%DELAUNAYN  N-次元の Delaunay 分割
%
%   T = DELAUNAYN(X) は、シンプレックスの周りの球面に含まれない X のデータ点
%   からなるシンプレックスの集合を返します。シンプレックスの集合は、Delaunay 
%   分割を形成します。X は、n-次元の空間に位置する m 点を表わすm 行 n 列の
%   配列です。X は numt 行 (n+1) 列の配列で、その行が対応するシンプレックスの
%   頂点の X のインデックスになります。
%
%   DELAUNAYN は、Qhull を使用します。
%
%   T = DELAUNAYN(X,OPTIONS) は、Qhull のオプションとして使用されるように、
%   文字列 OPTIONS のセル配列を指定します。デフォルトのオプションは、
%   以下のとおりです。
%           2D および 3D の入力の場合、{'Qt','Qbb','Qc'}
%           4D 以上の入力の場合、{'Qt','Qbb','Qc','Qx'}
%   OPTIONS が [] の場合、デフォルトのオプションが使われます。OPTIONS が 
%   {''} の場合、デフォルトも含め、オプションは用いられません。
%   Qhull オプションの詳細は、http://www.qhull.org を参照してください。
%
%   例:
%      X = [-0.5 -0.5  -0.5;
%           -0.5 -0.5   0.5;
%           -0.5  0.5  -0.5;
%           -0.5  0.5   0.5;
%            0.5 -0.5  -0.5;
%            0.5 -0.5   0.5;
%            0.5  0.5  -0.5;
%            0.5  0.5   0.5];
%      T = delaunayn(X);
%   は、エラーとなりますが、デフォルトオプションに 'Qz' を追加すると
%   役立つことを示します。
%      T = delaunayn(X,{'Qt','Qbb','Qc','Qz'});
%   この解答を表示するために、TETRAMESH 関数を使用することができます。
%      tetramesh(T,X)
%
%   参考 DelaunayTri, QHULL, VORONOIN, CONVHULLN, DELAUNAY, DELAUNAY3, 
%        TETRAMESH.


%   Copyright 1984-2009 The MathWorks, Inc.
