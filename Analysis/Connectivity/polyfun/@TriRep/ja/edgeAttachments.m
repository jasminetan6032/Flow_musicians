%edgeAttachments  指定したエッジに追加するシンプレックスを出力
%
%   SI = edgeAttachments(TR, V1, V2) は、(V1, V2) で指定したエッジに追加
%   するシンプレックス SI を返します。シンプレックスは、三角形/四面体、
%   またはより高い次元に相当するものです。SI はベクトルのセル配列です。
%   ここで、各セルは三角形分割の行列 TR.Triangulation へのインデックスを
%   含んでいます。(V1, V2) は、頂点の座標 TR.X を表す点の配列への頂点の
%   インデックスの列ベクトルです。(V1, V2) は、照合するエッジの最初と
%   最後の頂点を表します。SI は、各エッジに関するシンプレックスの数が
%   変化するため、セル配列になります。
%
%   SI = edgeAttachments(TR, EDGE) は、エッジの開始と終了点を行列形式で
%   指定します。ここで、EDGE は m 行 2 列で、m は照合するエッジの数です。
%
%   例 1: 3D の三角形分割を読み込み、エッジに追加する四面体を計算するために 
%         TriRep を使用します。
%       load tetmesh
%       % これは三角形分割 tet と頂点の座標 X を読み込みます。
%       trep = TriRep(tet, X)
%       v1 = [15 21]'
%       v2 = [936 716]'
%       t = edgeAttachments(trep, v1, v2)
%       t{:}
%       % さらに、エッジを指定します。
%       e = [v1 v2]
%       t = edgeAttachments(trep, e)
%       t{:}
%
%   例 2: DelaunayTri を使って作成した三角形分割を直接調べます。 
%   % 2D の Delaunay 三角形分割を作成し、edge(1,5) に追加する三角形を調べます。
%     x = [0 1 1 0 0.5]'
%     y = [0 0 1 1 0.5]'
%     dt = DelaunayTri(x,y)
%     t = edgeAttachments(dt, 1,5)
%     t{:}
%
%
%   参考 TriRep, DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
