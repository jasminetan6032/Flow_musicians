%circumcenters  �w�肵���V���v���b�N�X�̊O�S���o��
%
%   CC = circumcenters(TR, SI) �́A�w�肵���V���v���b�N�X SI ���Ƃ̊O�S��
%   ���W��Ԃ��܂��B�V���v���b�N�X�́A�O�p�`/�l�ʑ́A�܂��͂�荂��������
%   ����������̂ł��BSI �́A�O�p�`�����̍s�� TR.Triangulation �ւ�
%   �C���f�b�N�X�������V���v���b�N�X�̗�x�N�g���ł��BCC �� m �s n ��̍s��ł��B
%   �����ŁAm �͎w�肵���V���v���b�N�X�̐� length(SI) �ŁAn �͎O�p�`������
%   ���݂����Ԃ̎����ł��B�e�s CC(i,:) �́A�V���v���b�N�X SI(i) �̊O�S��
%   ���W��\���܂��BSI ���w�肳��Ȃ��ꍇ�A�O�p�`�����S�̂ɑ΂���O�S��
%   ��񂪕Ԃ���܂��B�����ŁA�V���v���b�N�X i �Ɋւ���O�S�́ACC �� 
%   i �Ԗڂ̍s�ɂȂ�܂��B
%
%   �� 1: 2D �̎O�p�`������ǂݍ��݁A�O�S���v�Z���邽�߂� TriRep ���g�p���܂��B
%       load trimesh2d
%       % ����͎O�p�`���� tri �ƒ��_�̍��W x, y ��ǂݍ��݂܂��B
%       trep = TriRep(tri, x,y)
%       cc = circumcenters(trep);
%       triplot(trep);
%       axis([-50 350 -50 350]);
%       axis equal;
%       hold on; plot(cc(:,1),cc(:,2),'*r'); hold off;
%       % �O�S�́A���p�`�̒��Ԃ̓_��\���܂��B
%
%   �� 2: DelaunayTri ���g���č쐬���� 3D �̎O�p�`�����𒼐ڒ��ׂ܂��B
%            �ŏ��� 5 �̎l�ʑ̂̊O�S���v�Z���܂��B
%       X = rand(10,3);
%       dt = DelaunayTri(X);
%       cc = circumcenters(dt, [1:5]')
%
%   �Q�l TriRep, TriRep.incenters, DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
