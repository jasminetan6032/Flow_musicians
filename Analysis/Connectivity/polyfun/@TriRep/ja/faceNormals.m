%faceNormals  �w�肵���O�p�`�̒P�ʖ@�����o��
%
%   ���̃N�G���[�́A�O�p�`�̕\�ʃ��b�V���ɂ̂ݓK�p�\�ł��B
%   FN = faceNormals(TR, TI) �́A�w�肵���O�p�` TI �̂��ꂼ��̒P�ʖ@��
%   �x�N�g����Ԃ��܂��B�����ŁATI �͎O�p�`�����̍s�� TR.Triangulation ��
%   �C���f�b�N�X�̗�x�N�g���ł��BFN �� m �s 3 ��̍s��ł��B�����ŁAm ��
%   �ƍ�����O�p�`�̐� length(TI) �ł��B�e�s FN(i,:) �́A�O�p�` TI(i) ��
%   �P�ʖ@���x�N�g����\���܂��BTI ���w�肳��Ȃ��ꍇ�A�O�p�`�����S�̂�
%   �΂���P�ʖ@���̏�񂪕Ԃ���܂��B�����ŁA�O�p�` i �Ɋւ���P�ʖ@���́A
%   FN �� i �Ԗڂ̍s�ɂȂ�܂��B
%
%   ��:
%   % ���̂̕\�ʏ�̗����̕W�{���O�p�`�������ATriRep ���g���Ċe�O�p�`��
%   % �@�����v�Z���܂��B
%     % quiver �v���b�g���g���Č��ʂ�\�����܂��B
%       numpts = 100;
%       thetha = rand(numpts,1)*2*pi;
%       phi = rand(numpts,1)*pi;
%       x = cos(thetha).*sin(phi);
%       y = sin(thetha).*sin(phi);
%       z = cos(phi);
%       dt = DelaunayTri(x,y,z);
%       [tri Xb] = freeBoundary(dt);
%       tr = TriRep(tri, Xb);
%       P = incenters(tr);
%       fn = faceNormals(tr);
%       trisurf(tri,Xb(:,1),Xb(:,2),Xb(:,3),'FaceColor', 'cyan', 'faceAlpha', 0.8);
%       axis equal;
%       hold on;
%       quiver3(P(:,1),P(:,2),P(:,3),fn(:,1),fn(:,2),fn(:,3),0.5, 'color','r');
%       hold off;
%
%   �Q�l TriRep, DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
