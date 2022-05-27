function plotGraph(data, C, linecolor)
%
%
% plotGraph plots a 2D/3D graph representation of instances in data 
% connected by a connectivity matrix C
%
%
% [INPUT]
%
%   data:   matrix, m-by-2 or m-by-3
%   
%           rows:   m data points
%           cols:   2D or 3D coordinates
%
%   C:      matrix, m-by-m
%           
%           connectivity matrix between data points
%
%
% [OUTPUT]
%
%   hfig:   figure handle
%
%
% Created:  nrg 03112013-2201
% 
% Tested:   nrg 03112013-2329 [OK]
%
%

dims = size(data);

if numel(dims)==2
    m = dims(1);
    d = dims(2);
else
    disp('Woah... the data seems be in the wrong format!');
    help plotGraph;
    return;
end

 
hold on; 
if d == 2       % 2D plot
    
    plot(data(:,1), data(:,2), 'o');
    
elseif d == 3   % 3D plot
    
    plot3(data(:,1), data(:,2), data(:,3), 'o');
    
else
    disp('Woah... too many dimensions here!!!');
    help plotGraph;
    return;
end
 

% connect neighbours
for i = 1:m

    nb = find(C(i,:));

    for j = 1:numel(nb)
        
        if d == 2
            
            line([data(i,1) data(nb(j),1)], [data(i,2) data(nb(j),2)], 'Color', linecolor); 
        
        elseif d == 3
        
            line([data(i,1) data(nb(j),1)], [data(i,2) data(nb(j),2)], [data(i,3) data(nb(j),3)], 'Color', linecolor); 
            
        end
    end

end


% hold off;



end

