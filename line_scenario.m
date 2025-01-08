% Escenario 3: Lambda caso general FSAK16, SIN ERRORES, N=100, Escenario linea con m lectores
warning off;
clear

% Conf tráfico
trafico = 0;
carga = 3;

for m=3:10
	A = zeros(m);
% LINEA
	for j=1:m
		A(j,j) = 1;
		if(j-1>1) A(j,j-1) = 1;	
		end
		if(j+1<m) A(j,j+1) = 1;	
		end
	end

% ESTRELLA
%	A(1,:) = ones(1,m);
%	A(:,1) = ones(m,1);
%	A
		
	% Conf lectores
%	errores = randi(2,1,m)-1
	errores = zeros(1,m);
		proto = randi(3,1,m)-1;
	
		[laux(REPEAT), taux(REPEAT)] = flowLP(proto, trafico, carga, errores, creaS(A))
	end
	lambda(m) = mean(laux);
	tux(m) = mean(taux);
end
