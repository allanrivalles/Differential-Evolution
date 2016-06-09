function [img,n_elem] = populacao_inicial (n_ind,cod_img,n_eletr)

%     [img,n_elem] = populacao_inicial (n_ind,cod_img,n_eletr)                     
%                                                                      
% POPULA��O INICIAL - Calcula os indiv�duos (poss�veis solu��es)                         
% img => os indiv�duos com distribui��o interna                  
%            de condutividade el�trica aleat�rio 
% n_elem => n� total de elementos da imagem do objeto de estudo discretizada
% n_ind => n�mero de indiv�duos
% cod_img => c�digo da imagem pelo EIDORS
% n_eletr => n� de eletrodos de borda
%                                                                          
% Autor: Reiga Ramalho Ribeiro                                          
% Aluno de Gradua��o em Eng. Biom�dica - CTG / UFPE                     
% Data de cria��o: 28/05/13                                             
% Data de atualiza��o: 13/06/13           


for i = 1:n_ind
    % fixando a distribui��o de condutividade el�trica nos indiv�duos
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
% % %     title(strcat('Indiv�duo',num2str(i),'da popula��o'));
% % %     saveas(gcf,strcat('imagem_indiv�duo_',num2str(i),'.jpg'));
end

n_elem = length(img_2.elem_data)

end
