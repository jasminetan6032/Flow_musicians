%cartToBary �_�̍��W�𒼌����W����d�S���W�ɕϊ�
%
%   B = cartToBary(TR, SI, XC) �́A�V���v���b�N�X SI �ɑ΂��� XC ���̊e�_��
%   �d�S���W��Ԃ��܂��B�V���v���b�N�X�́A�O�p�`/�l�ʑ́A�܂��͂�荂��������
%   ����������̂ł��BSI �́A�O�p�`�����̍s�� TR.Triangulation �ւ̃C���f�b�N�X��
%   �����V���v���b�N�X�̗�x�N�g���ł��BXC �́A�ϊ�����_�̒������W��\���s��ł��B
%   B �� m �s n ��̃T�C�Y�ł��B�����ŁAm �͕ϊ�����_�� length(SI) �ŁAn ��
%   �O�p�`���������݂����Ԃ̎����ł��BB �́A�V���v���b�N�X SI �ɑ΂���_ XC ��
%   �d�S���W��\���܂��B���Ȃ킿�A�V���v���b�N�X SI(j) �ɑ΂���_ XC(j) ��
%   �������W�� B(j) �ɂȂ�܂��BB �́Am �s k ��̎����̍s��ł��B�����ŁAk ��
%   �V���v���b�N�X���Ƃ̒��_�̐��ł��B
%
%   �� 1: �_�W���� Delaunay �O�p�`�������v�Z���܂��B
%              ���_�̏d�S���W���v�Z���܂��B
%              �O�p�`������ "�g��" ���A�ό`�����O�p�`������̃}�b�s���O����
%              ���_�̈ʒu���v�Z���܂��B
%
%       x = [0 4 8 12 0 4 8 12]';
%       y = [0 0 0 0 8 8 8 8]';
%       dt = DelaunayTri(x,y)
%       cc = incenters(dt);
%       tri = dt(:,:);
%       subplot(1,2,1);
%       triplot(dt); hold on;
%       plot(cc(:,1), cc(:,2), '*r'); hold off;
%       axis equal;
%       title(sprintf('Original triangulation and reference points.\n'));
%       b = cartToBary(dt,[1:length(tri)]',cc);
%       % �g�債���O�p�`�����̕\�����쐬���܂��B
%       y = [0 0 0 0 16 16 16 16]';
%       tr = TriRep(tri,x,y)
%       xc = baryToCart(tr, [1:length(tri)]', b);
%       subplot(1,2,2);
%       triplot(tr); hold on;
%       plot(xc(:,1), xc(:,2), '*r'); hold off;
%       axis equal;
%       title(sprintf('Deformed triangulation and mapped\n locations of the
%       reference points.\n'));
%
%
%   �Q�l TriRep, TriRep.baryToCart, DelaunayTri, DelaunayTri.pointLocation.


%   Copyright 2008-2009 The MathWorks, Inc.
