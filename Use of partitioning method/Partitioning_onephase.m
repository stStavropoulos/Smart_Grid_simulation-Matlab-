%Network parameters definition
RL1=300;
RL2=300;
L=1e-5;
Rs=0.8929;
R=1;
dt=5e-06;
Finish_Time = 1;
Vprms=3000/sqrt(3);
Vbrms=4000/sqrt(3);
Geff=dt/(2*L);
g=1;
Length=round(0.1/dt)+1 ;

%Initialization of the essential matrices
V=zeros(6,Length);
Y=zeros(6,Length);
u=zeros(1,Length);
Z=zeros(3,3);
Q=zeros(1,1);
q=0;
ihp1=zeros(1,Length);
iLp1=zeros(1,Length);
iLb1=zeros(1,Length);
ihb1=zeros(1,Length);
Vp1=zeros(1,Length);
Vb1=zeros(1,Length);
b=zeros(6,Length);
b1=zeros(3,Length);
b2=zeros(3,Length);

%Loading the simulink data for the error estimation 
vl1=logsout{1}.Values.Data(:,1);
vs1=logsout{2}.Values.Data(:,1);
s2=logsout{3}.Values.Data(:,1);

%Definition of A1,A2,Ablock,Aorig,D1,D2,B matrices and the values of b,b1,b2 vector and Vp1,Vp2 at step 1
D1=zeros(3,1);
D1(3,1)=1;
D2=-D1;
D=[D1;D2];
A1=[(1/Rs + 1/R),-1/R,0;
   -(1/R),1/Geff + 1/R,-1/Geff;
    0 ,-1/Geff,1/RL1 + 1/Geff
    ];
A2=[(1/Rs + 1/R) ,-1/R,0;
    -(1/R) ,1/Geff + 1/R,-1/Geff;
    0,-1/Geff,1/RL2 + 1/Geff
    ];
A11=inverse(A1,1e-09);
A22=inverse(A2,1e-09);
Vp1(1,g)=sqrt(2)*Vprms*sin(2*pi*50*g*dt);
Vb1(1,g)=sqrt(2)*Vbrms*sin(2*pi*50*g*dt);

b1(:,g)=[Vp1(1,g)/Rs;-ihp1(1,1);ihp1(1,1)-u(1,1);];
b2(:,g)=[Vb1(1,g)/Rs;-ihb1(1,1);ihb1(1,1)+u(1,1);];
b(:,g)=[b1(:,g);b2(:,g)];  
Ablock=[A1 Z;Z A2];
Aorig=[A1 Z D1;Z A2 D2;D1' D2' Q]; 
Ab=inverse(Ablock,1e-09);
A=(D')*Ab*(D);
Ainv=inverse(A,1e-09);
B=[b1(:,g);b2(:,g);q];

%Iterative process until the defined finish time 
for k=dt:dt:Finish_Time
    
    g=g+1;

    ihp1(1,g)=iLp1(1,g-1) + Geff*(V(2,g-1)-V(3,g-1));
    ihb1(1,g)=iLb1(1,g-1) + Geff*(V(5,g-1)-V(6,g-1));
    
    Vp1(1,g)=sqrt(2)*Vprms*sin(2*pi*50*g*dt);
    Vb1(1,g)=sqrt(2)*Vbrms*sin(2*pi*50*g*dt);

    b1(:,g)=[Vp1(1,g)/Rs;-ihp1(1,g);ihp1(1,g)-u(1,g-1);];
    b2(:,g)=[Vb1(1,g)/Rs;-ihb1(1,g);ihb1(1,g)+u(1,g-1);];     
    b(:,g)=[b1(:,g);b2(:,g)];
      
    u(1,g)=Ainv*((D') *Ab * b(:,g));
    
    V(1:6,g)=[A11*b1(:,g);A22*b2(:,g)]-[A11*D1;A22*D2]*u(1,g);
    
    iLp1(1,g)=ihp1(1,g) + Geff*(V(2,g)-V(3,g));
    iLb1(1,g)=ihb1(1,g) + Geff*(V(5,g)-V(6,g));
    
end 

 %Error estimation
%  Y(1,:)=V(6,1:20001);
%  Y(2,:)=V(1,1:20001);
%  Y(3,:)=V(4,1:20001);
%  Y(4,:)=vl1(1:20001);
%  Y(5,:)=vs1(1:20001);
%  Y(6,:)=vs2(1:20001);
%  [m,n]=size(V);
%  error1=abs(Y(1,2:end-1)-Y(4,3:end))';
%  error2=abs(Y(2,2:end-1)-Y(5,3:end))';
%  error3=abs(Y(3,2:end-1)-Y(6,3:end))';
%  [m1,n1]=size(error1);
%  [m2,n2]=size(error2);
%  [m3,n3]=size(error3);
%  %Plotting Matlab and Simulink results and the deviation between them
%  subplot(3,3,1);  
%  plot(Y(1,1:20001))
%  subplot(3,3,4);
%  plot(Y(2,1:20001))
%  subplot(3,3,7);
%  plot(Y(3,1:20001)) 
%  subplot(3,3,2);
%  plot(Y(4,1:20001))
%  subplot(3,3,5);
%  plot(Y(5,1:20001))
%  subplot(3,3,8);
%  plot(Y(6,1:20001))
%  
%  subplot(3,3,3);
%  plot(error1(1:m1))
%  subplot(3,3,6);
%  plot(error2(1:m2))
%  subplot(3,3,9);
%  plot(error3(1:m3))