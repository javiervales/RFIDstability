warning off;
clear

for escenario=31:38
for trafico=2:2:2
for proto=1:1:1
for t=1:1:1

%E1 = [0 0 0 0];
%N = [3 3 3 3];
%F = [2 1 1 1];
%T = [0 0 0 0];

A1 = [1 1 0; 1 1 1; 0 1 1];
A2 = [1 1 0 0; 1 1 1 0; 0 1 1 1; 0 0 1 1];

%  T = [1 0; 
%       0 1; 
%       0 1
%       0 0]  % 2 variables -> x1=a1, x2=a2=a3=a4

T1 = [1 0 0; 
     0 1 0; 
     0 0 1 ];  % 3 variables -> x1=a1, x2=a2, x3=a3,a4

T2 = [1 0 0; 
     0 1 0; 
     0 0 1
     0 0 1];  % 3 variables -> x1=a1, x2=a2, x3=a3,a4

TA1 = [1 0 0 
       0 1 0; 
       0 0 1;
       0 0 1/2];  % 3 variables -> x1=a1, x2=a2, x3=a3, x4=1/2


TA2 = [1 0 0 0 
       0 1 0 0; 
       0 0 1 0; 
       0 0 0 1;
       1/2 0 0 0];  % 3 variables -> x1=a1, x2=a2, x3=a3, x4=1/2

T3 = [1 0 0; 
     0 1 0; 
     0 0 1
     1 0 0];  % 3 variables -> x1=a1=14, x2=a2, x3=a3

T4 = [1 0 0; 
     0 1 0; 
     0 0 1
     0 1 0
     1 0 0];  % 3 variables -> x1=a1=14, x2=a2, x3=a3

esafin = 0;
switch escenario
case 0
	esafin = 1;
	A=A1; 
	T=TA1; 
	esc='-LINEA-AFIN';
case 1
	A=A1; 
	T=T1; 
	esc='-LINEA3';
case 2 
	A=A2; 
	T=T2;
	esc='-LINEA41';
case 3 
	A=A2; 
	T=T3;
	esc='-LINEA42';
case 4
	A=ones(3);
	T=T1; 
	esc='-FULL';
case 5 
	A=ones(4);
	T=T2;
	esc='-FULL41';
case 6 
	A=ones(5);
	T=T4;
	esc='-FULL51';
end

if escenario>=7
	esafin=1;
	if mod(escenario-7,4)==0 % LINEA
		A=[1 1 0 0; 1 1 1 0; 0 1 1 1; 0 0 1 1];
		esc='-LINEA';
	end
	if mod(escenario-8,4)==0 % STAR
		A=[0 1 1 1; 1 0 0 0; 1 0 0 0; 1 0 0 0];
		esc='-STAR';
	end
	if mod(escenario-9,4)==0 % FULL
		A=ones(4);
		esc='-FULL';
	end
	if mod(escenario-10,4)==0 % SQUARE
		A=[0 1 0 1; 1 0 1 0; 0 1 0 1; 1 0 1 0];
		esc='-SQUARE';
	end

	if escenario<=10 % A12
		T=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1; 1/2 0 0 0];
		esc=[esc 'A12'];
	elseif escenario<=14 % A14
		T=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1; 1/4 0 0 0];
		esc=[esc 'A14'];
	elseif escenario<=18 % A3A4
		T=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 1];
		esc=[esc 'A3A4'];
	elseif escenario<=22 % A1A4
		T=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1; 0 1 0 0];
		esc=[esc 'A1A4'];
	elseif escenario<=26 % A1A2
		T=[1 0 0; 0 1 0; 0 1 0; 0 0 1; 0 0 1];
		esc=[esc 'A1A2'];
	elseif escenario<=30 % A112A2
		T=[1 0 0; 0 1 0; 1/2 0 0; 1/2 0 0; 0 0 1];
		esc=[esc 'A112A2'];
	elseif escenario<=34 % A112A2
		T=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 1];
		PROTOCOLO=[1 2 1 0];
		esc=[esc 'A3A4-HETFSA'];
		pro='';
	elseif escenario<=38 % A112A2
		T=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1; 0 0 0 1];
		esc=[esc 'A3A4-HETCH'];
		can='';
		E=[1 2 3 1];
	end
end

if escenario<=30 || escenario>=35
switch proto
case 0
	PROTOCOLO=zeros(1,m);
	pro='-DFSA';
case 1
	PROTOCOLO=ones(1,m);
	pro='-FSAK16';
case 2
	PROTOCOLO=2*ones(1,m);
	pro='-FSAK64';
case 3
	switch m
	case 3
		PROTOCOLO=[1 2 1];
	case 4
		PROTOCOLO =[1 1 2 2];
	case 5
		PROTOCOLO =[1 1 2 2 3];
	end
	
	pro='-FSAMIX';
end
end



m = size(A,1); 
if escenario<=34
	E=zeros(1:m);  
	can='-IDEAL';
end
switch trafico
case 0 
	N=3*ones(1,m); X=zeros(1,m);
	tra='-N100';
case 1
	N=1*ones(1,m); X=zeros(1,m);
	tra='-N50';
case 2 
	N=3*ones(1,m); X=ones(1,m);
	tra='-P100';
case 3
	N=1*ones(1,m); X=ones(1,m);
	tra='-P50';
case 4 
	N=2*ones(1,m); X=ones(1,m);
	tra='-P75';
case 5
	N=2*ones(1,m); X=zeros(1,m);
	tra='-N75';
end

%A,T
S = creaS(A);
b = getb(PROTOCOLO,X,N,E,t);
if ~esafin
	[F,P] = rc(S,T,b);
else
	[F,P] = rca(S,T,b);
end
F = unique(F,'rows');

if ~isempty(F)
	nombre=['DATA/TRES/convex-t' num2str(round(t*10)) '-m' num2str(m) esc pro can tra '.dat']
	writetable(array2table(F),nombre,'WriteVariableNames',0,'Delimiter','tab')
end
end

end
end

end
