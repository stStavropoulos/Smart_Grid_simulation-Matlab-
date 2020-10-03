function [iLa,iLb] = metrhseis2( Iha,Ihb,G,xa )
   
    iLa=Iha + G*(xa(3,1)-xa(5,1));
    iLb=Ihb + G*(xa(4,1)-xa(5,1));
    
end

