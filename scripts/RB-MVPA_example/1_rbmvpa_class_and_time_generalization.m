% this script takes a long time to complete
% even when calculated for selected roi and condition combinations
% it is given here as an example

person = {
    'AD';
    ...
    }; 

cond = {'110';
    '120';
    '130';
    '140';
    '151';
    '161';
    '171';
    '181';
    '190';
    '200';
    '111';
    '121';
    '131';
    '141';
    '151';
    '161';
    '171';
    '181';
    '190';
    '200'};


roi = [41 42]; % take only selected roi to finish in the foreseeable time
    
np = 10; % number of pseudo trials

for p=1:length(person)

    erccct=NaN*zeros(4,4,20,length(roi),51,51);

            D1 = spm_eeg_load(strcat(data_dir2,'bnifcrefspm8_',person{p},'_run1_raw_tsss_mc.mat'));
            D2 = spm_eeg_load(strcat(data_dir2,'bnifcrefspm8_',person{p},'_run3_raw_tsss_mc.mat'));
            hmfile = strcat(hm_dir2,person{p},'/15/','headmodel_surf_os_meg.mat');
            ncovfile = strcat(hm_dir2,person{p},'/15/','noisecov_full.mat');
            srcSurfFile = strcat(anat_dir2,person{p},'/tess_cortex_pial_low.mat');
            atlas = make_new_atlas(person{p},anat_dir2);
            time_del = 336;
            
            
               % inverse operator
                megplanarbst= sort([1:3:304 2:3:305]);

%                 load(srcSurfFile);     
                load(hmfile);
                load(ncovfile);

                HeadModel.Gain = Gain(megplanarbst,:);
                HeadModel.GridOrient = GridOrient;

                OPTIONS.NoiseCov = NoiseCov(megplanarbst,megplanarbst);
                for i=1:length(megplanarbst)
                    OPTIONS.ChannelTypes{i} = 'MEG GRAD';
                end
                OPTIONS.InverseMethod = 'sloreta';
                OPTIONS.SourceOrient = {'fixed'};
                OPTIONS.SNR = 3;
                OPTIONS.gradreg = 0.1;
                OPTIONS.depth = 0;

                Results = bst_wmne(HeadModel,OPTIONS);
                ImKernel = Results.ImagingKernel;
                
    % precalculate space projectors on the decimated data set  
    
    crd=[];
    for ci=1:20

        if ci<=10
            p1 = pickconditions(D1,cond{ci},1);
            d1 = D1(1:204,:,p1(6:20:end));
        else
            p1 = pickconditions(D2,cond{ci},1);
            d1 = D2(1:204,:,p1(6:20:end));
        end
        
        if length(p1)>=50 
            % take interval 0 500 ms 
            d1 = d1(:,(0:500)+time_del+1,:);
            rd1=zeros(size(d1,1),round(size(d1,2)/10)+1,size(d1,3));
            for tr=1:size(d1,3)
                rd1(:,:,tr) = resample(squeeze(d1(:,:,tr))',1,10)';
            end
            rmd1 = reshape(rd1,204,[]);
   
            crd = cat(2,crd,rmd1);
        end
    end
    
    % transfer to source space
    sd = ImKernel*crd;
     
    ua = [];
    for i=1:length(roi)
        
        ri = roi(i);
        
        ud1=[]; ud2=[];

        vert = atlas(ri).Vertices;
        
        [u s v] = svd(sd(vert,:));
        ds = diag(s(:,1:size(s,1)));
        ds(ds<1e-10) = [];
        n = min([3 length(ds)]);
        ua{i} = u(:,1:n)';
    end

    % precalculate principal components

    pud = NaN*zeros(20,length(roi),3,51,np);

    for ci=1:20

        if ci<=10
            p1 = pickconditions(D1,cond{ci},1);
            d1 = D1(1:204,:,p1);
        else
            p1 = pickconditions(D2,cond{ci},1);
            d1 = D2(1:204,:,p1);
        end

        if length(p1)>=50 

        % take interval -0 500 ms 
        d1 = d1(:,(0:500)+time_del+1,:);

        % resample
        rd1=zeros(size(d1,1),round(size(d1,2)/10)+1,size(d1,3));
        for tr=1:size(d1,3)
            rd1(:,:,tr) = resample(squeeze(d1(:,:,tr))',1,10)';
        end

        clear d1 

        % transfer to source space

        sd1=zeros(size(ImKernel,1),size(rd1,2),size(rd1,3));
        for tr=1:size(rd1,3)
            sd1(:,:,tr) = ImKernel*squeeze(rd1(:,:,tr));
        end

        ssd1=[];
        ntr = length(p1);
        nm = ceil(ntr/np);
        for i=1:np
            ix = i+(0:np:(nm-1)*np);
            ix(ix>ntr) = [];
            ssd1(:,:,i) = mean(sd1(:,:,ix),3);
        end

        for i=1:length(roi)

            ri = roi(i);

            ud1=[]; ud2=[];

            vert = atlas(ri).Vertices;

            for tr=1:size(ssd1,3)
                ud1(:,:,tr) = ua{i}*squeeze(ssd1(vert,:,tr));
            end

            pud(ci,i,:,:,:) = ud1;

        end
        end
    end

    % here is the main part
    % c1 and c2 are the training pair

    c1 = [5 6]; % faces
    c2 = [9 10]; % nonsense
    for i=1:length(roi)
        for cii=1:length(c1)
            for cjj=1:length(c2)
                ci = c1(cii);
                cj = c2(cjj);
                for t=1:51
                    vect1 = squeeze(pud(ci,i,:,t,:))';
                    n1 = size(vect1,1);
                    vect2 = squeeze(pud(cj,i,:,t,:))';
                    n2 = size(vect2,1);
                    vect = [vect1; vect2];
                    group = [repmat(1,[n1 1]);repmat(2,[n2 1])];

                    for c3=1:20
                        if ~isnan(vect1(1,1)) && ~isnan(vect2(1,1))...
                             && ~isnan(pud(c3,i,1,1,1))
                            for t2=1:51
                                vect3 = squeeze(pud(c3,i,:,t2,:))';
                                class = classify(vect3,vect,group);
                                a1 = sum(class==1);
                                a2 = sum(class==2);
                                erccct(cii,cjj+2,c3,i,t,t2) = a1/10;
                                erccct(cjj+2,cii,c3,i,t,t2) = a2/10;
                            end
                        else
                            erccct(cii,cjj+2,c3,i,t,:) = NaN;
                            erccct(cjj+2,cii,c3,i,t,:) = NaN;
                        end
                    end
                    [p i cii cjj t]
                end
            end
        end
    end

    save(strcat(out_dir,'erccct_5_9_p_',num2str(p),'.mat'),'erccct');
    
end   

       
        



