%faceNormals  指定した三角形の単位法線を出力
%
%   このクエリーは、三角形の表面メッシュにのみ適用可能です。
%   FN = faceNormals(TR, TI) は、指定した三角形 TI のそれぞれの単位法線
%   ベクトルを返します。ここで、TI は三角形分割の行列 TR.Triangulation の
%   インデックスの列ベクトルです。FN は m 行 3 列の行列です。ここで、m は
%   照合する三角形の数 length(TI) です。各行 FN(i,:) は、三角形 TI(i) の
%   単位法線ベクトルを表します。TI が指定されない場合、三角形分割全体に
%   対する単位法線の情報が返されます。ここで、三角形 i に関する単位法線は、
%   FN の i 番目の行になります。
%
%   例:
%   % 球体の表面上の乱数の標本を三角形分割し、TriRep を使って各三角形の
%   % 法線を計算します。
%     % quiver プロットを使って結果を表示します。
%       numpts = 100;
%       thetha = rand(numpts,1)*2*pi;
%       phi = rand(numpts,1)*pi;
%       x = cos(thetha).*sin(phi);
%       y = sin(thetha).*sin(phi);
%       z = cos(phi);
%       dt = DelaunayTri(x,y,z);
%       [tri Xb] = freeBoundary(dt);
%       tr = TriRep(tri, Xb);
%       P = incenters(tr);
%       fn = faceNormals(tr);
%       trisurf(tri,Xb(:,1),Xb(:,2),Xb(:,3),'FaceColor', 'cyan', 'faceAlpha', 0.8);
%       axis equal;
%       hold on;
%       quiver3(P(:,1),P(:,2),P(:,3),fn(:,1),fn(:,2),fn(:,3),0.5, 'color','r');
%       hold off;
%
%   参考 TriRep, DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
