function distrib = get_distrib(n, chord)
step = (floor(max(chord))+1) / n; % step of discretization
distrib=[];

for k = 0:n-1
    distrib = [distrib, sum(k*step < chord & chord <=(k+1)*step)];
end
distrib = distrib/sum(distrib);
end