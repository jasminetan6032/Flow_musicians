%edges  �O�p�`�������̃G�b�W���o��
%
%   E = edges(TR) �́An �s 2 ��̍s��Ƃ��ĎO�p�`�����̃G�b�W��Ԃ��܂��B
%   n �̓G�b�W���ł��BTR.X �̃G�b�W�̃C���f�b�N�X�̒��_�́A���_�̍��W��
%   �\���_�̔z��ł��B
%
%   �� 1:
%       % 2D �̎O�p�`������ǂݍ��݁A�G�b�W�̏W�����쐬���邽�߂� TriRep ��
%       % �g�p���܂��B
%       load trimesh2d
%       % ����͎O�p�`���� tri �ƒ��_�̍��W x, y ��ǂݍ��݂܂��B
%       trep = TriRep(tri, x,y)
%       e = edges(trep)
%
%       % DelaunayTri ���g���č쐬���� 2D �� Delaunay �O�p�`�����𒼐�
%       % ���ׂ܂��B�O�̃P�[�X�Ɠ��l�ɃG�b�W�̏W�����쐬���܂��B
%       X = rand(10,2)
%       dt = DelaunayTri(X)
%       e = edges(dt)
%
%
%   �Q�l TriRep, DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
