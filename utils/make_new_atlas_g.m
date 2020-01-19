function new_atlas = make_new_atlas_g(an_str)

      
atlas = an_str.Atlas(2).Scouts;
if length(atlas)==150
    atlas(83:84)=[];
end

M.vertices = an_str.Vertices;
M.faces = an_str.Faces;
M = spm_mesh_inflate(M);
Vertices = M.vertices;
Faces = M.faces;

for i=1:length(atlas)
    atlas(i).Vertices = atlas(i).Vertices(:)';
end

new_atlas = [];

rr = 1:2:147;

r = [1 35 93 95 97];
rr = setdiff(rr,r);
new_atlas(1).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(1).Label = 'Insula L';

r = [3 5];
rr = setdiff(rr,r);
new_atlas(3).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(3).Label = 'Cingul-Ant L';

r = [7 19 91];
rr = setdiff(rr,r);
new_atlas(5).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(5).Label = 'Cingul-Post L';

r = [9 17];
rr = setdiff(rr,r);
new_atlas(7).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(7).Label = 'Front-pole L';

r = [33 107];
rr = setdiff(rr,r);
new_atlas(9).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(9).Label = 'Front-sup L';

r = [31 105];
rr = setdiff(rr,r);
new_atlas(11).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(11).Label = 'Front-mid L';

r = [25 27 29 77 79 103 125];
rr = setdiff(rr,r);
new_atlas(13).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(13).Label = 'Front-inf L';

r = [47 61 63 123 127 139];
rr = setdiff(rr,r);
new_atlas(15).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(15).Label = 'Front-bot L';

%---------------
r=67;
rr = setdiff(rr,r);
vv=atlas(r).Vertices;
vv1 = vv(Vertices(vv,1)>mean(Vertices(vv,1)));
vv2 = vv(Vertices(vv,1)<mean(Vertices(vv,1)));

r = 69;
rr = setdiff(rr,r);
new_atlas(17).Vertices = sort(horzcat(atlas(r).Vertices,vv1));
new_atlas(17).Label = 'Temp-Sup-Ant L';

r = [65 71 81 147];
rr = setdiff(rr,r);
new_atlas(19).Vertices = sort(horzcat(atlas(r).Vertices,vv2));
new_atlas(19).Label = 'Temp-Sup-Post L';
%------------------

r=75;
rr = setdiff(rr,r);
vv=atlas(r).Vertices;
vv1 = vv(Vertices(vv,1)>mean(Vertices(vv,1)));
vv2 = vv(Vertices(vv,1)<mean(Vertices(vv,1)));

new_atlas(21).Vertices = sort(horzcat(vv1));
new_atlas(21).Label = 'Temp-Mid-Ant L';

new_atlas(23).Vertices = sort(horzcat(vv2));
new_atlas(23).Label = 'Temp-Mid-Post L';
%------------------

r=145;
rr = setdiff(rr,r);
vv=atlas(r).Vertices;
vv1 = vv(Vertices(vv,1)>mean(Vertices(vv,1)));
vv2 = vv(Vertices(vv,1)<mean(Vertices(vv,1)));

new_atlas(25).Vertices = sort(horzcat(vv1));
new_atlas(25).Label = 'STS-Ant L';

new_atlas(27).Vertices = sort(horzcat(vv2));
new_atlas(27).Label = 'STS-Post L';
%------------------

r=[73 143];
rr = setdiff(rr,r);
vv = sort(horzcat(atlas(r).Vertices));
vv1 = vv(Vertices(vv,1)>mean(Vertices(vv,1)));
vv2 = vv(Vertices(vv,1)<mean(Vertices(vv,1)));

new_atlas(29).Vertices = sort(horzcat(vv1));
new_atlas(29).Label = 'Temp-Inf-Ant L';

new_atlas(31).Vertices = sort(horzcat(vv2));
new_atlas(31).Label = 'Temp-Inf-Post L';
%------------------

r = [55 133];
rr = setdiff(rr,r);
new_atlas(33).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(33).Label = 'Postcentral L';

r = [57 89];
rr = setdiff(rr,r);
new_atlas(35).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(35).Label = 'Central L';

r = [11];
rr = setdiff(rr,r);
new_atlas(37).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(37).Label = atlas(11).Label;

r = [109 49];
rr = setdiff(rr,r);
new_atlas(39).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(39).Label = atlas(49).Label;

r = [37 113];
rr = setdiff(rr,r);
new_atlas(41).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(41).Label = atlas(37).Label;


r = [13 15 21 131 141 101];
rr = setdiff(rr,r);

ii = 41;
for i=1:length(rr)
    ii = ii+2;
    new_atlas(ii).Vertices = sort(horzcat(atlas(rr(i)).Vertices));
    new_atlas(ii).Label = atlas(rr(i)).Label;
