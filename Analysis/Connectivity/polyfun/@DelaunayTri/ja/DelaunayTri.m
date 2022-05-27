% DelaunayTri  �_�W������ Delaunay �O�p�`�������쐬
%
%    �_��ǉ��܂��͍폜���邱�ƂŁA�O�p�`������i�K�I�ɏC�����邱�Ƃ��ł��܂��B
%    2D �O�p�`�����ɂ����āA�G�b�W�̐�����ۂ����Ƃ��ł��܂��B
%    ����ɁAVoronoi ���}�Ɠʕ���v�Z���邱�Ƃňʑ��􉽊w�I�ȏƍ����s��
%    ���Ƃ��\�ł��B
%
%    DT = DelaunayTri() �́A��� Delaunay �O�p�`�������쐬���܂��B
%
%    DT = DelaunayTri(X), DelaunayTri(X, Y), DelaunayTri(X, Y, Z) �́A
%    �_�W������ Delaunay �O�p�`�������쐬���܂��B�_�́Ampts �s ndim ���
%    �s�� X �Ƃ��Ďw�肳��܂��B�����ŁAmpts �͓_���ŁAndim �͓_�̑��݂���
%    ��Ԃ̎����� ndim >= 2 �ƂȂ�܂��B
%    ���邢�́A2D �� 3D �̓��͂̏ꍇ�ɓ_���x�N�g�� (X,Y) �܂��� (X,Y,Z) ��
%    ���Ďw�肷�邱�Ƃ��ł��܂��B
%
%    DT = DelaunayTri(..., C) �́A����t���� Delaunay �O�p�`�������쐬���܂��B
%    �G�b�W�̐��� C �́Anumc �s 2 ��̍s��Œ�`����܂��B�����ŁAnumc ��
%    ����t���̃G�b�W�ł��BC �̊e�s�́A�[�_�̃C���f�b�N�X�̍��ɂ��鐧��t����
%    �G�b�W��_�W�� X �ɒ�`���܂��B���̋@�\�́A2D �O�p�`�����ł̂ݎg�p����
%    ���Ƃ��ł��܂��B
%
%    DelaunayTri �� CGAL (Computational Geometry Algorithms Library) ��
%    �g�p���܂��B(http://www.cgal.org)
%
%    ��: �P�ʐ����`���ɂ��� 20 �_�̗����� Delaunay �O�p�`�������v�Z���܂��B
%        x = rand(20,1);
%        y = rand(20,1);
%        dt = DelaunayTri(x,y)
%        triplot(dt);
%
%    ����ɐi�񂾗�: �Q�l�s�ɂ��� demoDelaunayTri �̃����N�ɏ]���Ă��������B
%
% DelaunayTri ���\�b�h:
%    convexHull         - �ʕ�̏o��
%    voronoiDiagram     - Voronoi ���}�̏o��
%    nearestNeighbor    - �w�肵���ʒu�ɍł��߂��_�̌���
%    pointLocation      - �w�肵���ʒu���܂ރV���v���b�N�X�̈ʒu
%    inOutStatus        - 2D ����t�� Delaunay ���̎O�p�`�̓�/�O�̏�Ԃ��o��
%
% DelaunayTri �p�����\�b�h:
%    DelaunayTri �́ATriRep �̃��\�b�h�̂��ׂĂ��p�����܂��B
%    �����̃��\�b�h�̃��X�g�ɂ��ẮATriRep �̃w���v���Q�Ƃ��Ă��������B
%
% DelaunayTri �v���p�e�B:
%    Constraints		  - �ۂ�����G�b�W�̐���� 2D �̂�
%    X                - �O�p�`�������̓_�̍��W
%    Triangulation		- �v�Z�����O�p�`����
%
% �Q�l demoDelaunayTri, TriRep, triplot, trisurf, tetramesh, 
%      TriScatteredInterp.


%   Copyright 2008-2009 The MathWorks, Inc.
