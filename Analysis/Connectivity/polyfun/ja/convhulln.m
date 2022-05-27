%CONVHULLN  N-次元の凸包
%
%   K = CONVHULLN(X) は、X の凸包の面を構成する X の中の点のインデックス K を
%   返します。
%   X は、n-次元の空間に位置する m 点を表わすm 行 n 列の配列です。凸包が p 面
%   を持つ場合、K は p 行 n 列になります。
%
%   CONVHULLN は、Qhull を使用します。
%
%   K = CONVHULLN(X,OPTIONS) は、Qhull のオプションとして使用されるように、
%   文字列 OPTIONS のセル配列を指定します。デフォルトのオプションは、
%   以下のとおりです。
%                                 2D, 3D および 4D 入力の場合、{'Qt'}
%                                 5D 以上の入力の場合、{'Qt','Qx'}
%   OPTIONS が [] の場合、デフォルトのオプションが使われます。OPTIONS が 
%   {''} の場合、デフォルトも含め、オプションは用いられません。Qhull と
%   そのオプションについての詳細は、http://www.qhull.org を参照してください。
%
%   [K,V] = CONVHULLN(...) は、V に凸包の体積を返します。
%
%   例:
%      X = [0 0; 0 1e-10; 0 0; 1 1];
%      K = convhulln(X)
%   は、追加オプション 'Pp' で警告を非表示にします。
%      K = convhulln(X,{'Qt','Pp'})
%
%   参考 DelaunayTri, TriRep, CONVHULL, QHULL, DELAUNAYN, VORONOIN,
%        TSEARCHN, DSEARCHN.


%   Copyright 1984-2009 The MathWorks, Inc. 
