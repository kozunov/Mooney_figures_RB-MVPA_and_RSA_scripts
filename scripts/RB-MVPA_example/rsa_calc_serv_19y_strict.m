function cm = rsa_calc_serv_19y_strict(quc,vtr,nn,ff,m0,m1)

            mask = ones(size(quc));
            mask(isnan(quc)) = NaN;             % mask for RDM
            nvtr = setdiff(1:20,vtr);           % numbers of selected rows
            [nu, ix, i2] = intersect(nvtr, nn); % rows to exclude by data
            qunn = ix(ix>0);
            pout = ff;
            pout(:,vtr)=[];
            pout(vtr,:)=[];
            pout = pout.*mask;
            pout(qunn,:) = [];
            pout(:,qunn) = [];
            quc(qunn,:) = [];
            quc(:,qunn) = [];
%             figure;imagesc(pout);
            qulc = triu_line_nan(quc);
            out = triu_line_nan(pout);
            
            if sum(qulc==0)<m0 || sum(qulc==1)<m1
                cm = NaN;
            elseif ~any(out-out(1))
                cm = NaN;
            else                
                cm = corr(qulc',out','type','Spearman');
            end

