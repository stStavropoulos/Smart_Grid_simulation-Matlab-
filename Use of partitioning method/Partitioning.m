%Network parameters definition
RL1=300;
RL2=300;
L=1e-5;
Rs=0.8929;
R=1;
dt=5e-06;
Finish_Time = 0.1;
Vprms=3000/sqrt(3);
Vbrms=4000/sqrt(3);
Geff=dt/(2*L);
g=1;
Length=round(0.1/dt)+1 ;

%Initialization of the essential matrices
ihp1=0;
ihp2=0;
ihp3=0;

iLp1=0;
iLp2=0;
iLp3=0;

iLb1=0;
iLb2=0;
iLb3=0;

ihb1=0;
ihb2=0;
ihb3=0;

V=zeros(18,Length);
u=zeros(3,Length);
Z=zeros(9,9);
Q=zeros(3,3);
q=zeros(3,1);
D1=zeros(9,3);

Vp1=sqrt(2)*Vprms*sin(2*pi*50*g*dt);
Vp2=sqrt(2)*Vprms*sin(2*pi*50*g*dt + 2*pi/3);
Vp3=sqrt(2)*Vprms*sin(2*pi*50*g*dt - 2*pi/3);

Vb1=sqrt(2)*Vbrms*sin(2*pi*50*g*dt);
Vb2=sqrt(2)*Vbrms*sin(2*pi*50*g*dt + 2*pi/3);
Vb3=sqrt(2)*Vbrms*sin(2*pi*50*g*dt - 2*pi/3);

D1(7,1)=1;
D1(8,2)=1;
D1(9,3)=1;
D2=-D1;
D=[D1;D2];


A1=[(1/Rs + 1/R), 0 ,0 ,-1/R,0,0,0,0,0;
    0,(1/Rs + 1/R), 0 ,0,-1/R,0,0,0,0;
    0,0,(1/Rs + 1/R),0, 0,-1/R,0,0,0;
    -(1/R), 0 ,0 ,1/Geff + 1/R,0,0,-1/Geff,0,0;
    0,-1/R,0 ,0,1/Geff + 1/R,0,0,-1/Geff,0;
    0,0,-1/R,0, 0,1/Geff + 1/R,0,0,-1/Geff;
    0, 0 ,0 ,-1/Geff,0,0,1/RL1 + 1/Geff,0,0;
    0,0,0 ,0,-1/Geff ,0,0,1/RL1+1/Geff,0;
    0,0,0,0,0,-1/Geff,0,0,1/RL1 + 1/Geff
    ];

A2=[(1/Rs + 1/R), 0 ,0 ,-1/R,0,0,0,0,0;
    0,(1/Rs + 1/R), 0 ,0,-1/R,0,0,0,0;
    0,0,(1/Rs + 1/R),0, 0,-1/R,0,0,0;
    -(1/R), 0 ,0 ,1/Geff + 1/R,0,0,-1/Geff,0,0;
    0,-1/R,0 ,0,1/Geff + 1/R,0,0,-1/Geff,0;
    0,0,-1/R,0, 0,1/Geff + 1/R,0,0,-1/Geff;
    0, 0 ,0 ,-1/Geff,0,0,1/RL2 + 1/Geff,0,0;
    0,0,0 ,0,-1/Geff ,0,0,1/RL2+1/Geff,0;
    0,0,0,0,0,-1/Geff,0,0,1/RL2 + 1/Geff
    ];
A11=inverse(A1,1e-09);
A22=inverse(A2,1e-09);
b1=[Vp1/Rs;Vp2/Rs;Vp3/Rs;- ihp1;-ihp2;-ihp3;ihp1-u(1,1);ihp2-u(2,1);ihp3-u(3,1)];
b2=[Vb1/Rs;Vb2/Rs;Vb3/Rs;-ihb1;-ihb2;-ihb3;ihb1+u(1,1);ihb2+u(2,1);ihb3+u(3,1)];    
b=[b1;b2];    
Aorig=[A1 Z D1;Z A2 D2;D1' D2' Q]; 
Ablock=[A1 Z;Z A2];
B=[b1;b2;q];
X=[V;u];
Ab=inverse(Ablock,1e-09);

%Iterative process until the defined finish time
for k=dt:dt:Finish_Time
    
    g=g+1;
    [ihp1,ihp2,ihp3,ihb1,ihb2,ihb3,Vp1,Vp2,Vp3,Vb1,Vb2,Vb3] = metrhseis_partition1(Geff,V(1:18,g),iLp1,iLp2,iLp3,iLb1,iLb2,iLb3,Vprms,g,Vbrms,dt);
     
    Ainv=(D')*Ab*(D);
    u(1:3,g)=inverse(Ainv,1e-09)*((D') *Ab * b);
  
    [b1, b2, V(1:18,g)] = metrhseis_partition2(V(1:18,g),Vp1,Vp2,Vp3,Vb1,Vb2,Vb3,Rs,ihp1,ihp2,ihp3,ihb1,ihb2,ihb3, u(1:3,g-1),A11,A22, D1, D2 );
    [B, X, b, iLp1, iLp2, iLp3, iLb1, iLb2, iLb3] = metrhseis_partition3(b1, b2, q, V(1:18,g), u(1:3,g), ihp1, ihp2, ihp3, ihb1, ihb2, ihb3, Geff);
    
end  
%Error estimation and plotting

% error1=abs(Y(1,2:end-1)-Y(4,3:end))';
% error2=abs(Y(2,2:end-1)-Y(5,3:end))';
% error3=abs(Y(3,2:end-1)-Y(6,3:end))';
% n=20001;
% 
% subplot(12,2,1);  
% plot(V(1,1:n))
% 
% subplot(12,2,3);
% plot(V(2,1:n))
% 
% subplot(12,2,5);
% plot(V(3,1:n))
% 
% subplot(12,2,7);
% plot(V(4,1:n))
% 
% subplot(12,2,9);
% plot(V(5,1:n))
% 
% subplot(12,2,11);  
% plot(V(6,1:n))
% 
% subplot(12,2,13);
% plot(V(7,1:n))
% 
% subplot(12,2,15);
% plot(V(8,1:n))
% 
% subplot(12,2,17);
% plot(V(9,1:n))
% 
% subplot(12,2,19);
% plot(u(1,1:Length))
% 
% subplot(12,2,21);
% plot(u(2,1:Length))
% 
% subplot(12,2,23);
% plot(u(3,1:Length))
% 
% subplot(12,2,2);  
% plot(V(10,1:n))
% 
% subplot(12,2,4);
% plot(V(11,1:n))
% 
% subplot(12,2,6);
% plot(V(12,1:n))
% 
% subplot(12,2,8);
% plot(V(13,1:n))
% 
% subplot(12,2,10);
% plot(V(14,1:n))
% 
% subplot(12,2,12);  
% plot(V(15,1:n))
% 
% subplot(12,2,14);
% plot(V(16,1:n))
% 
% subplot(12,2,16);
% plot(V(17,1:n))
% 
% subplot(12,2,18);
% plot(V(18,1:n))
% 
% subplot(12,2,20);
% plot(u(1,1:n))
% subplot(12,2,22);
% plot(u(2,1:n))
% subplot(12,2,24);
% plot(u(3,1:n))