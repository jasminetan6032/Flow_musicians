%featureEdges  �\�ʂ̎O�p�`�����̉s���G�b�W���o��
%
%   ���̃N�G���[�́A�O�p�`�̕\�ʃ��b�V���ɂ̂ݓK�p�\�ł��B
%   FE = featureEdges(TR, FILTERANGLE) �́A�אڂ���O�p�`�� FILTERANGLE 
%   �ȏ�̊p�x�� PI ����h�������ʊp�����O�p�`�����̃G�b�W��\���s�� 
%   FE ��Ԃ��܂��B���̕��@�́A��ʓI�ɕ\���ړI�ŕ\�ʃ��b�V�����̉s��
%   �G�b�W�𒊏o���邽�߂Ɏg���܂��B1 �̎O�p�`�ł̂݋��L�����G�b�W�� 
%   2 �ȏ�̎O�p�`�ŋ��L�����G�b�W�́A�f�t�H���g�� feature �G�b�W��
%   �Ȃ�ƍl�����܂��B
%   FE �� m �s 2 ��̃T�C�Y�ł��B�����ŁAm �̓��b�V�����̎��R�G�b�W�̐��ł��B
%   �G�b�W�̃C���f�b�N�X�̒��_�́A���_�̍��W TR.X ��\���_�̔z��ł��B
%
%   ��:
%       % �\�ʂ̎O�p�`�������쐬���Afeature �G�b�W�𒊏o���܂��B
%       x = [0 0 0 0 0 3 3 3 3 3 3 6 6 6 6 6 9 9 9 9 9 9]';
%       y = [0 2 4 6 8 0 1 3 5 7 8 0 2 4 6 8 0 1 3 5 7 8]';
%       dt = DelaunayTri(x,y);
%       tri = dt(:,:);
%       % �\�ʂ��쐬���邽�߂� 2D ���b�V�����������܂��B
%       z = [0 0 0 0 0 2 2 2 2 2 2 0 0 0 0 0 0 0 0 0 0 0]';
%       subplot(1,2,1);
%       trisurf(tri,x,y,z, 'FaceColor', 'cyan'); axis equal;
%       title(sprintf('TRISURF display of surface mesh\n showing mesh edges\n'));
%       % pi/4 �̃t�B���^�̊p�x���g���� feature �G�b�W���v�Z���܂��B
%       tr = TriRep(tri, x,y,z);
%       fe = featureEdges(tr,pi/6)';
%       subplot(1,2,2);
%	      trisurf(tr, 'FaceColor', 'cyan', 'EdgeColor','none', ...
%          'FaceAlpha', 0.8); axis equal;
%       % feature �G�b�W��ǉ�
%	      hold on; plot3(x(fe), y(fe), z(fe), 'k', 'LineWidth',1.5); hold off;
%       title(sprintf('TRISURF display of surface mesh\n suppressing mesh edges\nand showing feature edges'));
%
%   �Q�l TriRep, DelaunayTri.


%   Copyright 2007-2009 The MathWorks, Inc.
