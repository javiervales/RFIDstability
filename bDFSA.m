function [probability,  elapsedtime] = bDFSA(N,T,pc,ps)
% function [probability, elapsedtime] = bDFSA(N,T,pc,ps)
% Montecarlo simulation for the computation of batch identification probability (bip)
% under optimal DFSA-policy with perfect tag count
% N: Batch size (Tags)
% T: Timeslot duration (seconds)
% Confidence level is set to of 99% for a confidence interval of +- 1% 

tS=0.00283;
tE=0.00021;
tC=0.00049;

tolR = 0.01;
confidencelevel=0;
minconfidencelevel=0.99;

total = 0;
totalcuadrado = 0;
iters = 0;
tic;

while confidencelevel<minconfidencelevel
	tiempo = T;
	tags = N;
	muestra = 0;
	while tiempo>=0
		% SELECCCION DE k
		k=selectK(tags);

		seleccion = randi(k,tags,1);
		S = 0;
		SS = 0;
		C = 0;
		CC = 0;
		CCC = 0;
		tagsenslot = zeros(k,1);
		for slot=1:k
		      tagsenslot(slot) = sum(seleccion==slot); 
		      if tagsenslot(slot)==1 
			  S=S+1;
			  SS = binornd(S,ps);
		      elseif tagsenslot(slot)>1
			  C=C+1;
			  CC = binornd(C,pc);
			  CCC = binornd(CC,ps);
		      end
		end
		E = k-S-C;

		% Check if frame fits into the remaining slot time 
		ttrama = (S+CC)*tS+E*tE+(C-CC)*tC;
		if ( tiempo >= ttrama )
		    tags = tags - SS - CCC;
		    tiempo = tiempo - ttrama;
		    if(tags==0) 
			    muestra = muestra + 1;
			    break;
		    end
		else
		    break;
		end	
	end
	
	total = total + muestra;
	totalcuadrado = totalcuadrado + muestra^2;
	iters = iters + 1;
	if iters>10000 && mod(iters,1000)
		meanvalue = total/iters;
		S = (totalcuadrado - iters*meanvalue^2)/(iters-1);
		tol = tolR*meanvalue;
		Z = tol/sqrt(S/iters);
		confidencelevel = 1-(1-normcdf(Z))*2;
	end
end
elapsedtime = toc;
probability = meanvalue;

end
