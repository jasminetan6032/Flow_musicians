%INTERP3  3 ������� (table lookup)
%
%   VI = INTERP3(X,Y,Z,V,XI,YI,ZI) �́A�z�� XI, YI, ZI ���̓_�ŁA3 �����֐� 
%   V �� VI �l�����߂邽�߂ɕ�Ԃ��s���܂��BXI, YI, ZI �́A�����T�C�Y�̔z��A
%   �܂��̓x�N�g���łȂ���΂Ȃ�܂���B�x�N�g�������������T�C�Y�łȂ��A������
%   ���݂��� (�� �s�x�N�g���Ɨ�x�N�g��) �ꍇ�́AMESHGRID �ɓn����A�z�� 
%   Y1, Y2, Y3 ���쐬���܂��B�z�� X, Y, Z �́A�f�[�^ V ���^������_���w�肵�܂��B
%
%   VI = INTERP3(V,XI,YI,ZI) �́AX=1:N, Y=1:M, Z=1:P �ł���Ɖ��肵�܂��B
%        �����ŁA[M,N,P]=SIZE(V) �ł��B
%   VI = INTERP3(V,NTIMES) �́A�ċA�I�� NTIMES ��A�v�f�Ԃ̕�Ԃ��J��Ԃ�
%        ���Ƃ� V ���g�����܂��B
%   INTERP3(V) �́AINTERP3(V,1) �Ɠ����ł��B
%
%   VI = INTERP3(...,METHOD) �́A��Ԏ�@���w�肵�܂��B�f�t�H���g�́A���`���
%   �ł��B�g�p�\�Ȏ�@�͈ȉ��̂Ƃ���ł��B
%
%     'nearest' - �ŋߖT���
%     'linear'  - ���`���
%     'spline'  - �X�v���C�����
%     'cubic'   - �f�[�^�����Ԋu�̏ꍇ�A�o�O����ԁA�����łȂ��ꍇ�� 
%                 'spline' �Ɠ���
%
%   VI = INTERP3(...,METHOD,EXTRAPVAL) �́AX, Y, Z �ō쐬���ꂽ�̈�̊O���� 
%   VI �̗v�f�ɑ΂��Ďg�p����O�}�@�ƒl���w�肷��̂Ɏg���܂��B�������āAVI �́A
%   X, Y, Z �̂��ꂼ��ɂ��쐬����Ă��Ȃ��AXI,YI �܂��� ZI �̂����ꂩ�̒l��
%   ���� EXTRAPVAL �ɓ������Ȃ�܂��B�g�p����� EXTRAPVAL �ɑ΂��āA���\�b�h��
%   �w�肳��Ȃ���΂Ȃ�܂���B�f�t�H���g�̃��\�b�h�� 'linear' �ł��B
%
%   ���ׂĂ̕�Ԗ@�ŁAX, Y, Z �͒P���֐��ŁA(MESHGRID �ō쐬�������̂�
%   ���l��) �i�q�`�łȂ���΂Ȃ�܂���BX, Y, Z �́A���Ԋu�łȂ��ꍇ������܂��B
%
%   ���Ƃ��΁AFLOW �̑e���ߎ����쐬���A�ׂ������b�V���ŕ�Ԃ��܂��B
%       [x,y,z,v] = flow(10);
%       [xi,yi,zi] = meshgrid(.1:.25:10,-3:.25:3,-3:.25:3);
%       vi = interp3(x,y,z,v,xi,yi,zi); % vi �� 25�~40�~25
%       slice(xi,yi,zi,vi,[6 9.5],2,[-2 .2]), shading flat
%
%   �Q�l INTERP1, INTERP2, INTERPN, MESHGRID.


%   Copyright 1984-2007 The MathWorks, Inc.
