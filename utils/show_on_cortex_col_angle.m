function show_on_cortex_col_angle(srcs_disp1,titl,vert,face,angle)
       

        cla; axis off

        fig1 = patch('vertices',vert,'faces',face,'FaceVertexCData',srcs_disp1);

        set(fig1,'FaceColor',[.5 .5 .5],'EdgeColor','none');
        shading interp
        lighting gouraud
        %camlight
        zoom off
        lightangle(0,270);lightangle(270,0),lightangle(90,0),lightangle(0,45),lightangle(0,135);
%         material([.1 .1 .4 .5 .4]);
        material([.5 .1 .2 .5 .4]);
        view(angle);
        caxis([0 1])
        colormap(jet);
        axis tight
        if ~isempty(titl)
            title(titl);
        end

end
