%GRIDDATA3  3 �����f�[�^�p�̃f�[�^�̃O���b�h���ƒ��Ȗʋߎ�
%
%   W = GRIDDATAN(X, Y, Z, V, XI, YI, ZI) �́A��ԓI�ɕs�ώ��ɕ��z����
%   �x�N�g�� (X, Y, Z, V) �̃f�[�^�� W = F(X,Y,Z) �̌^�̒��Ȗʂ��ߎ����܂��B
%   GRIDDATA3 �́AW ���쐬���邽�߂ɁA(XI,YI,ZI) �Ŏw�肳���_�ł��̒��Ȗʂ�
%   
%   (XI,YI,ZI) �́A�ʏ� (�֐� MESHGRID �ō쐬����) ��l���z�O���b�h�ŁA
%   ���̂��� GRIDDATA3 �Ɩ��t�����Ă��܂��B
%
%   [...] = GRIDDATA3(X,Y,Z,V,XI,YI,ZI,METHOD) �� METHOD ���ȉ��̂����ꂩ��
%   ����ꍇ�A
%       'linear'    - �e�Z���[�V�����Ɋ�Â����`���} (�f�t�H���g)
%       'nearest'   - �ŋߖT���
%
%   �f�[�^�ɋߎ�����\�ʂ̃^�C�v���`���܂��B
%   ���ׂĂ̕��@�́A�f�[�^�� Delaunay �O�p�`�����Ɋ�Â��Ă��܂��B
%   METHOD �� [] �̏ꍇ�A�f�t�H���g�� 'linear' ���\�b�h���g�p����܂��B
%
%   [...] = GRIDDATA3(X,Y,Z,V,XI,YI,ZI,METHOD,OPTIONS) �́ADELAUNAYN �ɂ�� 
%   Qhull �̃I�v�V�����Ƃ��Ďg�p�����悤�ɁA������ OPTIONS �̃Z���z���
%   �w�肵�܂��BOPTIONS �� [] �̏ꍇ�A�f�t�H���g�̃I�v�V�������g���܂��B
%   OPTIONS �� {''} �̏ꍇ�A�f�t�H���g���܂߁A�I�v�V�����͗p�����܂���B
%
%   ��:
%      x = 2*rand(5000,1)-1; y = 2*rand(5000,1)-1; z = 2*rand(5000,1)-1;
%      v = x.^2 + y.^2 + z.^2;
%      d = -0.8:0.05:0.8;
%      [xi,yi,zi] = meshgrid(d,d,d);
%      w = griddata3(x,y,z,v,xi,yi,zi);
%   4 �����̃f�[�^�Z�b�g�����o������͓̂�����߁A0.8 �̓����ʂ��g�p���܂��B
%      p = patch(isosurface(xi,yi,zi,w,0.8));
%      isonormals(xi,yi,zi,w,p);
%      set(p,'FaceColor','blue','EdgeColor','none');
%      view(3), axis equal, axis off, camlight, lighting phong
%
%   ���� X,Y,Z,V,XI,YI,ZI �ɑ΂���N���X�T�|�[�g: double
%
%   �Q�l TriScatteredInterp, DelaunayTri, GRIDDATA, GRIDDATAN, QHULL, 
%        DELAUNAYN, MESHGRID.


%   Copyright 1984-2009 The MathWorks, Inc.
