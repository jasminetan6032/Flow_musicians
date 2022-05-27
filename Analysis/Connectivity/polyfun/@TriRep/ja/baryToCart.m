%baryToCart  点の座標を重心座標から直交座標に変換
%
%   XC = baryToCart(TR, SI, B) は、シンプレックス SI に対して重心座標を
%   表す B の各点の直交座標 XC を返します。シンプレックスは、三角形/四面体、
%   またはより高い次元に相当するものです。SI は、三角形分割の行列 
%   TR.Triangulation へのインデックスを示すシンプレックスの列ベクトルです。
%   B は、シンプレックス SI に対して変換するための点の重心座標を表す行列です。
%   B は m 行 k 列のサイズです。ここで、m は変換する点数 length(SI) で、
%   k はシンプレックスごとの頂点の数です。
%
%   XC は、変換された点の直交座標を表す行列です。XC は、m 行 n 列のサイズで
%   す。ここで、n は三角形分割のある空間の次元です。すなわち、シンプレックス 
%   SI(j) に対する点 B(j) の直交座標は XC(j) になります。
%
%   例 1: 点集合の Delaunay 三角形分割を計算します。
%              内点の重心座標を計算します。
%              三角形分割を "拡大" し、変形した三角形分割上のマッピングした
%              内点の位置を計算します。
%
%       x = [0 4 8 12 0 4 8 12]';
%       y = [0 0 0 0 8 8 8 8]';
%       dt = DelaunayTri(x,y)
%       cc = incenters(dt);
%       tri = dt(:,:);
%       subplot(1,2,1);
%       triplot(dt); hold on;
%       plot(cc(:,1), cc(:,2), '*r'); hold off;
%       axis equal;
%       title(sprintf('Original triangulation and reference points.\n'));
%       b = cartToBary(dt,[1:length(tri)]',cc);
%       % 拡大した三角形分割の表現を作成します。
%       y = [0 0 0 0 16 16 16 16]';
%       tr = TriRep(tri,x,y)
%       xc = baryToCart(tr, [1:length(tri)]', b);
%       subplot(1,2,2);
%       triplot(tr); hold on;
%       plot(xc(:,1), xc(:,2), '*r'); hold off;
%       axis equal;
%       title(sprintf('Deformed triangulation and mapped\n locations of the reference points.\n'));
%
%
%   参考 TriRep, TriRep.cartToBary, DelaunayTri, DelaunayTri.pointLocation.


%   Copyright 2008-2009 The MathWorks, Inc.
