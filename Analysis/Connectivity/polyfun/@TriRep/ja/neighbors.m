%neighbors  �V���v���b�N�X�̋ߖT�����o��
%
%   SN = neighbors(TR, SI) �́A�w�肵���V���v���b�N�X SI �ɑ΂���V���v���b�N�X
%   �̋ߖT����Ԃ��܂��B�V���v���b�N�X�́A�O�p�`/�l�ʑ́A�܂��͂�荂��������
%   ����������̂ł��BSI �́A�O�p�`�����̍s�� TR.Triangulation �ւ̃C���f�b�N�X
%   �������V���v���b�N�X�̗�x�N�g���ł��BSN �� m �s n ��̍s��ł��B�����ŁA
%   m �͎w�肵���V���v���b�N�X�̐� length(SI) �ŁAn �̓V���v���b�N�X���Ƃ̋ߖT��
%   ���ł��B�e�s SN(i,:) �́A�V���v���b�N�X SI(i) �̋ߖT��\���܂��BSI ���w��
%   ����Ȃ��ꍇ�A�O�p�`�����S�̂ɑ΂���ߖT�̏�񂪕Ԃ���܂��B
%   �����ŁA�V���v���b�N�X i �Ɋւ���ߖT�́ASN �� i �Ԗڂ̍s�Œ�`����܂��B
%
%   �֋X��A�V���v���b�N�X SI(i) �̃V���v���b�N�X�̔��΂̒��_ (j) �� SN(i,j) 
%   �ł��B�V���v���b�N�X�ɕ����̋��E�̏��ʂ�����ꍇ�A���݂��Ȃ��ߖT�� NaN ��
%   ������܂��B
%
%   �� 1: 2D �̎O�p�`������ǂݍ��݁ATriRep ���g�p���ĎO�p�`�̋ߖT���v�Z���܂��B
%       load trimesh2d
%       % ����͎O�p�`���� tet �ƒ��_�̍��W X ��ǂݍ��݂܂��B
%       trep = TriRep(tri,x,y)
%       triplot(trep);
%       nbrs = neighbors(trep,119)
%       trigroup = [119, 2 29 108]';
%       ic = incenters(trep, trigroup);
%       hold on
%       axis([-50 350 -50 350]);
%       axis equal;
%       trilabels = arrayfun(@(x) {sprintf('T%d', x)}, trigroup);
%       Htl = text(ic(:,1), ic(:,2), trilabels, 'FontWeight', 'bold', ...
%               'HorizontalAlignment', 'center', 'Color', 'red');
%       hold off
%
%   �� 2: DelaunayTri ���g���č쐬���� 2D �̎O�p�`�����𒼐ڒ��ׂ܂��B
%       % �P�ʐ����`���̗������� 2D �� Delaunay �O�p�`�������v�Z���܂��B
%       x = rand(10,1)
%       y = rand(10,1)
%       dt = DelaunayTri(x,y)
%       % 1 �Ԗڂ̎O�p�`�̋ߖT�����߂܂��B
%       n1 = neighbors(dt, 1)
%
%
%   �Q�l TriRep, DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
