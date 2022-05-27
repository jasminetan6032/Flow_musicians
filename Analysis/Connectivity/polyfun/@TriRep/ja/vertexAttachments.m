%vertexAttachments  指定した頂点に追加するシンプレックスを出力
%
%   SI = vertexAttachments(TR, VI) は、指定した頂点 VI に対する頂点-シンプレックス
%   情報を返します。シンプレックスは、三角形/四面体、またはより高い次元に相当する
%   ものです。VI は、頂点の座標 TR.X を表す点の配列へのインデックスの列ベクトルです。
%   頂点 i に関するシンプレックスは、セル配列内の i 番目の要素です。
%   VI が指定されない場合、三角形分割全体に対する頂点-シンプレックス情報が
%   返されます。ここで、頂点 i に関するシンプレックスは、セル配列 SI 内の 
%   i 番目の要素になります。セル配列は、各頂点に関するシンプレックスの数が
%   変化するため、情報を保存するために使われます。
%
%   2D の三角形分割に関して、三角形分割が一致した方向を持つ場合、各セル内の
%   三角形は、各頂点のまわりに連続的に並べられます。
%
%   例 1: 2D の三角形分割を読み込み、TriRep を使用して頂点と三角形の関係を
%         計算します。
%       load trimesh2d
%       % これは三角形分割 tet と頂点の座標 X を読み込みます。
%       trep = TriRep(tri, x, y);
%       Tv = vertexAttachments(trep, 1)
%       % 1 番目の頂点に追加された四面体のインデックス
%       Tv{:}
%
%   例 2: DelaunayTri を使って作成した 2D の三角形分割を直接調べます。
%       x = rand(20,1);
%       y = rand(20,1);
%       dt = DelaunayTri(x,y);
%       t = vertexAttachments(dt,5);
%       % 頂点 5 に追加した三角形を赤でプロットします。
%       triplot(dt);
%       hold on; triplot(dt(t{:},:),x,y,'Color','r'); hold off;
%
%   参考 TriRep, DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
