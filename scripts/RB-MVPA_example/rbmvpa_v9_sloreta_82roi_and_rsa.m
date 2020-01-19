% this script requires about 40 hours of calculation time for one person
% it is given here as an example

person = {
    'AA';
    ...
    }; 

% here is the list of "correct" conditions fro two session separately
% the last digit means 0 - unrecognized; 1 - recognized
% so conditions 11x 12x 13x 14x differ in first and second sessions

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

roi = 1:82;

np = 10; % number of pseudo trials

% initialize RSA results by NaNs
cm=NaN*zeros(2,length(person),length(roi),51); % face/tool, patrticipant, roi, time

for p=1:length(person)

    ert=zeros(20,20,82,51);

    D1 = spm_eeg_load(strcat(data_dir,'bnifcrefspm8_',person{p},'_run1_raw_tsss_mc.mat'));
    D2 = spm_eeg_load(strcat(data_dir,'bnifcrefspm8_',person{p},'_run3_raw_tsss_mc.mat'));

        % inverse operator

        hmfile = strcat(hm_dir,person{p},'/15/','headmodel_surf_os_meg.mat');
        ncovfile = strcat(hm_dir,person{p},'/15/','noisecov_full.mat');
        megplanarbst= sort([1:3:304 2:3:305]);
        
        srcSurfFile = strcat(anat_dir,person{p},'/tess_cortex_pial_low.mat');
        load(srcSurfFile);
      
        load(hmfile);
        load(ncovfile);

        atlas = make_new_atlas(person{p},anat_dir);

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
%         OPTIONS.weightexp = 0.8;

        Results = bst_wmne(HeadModel,OPTIONS);
        ImKernel = Results.ImagingKernel;

    for ci=1:19
        for cj=ci+1:20

            if ci<=10
                p1 = pickconditions(D1,cond{ci},1);
                d1 = D1(1:204,:,p1);
            else
                p1 = pickconditions(D2,cond{ci},1);
                d1 = D2(1:204,:,p1);
            end

            if cj<=10
                p2 = pickconditions(D1,cond{cj},1);
                d2 = D1(1:204,:,p2);
            else
                p2 = pickconditions(D2,cond{cj},1);
                d2 = D2(1:204,:,p2);
            end

            if length(p1)<50 || length(p2)<50
                ert(ci,cj,:,:) = NaN;
            else

                % take interval 0 500 ms 
                d1 = d1(:,(0:500)+336+1,:);
                d2 = d2(:,(0:500)+336+1,:);

                % resample
                rd1=zeros(size(d1,1),size(d1,2),size(d1,3));
                for tr=1:size(d1,3)
                    rd1(:,:,tr) = resample(squeeze(d1(:,:,tr))',1,10)';
                end
                rd2=zeros(size(d2,1),size(d2,2),size(d2,3));
                for tr=1:size(d2,3)
                    rd2(:,:,tr) = resample(squeeze(d2(:,:,tr))',1,10)';
                end

                clear d1 d2

                % transfer to source space

                sd1=zeros(size(ImKernel,1),size(rd1,2),size(rd1,3));
                for tr=1:size(rd1,3)
                    sd1(:,:,tr) = ImKernel*squeeze(rd1(:,:,tr));
                end
                sd2=zeros(size(ImKernel,1),size(rd2,2),size(rd2,3));
                for tr=1:size(rd2,3)
                    sd2(:,:,tr) = ImKernel*squeeze(rd2(:,:,tr));
                end


                ssd1=[];ssd2=[];
                ntr = length(p1);
                nm = ceil(ntr/np);
                for i=1:np
                    ix = i+(0:np:(nm-1)*np);
                    ix(ix>ntr) = [];
                    ssd1(:,:,i) = mean(sd1(:,:,ix),3);
                end

                ntr = length(p2);
                nm = ceil(ntr/np);
                for i=1:np
                    ix = i+(0:np:(nm-1)*np);
                    ix(ix>ntr) = [];
                    ssd2(:,:,i) = mean(sd2(:,:,ix),3);
                end

                for i=1:length(roi)

                    ri = roi(i);

                    ud1=[]; ud2=[];

                    vert = atlas(ri).Vertices;

                    ssd = cat(2,ssd1(vert,:,:),ssd2(vert,:,:));
                    rsd = reshape(ssd,length(vert),[]);
                    [u s v] = svd(rsd);
                    ds = diag(s(:,1:size(s,1)));
                    ds(ds<1e-10) = [];
                    n = min([3 length(ds)]);
            %         if n<3
            %             stop=1;
            %         end
                    for tr=1:size(ssd1,3)
                        ud1(:,:,tr) = u(:,1:n)'*squeeze(ssd1(vert,:,tr));
                    end
                    for tr=1:size(ssd2,3)
                        ud2(:,:,tr) = u(:,1:n)'*squeeze(ssd2(vert,:,tr));
                    end

                    for t=1:51
                        if size(ud1,1)==1
                            vect1 = squeeze(ud1(:,t,:));
                        else
                            vect1 = squeeze(ud1(:,t,:))';
                        end
                        n1 = size(vect1,1);
                        if size(ud2,1)==1
                            vect2 = squeeze(ud2(:,t,:));
                        else
                            vect2 = squeeze(ud2(:,t,:))';
                        end
                        n2 = size(vect2,1);
                        vect = [vect1; vect2];
                        agroup = [repmat(1,[n1 1]);repmat(2,[n2 1])];

                        % randomization
                        hc = 0;
                        for j=1:np^2
                            o1 = mod(j-1,np)+1;
                            o2 = ceil(j/np)+np; % shift to second group
                            training = vect;
                            training([o1 o2],:) = [];
                            group = agroup;
                            group([o1 o2],:) = [];
                            sample = vect([o1 o2],:);
                            [class err] = classify(sample,training,group);
                            if class(1)==1
                                hc=hc+1;
                            end
                            if class(2)==2
                                hc=hc+1;
                            end
                        end

                        ert(ci,cj,i,t) = hc/np^2/2;

                    end
                end
            end
        end
    end
    
    
%----------------------------------------------
% RSA starts here

    ertm = ert(:,:,:,11:61);
    nn = [];
    tt = squeeze(ertm(:,:,1,1));
    tt = tt+tt';
    for i=1:20
        ttr = tt(i,:);
        ttr(i) = [];
        if all(isnan(ttr))
            nn = [nn i];
        end
    end
    for i=1:10
        if ismember(i,nn)
            nn = unique([nn i+10]);
        end
    end
    for i=11:20
        if ismember(i,nn)
            nn = unique([nn i-10]);
        end
    end
      
    for i=1:82 % roi
       for t=1:51 % time
            ff=triu(squeeze(ertm(:,:,i,t)),1);
            ff = ff+ff';
          
            % 6.2   learned face against repeated and noise
            vtr = [3:8 13:18];
            quc=[0 0 0 0 1 1 0 0];
            quc=toMatrix(quc);
%             figure;image((quc+0.2)*100);
            cm(1,p,i,t) = rsa_calc_serv_19y_strict(quc,vtr,nn,ff,16,12);
            
            % 6.3   learned object against repeated and noise
            vtr = [1:2 5:8 11:12 15:18];
            quc=[0 0 0 0 1 1 0 0];
            quc=toMatrix(quc);
%             figure;image((quc+0.2)*100);
            cm(2,p,i,t) = rsa_calc_serv_19y_strict(quc,vtr,nn,ff,16,12);

      end
   end
    
end


       
        



