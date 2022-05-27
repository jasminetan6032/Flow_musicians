% 補間と多項式
%
% データ補間
%   pchip       - 区分的な 3 次エルミート内挿多項式
%   interp1     - 1 次元補間 (table lookup)
%   interp1q    - 高速 1 次元補間
%   interpft    - FFT 法を使った1次元補間
%   interp2     - 2 次元補間 (table lookup)
%   interp3     - 3 次元補間 (table lookup)
%   interpn     - 多次元補間 (table lookup)
%   griddata    - データのグリッド化と表面近似
%   griddata3   - 3 次元データ用のデータのグリッド化と超曲面近似
%   griddatan   - データのグリッド化と超曲面近似 (次元 >= 2)
%   TriScatteredInterp - 散布図データの補間
%
% スプライン補間
%   spline      - 3 次スプライン補間
%   ppval       - 区分多項式の実行
%
% 幾何学的解析
%   delaunay    - Delaunay 三角形分割
%   delaunay3   - 3-次元 Delaunay 分割
%   delaunayn   - N-次元 Delaunay 分割
%   dsearch     - 最近傍点の Delaunay 三角形分割の検索
%   dsearchn    - 最近傍点に対する N-次元の Delaunary 分割の探索
%   tsearch     - 最近傍三角形の検索
%   tsearchn    - N-次元最近傍三角形の探索
%   convhull    - 凸包
%   convhulln   - N-次元凸包
%   voronoi     - Voronoi 面
%   voronoin    - N-次元 Voronoi 線図
%   inpolygon   - 多角形内の点の検出
%   rectint     - 長方形の交点
%   polyarea    - 多角形の面積
% 
% 三角形分割表現
%   TriRep                    - 三角形分割表現
%   TriRep/baryToCart         - 点の座標を重心座標から直交座標に変換
%   TriRep/cartToBary         - 点の座標を重心座標から直交座標に変換
%   TriRep/circumcenters      - 指定したシンプレックスの外心を出力
%   TriRep/edges              - 三角形分割内のエッジを出力
%   TriRep/edgeAttachments    - 指定したエッジに追加するシンプレックスを出力
%   TriRep/faceNormals        - 指定した三角形のシンプレックスへの法線を出力
%   TriRep/featureEdges       - 表面の三角形分割の鋭いエッジを出力
%   TriRep/freeBoundary       - 1 つのシンプレックスのみで参照される小面を出力
%   TriRep/incenters          - 指定したシンプレックスの内点を出力
%   TriRep/isEdge             - 頂点の組がエッジで連結しているかどうかをテスト
%   TriRep/neighbors          - シンプレックスの近傍情報を出力
%   TriRep/size               - 三角形分割の行列のサイズを出力
%   TriRep/vertexAttachments  - 指定した頂点に追加するシンプレックスを出力
%   
% Delaunay 三角形分割
%   DelaunayTri                 - 点集合から Delaunay 三角形分割を作成
%   DelaunayTri/convexHull      - 凸包の出力
%   DelaunayTri/inOutStatus     - 2D 制約付き Delaunay 内の三角形の内/外の状態を出力
%   DelaunayTri/nearestNeighbor - 指定した位置に最も近い点の検索
%   DelaunayTri/pointLocation   - 指定した位置を含むシンプレックスの位置
%   DelaunayTri/voronoiDiagram  - Voronoi 線図の出力
%
% 多項式
%   roots       - 多項式の根
%   poly        - 根を多項式に変換
%   polyval     - 多項式の計算
%   polyvalm    - 行列として多項式を計算
%   residue     - 部分分数展開 (residues)
%   polyfit     - 多項式近似
%   polyder     - 多項式の導関数
%   polyint     - 多項式の解析的な積分
%   conv        - 多項式の乗算
%   deconv      - 多項式の除算


%   Copyright 1984-2009 The MathWorks, Inc.
