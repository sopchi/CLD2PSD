function K = get_K(part_size,form, n,method)
K =[];
if method == "random"
    random_method=true
else
    random_method=false
end
for r = part_size
    chord = CLD_part(form(1),form(2),form(3),r,random_method); % list of all random chords for a particle of form and size = r
    distrib = get_distrib(n, chord);
    K = [K; distrib];
end
K = K.';
end