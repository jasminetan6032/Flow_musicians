%VORONOIN  N-���� Voronoi ���}
%
%   [V,C] = VORONOIN(X) �́AX �� Voronoi ���}�� Voronoi ���_ V �ƁAVoronoi 
%   �Z�� C ��Ԃ��܂��BV �́An ������Ԃł� numv �� Voronoi ���_����Ȃ� 
%   numv �s n ��̔z��ł��B�e�s�́AVoronoi ���_�ɑΉ����܂��BC �́A�e�v�f��
%   �Ή����� oronoi �Z���̒��_�� V �̃C���f�b�N�X�ł���x�N�g���̃Z���z��ł��B
%   X �́Am �s n ��z��ŁAm �� n �����̓_��\�킵�܂��B
%
%   VORONOIN �́AQhull ���g�p���܂��B
%
%   [V,C] = VORONOIN(X,OPTIONS) �́AQhull �̃I�v�V�����Ƃ��Ďg�p�����悤�ɁA
%   ������ OPTIONS �̃Z���z����w�肵�܂��B�f�t�H���g�̃I�v�V�����́A
%   �ȉ��̂Ƃ���ł��B
%                                 2D ����� 3D �̓��͂̏ꍇ�A{'Qbb'}
%                                 4D �ȏ�̓��͂̏ꍇ�A{'Qbb','Qx'}
%   OPTIONS �� [] �̏ꍇ�A�f�t�H���g�̃I�v�V�������g���܂��BOPTIONS �� 
%   {''} �̏ꍇ�A�f�t�H���g���܂߁A�I�v�V�����͗p�����܂���B
%   Qhull �I�v�V�����̏ڍׂ́Ahttp://www.qhull.org ���Q�Ƃ��Ă��������B
%
%   �� 1:
%      X = [0.5 0; 0 0.5; -0.5 -0.5; -0.2 -0.1; -0.1 0.1; 0.1 -0.1; 0.1 0.1]
%     [V,C] = voronoin(X)
%   �̏ꍇ�AC �̓��e������ɂ́A�ȉ��̃R�}���h���g���܂��B
%      for i = 1:length(C), disp(C{i}), end
%   ���ɁA5 �Ԗڂ� Voronoi �Z���́A4 �_ V(10,:), V(5,:), V(6,:), V(8,:) ����
%   �\������Ă��܂��B
%
%   2 �����̏ꍇ�AC �̒��̒��_�ׂ͗荇�������Ƀ��X�g����A���Ȃ킿�A������
%   �������邱�Ƃɂ��A���p�` (voronoi ���}) ���쐬����܂��B3 �����A�܂���
%   ����ȏ�̎����ł́A���_�͏����Ƀ��X�g����܂��Bvoronoi ���}�̓���̃Z����
%   �쐬����ɂ́ACONVHULLN ���g�p���āA���̃Z���̖ʂ��v�Z�A�܂� 5 �Ԗڂ� 
%   Voronoi �Z���𐶐����܂��B
%
%      X = V(C{5},:);
%      K = convhulln(X);
%
%   �� 2:
%      X = [-1 -1; 1 -1; 1 1; -1 1];
%      [V,C] = voronoin(X)
%   �́A�G���[�ƂȂ�܂����A�f�t�H���g�I�v�V������ 'Qz' ��ǉ������
%   �𗧂��Ƃ������܂��B
%      [V,C] = voronoin(X,{'Qbb','Qz'})
%
%   �Q�l DelaunayTri, VORONOI, QHULL, DELAUNAYN, CONVHULLN, DELAUNAY, 
%        CONVHULL.


%   Copyright 1984-2009 The MathWorks, Inc. 
