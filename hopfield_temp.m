
samples=3;
%input data

x=[0 0 1 0 1 0 0 1;
   0 0 0 0 0 1 0 0;
   0 1 1 0 0 1 0 1];


n=size(x,2);

%data to recognise
y=[1 1 1 0 1 1 0 1];

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



figure(1)
before=imagesc(y)


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


figure(2)
after=imagesc(y)

%for i=1:size(W,1)
 %   for j=1:size(W,2)
  %      fprintf('%i ',W(i,j))
   % end
    %fprintf('\n')
%end


