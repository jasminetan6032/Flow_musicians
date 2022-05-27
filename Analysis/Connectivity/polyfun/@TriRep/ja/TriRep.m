%TriRep     三角形分割表現
%
%   これは、2D と 3D 空間内の三角形分割に対して位相幾何学的な照合を行います。
%   たとえば、三角形メッシュの場合、頂点を追加した三角形や、エッジを共有して
%   いる三角形、近傍情報、外心などを調べることができます。既存の三角形分割
%   データを使って、直接 TriRep を作成することができます。あるいは、TriRep への
%   機能的なアクセス方法である DelaunayTri により、Delaunay 三角形分割を作成する
%   ことが可能です。
%
%   TR = TriRep(TRI, X, Y) は、三角形分割の行列 TRI と頂点の座標 (X, Y) から 
%   2D の TriRep を作成します。TRI は、三角形分割を面-頂点の形式で定義する 
%   m 行 3 列の行列です。ここで、m は三角形の数です。TRI の各行は、頂点の座標 
%   (X, Y) の列ベクトルのインデックスで定義される三角形です。
%
%   TR = TriRep(TRI, X, Y, Z) は、三角形分割の行列 TRI と頂点の座標 (X, Y, Z) 
%   から 3D の TriRep を作成します。TRI は、三角形分割をシンプレックス-頂点の
%   形式で定義する m 行 3 列、または m 行 4 列の行列です。ここで、m は
%   シンプレックス (この場合、三角形または四面体) の数です。TRI の各行は、
%   頂点の座標 (X, Y, Z) の列ベクトルのインデックスで定義されるシンプレックスです。
%
%   TR = TriRep(TRI, X) は、三角形分割の行列 TRI と頂点の座標 X から TriRep 
%   を作成します。TRI は、三角形分割をシンプレックス-頂点の形式で定義する m 行 
%   n 列の行列です。ここで、m はシンプレックスの数で、n はシンプレックスごとの
%   頂点の数です。TRI の各行は、頂点の座標 X の配列のインデックスで定義される
%   シンプレックスです。X は mpts 行 ndim 列の行列です。ここで、mpts は点数で、
%   ndim は点が存在する空間の次元で 2 <= ndim <= 3 です。
%
%
%   例 1:
%       % 2D の三角形分割を読み込み、TriRep を使用して自由境界のエッジの
%       % 配列を作成します。
%       load trimesh2d
%       % これは三角形分割 tri と頂点の座標 x, y を読み込みます。
%       trep = TriRep(tri, x,y);
%       fe = freeBoundary(trep)';
%       triplot(trep);
%       % 自由境界のエッジを赤で追加します。
%       hold on; plot(x(fe), y(fe), 'r','LineWidth',2); hold off;
%       axis([-50 350 -50 350]);
%       axis equal;
%
%   例 2:
%       % 3D の四面体の三角形分割を読み込み、TriRep を使用して自由境界 
%       % (三角形分割の表面) を計算します。
%       load tetmesh
%       % これは三角形分割 tet と頂点の座標 X を読み込みます。
%       trep = TriRep(tet, X);
%       [tri, Xb] = freeBoundary(trep);
%       % 表面メッシュをプロット
%       trisurf(tri, Xb(:,1), Xb(:,2), Xb(:,3), 'FaceColor', 'cyan', 'FaceAlpha', 0.8);
%
%   例 3:
%       % DelaunayTri を使って作成した 3D の Delaunay 三角形分割を直接
%       % 調べます。例 2 と同様に自由境界を計算します。
%       X = rand(50,3);
%       dt = DelaunayTri(X);
%       [tri, Xb] = freeBoundary(dt);
%       % 表面メッシュをプロット
%       trisurf(tri, Xb(:,1), Xb(:,2), Xb(:,3), 'FaceColor', 'cyan','FaceAlpha', 0.8);
%
%
%   TriRep メソッド:
%        baryToCart     - 点の座標を重心座標から直交座標に変換
%        cartToBary     - 点の座標を直交座標から重心座標に変換
%        circumcenters  - 指定したシンプレックスの外心を出力
%        edgeAttachments  - 指定したエッジに追加するシンプレックスを出力
%        edges          - 三角形分割内のエッジを出力
%        faceNormals    - 指定した三角形の単位法線を出力
%        featureEdges   - 表面の三角形分割の鋭いエッジを出力
%        freeBoundary   - 1 つのシンプレックスのみで参照される小面を出力
%        incenters      - 指定したシンプレックスの内点を出力
%        isEdge         - 頂点の組がエッジで連結しているかどうかをテスト
%        neighbors      - シンプレックスの近傍情報を出力
%        vertexAttachments  - 指定した頂点に追加するシンプレックスを出力
%        size               - 三角形分割の行列のサイズを出力
%
%    TriRep プロパティ:
%        X              - 三角形分割内の点の座標
%        Triangulation  - 三角形分割データの構造体
%
%   参考 DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
