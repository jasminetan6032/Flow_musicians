%DELAUNAY  Delaunay �O�p�`����
%
%   TRI = DELAUNAY(X,Y) �́A�O�p�`�̊O�ډ~�Ƀf�[�^�_���܂܂�Ȃ��悤��
%   �O�p�`�̏W����Ԃ��܂��BM �s 3 ��̍s�� TRI �̊e�s�́A�x�N�g�� X �� 
%   Y �̃C���f�b�N�X���܂� 1 �̎O�p�`���`���܂��B
%
%   DELAUNAY �́AQhull ���g�p���܂��B
%
%   TRI = DELAUNAY(X,Y,OPTIONS) �́ADELAUNAYN �ɂ�� Qhull �̃I�v�V�����Ƃ���
%   �g�p�����悤�ɁA������ OPTIONS �̃Z���z����w�肵�܂��B�f�t�H���g��
%   �I�v�V�����́A{'Qt','Qbb','Qc'} �ł��BOPTIONS �� [] �̏ꍇ�A�f�t�H���g��
%   �I�v�V�������g���܂��BOPTIONS �� {''} �̏ꍇ�A�f�t�H���g���܂߁A
%   �I�v�V�����͗p�����܂���BQhull �Ƃ��̃I�v�V�����ɂ��Ă̏ڍׂ́A
%   http://www.qhull.org ���Q�Ƃ��Ă��������B
%
%   ��:
%      x = [-0.5 -0.5 0.5 0.5];
%      y = [-0.5 0.5 0.5 -0.5];
%      tri = delaunay(x,y,{'Qt','Qbb','Qc','Qz'})
%
%   Delaunay �O�p�`�����́AGRIDDATA (�U�z���Ă���f�[�^����}), CONVHULL, 
%   VORONOI (VORONOI ���}���v�Z) �Ƌ��Ɏg���A�U�z���Ă���f�[�^�_�ɑ΂��āA
%   �O�p�O���b�h���쐬���邽�߂ɗL���ł��B
%
%   �֐� DSEARCH �� TSEARCH �́A���ꂼ��A�ŋߖT�̃f�[�^�_��͂񂾎O�p�`��
%   ���߂邽�߂̎O�p�`�������������܂��B
%
%   �Q�l DelaunayTri, VORONOI, TRIMESH, TRISURF, TRIPLOT, GRIDDATA, CONVHULL,
%        DSEARCH, TSEARCH, DELAUNAY3, DELAUNAYN, QHULL.


%   Copyright 1984-2009 The MathWorks, Inc.
