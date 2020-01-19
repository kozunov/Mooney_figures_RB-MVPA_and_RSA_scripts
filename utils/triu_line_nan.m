function out = triu_line_nan(in)

out=[];
l = length(in);
for i=1:l-1
    for j=i+1:l
        if ~isnan(in(i,j))
            out = [out in(i,j)];
        end
    end
end