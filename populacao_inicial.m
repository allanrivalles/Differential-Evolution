function [img,n_elem] = populacao_inicial (n_ind,cod_img,n_eletr)

%     [img,n_elem] = populacao_inicial (n_ind,cod_img,n_eletr)                     
%                                                                      
% POPULAÇÃO INICIAL - Calcula os indivíduos (possíveis soluções)                         
% img => os indivíduos com distribuição interna                  
%            de condutividade elétrica aleatório 
% n_elem => nº total de elementos da imagem do objeto de estudo discretizada
% n_ind => número de indivíduos
% cod_img => código da imagem pelo EIDORS
% n_eletr => nº de eletrodos de borda
%                                                                          
% Autor: Reiga Ramalho Ribeiro                                          
% Aluno de Graduação em Eng. Biomédica - CTG / UFPE                     
% Data de criação: 28/05/13                                             
% Data de atualização: 13/06/13           


for i = 1:n_ind
    % fixando a distribuição de condutividade elétrica nos indivíduos
    imdl_2d = mk_common_model(cod_img, n_eletr);  
    img_2 = mk_image(imdl_2d.fwd_model,1);
    for j = 1:size(img_2.elem_data)
        img_2.elem_data(j) = (1/5)*rand(1);
    end
    img(i).elem_data = img_2.elem_data;
% % %     imdl_1d = mk_common_model(cod_img, n_eletr);  
% % %     imgr = mk_image(imdl_1d.fwd_model,1);
% % %     imgr.elem_data = img(i).elem_data;
% % %     figure; show_fem(imgr,[1,1]); axis off
% % %     title(strcat('Indivíduo',num2str(i),'da população'));
% % %     saveas(gcf,strcat('imagem_indivíduo_',num2str(i),'.jpg'));
end

n_elem = length(img_2.elem_data)

end
