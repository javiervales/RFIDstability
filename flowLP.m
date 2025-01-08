function [lambda, t]=flowLP(proto, trafico, N, errores, S)

resultado = 0;
acciones = size(S,1);
lectores = size(S,2);
%N = N*ones(1,lectores);
%trafico = trafico*ones(1,lectores);


% Analisis teorico
idx = 0;
for t=0.01:0.01:2
	b=getb(proto, trafico, N, errores, t);
	
	% Solucion LP
	%f = [zeros(1, acciones) ones(1, lectores+1)];
	f = -b*S';
	if (sum(f)~=0) 
		Aeq = ones(1, acciones);

		options = optimoptions('linprog','Algorithm','dual-simplex','Display','none','OptimalityTolerance',1.0000e-07);
		[x,fval,exitflag,~] = linprog(f,[],[],Aeq,1, zeros(1,acciones),ones(1,acciones),options);
		p = x(1:acciones);

	%	fval, exitflag, pause
	else
		exitflag = 0;
	end

	idx = idx+1;
	resultado(idx, 1) =  t;
	if exitflag==1 && t>0
		resultado(idx, 2) = -f*p/t;
	else
		resultado(idx, 2) = 0;
	end
end

[lambda, indice] = max(resultado(:,2));
t = resultado(indice,1);

end
