function h = my_subplot(r,c,n)

dw = 0.02;
dh = 0.03;

hr = round((1-dh)/r*100)/100;
wc = round((1-dw)/c*100)/100;

cc = rem((n-1),c)+1;
cr = (n-cc)/c+1;

y = dh+(r-cr)*hr;
x = dw+(cc-1)*wc;

h=subplot('Position',[x y wc-dw hr-dh]);