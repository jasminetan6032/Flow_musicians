%POLYVAL  多項式の計算
%
%   Y = POLYVAL(P,X) は、X で評価された多項式 P の値を返します。P は、
%   その要素が降べきな多項式の係数となる長さ N+1 のベクトルです。
%
%       Y = P(1)*X^N + P(2)*X^(N-1) + ... + P(N)*X + P(N+1)
%
%   X が行列、またはベクトルの場合、多項式は、X のすべての点で評価されます。
%   行列の評価の意味については、POLYVALM を参照してください。
%
%   [Y,DELTA] = POLYVAL(P,X,S) は、予測誤差推定 DELTA を生成するために 
%   POLYFIT で作成されたオプションの出力構造体 S を使用します。DELTA は、
%   P(X) により X において予測される将来の観測の誤差の標準偏差の推定です。
%
%   P の係数が POLYFIT で計算された最小二乗誤差であり、POLYFIT へのデータ
%   入力の誤差が定数の分散を持つ独立な正規分布の場合、Y +/- DELTA は、
%   X における将来の観測の少なくとも 50% を含みます。
%
%   Y = POLYVAL(P,X,[],MU) または [Y,DELTA] = POLYVAL(P,X,S,MU) は、X の
%   代わりに XHAT = (X-MU(1))/MU(2) を使用します。中心化とスケーリング
%   パラメータ MU は、POLYFIT で計算されたオプションの出力です。
%
%   入力 P,X,S,MU に対するクラスサポート:
%      float: double, single
%
%   参考 POLYFIT, POLYVALM.


%   Copyright 1984-2008 The MathWorks, Inc.
