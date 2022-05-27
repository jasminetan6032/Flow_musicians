%CONVHULL  凸包
%
%   K = CONVHULL(X,Y) は、凸包上の点のベクトル X と Y のインデックスを返します。
%
%   CONVHULL は、Qhull を使用します。
%
%   K = CONVHULL(X,Y,OPTIONS) は、CONVHULLN により Qhull のオプションとして
%   使用されるように、文字列 OPTIONS のセル配列を指定します。デフォルトの
%   オプションは、{'Qt'} です。OPTIONS が [] の場合、デフォルトのオプションが
%   使われます。OPTIONS が {''} の場合、デフォルトも含め、オプションは用いられません。
%   Qhull とそのオプションについての詳細は、http://www.qhull.org を参照してください。
%
%   [K,A] = CONVHULL(...) は、A の中の凸包の部分も返します。
%
%   例:
%      X = [0 0 0 1];
%      Y = [0 1e-10 0 1];
%      K = convhull(X,Y,{'Qt','Pp'})
%
%   参考 DelaunayTri, TriRep, CONVHULLN, DELAUNAY, VORONOI,
%        POLYAREA, QHULL.


%   Copyright 1984-2009 The MathWorks, Inc.
