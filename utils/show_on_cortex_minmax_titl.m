function show_on_cortex_minmax_titl(srcs_disp1,minmax,titl,vert,face)

if minmax(1)<0
    ni = find(srcs_disp1<0);
    pi = find(srcs_disp1>=0);
    srcs_disp1(ni) = srcs_disp1(ni)/(2*abs(minmax(1)))+0.5;
    srcs_disp1(pi) = srcs_disp1(pi)/(2*abs(minmax(2)))+0.5;
else
    pi = 1:length(srcs_disp1);
    srcs_disp1(pi) = (srcs_disp1(pi)-minmax(1))/(minmax(2)-minmax(1));
end
        cla; axis off

        fig1 = patch('vertices',vert,'faces',face,'FaceVertexCData',srcs_disp1);

        set(fig1,'FaceColor',[.5 .5 .5],'EdgeColor','none');
        shading interp
        lighting gouraud
%         camlight
        zoom off
        lightangle(0,270);lightangle(270,0),lightangle(90,0),lightangle(0,45),lightangle(0,135);
        material([.5 .1 .2 .5 .4]);
        caxis([0 1])
        colormap(jet);
        title(titl);
end
