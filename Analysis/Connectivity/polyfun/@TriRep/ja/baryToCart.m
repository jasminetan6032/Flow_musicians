%baryToCart  �_�̍��W���d�S���W���璼�����W�ɕϊ�
%
%   XC = baryToCart(TR, SI, B) �́A�V���v���b�N�X SI �ɑ΂��ďd�S���W��
%   �\�� B �̊e�_�̒������W XC ��Ԃ��܂��B�V���v���b�N�X�́A�O�p�`/�l�ʑ́A
%   �܂��͂�荂�������ɑ���������̂ł��BSI �́A�O�p�`�����̍s�� 
%   TR.Triangulation �ւ̃C���f�b�N�X�������V���v���b�N�X�̗�x�N�g���ł��B
%   B �́A�V���v���b�N�X SI �ɑ΂��ĕϊ����邽�߂̓_�̏d�S���W��\���s��ł��B
%   B �� m �s k ��̃T�C�Y�ł��B�����ŁAm �͕ϊ�����_�� length(SI) �ŁA
%   k �̓V���v���b�N�X���Ƃ̒��_�̐��ł��B
%
%   XC �́A�ϊ����ꂽ�_�̒������W��\���s��ł��BXC �́Am �s n ��̃T�C�Y��
%   ���B�����ŁAn �͎O�p�`�����̂����Ԃ̎����ł��B���Ȃ킿�A�V���v���b�N�X 
%   SI(j) �ɑ΂���_ B(j) �̒������W�� XC(j) �ɂȂ�܂��B
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
%       title(sprintf('Deformed triangulation and mapped\n locations of the reference points.\n'));
%
%
%   �Q�l TriRep, TriRep.cartToBary, DelaunayTri, DelaunayTri.pointLocation.


%   Copyright 2008-2009 The MathWorks, Inc.
