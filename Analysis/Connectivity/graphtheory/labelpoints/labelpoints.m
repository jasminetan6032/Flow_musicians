function h = labelpoints (xpos, ypos, labels, position, buffer, adjust_axes)
%  h = labelpoints (xpos, ypos, labels, position, buffer, adjust_axes)
%
%   Given x and y position vectors (xpos, ypos) and given 
%     a row vector of labels of equal length to xpos & ypos vectors,
%     this script will label all data points and output the label 
%     handles in vector, h.  
%
%   'labels' needs to be of class 'cell' or a number vector (double).
%
%   The position of the labels relative to the data points 
%     can be set by 'position' by entering one of the following
%     strings.  (optional!  default is 'NW')
%       N, S, E, W, NE, NW, SE, SW, center
%       where each represents a direction on a compass relative to xpos & ypos.
%
%   buffer (optional) is a number between 0:1 that adds distance between
%     the label and the plotted point where 0 (default) is none and 1 is
%     1/10th of the axis (x-axis or y-axis depending on label position).  Ignored for 'center' position.
%
%   adjust_axes (optional, default=0): depending on the positioning of labels, some may
%     fall beyond the axis limits. adjust_axes = 1 will readjust xlim & ylim slightly
%     so labels are not beyond axis limits.
%
%   Example:  
%             x = 1:10;  y=rand(1,10); 
%             scatter(x,y)
%             labs = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j'};
%             txt_h = labelpoints(x, y, labs, 'E', 0.2, 1);
%             set(txt_h, 'FontSize', 8)
%
%             Also works for     
%               labs = [1:1:10];
%               labs = {'Sofia' '' '' '' 'Bucharest' '' '' 'Belgrade' '' 'Ankara'}
%               labs = {'' '' '*' '**' '' '***' '*' '' '' '*'}
%
%   Alternative use: 
%            x = randn(1,100); y = 1:100;  
%            scatter(x,y)
%            labs = repmat({'|'},[1,100]);
%            txt_h = labelpoints(x, repmat(8,[1,100]), labs, 'center');
%
%   Use this for single texts, too
%           x = 2004:2013;  y=rand(1,10); 
%           plot(x,y,'-o')
%           labs = {'acquisition'};
%           txt_h = labelpoints(x(3), y(3), labs, 'N', 0.2, 1);
%
%  140331 Danz  
%   adam%danz@gmail.com

% Copyright (c) 2014, Adam Danz
%All rights reserved

%check that x, y, and labels are same length
if isequal(length(xpos), length(ypos), length(labels)) == 0
    error('xpos, ypos, and labels must all be the same length')
end

if nargin <4 || isempty(position)
    position = 'NW';
end

if nargin <5 || isempty(buffer)
    buffer = 0;
end

if nargin <6 || isempty(adjust_axes)
    adjust_axes = 0;
end

a = axis/10;% I've somewhat arbitrarily divided by 10 to make 'buffer' more sensitive
u1 = 0;     %x offset
u2 = 0;     %y offset

%assign position
switch position 
    case 'E',       va = 'middle'; ha = 'left';         u1 = a(2)-a(1);         
    case 'W',       va = 'middle'; ha = 'right';        u1 = (a(2)-a(1))*-1;
    case 'N',       va = 'bottom'; ha = 'center';       u2 = a(4)-a(3);
	case 'S',       va = 'top'; ha = 'center';          u2 = (a(4)-a(3))*-1;
	case 'NE',      va = 'bottom'; ha = 'left';         u1 = (a(2)-a(1))/2;     u2 = (a(4)-a(3))/2;
    case 'NW',      va = 'bottom'; ha = 'right';        u1 = (a(2)-a(1))*-0.5;  u2 = (a(4)-a(3))/2;
	case 'SE',      va = 'top'; ha = 'left';            u1 = (a(2)-a(1))/2;     u2 = (a(4)-a(3))*-0.5;
    case 'SW',      va = 'top'; ha = 'right';           u1 = (a(2)-a(1))*-0.5;  u2 = (a(4)-a(3))*-0.5;
    case 'center',  va = 'middle'; ha = 'center';    
end

%Factor in buffer
u1 = u1*buffer;
u2 = u2*buffer;


%If labels are number, change them to cell
if isnumeric(labels) == 1
    labels = num2cell(labels); 
end

h = text(xpos+u1 , ypos+u2, labels, 'VerticalAlignment',va, 'HorizontalAlignment',ha);

%Determine if any labels go beyond axis limits and adjust if desired
if adjust_axes == 1
    x_adj = sign(u1+0.0000001);                 %the addition is to avoid '0'
    y_adj = sign(u2+0.0000001);                 %the addition is to avoid '0'

    labelextent = get(h, 'extent');
    if isequal(class(labelextent),'cell')
        labelextent = cat(1, labelextent{:});
    end
    xl = xlim;      yl = ylim;
    lablimX = [min(labelextent(:,1)), max(labelextent(:,1)+(labelextent(:,3).*x_adj))] +u1;
    lablimY = [min(labelextent(:,2)), max(labelextent(:,2)+(labelextent(:,4).*y_adj))] +u2;

    xlim([min(min(xl), min(lablimX)), max(max(xl), max(lablimX))])
    ylim([min(min(yl), min(lablimY)), max(max(yl), max(lablimY))])


end


%% Notes
% a vid explaining this method:  http://blogs.mathworks.com/videos/2012/05/30/how-to-label-a-series-of-points-on-a-plot-in-matlab/
% Text properties :  http://www.mathworks.com/help/matlab/ref/text_props.html
