function out = toMatrix(quc)

tquc=[];
            for ti=1:length(quc)
                switch quc(ti)
                    case 0
                        tquc(ti,:) = quc;
                    case 1
                        tquc(ti,:) = ~quc;
                end
            end
out = tquc;
