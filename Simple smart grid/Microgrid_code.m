%Network parameters definition
RL1=300;
RL2=300;
L=1e-5;
Rs=0.8929;
R=1;
dt=5e-06;
Finish_Time =1;
Vrms1=3000/sqrt(3);
Vrms2=4000/sqrt(3);
Geff=dt/(2*L);
g=1;
Length=round(0.1/dt)+1 ;
Voffset1=0;
Voffset2=0;
Voffset=5e-5;

%Initialization of the essential matrices
x=zeros(5,Length);
Y=zeros(6,Length);
Vp1=zeros(1,Length);
Vp2=zeros(1,Length);
Ih1=zeros(1,Length);
Ih2=zeros(1,Length);
iL1=zeros(1,Length);
iL2=zeros(1,Length);
b=zeros(5,Length);

%Loading the simulink data for the error estimation
vl1=logsout{1}.Values.Data(:,1);
vs1=logsout{2}.Values.Data(:,1);
vs2=logsout{3}.Values.Data(:,1);

%Definition of A matrix and the values of b vector and Vp1,Vp2 at step 1

Vp1(1,g)=sqrt(2)*Vrms1*sin(2*pi*50*g*dt) + Voffset;
Vp2(1,g)=sqrt(2)*Vrms2*sin(2*pi*50*g*dt) - Voffset;

A=[(1/Rs + 1/R),0,-(1/R),0,0; 
   0,(1/Rs + 1/R),0 ,-(1/R),0;
   -(1/R), 0,(1/Geff + 1/R) , 0, -(1/Geff);
   0, -(1/R) ,0,(1/Geff + 1/R), -(1/Geff);
   0,0, -(1/Geff), -(1/Geff),(1/RL1 + 1/RL2 + 2/Geff)
   ]
   
Ainverse=inverse(A,1e-09);

b(:,g)=[Vp1(1,g)/Rs ; Vp2(1,g)/Rs  ; -Ih1(1,g) ; -Ih2(1,g) ; Ih1(1,g)+Ih2(1,g)];

%Iterative process until the defined finish time 
for k=dt:dt:Finish_Time
    
    g=g+1;
    
    [x(:,g),Ih1(1,g),Ih2(1,g),Vp1(1,g),Vp2(1,g),b(:,g)]=metrhseis1(x(1:5,g-1),A,Geff,iL1(1,g-1),iL2(1,g-1),Vrms1,Vrms2,Rs,Voffset,g,dt);
    
    [iL1(1,g),iL2(1,g)]=metrhseis2(Ih1(1,g),Ih2(1,g),Geff,x(1:5,g));
    
end

%Error estimation
 Y(1,:)=x(5,1:20001 );
  Y(2,:)=x(1,1:20001 );
  Y(3,:)=x(2,1:20001 );
  Y(4,:)=vl1(1:20001);
  Y(5,:)=vs1(1:20001);
  Y(6,:)=vs2(1:20001);
  [m,n]=size(x);
  error1=abs(Y(1,4:end-1)-Y(4,5:end))';
  error2=abs(Y(2,2:end-1)-Y(5,3:end))';
  error3=abs(Y(3,2:end-1)-Y(6,3:end))';
  [m1,n1]=size(error1);
  [m2,n2]=size(error2);
  [m3,n3]=size(error3);
  
%Plotting Matlab and Simulink results and the deviation between them
  subplot(3,3,1);  
  plot(Y(1,:))
  subplot(3,3,4);
  plot(Y(2,:))
  subplot(3,3,7);
  plot(Y(3,:))
   
  subplot(3,3,2);
  plot(Y(4,:))
  subplot(3,3,5);
  plot(Y(5,:))
  subplot(3,3,8);
  plot(Y(6,:))
  
  subplot(3,3,3);
  plot(error1(1:m1))
  subplot(3,3,6);
  plot(error2(1:m2))
  subplot(3,3,9);
  plot(error3(1:m3))