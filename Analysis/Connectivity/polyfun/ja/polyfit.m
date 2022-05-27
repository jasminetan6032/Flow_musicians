%POLYFIT  �������ߎ�
%
%   P = POLYFIT(X,Y,N) �́A�f�[�^ Y ���ŏ����I�ɍœK�ߎ����� N ���̑����� 
%   P(X) �̌W�����Z�o���܂��BP �͍~���ׂ̂���̑������W��  
%   P(1)*X^N + P(2)*X^(N-1) +...+ P(N)*X + P(N+1) 
%   ���܂ޒ��� N+1 �̍s�x�N�g���ł��B
%
%   [P,S] = POLYFIT(X,Y,N) �́A�\���̐���덷�𓾂邽�߂� POLYVAL �Ŏg�p����
%   �������̌W�� P �ƍ\���� S ��Ԃ��܂��BS �́AX �� Vandermonde �s��� QR ����
%   ����̎O�p���q (R)�A���R�x (df)�A�c���̃m���� (normr) �ɑ΂���t�B�[���h��
%   �܂�ł��܂��B�f�[�^ Y �������̏ꍇ�AP �̋����U�s��̐���� 
%   (Rinv*Rinv')*normr^2/df �ł��B������ Rinv �� R �̋t�s��ł��B
%
%   [P,S,MU] = POLYFIT(X,Y,N) �́AXHAT = (X-MU(1))/MU(2) �̑������̌W��������
%   �܂��B�����ŁAMU(1) = MEAN(X) �� MU(2) = STD(X) �ł��B���̃Z���^�����O��
%   �X�P�[�����O�̕ϊ��́A�������Ƌߎ��A���S���Y���̗����̐��l�I�ȃv���p�e�B��
%   ���ǂ��܂��B
%
%   N �� >= length(X)�AX ���d�����Ă���A�܂��͏d���ɋ߂��_�ł���AX ��
%   �Z���^�����O��X�P�[�����O���K�v�ł��邩�̂����ꂩ�̏ꍇ�A�x�����b�Z�[�W��
%   ����܂��B
%
%   ���� X,Y �̃N���X�T�|�[�g:
%      float: double, single
%
%   �Q�l POLY, POLYVAL, ROOTS, LSCOV.


%   Copyright 1984-2010 The MathWorks, Inc.
