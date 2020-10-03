function [B, X, b, iLp1, iLp2, iLp3, iLb1, iLb2, iLb3] = metrhseis_partition3(b1, b2, q, V, u, ihp1, ihp2, ihp3, ihb1, ihb2, ihb3, Geff)

    B=[b1;b2;q];
    X=[V;u];
    b=[b1;b2]; 
    
    iLp1=ihp1 + Geff*(V(4,1)-V(7,1));
    iLp2=ihp2 + Geff*(V(5,1)-V(8,1));
    iLp3=ihp3 + Geff*(V(6,1)-V(9,1));
    
    iLb1=ihb1 + Geff*(V(10,1)-V(16,1));
    iLb2=ihb2 + Geff*(V(11,1)-V(17,1));
    iLb3=ihb3 + Geff*(V(12,1)-V(18,1));

end

