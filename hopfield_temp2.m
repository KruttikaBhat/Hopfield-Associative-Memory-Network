
samples=3;
%input data

x=zeros(samples,8);
n=size(x,2);

% for i=1:samples
%     for j=1:int32(0.2*n)
%         index=randi(n);
%         x(i,index)=1;
%     end
% end

x=[0 0 1 0 1 0 0 0;
   0 0 0 0 0 1 0 0;
   0 1 0 0 0 1 0 1];

y=[0 0 1 0 1 0 0 0];
% 
%  test=1;
%  %data to recognise
%  y=flipbit(x,test,2);

%Learning the input. Calculate weight matrix
W = zeros(n,n);


for i = 1:n
    for j= i+1:n
        for count=1:size(x,1)
            W(i,j)= W(i,j)+((2*x(count,i)-1) * (2*x(count,j)-1));
            W(j,i)= W(i,j);
        end
    end
    
end

W

% figure('Name','Before','NumberTitle','off');
% before=imagesc(reshape(y,2,4))


% removed=randi(n);
% for i=1:size(W,1)
%     W(removed,i)=0;
%     W(i,removed)=W(removed,i);
% end    

flag=true;
iteration=0;
index=1;
lastchange=0;

while flag
    iteration=iteration+1;
    i=randi(n);
    sum=0;
    for j=1:n
        sum=sum+W(j,i)*(2*y(j)-1);
    end
    changed=0;
    out=int32((sign(sum)+1)/2);
    if y(i)~=out
        changed=1;
        y(i)=out;
    end
    
    if changed==1
        lastchange=iteration;
    end
    
    if iteration - lastchange > 100
        flag=false;
    end
    fprintf('Iteration %i: ',iteration);    
    for i=1:n
        fprintf('%i ',y(i));
    end    
    fprintf('\n');
    energy=0;
    for m=1:n
        for l=1:n
            energy=energy-W(m,l)*y(m)*y(l);
        end    
    end
    fprintf('Energy: %i\n',energy);
end

% figure('Name','After','NumberTitle','off');
% after=imagesc(reshape(y,2,4))
% figure('Name','Required','NumberTitle','off');
% required=imagesc(reshape(x(1,:),2,4))
% 
% for i=1:n
%     if y(i)~=x(test,i)
%         fprintf('doesnt match at position %i\n',i);
%         break;
%     end    
% end
% 
% x
% y
% 
