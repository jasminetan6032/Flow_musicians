%vertexAttachments  �w�肵�����_�ɒǉ�����V���v���b�N�X���o��
%
%   SI = vertexAttachments(TR, VI) �́A�w�肵�����_ VI �ɑ΂��钸�_-�V���v���b�N�X
%   ����Ԃ��܂��B�V���v���b�N�X�́A�O�p�`/�l�ʑ́A�܂��͂�荂�������ɑ�������
%   ���̂ł��BVI �́A���_�̍��W TR.X ��\���_�̔z��ւ̃C���f�b�N�X�̗�x�N�g���ł��B
%   ���_ i �Ɋւ���V���v���b�N�X�́A�Z���z����� i �Ԗڂ̗v�f�ł��B
%   VI ���w�肳��Ȃ��ꍇ�A�O�p�`�����S�̂ɑ΂��钸�_-�V���v���b�N�X���
%   �Ԃ���܂��B�����ŁA���_ i �Ɋւ���V���v���b�N�X�́A�Z���z�� SI ���� 
%   i �Ԗڂ̗v�f�ɂȂ�܂��B�Z���z��́A�e���_�Ɋւ���V���v���b�N�X�̐���
%   �ω����邽�߁A����ۑ����邽�߂Ɏg���܂��B
%
%   2D �̎O�p�`�����Ɋւ��āA�O�p�`��������v�������������ꍇ�A�e�Z������
%   �O�p�`�́A�e���_�̂܂��ɘA���I�ɕ��ׂ��܂��B
%
%   �� 1: 2D �̎O�p�`������ǂݍ��݁ATriRep ���g�p���Ē��_�ƎO�p�`�̊֌W��
%         �v�Z���܂��B
%       load trimesh2d
%       % ����͎O�p�`���� tet �ƒ��_�̍��W X ��ǂݍ��݂܂��B
%       trep = TriRep(tri, x, y);
%       Tv = vertexAttachments(trep, 1)
%       % 1 �Ԗڂ̒��_�ɒǉ����ꂽ�l�ʑ̂̃C���f�b�N�X
%       Tv{:}
%
%   �� 2: DelaunayTri ���g���č쐬���� 2D �̎O�p�`�����𒼐ڒ��ׂ܂��B
%       x = rand(20,1);
%       y = rand(20,1);
%       dt = DelaunayTri(x,y);
%       t = vertexAttachments(dt,5);
%       % ���_ 5 �ɒǉ������O�p�`��ԂŃv���b�g���܂��B
%       triplot(dt);
%       hold on; triplot(dt(t{:},:),x,y,'Color','r'); hold off;
%
%   �Q�l TriRep, DelaunayTri.


%   Copyright 2008-2009 The MathWorks, Inc.
