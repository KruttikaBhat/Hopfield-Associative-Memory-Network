t=0;

%input data

x=       [0 1 1 1 0; ...
          1 0 0 0 1; ...
          1 0 0 0 1; ...
          1 0 0 0 1; ...
          1 0 0 0 1;
          0 1 1 1 0];
      
x(:,:,2)=[1 1 1 0 0; 
          0 0 1 0 0; 
          0 0 1 0 0;
          0 0 1 0 0;
          0 0 1 0 0;
          1 1 1 1 1];
      
x(:,:,3)=[1 1 1 1 0; 
          0 0 0 0 1; 
          0 0 0 1 1;
          0 1 1 0 0;
          1 0 0 0 0;
          1 1 1 1 1];

x(:,:,4)=[1 1 1 1 1; 
          0 0 0 0 1; 
          0 0 1 1 0;
          0 0 1 1 0;
          0 0 0 0 1;
         1 1 1 1 1];      
      
x(:,:,5)=[1 0 0 0 1; 
          1 0 0 0 1; 
          1 0 0 0 1;
          1 1 1 1 1;
          0 0 0 0 1;
          0 0 0 0 1];
      
   

      
%data to recognise
y=[1 1 1 0 0; 
   0 0 1 0 0; 
   0 0 1 0 0;
   0 0 0 0 0;
   0 0 0 0 0;
   0 0 0 0 0];

nodes=size(x,1)*size(x,2);

input = zeros(size(x,3),nodes);
output = zeros(size(y,3),nodes);

for n = 1:size(x,3)
    for i = 1:size(x,1)
        for j = 1:size(x,2)
            input(n,(i-1)*size(x,2)+j) = x(i,j,n); 
        end
    end
end


for n = 1:size(y,3)
    for i = 1:size(y,1)
        for j = 1:size(y,2)
            output(n,(i-1)*size(y,2)+j) =y(i,j,n);  
        end
    end
end

for i=1:size(input,1)
    for j=1:size(input,2)
        fprintf('%i ',input(i,j));
    end
    fprintf('\n');
end

fprintf('\n');
for i=1:size(output,1)
    for j=1:size(output,2)
        fprintf('%i ',output(i,j));
    end
    fprintf('\n');
end


W = zeros(nodes,nodes);

for i = 1:nodes
    for j = i+1:nodes
        for count= 1:size(x,3)
            W(i,j)= W(i,j)+((2*input(count,i)-1)*(2*input(count,j)-1));
            W(j,i)= W(i,j);
        end
    end
    
end  

fprintf('\n');

for i=1:nodes
    for j=1:nodes
        fprintf('%i ',W(i,j));
    end
    fprintf('\n');
end
fprintf('\n');

removed=3;
for i=1:size(W,1)
    W(removed,i)=0;
    W(i,removed)=W(removed,i);
end    

flag=true;
iteration=0;
index=1;
lastchange=0;

for index=1:size(y,3)
    while flag
        iteration=iteration+1;
        i=randi([1,nodes],1,1);
        sum=0;
        for j=1:nodes
            sum=sum+W(i,j)*output(index,j);
        end
        changed=0;
        out=sign(sum);
        out=int32(out+1)/2;
        if output(index,i)~=out
            changed=1;
            output(index,i)=out;
        end
    
        if changed==1
            lastchange=iteration;
        end
    
        if iteration - lastchange > 1000
            flag=false;
        end
    end
    count=0;  

    for i=1:size(output,2)
        count=count+1;
        fprintf('%i ',output(n,i));
        if count==size(y,2)
            count=0;
            fprintf('\n');
        end    
    end    
    fprintf('\n');
end



