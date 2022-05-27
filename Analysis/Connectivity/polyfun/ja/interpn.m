%INTERPN  N ������� (table lookup)
%
%   VI = INTERPN(X1,X2,X3,...,V,Y1,Y2,Y3,...) �́A�z�� Y1, Y2, Y3...�̓_�� 
%   N �����֐� V �̒l VI �����߂邽�߂ɕ�Ԃ��܂��BN �����z�� V �ɑ΂��āA
%   INTERPN �� 2*N+1 �̈������g���ČĂяo�����K�v������܂��B
%   �z�� X1, X2, X3...�́A�f�[�^ V ���^������_���w�肵�܂��B�͈͊O�̒l�́A
%   NaN �Ƃ��ĕԂ���܂��BY1, Y2, Y3... �́A�����T�C�Y�̔z��܂��̓x�N�g����
%   �Ȃ���΂Ȃ�܂���B�x�N�g�������������T�C�Y�łȂ��A���������݂��� 
%   (���Ȃ킿�A�s�Ɨ�x�N�g���̗���������) �ꍇ�AMESHGRID �ɓn����A�z�� 
%   Y1, Y2, Y3 ���쐬���܂��BINTERPN �́A2 �����ȏ�� N �����z��ɑ΂��ċ@�\���܂��B
%
%   VI = INTERPN(V,Y1,Y2,Y3,...) �́AX1 = 1:SIZE(V,1), X2 = 1:SIZE(V,2)... ��
%   ���肵�܂��BVI = INTERPN(V,NTIMES) �́A�ċA�I�� NTIMES ��A�v�f�Ԃ̕�Ԃ�
%   �J��Ԃ����Ƃɂ��AV ���g�����܂��B
%   VI = INTERPN(V) �́AINTERPN(V,1) �Ɠ����ł��B
%
%   VI = INTERPN(...,METHOD) �́A��Ԏ�@���w�肵�܂��B�f�t�H���g�́A
%   ���`��Ԃł��B�g�p�\�Ȏ�@�͈ȉ��̂Ƃ���ł��B
%
%     'nearest' - �ŋߖT���
%     'linear'  - ���`���
%     'spline'  - �X�v���C�����
%     'cubic'   - �f�[�^�����Ԋu�̏ꍇ�A�o�O����ԁA�����łȂ��ꍇ�� 
%                 'spline' �Ɠ���
%
%   VI = INTERPN(...,METHOD,EXTRAPVAL) �́AX1,X2,... �ō쐬���ꂽ�̈�̊O��
%   �� VI �̗v�f�ɑ΂��Ďg�p����O�}�@�ƒl���w�肷��̂Ɏg���܂��B�������āA
%   VI �� X1,X2,... �̂��ꂼ��ɂ��쐬����Ă��Ȃ��AY1,Y2,.. �̂����ꂩ��
%   �l�ɂ��� EXTRAPVAL �ɓ������Ȃ�܂��B�g�p����� EXTRAPVAL �ɑ΂��āA
%   ���\�b�h���w�肳��Ȃ���΂Ȃ�܂���B�f�t�H���g�̃��\�b�h�� 'linear' �ł��B
%
%   INTERPN �́AX1, X2, X3... ���P���֐��ŁA(NDGRID �ō쐬�������̂Ɠ��l) 
%   �i�q�`�łȂ���΂Ȃ�܂���BX1, X2, X3... �́A���Ԋu�łȂ��ꍇ������܂��B
%
%   ���Ƃ��΁Ainterpn �́A�ȉ��̊֐����Ԃ��邽�߂Ɏg���܂��B
%      f = @(x,y,z,t) t.*exp(-x.^2 - y.^2 - z.^2);
%
%   ndgrid �ō��ꂽ�O���b�h��̊֐� f ��]�����邱�ƂŁA���b�N�A�b�v
%   �e�[�u�����쐬���܂��B
%      [x,y,z,t] = ndgrid(-1:0.2:1,-1:0.2:1,-1:0.2:1,0:2:10);
%      v = f(x,y,z,t);
%
%   ���ׂ����O���b�h���쐬���܂��B
%      [xi,yi,zi,ti] = ndgrid(-1:0.05:1,-1:0.08:1,-1:0.05:1,0:0.5:10);
%
%   �X�v���C�����g�����Ƃɂ��A�ׂ����O���b�h�� f ���Ԃ��܂��B
%      vi = interpn(x,y,z,t,v,xi,yi,zi,ti,'spline');
%
%   �Ō�ɁA�֐���\�����܂��B
%      nframes = size(ti, 4);
%      for j = 1:nframes
%         slice(yi(:,:,:,j), xi(:,:,:,j), zi(:,:,:,j), vi(:,:,:,j),0,0,0);
%         caxis([0 10]);
%         M(j) = getframe;
%      end
%      movie(M);
%
%   �f�[�^���͂ɑ΂���N���X�T�|�[�g:
%      float: double, single
%
%   �Q�l INTERP1, INTERP2, INTERP3, NDGRID.


%   Copyright 1984-2007 The MathWorks, Inc.
