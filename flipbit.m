function y=flipbit(x,sample,numflips)
y=x(sample,:);

for i=1:numflips 
    index=randi(size(x,2));
    if y(index) == 1
        y(index)= 0;
    else
        y(index) = 1;
    end    
end