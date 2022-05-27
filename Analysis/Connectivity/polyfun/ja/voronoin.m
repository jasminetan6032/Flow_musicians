%VORONOIN  N-次元 Voronoi 線図
%
%   [V,C] = VORONOIN(X) は、X の Voronoi 線図の Voronoi 頂点 V と、Voronoi 
%   セル C を返します。V は、n 次元空間での numv 個の Voronoi 頂点からなる 
%   numv 行 n 列の配列です。各行は、Voronoi 頂点に対応します。C は、各要素が
%   対応する oronoi セルの頂点の V のインデックスであるベクトルのセル配列です。
%   X は、m 行 n 列配列で、m 個の n 次元の点を表わします。
%
%   VORONOIN は、Qhull を使用します。
%
%   [V,C] = VORONOIN(X,OPTIONS) は、Qhull のオプションとして使用されるように、
%   文字列 OPTIONS のセル配列を指定します。デフォルトのオプションは、
%   以下のとおりです。
%                                 2D および 3D の入力の場合、{'Qbb'}
%                                 4D 以上の入力の場合、{'Qbb','Qx'}
%   OPTIONS が [] の場合、デフォルトのオプションが使われます。OPTIONS が 
%   {''} の場合、デフォルトも含め、オプションは用いられません。
%   Qhull オプションの詳細は、http://www.qhull.org を参照してください。
%
%   例 1:
%      X = [0.5 0; 0 0.5; -0.5 -0.5; -0.2 -0.1; -0.1 0.1; 0.1 -0.1; 0.1 0.1]
%     [V,C] = voronoin(X)
%   の場合、C の内容を見るには、以下のコマンドを使います。
%      for i = 1:length(C), disp(C{i}), end
%   特に、5 番目の Voronoi セルは、4 点 V(10,:), V(5,:), V(6,:), V(8,:) から
%   構成されています。
%
%   2 次元の場合、C の中の頂点は隣り合った順にリストされ、すなわち、それらを
%   結合することにより、閉多角形 (voronoi 線図) が作成されます。3 次元、または
%   それ以上の次元では、頂点は昇順にリストされます。voronoi 線図の特定のセルを
%   作成するには、CONVHULLN を使用して、そのセルの面を計算、つまり 5 番目の 
%   Voronoi セルを生成します。
%
%      X = V(C{5},:);
%      K = convhulln(X);
%
%   例 2:
%      X = [-1 -1; 1 -1; 1 1; -1 1];
%      [V,C] = voronoin(X)
%   は、エラーとなりますが、デフォルトオプションに 'Qz' を追加すると
%   役立つことを示します。
%      [V,C] = voronoin(X,{'Qbb','Qz'})
%
%   参考 DelaunayTri, VORONOI, QHULL, DELAUNAYN, CONVHULLN, DELAUNAY, 
%        CONVHULL.


%   Copyright 1984-2009 The MathWorks, Inc. 
