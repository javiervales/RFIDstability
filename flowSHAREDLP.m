function [lambda, t]=flowSHAREDLP(proto, trafico, N, errores, S)

resultado = 0;
m = size(S,2);
%N = N*ones(1,lectores);
%trafico = trafico*ones(1,lectores);


% Analisis teorico
idx = 0;
R=[];
lambdaanterior = 0;
for t=0.01:0.01:2
	b=getb(proto, trafico, N, errores, t);
	
	% Solucion LP

	if (sum(b)>0) 
		iter = 0;
		resultado = 1;
		lambda=lambdaanterior;
		TEMP = 0;
		while resultado
			lambda = lambda + 0.01;
			a = lambda*ones(1,m)*t/m;
			if(sum(b)>=sum(a)) 
				resultado = admisibleLP(a,b,S);
			else
				resultado = 0;
			end
			
			if resultado
				TEMP = lambda;
			end
		end
	else 
		TEMP = 0;
	end

	idx = idx + 1;
	R(idx, 1) = t;
	R(idx, 2) = TEMP;
	lambdaanterior = TEMP;
end

[lambda, indice] = max(R(:,2));
t = R(indice,1);

end
