% DelaunayTri  点集合から Delaunay 三角形分割を作成
%
%    点を追加または削除することで、三角形分割を段階的に修正することができます。
%    2D 三角形分割において、エッジの制約を課すことができます。
%    さらに、Voronoi 線図と凸包を計算することで位相幾何学的な照合を行う
%    ことも可能です。
%
%    DT = DelaunayTri() は、空の Delaunay 三角形分割を作成します。
%
%    DT = DelaunayTri(X), DelaunayTri(X, Y), DelaunayTri(X, Y, Z) は、
%    点集合から Delaunay 三角形分割を作成します。点は、mpts 行 ndim 列の
%    行列 X として指定されます。ここで、mpts は点数で、ndim は点の存在する
%    空間の次元で ndim >= 2 となります。
%    あるいは、2D と 3D の入力の場合に点を列ベクトル (X,Y) または (X,Y,Z) と
%    して指定することができます。
%
%    DT = DelaunayTri(..., C) は、制約付きの Delaunay 三角形分割を作成します。
%    エッジの制約 C は、numc 行 2 列の行列で定義されます。ここで、numc は
%    制約付きのエッジです。C の各行は、端点のインデックスの項にある制約付きの
%    エッジを点集合 X に定義します。この機能は、2D 三角形分割でのみ使用する
%    ことができます。
%
%    DelaunayTri は CGAL (Computational Geometry Algorithms Library) を
%    使用します。(http://www.cgal.org)
%
%    例: 単位正方形内にある 20 点の乱数の Delaunay 三角形分割を計算します。
%        x = rand(20,1);
%        y = rand(20,1);
%        dt = DelaunayTri(x,y)
%        triplot(dt);
%
%    さらに進んだ例: 参考行にある demoDelaunayTri のリンクに従ってください。
%
% DelaunayTri メソッド:
%    convexHull         - 凸包の出力
%    voronoiDiagram     - Voronoi 線図の出力
%    nearestNeighbor    - 指定した位置に最も近い点の検索
%    pointLocation      - 指定した位置を含むシンプレックスの位置
%    inOutStatus        - 2D 制約付き Delaunay 内の三角形の内/外の状態を出力
%
% DelaunayTri 継承メソッド:
%    DelaunayTri は、TriRep のメソッドのすべてを継承します。
%    これらのメソッドのリストについては、TriRep のヘルプを参照してください。
%
% DelaunayTri プロパティ:
%    Constraints		  - 課せられるエッジの制約は 2D のみ
%    X                - 三角形分割内の点の座標
%    Triangulation		- 計算される三角形分割
%
% 参考 demoDelaunayTri, TriRep, triplot, trisurf, tetramesh, 
%      TriScatteredInterp.


%   Copyright 2008-2009 The MathWorks, Inc.