end

% right hemi

rr = 2:2:148;

r = [1 35 93 95 97]+1;
rr = setdiff(rr,r);
new_atlas(1+1).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(1+1).Label = 'Insula R';

r = [3 5]+1;
rr = setdiff(rr,r);
new_atlas(3+1).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(3+1).Label = 'Cingul-Ant R';

r = [7 19 91]+1;
rr = setdiff(rr,r);
new_atlas(5+1).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(5+1).Label = 'Cingul-Post R';

r = [9 17]+1;
rr = setdiff(rr,r);
new_atlas(7+1).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(7+1).Label = 'Front-pole R';

r = [33 107]+1;
rr = setdiff(rr,r);
new_atlas(9+1).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(9+1).Label = 'Front-sup R';

r = [31 105]+1;
rr = setdiff(rr,r);
new_atlas(11+1).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(11+1).Label = 'Front-mid R';

r = [25 27 29 77 79 103 125]+1;
rr = setdiff(rr,r);
new_atlas(13+1).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(13+1).Label = 'Front-inf R';

r = [47 61 63 123 127 139]+1;
rr = setdiff(rr,r);
new_atlas(15+1).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(15+1).Label = 'Front-bot R';

%---------------
r=67+1;
rr = setdiff(rr,r);
vv=atlas(r).Vertices;
vv1 = vv(Vertices(vv,1)>mean(Vertices(vv,1)));
vv2 = vv(Vertices(vv,1)<mean(Vertices(vv,1)));

r = 69+1;
rr = setdiff(rr,r);
new_atlas(17+1).Vertices = sort(horzcat(atlas(r).Vertices,vv1));
new_atlas(17+1).Label = 'Temp-Sup-Ant R';

r = [65 71 81 147]+1;
rr = setdiff(rr,r);
new_atlas(19+1).Vertices = sort(horzcat(atlas(r).Vertices,vv2));
new_atlas(19+1).Label = 'Temp-Sup-Post R';
%------------------

r=75+1;
rr = setdiff(rr,r);
vv=atlas(r).Vertices;
vv1 = vv(Vertices(vv,1)>mean(Vertices(vv,1)));
vv2 = vv(Vertices(vv,1)<mean(Vertices(vv,1)));

new_atlas(21+1).Vertices = sort(horzcat(vv1));
new_atlas(21+1).Label = 'Temp-Mid-Ant R';

new_atlas(23+1).Vertices = sort(horzcat(vv2));
new_atlas(23+1).Label = 'Temp-Mid-Post R';
%------------------

r=145+1;
rr = setdiff(rr,r);
vv=atlas(r).Vertices;
vv1 = vv(Vertices(vv,1)>mean(Vertices(vv,1)));
vv2 = vv(Vertices(vv,1)<mean(Vertices(vv,1)));

new_atlas(25+1).Vertices = sort(horzcat(vv1));
new_atlas(25+1).Label = 'STS-Ant R';

new_atlas(27+1).Vertices = sort(horzcat(vv2));
new_atlas(27+1).Label = 'STS-Post R';
%------------------

r=[73 143]+1;
rr = setdiff(rr,r);
vv = sort(horzcat(atlas(r).Vertices));
vv1 = vv(Vertices(vv,1)>mean(Vertices(vv,1)));
vv2 = vv(Vertices(vv,1)<mean(Vertices(vv,1)));

new_atlas(29+1).Vertices = sort(horzcat(vv1));
new_atlas(29+1).Label = 'Temp-Inf-Ant R';

new_atlas(31+1).Vertices = sort(horzcat(vv2));
new_atlas(31+1).Label = 'Temp-Inf-Post R';
%------------------

r = [55 133]+1;
rr = setdiff(rr,r);
new_atlas(33+1).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(33+1).Label = 'Postcentral R';

r = [57 89]+1;
rr = setdiff(rr,r);
new_atlas(35+1).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(35+1).Label = 'Central R';

r = [11]+1;
rr = setdiff(rr,r);
new_atlas(37+1).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(37+1).Label = atlas(11+1).Label;

r = [109 49]+1;
rr = setdiff(rr,r);
new_atlas(39+1).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(39+1).Label = atlas(49+1).Label;

r = [37 113]+1;
rr = setdiff(rr,r);
new_atlas(41+1).Vertices = sort(horzcat(atlas(r).Vertices));
new_atlas(41+1).Label = atlas(37+1).Label;

r = [13 15 21 131 141 101]+1;
rr = setdiff(rr,r);

ii = 41+1;
for i=1:length(rr)
    ii = ii+2;
    new_atlas(ii).Vertices = sort(horzcat(atlas(rr(i)).Vertices));
    new_atlas(ii).Label = atlas(rr(i)).Label;
end



