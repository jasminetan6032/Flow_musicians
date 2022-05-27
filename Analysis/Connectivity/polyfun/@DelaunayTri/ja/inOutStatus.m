%    inOutStatus  2D 制約付き Delaunay 内の三角形の内/外の状態を出力
%
%    IN = inOutStatus(DT) は、幾何学的領域の 2D 制約付き Delaunay 三角形分割
%    において、三角形の内/外の状態を返します。
%    IN は、三角形分割の三角形の数と等しい長さの論理配列です。三角形分割で
%    制約されたエッジは、有効な幾何学的領域の範囲を定義します。
%
%    与えられた Delaunay 三角形分割には、囲まれた幾何学的領域を定義する制約
%    されたエッジの集合があります。三角形分割内の i 番目の三角形は、IN(i) が 
%    1 と等しい場合は領域内部として、そうでない場合は三角形の外側として分類されます。
%
%    注意: inOutStatus は、2D の制約付き Delaunay 三角形分割に対してのみ
%          有効です。これは、課せられたエッジの制約が閉じた幾何学的領域を
%          囲むことを表します。
%
%    例:
%            % 正方形の穴を持つ正方形からなる幾何学的な領域を作成します。
%            outerprofile = [-5 -5; -3 -5; -1 -5; 1 -5; 3 -5; 5 -5;...
%                                 5 -3; 5 -1; 5  1; 5  3;...
%                             5  5;  3  5;  1  5; -1  5; -3  5; -5  5;...
%                                   -5  3; -5  1; -5 -1; -5 -3; ];
%            innerprofile = outerprofile.*0.5;
%            profile = [outerprofile; innerprofile];
%            outercons = [(1:19)' (2:20)'; 20 1;];
%            innercons = [(21:39)' (22:40)'; 40 21];
%            edgeconstraints = [outercons; innercons];
%            % 領域の制約付き Delaunay 三角形分割を作成します。
%            dt = DelaunayTri(profile, edgeconstraints)
%            subplot(1,2,1);
%            triplot(dt);
%            hold on; 
%            plot(dt.X(outercons',1), dt.X(outercons',2), '-r', 'LineWidth', 2); 
%            plot(dt.X(innercons',1), dt.X(innercons',2), '-r', 'LineWidth', 2);
%            axis equal;
%            title(sprintf('Plot showing interior and exterior\n triangles with respect to the domain.'));
%            hold off;
%            subplot(1,2,2);
%            inside = inOutStatus(dt);
%            triplot(dt(inside, :), dt.X(:,1), dt.X(:,2));
%            hold on;
%            plot(dt.X(outercons',1), dt.X(outercons',2), '-r', 'LineWidth', 2); 
%            plot(dt.X(innercons',1), dt.X(innercons',2), '-r', 'LineWidth', 2);
%            axis equal;
%            title(sprintf('Plot showing interior triangles only\n'));
%            hold off;
