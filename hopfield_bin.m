n=8;
samples=3;
%input data


x=[0 0 1 0 1 0 0 0;
   0 0 0 0 0 1 0 0;
   0 1 0 0 0 1 0 1];


fprintf('\n');

%data to recognise
y=[0 0 1 0 1 0 0 0];

%Learning the input. Calculate weight matrix
%W = zeros(n,n);
W=sign(normrnd(0,1,n,n));
W(logical(eye(size(W)))) = 0;

for count = 1:size(x,1)
    for i = 1:n
        for j= i+1:n
        W(i,j)= W(i,j)+((2*x(count,i)-1) * (2*x(count,j)-1));
        W(j,i)= W(i,j);
        end
    end
    
end

removed=randi(n);
for i=1:size(W,1)
    W(removed,i)=0;
    W(i,removed)=W(removed,i);
end    

flag=true;
iteration=0;
index=1;
lastchange=0;

while flag
    iteration=iteration+1;
    i=randi([1,n],1,1);
    sum=0;
    for j=1:n
        sum=sum+W(j,i)*y(index,j);
    end
    changed=0;
    out=0;
    if sum>=0
        out=1;
    end
    if sum<0
        out=0;
    end
    if y(index,i)~=out
        changed=1;
        y(index,i)=out;
    end
    
    if changed==1
        lastchange=iteration;
    end
    
    if iteration - lastchange > 1000
        flag=false;
    end
end
    
for i=1:n
    fprintf('%i ',y(i));
end    
fprintf('\n');

%for i=1:size(W,1)
 %   for j=1:size(W,2)
  %      fprintf('%i ',W(i,j))
   % end
    %fprintf('\n')
%end



    
