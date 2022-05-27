% voronoiDiagram  Voronoi 線図の出力
%
%    点 X の離散集合の Voronoi 線図は、各点 X(i) の周りの空間を影響範囲 R{i} 
%    に分解します。範囲 R{i} の位置は、X 内の他の点より点 i に近くなります。
%    影響範囲は、Voronoi 領域を呼び出します。Voronoi 領域のすべての集合が 
%    Voronoi 線図です。
%
%    [V, R] = voronoiDiagram(DT) は、点 DT.X の Voronoi 線図の頂点 V と
%    領域 R を返します。領域 R{i} は、領域を囲む Voronoi の頂点を表す 
%    V のインデックスのセル配列です。V は、Voronoi の頂点の座標を表す 
%    numv 行 ndim 列の行列です。ここで、numv は頂点の数で、ndim は点の
%    存在する空間の次元です。R は、各点に関連する Voronoi のセルを表す 
%    length(DR.X) のベクトルのセル配列です。したがって、Voronoi 領域は、
%    DT.X(i) が R{i} となるように、i 番目の点に関連します。
%
%    2 次元の場合、R{i} の中の頂点は隣り合った順にリストされ、すなわち、
%    それらを結合することにより、閉多角形 (voronoi 線図) が作成されます。
%    3 次元の場合、R{i} の頂点は昇順にリストされます。
%
%    無限頂点
%    DT.X の凸包にある点に関連する Voronoi 領域には境界がありません。
%    これらの領域のエッジを囲むと無限に広がります。無限大の頂点は、
%    V の 1 番目の頂点で表されます。
%
%    例: 点集合の Voronoi 線図を計算します。
%        X = [ 0.5    0
%              0      0.5
%             -0.5   -0.5
%             -0.2   -0.1
%             -0.1    0.1
%              0.1   -0.1
%              0.1    0.1 ]
%        dt = DelaunayTri(X)
%        [V,R] = voronoiDiagram(dt)
%
%    参考 DelaunayTri, voronoi
