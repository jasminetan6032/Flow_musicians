%incenters  指定したシンプレックスの内点を出力
%
%   IC = incenters(TR, SI) は、指定したシンプレックス SI ごとの内点の座標を
%   返します。シンプレックスは、三角形/四面体、またはより高い次元に相当する
%   ものです。SI は、三角形分割の行列 TR.Triangulation へのインデックスを示す
%   シンプレックスの列ベクトルです。IC は m 行 n 列の行列です。ここで、m は
%   指定したシンプレックスの数 length(SI) で、n は三角形分割が存在する空間の
%   次元です。各行 IC(i,:) は、シンプレックス SI(i) の内点の座標を表します。
%   SI が指定されない場合、三角形分割全体に対する内点の情報が返されます。
%   ここで、シンプレックス i に関する内点は、IC の i 番目の行になります。
%
%   例 1: 3D の三角形分割を読み込み、TriRep を使用して最初の 5 つの四面体の
%         内点を計算します。
%       load tetmesh
%       % これは三角形分割 tet と頂点の座標 X を読み込みます。
%       trep = TriRep(tet, X)
%       ic = incenters(trep, [1:5]')
%
%   例 2: DelaunayTri を使って作成した 2D の三角形分割を直接調べます。
%            三角形の内点を計算し、三角形と内点をプロットします。
%       x = [0 1 1 0 0.5]';
%       y = [0 0 1 1 0.5]';
%       dt = DelaunayTri(x,y);
%       ic = incenters(dt);
%       % 三角形と内点を表示
%       triplot(dt);
%       axis equal;
%       axis([-0.2 1.2 -0.2 1.2]);
%       hold on; plot(ic(:,1),ic(:,2),'*r'); hold off;
%
%   参考 TriRep, TriRep.circumcenters, DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
