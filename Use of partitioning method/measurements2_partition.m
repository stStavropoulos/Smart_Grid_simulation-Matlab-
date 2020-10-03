function [b1, b2, V] = metrhseis_partition2(V,Vp1,Vp2,Vp3,Vb1,Vb2,Vb3,Rs,ihp1,ihp2,ihp3,ihb1,ihb2,ihb3,u,A11,A22,D1,D2)
    
    b1=[Vp1/Rs;Vp2/Rs;Vp3/Rs;- ihp1;-ihp2;-ihp3;ihp1-u(1,1);ihp2-u(2,1);ihp3-u(3,1)];
    b2=[Vb1/Rs;Vb2/Rs;Vb3/Rs;-ihb1;-ihb2;-ihb3;ihb1+u(1,1);ihb2+u(2,1);ihb3+u(3,1)];  
    b=[b1;b2];
 
    V(1:18,1)=[A11*b1;A22*b2]-[A11*D1;A22*D2]*u(1:3,1);

end

