%GRIDDATAN  3 �����ȏ�̃f�[�^�ɑ΂���O���b�h���ƒ��Ȗʋߎ�
%
%   YI = GRIDDATAN(X,Y,XI) �́A��ԓI�ɕs�ώ��ɕ��z����x�N�g�� (X, Y) ��
%   �f�[�^�ɁAY = F(X) �̌^�̒��Ȗʂ��ߎ����܂��BGRIDDATAN �́AZ ���쐬���邽�߂ɁA
%   XI �Őݒ肳�ꂽ�_�ł��̒��Ȗʂ��Ԃ��܂��BXI �́A���l�ɂȂ�܂��B
%
%   X �͎��� m �s n ��ŁAn-������Ԃł� m �_��\�킵�܂��BY �� m �s 1 ���
%   �����ŁA���Ȗ� F(X) �� m �̒l��\���܂��BXI �́Ap �s n ��̃x�N�g���ŁA
%   �ߎ����� n-������Ԃ̕\�ʂ̒l�� p �̓_�ŕ\���܂��BYI �́A�l F(XI) ��
%   �ߎ����钷�� p �̃x�N�g���ł��B���Ȗʂ́A��Ƀf�[�^�_ (X,Y) ��ʂ�܂��B
%   XI �́A�ʏ�� (MESHGRID �ō쐬����悤��) ��l�ȃO���b�h�ł��B
%
%   YI = GRIDDATAN(X,Y,XI,METHOD) �́AMETHOD ���ȉ��̂����ꂩ�̏ꍇ�A
%       'linear'    - �e�Z���[�V�����Ɋ�Â����`���} (�f�t�H���g)
%       'nearest'   - �ŋߖT���
%   �f�[�^�ɋߎ�����\�ʂ̃^�C�v���`���܂��B
%   ���ׂĂ̎�@�́A�f�[�^�� Delaunay �O�p�����Ɋ�Â��܂��BMETHOD �� [] ��
%   �ꍇ�A�f�t�H���g�� 'linear' ���\�b�h���g�p����܂��B
%
%   YI = GRIDDATAN(X,Y,XI,METHOD,OPTIONS) �́ADELAUNAYN �ɂ�� Qhull ��
%   �I�v�V�����Ƃ��Ďg�p�����悤�ɁA������ OPTIONS �̃Z���z����w�肵�܂��B
%   OPTIONS �� [] �̏ꍇ�A�f�t�H���g�̃I�v�V�������g���܂��BOPTIONS �� 
%   {''} �̏ꍇ�A�f�t�H���g���܂߁A�I�v�V�����͗p�����܂���B
%
%   ��:
%      X = 2*rand(5000,3)-1; Y = sum(X.^2,2);
%      d = -0.8:0.05:0.8; [x0,y0,z0] = meshgrid(d,d,d);
%      XI = [x0(:) y0(:) z0(:)];
%      YI = griddatan(X,Y,XI);
%   4 �����̃f�[�^�Z�b�g�����o������͓̂�����߁A0.8 �̓����ʂ��g�p���܂��B
%      YI = reshape(YI, size(x0));
%      p = patch(isosurface(x0,y0,z0,YI,0.8));
%      isonormals(x0,y0,z0,YI,p);
%      set(p,'FaceColor','blue','EdgeColor','none');
%      view(3), axis equal, axis off, camlight, lighting phong
%
%   �Q�l TriScatteredInterp, DelaunayTri, GRIDDATA, GRIDDATA3, QHULL, 
%        DELAUNAYN, MESHGRID.


%   Copyright 1984-2009 The MathWorks, Inc.
