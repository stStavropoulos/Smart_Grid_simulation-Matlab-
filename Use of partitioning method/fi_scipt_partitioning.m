%Convert the matrices to fixed point
t1=fi(V(1,1:20000),1,35,22);
t2=fi(V(2,1:20000),1,35,22);
t3=fi(V(3,1:20000),1,35,22);
t4=fi(V(4,1:20000),1,35,22);
t5=fi(V(5,1:20000),1,35,22);
t6=fi(V(6,1:20000),1,35,22);

%Open the files
fid1 = fopen('V1.txt','wt');
fid2 = fopen('V2.txt','wt');
fid3 = fopen('V3.txt','wt');
fid4 = fopen('V4.txt','wt');
fid5 = fopen('V5.txt','wt');
fid6 = fopen('V6.txt','wt');

%Fill fid1
for i=1:20000       
      
    K(1,i)=t1(1,i);
    M1(i,:)=bin(K(1,i));  
   
end
 for ii = 1:20000
     
    fprintf(fid1,'%s\t',M1(ii,:));
    fprintf(fid1,'\n');
 end
%Fill fid2 
for i=1:20000      
      
    K(1,i)=t2(1,i);
    M2(i,:)=bin(K(1,i));  
   
end
 for ii = 1:20000
    fprintf(fid2,'%s\t',M2(ii,:));
    fprintf(fid2,'\n');
 end

 
 for i=1:20000       
      
    K(1,i)=t3(1,i);
    M3(i,:)=bin(K(1,i));  
   
end
 for ii = 1:20000
     
    fprintf(fid3,'%s\t',M3(ii,:));
    fprintf(fid3,'\n');
 end
 
  for i=1:20000       
      
    K(1,i)=t4(1,i);
    M4(i,:)=bin(K(1,i));  
   
end
 for ii = 1:20000
     
    fprintf(fid4,'%s\t',M4(ii,:));
    fprintf(fid4,'\n');
 end
 
   for i=1:20000       
      
    K(1,i)=t5(1,i);
    M5(i,:)=bin(K(1,i));  
   
end
 for ii = 1:20000
     
    fprintf(fid5,'%s\t',M5(ii,:));
    fprintf(fid5,'\n');
 end
 
    for i=1:20000       
      
    K(1,i)=t6(1,i);
    M6(i,:)=bin(K(1,i));  
   
end
 for ii = 1:20000
     
    fprintf(fid6,'%s\t',M6(ii,:));
    fprintf(fid6,'\n');
 end
 
fclose(fid1); 
fclose(fid2); 
fclose(fid3); 
fclose(fid4); 
fclose(fid5);
fclose(fid6);