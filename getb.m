function b = getb(proto, trafico, N, errores, t)

PATH='../RESULTADOS/';

m = length(proto);
b = zeros(1,m);

for j=1:m
	switch(proto(j)) 
	case 0	
	      	pro='DFSA';
	case 1
	   	pro='FSAK16';
	case 2
	       	pro='FSAK64';
	end
	
	if(trafico(j)==0) 
		tra='';
	else
		tra='-POISSON';
	end

	switch errores(j)
	case 0
		err='';
	case 1	
		err='-ERRORES';
	case 2
		err='-PC015PS08';
	case 3 
		err='-PC02PS07';
	end

	fichero = [PATH,pro, tra, err, '.dat'];
	T = table2array(readtable(fichero));
	indice = min(find(T(:,1)>=t));

	switch(N(j))
	case 1 % N=50
		b(j) = T(indice, 3);
	case 2 % N=75
		b(j) = T(indice, 6);
	case 3 % N=100
		b(j) = T(indice, 9);
	end
end

end
