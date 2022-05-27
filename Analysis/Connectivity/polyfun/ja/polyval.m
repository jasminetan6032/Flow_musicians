%POLYVAL  �������̌v�Z
%
%   Y = POLYVAL(P,X) �́AX �ŕ]�����ꂽ������ P �̒l��Ԃ��܂��BP �́A
%   ���̗v�f���~�ׂ��ȑ������̌W���ƂȂ钷�� N+1 �̃x�N�g���ł��B
%
%       Y = P(1)*X^N + P(2)*X^(N-1) + ... + P(N)*X + P(N+1)
%
%   X ���s��A�܂��̓x�N�g���̏ꍇ�A�������́AX �̂��ׂĂ̓_�ŕ]������܂��B
%   �s��̕]���̈Ӗ��ɂ��ẮAPOLYVALM ���Q�Ƃ��Ă��������B
%
%   [Y,DELTA] = POLYVAL(P,X,S) �́A�\���덷���� DELTA �𐶐����邽�߂� 
%   POLYFIT �ō쐬���ꂽ�I�v�V�����̏o�͍\���� S ���g�p���܂��BDELTA �́A
%   P(X) �ɂ�� X �ɂ����ė\������鏫���̊ϑ��̌덷�̕W���΍��̐���ł��B
%
%   P �̌W���� POLYFIT �Ōv�Z���ꂽ�ŏ����덷�ł���APOLYFIT �ւ̃f�[�^
%   ���͂̌덷���萔�̕��U�����Ɨ��Ȑ��K���z�̏ꍇ�AY +/- DELTA �́A
%   X �ɂ����鏫���̊ϑ��̏��Ȃ��Ƃ� 50% ���܂݂܂��B
%
%   Y = POLYVAL(P,X,[],MU) �܂��� [Y,DELTA] = POLYVAL(P,X,S,MU) �́AX ��
%   ����� XHAT = (X-MU(1))/MU(2) ���g�p���܂��B���S���ƃX�P�[�����O
%   �p�����[�^ MU �́APOLYFIT �Ōv�Z���ꂽ�I�v�V�����̏o�͂ł��B
%
%   ���� P,X,S,MU �ɑ΂���N���X�T�|�[�g:
%      float: double, single
%
%   �Q�l POLYFIT, POLYVALM.


%   Copyright 1984-2008 The MathWorks, Inc.
