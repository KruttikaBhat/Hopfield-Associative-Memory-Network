n=30;
samples=3;
%input data


x=[0 1 1 1 0 1 0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 0 0 0 1 0 1 1 1 0;
   1 1 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 1 1 0 1 1;
   1 0 0 1 0 0 0 0 0 1 0 0 0 1 1 0 1 1 0 0 1 0 0 0 0 1 1 0 0 1];

fprintf('\n');

%data to recognise
y=[0 1 0 1 1 1 0 0 0 1 0 1 0 0 1 1 0 0 0 1 1 0 0 1 0 1 0 1 1 0];

%W=sign(normrnd(0,1,n,n));
%W(logical(eye(size(W)))) = 0;
W=zeros(n,n);

figure('Name','Before','NumberTitle','off');
before=imagesc(reshape(y,5,6))

%Storkey learning algorithm. Works if W is initially zero.
%
% 
% 
% for k=1:samples
%     for i=1:n
%         for j=1:n
%             hij=0;
%             hji=0;
%             for p=1:n
%                 if p~=i && p~=j
%                     hij=hij+W(i,p)*x(k,p);
%                     hji=hji+W(j,p)*x(k,p);
%                 end
%             end
%             W(i,j)=W(i,j)+((2*x(k,i)-1)*(2*x(k,j)-1)/n) - ((2*x(k,i)-1)*hji/n) - ((2*x(k,j)-1)*hij/n);
%         end
%     end
% 
% end
% 
% 
% W


%Learning the input. Calculate weight matrix

 
%given by sir. Works if W intialised with 0 

% ep=0.001;
% 
% for k=1:samples
%     for i=1:n
%         for j=1:n
%             W(i,j)=(1-ep).*W(i,j)+(ep*(2*x(k,i)-1)*(2*x(k,j)-1));
%         end
%     end
% end
% W

%one shot learning algorithm
for count = 1:size(x,1)
    for i = 1:n
        for j= i+1:n
        W(i,j)= W(i,j)+((2*x(count,i)-1) * (2*x(count,j)-1));
        W(j,i)= W(i,j);
        end
    end
    
end
W
% 
% removed=randi(n);
% for i=1:size(W,1)
%     W(removed,i)=0;
%     W(i,removed)=W(removed,i);
% end    

iteration=0;
lastchange=0;
flag=true;

while flag
    iteration=iteration+1;
    
    i=randi([1,n],1,1);
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
    fprintf('Iteration: %i, Node: %i, sum: %i, out: %i, updated: ',iteration,i,sum,out);    
    for i=1:n
        fprintf('%i ',y(i));
    end    
    fprintf('\n');
end



figure('Name','After','NumberTitle','off');
after=imagesc(reshape(y,5,6))
  

%for i=1:size(W,1)
 %   for j=1:size(W,2)
  %      fprintf('%i ',W(i,j))
   % end
    %fprintf('\n')
%end
