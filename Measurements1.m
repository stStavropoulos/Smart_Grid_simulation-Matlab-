function  [x,iha,ihb,Vpa,Vpb,b1]  = metrhseis1( xa,A1,Ge,iL1,iL2,Vrmsa,Vrmsb,R,Voff,g,dta )

    iha=Ge*(xa(3,1)-xa(5,1)) + iL1;
    ihb=Ge*(xa(4,1)-xa(5,1)) + iL2;
    
    Vpa=sqrt(2)*Vrmsa*sin(2*pi*50*g*dta) + Voff ;
    Vpb=sqrt(2)*Vrmsb*sin(2*pi*50*g*dta)- Voff ;
    
    b1=[Vpa/R ; Vpb/R  ; -iha ; -ihb ; iha+ihb];
 
    x=A1*b1;

end