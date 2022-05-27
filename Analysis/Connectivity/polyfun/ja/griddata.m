%GRIDDATA  �f�[�^�̃O���b�h���ƕ\�ʋߎ�
%
%   ZI = GRIDDATA(X,Y,Z,XI,YI) �́A(�ʏ�) ��l�Ԋu�łȂ��x�N�g�� (X,Y,Z) ��
%   �f�[�^�ɁAZ = F(X,Y) �`���̕\�ʂ��ߎ����܂��BGRIDDATA �́AZI ���쐬����
%   ���߂ɁA(XI,YI) �Ŏw�肳���_�ł��̕\�ʂ��Ԃ��܂��B�\�ʂ́A�K���f�[�^�_��
%   �ʂ�܂��BXI �� YI �́A�ʏ� (MESHGRID �ō쐬�����悤��) ��l�Ԋu�̃O���b�h�ŁA
%   ���̂��߁AGRIDDATA �Ɩ��t�����Ă��܂��B
%
%   XI �́A�s�x�N�g���ł��\���܂���B���̏ꍇ�A��v�f�����̒l�ł���s���
%   �l�����܂��B���l�ɁAYI �͗�x�N�g���ł��\�킸�A�s�v�f�����̒l�ł���
%   �s��ƍl�����܂��B
%
%   [XI,YI,ZI] = GRIDDATA(X,Y,Z,XI,YI) �́A���̕��@�ō쐬���ꂽ XI �� YI ��
%   �Ԃ��܂� ([XI,YI] = MESHGRID(XI,YI) �̌���)�B
%
%   [...] = GRIDDATA(X,Y,Z,XI,YI,METHOD) �́AMETHOD ���ȉ��̂����ꂩ�̏ꍇ�A
%       'linear'    - �O�p�`�Ɋ�Â����`��� (�f�t�H���g)
%       'cubic'     - �O�p�`�Ɋ�Â��O�����
%       'nearest'   - �ŋߖT���
%       'v4'        - MATLAB 4 �� griddata ���\�b�h
%   �f�[�^�ɋߎ�����\�ʂ̃^�C�v���`���܂��B'cubic' �� 'v4' �́A���炩��
%   �\�ʂ��쐬���܂��B����A'linear' �� 'nearest' �́A���ꂼ��A1 �������� 
%   0 �������ɂ�����s�A�����������܂��B'v4' �ȊO�̂��ׂĂ̎�@�́A�f�[�^�� 
%   Delaunay �O�p�`�����Ɋ�Â��Ă��܂��B
%   METHOD �� [] �̏ꍇ�A�f�t�H���g�� 'linear' ���\�b�h���g�p����܂��B
%
%   [...] = GRIDDATA(X,Y,Z,XI,YI,METHOD,OPTIONS) �́ADELAUNAYN �ɂ�� Qhull 
%   �̃I�v�V�����Ƃ��Ďg����悤�ɁA������ OPTIONS �̃Z���z����w�肵�܂��B
%   OPTIONS �� [] �̏ꍇ�A�f�t�H���g�� DELAUNAYN �I�v�V�������g�p����܂��B
%   OPTIONS �� {''} �̏ꍇ�A�f�t�H���g���܂߁A�I�v�V�����͗p�����܂���B
%
%   ��:
%      x = rand(100,1)*4-2; y = rand(100,1)*4-2; z = x.*exp(-x.^2-y.^2);
%      ti = -2:.25:2;
%      [xi,yi] = meshgrid(ti,ti);
%      zi = griddata(x,y,z,xi,yi);
%      mesh(xi,yi,zi), hold on, plot3(x,y,z,'o'), hold off
%
%   �Q�l TriScatteredInterp, DelaunayTri, GRIDDATA3, GRIDDATAN, DELAUNAY, 
%        INTERP2, MESHGRID, DELAUNAYN.


%   Copyright 1984-2009 The MathWorks, Inc. 
