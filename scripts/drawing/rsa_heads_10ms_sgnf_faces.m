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


figure('Position',[20 20 1200 930]);
hi=0;
nr = 5;
nc = 6;

hs=[];

st = 90;
time = st:10:st+(nr*nc-1)*10;

% load RSA results
load('data\cms.mat'); 
% load precalculated significant region-time points
load('data\sgnf_cmf1.mat');

% make nonnan selection of participants
pp = find(~isnan(cms(1,:,1,1)));

cmi = squeeze(nanmean(cms(1,pp,:,:),2));

m = 1;

for pic=1:nr*nc
    
            tix = (time(pic))/10+1;
            m = m+0.02;
           
            six = zeros(82,length(tix));
            for k=1:length(tix)
                six(sgnf.r(sgnf.t==tix(k)),k) = 1;
            end
            
            cmim = squeeze(cmi(:,tix));
            cmim = cmim.*six;

            val = repmat(0,[5002 1]);

            for k=1:82
                 in = atlas(k).Vertices;
                 val(in,:) = repmat(cmim(k),[length(in) 1]);
            end
                

            hi = hi+1;
            hs(hi)=my_subplot(nr,nc,hi);
            lbl = strcat(num2str(time(pic)));
            show_on_cortex_minmax_titl(val,[0.05 0.2*m],lbl,Vertices,Faces)

end


    hlink = linkprop(hs, {'CameraPosition','CameraUpVector'});
    key = 'graphics_linkprop';
    setappdata(hs(1),key,hlink); 

    
    
    
    
    
    
