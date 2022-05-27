%INTERP2  2 ������� (table lookup)
%
%   ZI = INTERP2(X,Y,Z,XI,YI) �́A�s�� XI �� YI ���̓_�� 2 �����֐� Z �̒l 
%   ZI �����߂邽�߂ɕ�Ԃ��܂��B�s�� X �� Y �́A�f�[�^ Z ���^������_��
%   �w�肵�܂��B
%
%   XI �́A�s�x�N�g���ł��\���܂���B���̏ꍇ�A��v�f�����̒l�ł���s���
%   �l�����܂��B���l�ɁAYI �͗�x�N�g���ł��\�킸�A�s�v�f�����̒l�ł���
%   �s��ƍl�����܂��B
%
%   ZI = INTERP2(Z,XI,YI) �́A[M,N] = SIZE(Z) �̂Ƃ��AX = 1:N ���� Y = 1:M ��
%   ����Ɖ��肵�܂��BZI = INTERP2(Z,NTIMES) �́A�ċA�I�� NTIMES ��A�v�f�Ԃ�
%   ��Ԃ��J��Ԃ����Ƃ� Z ���g�����܂��BINTERP2(Z) �́AINTERP2(Z,1) �Ɠ����ł��B
%
%   ZI = INTERP2(...,METHOD) �́A��Ԏ�@���w�肵�܂��B�f�t�H���g�́A���`���
%   �ł��B�g�p�\�Ȏ�@�͈ȉ��̂Ƃ���ł��B
%
%     'nearest' - �ŋߖT���
%     'linear'   - ���`���
%     'spline'  - �X�v���C�����
%     'cubic'   - �f�[�^�����Ԋu�̏ꍇ�A�o�O����ԁA�����łȂ��ꍇ�� 
%                 'spline' �Ɠ���
%
%   X �� Y �����Ԋu�ŒP���ȏꍇ�̂�荂���ȕ�Ԃɂ��ẮA�V���^�b�N�X 
%   ZI = INTERP2(...,*METHOD) ���g�p���Ă��������B
%
%   ZI = INTERP2(...METHOD,EXTRAPVAL) �́AX �� Y �ō쐬���ꂽ�̈�̊O���� ZI 
%   �̗v�f�ɑ΂��Ďg�p����O�}�@�ƃX�J���l���w�肷��̂Ɏg���܂��B�������āA
%   ZI �́AY �܂��� X �̂��ꂼ��ɂ��쐬����Ă��Ȃ��AYI �܂��� XI �̂����ꂩ��
%   �l�ɑ΂��� EXTRAPVAL �Ɠ������Ȃ�܂��B�g�p����� EXTRAPVAL �ɑ΂��āA
%   ���\�b�h���w�肳��Ȃ���΂Ȃ�܂���B�f�t�H���g�̃��\�b�h�� 'linear' �ł��B
%
%   ���ׂĂ̕�Ԗ@�ŁAX �� Y �͒P���֐��ŁA(MESHGRID �ō쐬�������̂Ɠ���) 
%   �i�q�`�łȂ���΂Ȃ�܂���B2 �̒P���x�N�g�����^�����Ȃ��ꍇ�Ainterp2 
%   �́A����������I�ɔz�u���܂��BX �� Y �́A���Ԋu�łȂ��ꍇ������܂��B
%
%   ���Ƃ��΁APEAKS �̑e���ߎ����쐬���A�ׂ������b�V���ŕ�Ԃ��܂��B
%       [x,y,z] = peaks(10); [xi,yi] = meshgrid(-3:.1:3,-3:.1:3);
%       zi = interp2(x,y,z,xi,yi); mesh(xi,yi,zi)
%
%   ���� X, Y, Z, XI, YI �ɑ΂���N���X�T�|�[�g:
%      float: double, single
%
%   �Q�l INTERP1, INTERP3, INTERPN, MESHGRID, GRIDDATA.


%   Copyright 1984-2007 The MathWorks, Inc.
