%Convert the matrices to fixed point
 
r1=fi(x(3,1:20000),1,35,22);
r2=fi(x(4,1:20000),1,35,22);
r3=fi(x(5,1:20000),1,35,22);

%Open the files
fid1 = fopen('V3.txt','wt');
fid2 = fopen('V4.txt','wt');
fid3 = fopen('V5.txt','wt');

%Fill fid1   
for i=1:20000       
      

    K(1,i)=r1(1,i);
    V2(i,:)=bin(K(1,i));  

end
    for ii = 1:20000
    fprintf(fid1,'%s\t',V2(ii,:));
    fprintf(fid1,'\n');
    end
%Fill fid2      
for i=1:20000       
      

    K(1,i)=r2(1,i);
    V2(i,:)=bin(K(1,i));  
   
end
 for ii = 1:20000
    fprintf(fid2,'%s\t',V2(ii,:));
    fprintf(fid2,'\n');
 end
%Fill fid3     
for i=1:20000       
      

    K(1,i)=r3(1,i);
    V3(i,:)=bin(K(1,i));  
end
        for ii = 1:20000
    fprintf(fid3,'%s\t',V4(ii,:));
    fprintf(fid3,'\n');
    end

fclose(fid2); 
fclose(fid3); 
fclose(fid4); 
