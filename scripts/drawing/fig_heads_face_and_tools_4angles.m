% this needs SPM package to be installed
% and make sure utils folder is on the path

cd ../..
anat_dir = './anat';

srcSurfFile = strcat(anat_dir,'\tess_cortex_pial_low_5002V.mat');
an_str = load(srcSurfFile);
      
atlas = make_new_atlas_g(an_str);

M.vertices = an_str.Vertices;
M.faces = an_str.Faces;
M = spm_mesh_inflate(M);
Vertices = M.vertices;
Faces = M.faces;

hs=[];

% load precalculated significant region-time points
load('data\sgnf_cmf1.mat');
sgnf1 = sgnf;
load('data\sgnf_cmt1.mat');
sgnf2 = sgnf;

tw = [
    100 130; %1
    140 160; %2
    170 200; %3
    210 230; %4
    240 290; %5
    300 400]; %6

figure('Position',[20 50 550 700]);
nr = 6;
nc = 1;

vost = [2 2 2 2 4 7];

anv = [90 -90;
    -90 90;
    0 0;
    180 0];

for an=1:4
    for pic=1:6

                time = tw(pic,:);
                tix = (time)/10+1;
                tix = tix(1):tix(2);

                six1 = zeros(82,length(tix));
                six2 = zeros(82,length(tix));
                six3 = zeros(82,length(tix));
                for k=1:length(tix)
                    ss1 = sgnf1.r(sgnf1.t==tix(k));
                    six1(ss1,k) = 1;
                    ss2 = sgnf2.r(sgnf2.t==tix(k));
                    six2(ss2,k) = 1;
                end
                six1 = double(sum(six1')'>=vost(pic));
                six2 = double(sum(six2')'>=vost(pic));
                six3 = six1&six2;

                val = repmat([0.8 0.8 0.8],[5002 1]);

                for r=1:82
                    if six1(r)>0  
                        in = atlas(r).Vertices;
                            val(in,:) = repmat([0 0 1],[length(in) 1]);
                    end
                    if six2(r)>0  
                        in = atlas(r).Vertices;
                            val(in,:) = repmat([0 0.5 0],[length(in) 1]);
                    end
                    if six3(r)>0 
                        in = atlas(r).Vertices;
                            val(in,:) = repmat([0.8 0 0.2],[length(in) 1]);
                    end
                end

                if pic==1
                    in = atlas(72).Vertices;
                    val(in,:) = repmat([0.8 0.8 0.8],[length(in) 1]);
                end

                hi = an+(pic-1)*4;
                hs(hi)=my_subplot_wh(nr,nc*4,hi,0.05,0.03);
                lbl=num2str(time(1));
                lbl='';
                show_on_cortex_col_angle(val,lbl,Vertices,Faces,anv(an,:))

    end

end

