
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

round=0;
correct=0;
incorrect=0;
 %data to recognise
 %y=flipbit(x,test,2);

%Learning the input. Calculate weight matrix
W=sign(normrnd(0,1,n,n));
W(logical(eye(size(W)))) = 0;
%W = zeros(n,n);

for i = 1:n
        for j= i+1:n
            for count=1:size(x,1)
                W(i,j)= W(i,j)+((2*x(count,i)-1) * (2*x(count,j)-1));
                W(j,i)= W(i,j);
            end
        end
    
end


while true
    ep=0.05;
    y=[0 0 1 0 1 0 0 0];
    test=1;
    round=round+1;
    %network evolves only in every 3rd iteration
    %if mod(round,3)==0 
        for i = 1:n
            for j= i+1:n
                for count=1:size(x,1)
                    W(i,j)= (1-ep).*W(i,j)+((2*x(count,i)-1) * (2*x(count,j)-1));
                    W(j,i)= W(i,j);
                end
            end
        end
    %end
    W
    %check if network still holds the memory
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
        fprintf('Iteration: %i, Node: %i, sum: %i, out: %i, updated: ',iteration,i,sum,out);    
        for i=1:n
            fprintf('%i ',y(i));
        end    
        fprintf('\n');
%         energy=0;
%         for m=1:n
%             for l=1:n
%                 energy=energy-W(m,l)*y(m)*y(l);
%             end    
%         end
%         fprintf('Energy: %i\n',energy);
    end
    fprintf('\nRound %i: ',round);
    for i=1:n
        fprintf('%i ',y(i));
    end   
    
    %update error percentage
    for i=1:n
        if y(i)~=x(test,i) && mod(round,3)==0
            incorrect=incorrect+1;
            break
        end    
    end
    
    error=incorrect/round;
    fprintf(' Error percentage: %f',error);
    
    %remove a node
    removed=randi(n);
    W(removed,:)=zeros(1,n);
    %W(removed,:)=sign(randn(1,n));
    W(:,removed)=W(removed,:);
    %W(removed,removed)=0;
    
    %wait 1 second
    pause(1);
end    



% 
% figure('Name','Before','NumberTitle','off');
% before=imagesc(reshape(y,2,4))

% figure('Name','After','NumberTitle','off');
% after=imagesc(reshape(y,2,4))
% figure('Name','Required','NumberTitle','off');
% required=imagesc(reshape(x(1,:),2,4))

% for i=1:n
%     if y(i)~=x(test,i)
%         fprintf('doesnt match at position %i\n',i);
%         break;
%     end    
% end


 
