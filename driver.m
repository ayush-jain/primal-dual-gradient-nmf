
%filename = 'datafile.txt';
%delimiterIn = ' ';
%headerlinesIn = 1;
%ABC = importdata(filename,delimiterIn,headerlinesIn);

rand('seed',0);
randn('seed',0);

% Problem size
n = 500;
m = 500;
r1 = 30;

% True matrices
W  = abs(randn(n,r1));
H  = abs(randn(r1,m));
V  = W * H;


filename = 'data500x500.txt';
delimiterIn = ' ';
headerlinesIn = 0;

V = importdata(filename,delimiterIn,headerlinesIn);
V = V.';

[r,c] = size(V);
i=0;
for m = 1:r
    for n = 1:c
        if V(m,n)==0
            i=i+1;
            %disp('changing');
            V(m,n) = (rand()/1000);
        end
    end
end

%disp(i);
    
% Initialization
W0 = rand(n,r1);
H0 = rand(r1,m);

% Number of iterations
N = 300;
D=10;
a = [10 100 200 400 600 800 1000 2000];
for i = 1:8
%disp(i);    
%[W1, H1, obj] = dualkl(V, W0, H0, a(i), D);
%disp(obj);
%[H,W,grad,iter] = pgwitharmijo(V,W0,H0,0.001,1000);

%[H1,W1,grad,iter] = pgwitharmijo(V,W0,H0,0.001,a(i));
%[W1, H1, obj, time] = dualkl(V, W0, H0, a(i), D);
%[H1,W1,grad,iter] = pgwithlin(V,W0,H0,0.001,a(i));

%[Hnew,Wnew,grad,iter] = pgwitharmijo(V,W0,H0,N,1000);
xx=size(V-W1*H1,1);
yy=size(V-W1*H1,2);
A=V-W1*H1;
difference=0;
disp(norm(A));
%if(i== 8)
    %export(mat2dataset(W1),'file','W-dual-10.txt','Delimiter',delimiterIn);
    %export(mat2dataset(H1),'file','H-dual-10.txt','Delimiter',delimiterIn);    
    %disp(H1);
%end
%disp(fprintf('%f and %f \n', num2str(det(A)), num2str(norm(A))));
%disp(strcat(num2str(det(A)),' ',num2str(norm(A))));
end

for m = 1:xx
    for n = 1:yy      
        if A(m,n)~=0
           % disp (A(m,n))
            difference= difference + A(m,n);
        end
        
    end
end

%V=[1 1 1 1;1 1 1 1;1 1 1 1;1 1 1 2];
%W=[1 0; 0 0;0 0; 0 1];
%H=[1 1 1 1;1 0 0 0];
