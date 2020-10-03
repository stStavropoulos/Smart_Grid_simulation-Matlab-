function [ ihpa, ihpb, ihpc, ihba, ihbb, ihbc, Vpa, Vpb, Vpc, Vba, Vbb, Vbc] = metrhseis_partition1(Gef,Va,iLpa,iLpb,iLp3,iLb1,iLbb,iLbc,Vpr,g1,Vbr,dta)

    ihpa=iLpa + Gef*(Va(4,1)-Va(7,1));
    ihpb=iLpb + Gef*(Va(5,1)-Va(8,1));
    ihpc=iLp3 + Gef*(Va(6,1)-Va(9,1));
    
    ihba=iLb1 + Gef*(Va(10,1)-Va(16,1));
    ihbb=iLbb + Gef*(Va(11,1)-Va(17,1));
    ihbc=iLbc + Gef*(Va(12,1)-Va(18,1));
        
    Vpa=sqrt(2)*Vpr*sin(2*pi*50*g1*dta);
    Vpb=sqrt(2)*Vpr*sin(2*pi*50*g1*dta + 2*pi/3);
    Vpc=sqrt(2)*Vpr*sin(2*pi*50*g1*dta - 2*pi/3);

    Vba=sqrt(2)*Vbr*sin(2*pi*50*g1*dta);
    Vbb=sqrt(2)*Vbr*sin(2*pi*50*g1*dta + 2*pi/3);
    Vbc=sqrt(2)*Vbr*sin(2*pi*50*g1*dta - 2*pi/3);

end

