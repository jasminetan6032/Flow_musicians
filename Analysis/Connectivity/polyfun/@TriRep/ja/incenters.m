%incenters  �w�肵���V���v���b�N�X�̓��_���o��
%
%   IC = incenters(TR, SI) �́A�w�肵���V���v���b�N�X SI ���Ƃ̓��_�̍��W��
%   �Ԃ��܂��B�V���v���b�N�X�́A�O�p�`/�l�ʑ́A�܂��͂�荂�������ɑ�������
%   ���̂ł��BSI �́A�O�p�`�����̍s�� TR.Triangulation �ւ̃C���f�b�N�X������
%   �V���v���b�N�X�̗�x�N�g���ł��BIC �� m �s n ��̍s��ł��B�����ŁAm ��
%   �w�肵���V���v���b�N�X�̐� length(SI) �ŁAn �͎O�p�`���������݂����Ԃ�
%   �����ł��B�e�s IC(i,:) �́A�V���v���b�N�X SI(i) �̓��_�̍��W��\���܂��B
%   SI ���w�肳��Ȃ��ꍇ�A�O�p�`�����S�̂ɑ΂�����_�̏�񂪕Ԃ���܂��B
%   �����ŁA�V���v���b�N�X i �Ɋւ�����_�́AIC �� i �Ԗڂ̍s�ɂȂ�܂��B
%
%   �� 1: 3D �̎O�p�`������ǂݍ��݁ATriRep ���g�p���čŏ��� 5 �̎l�ʑ̂�
%         ���_���v�Z���܂��B
%       load tetmesh
%       % ����͎O�p�`���� tet �ƒ��_�̍��W X ��ǂݍ��݂܂��B
%       trep = TriRep(tet, X)
%       ic = incenters(trep, [1:5]')
%
%   �� 2: DelaunayTri ���g���č쐬���� 2D �̎O�p�`�����𒼐ڒ��ׂ܂��B
%            �O�p�`�̓��_���v�Z���A�O�p�`�Ɠ��_���v���b�g���܂��B
%       x = [0 1 1 0 0.5]';
%       y = [0 0 1 1 0.5]';
%       dt = DelaunayTri(x,y);
%       ic = incenters(dt);
%       % �O�p�`�Ɠ��_��\��
%       triplot(dt);
%       axis equal;
%       axis([-0.2 1.2 -0.2 1.2]);
%       hold on; plot(ic(:,1),ic(:,2),'*r'); hold off;
%
%   �Q�l TriRep, TriRep.circumcenters, DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
