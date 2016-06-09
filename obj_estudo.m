function pot_borda_obj_estudo = obj_estudo(cod_img, n_eletr, val_cond)

%       pot_borda_obj_estudo = obj_estudo(cod_img, n_eletr, val_cond)
%                                                                      
% OBJ_ESTUDO - Calcula a distribui��o de potenciais de borda no objeto de estudo criado pelo usu�rio  
% pot_borda_obj_estudo => distribui��o de potenciais de borda no objeto de estudo
% cod_img => c�digo da imagem pelo EIDORS
% n_eletr => n� de eletrodos de borda
% val_cond => valor de condutividade do objeto interno ao objeto de estudo
%                                                                          
% Autor: Reiga Ramalho Ribeiro                                          
% Aluno de Gradua��o em Eng. Biom�dica - CTG / UFPE                     
% Data de cria��o: 04/06/13                                             
% Data de atualiza��o: 13/06/13  


% Criando e fixando a distribui��o de condutividade el�trica do objeto de estudo
imdl_2d = mk_common_model(cod_img, n_eletr);  
img_22 = mk_image(imdl_2d.fwd_model,1);

for i = 1:size(img_22.elem_data)
    img_22.elem_data(i) = 0.1;
end
figure; show_fem(img_22,[1,1,1]); axis off

pause(3)

n_elem1 = inputdlg('N�mero de elementos do objeto:','IMPORTANTE!');
n_elem = str2double(n_elem1);
for j = 1:n_elem
    pause(1)
    n1 = inputdlg(strcat('N�mero do Elemento',num2str(j),':'),'IMPORTANTE!');
    n = str2double(n1);
    img_22.elem_data(n) = val_cond;
end

% Resolvendo o problema direto para o objeto de estudo
pot_borda = potencial_borda(img_22);
pot_borda_obj_estudo = pot_borda.meas;

figure
% Mostrando objeto de estudo com distribui��o de condutividade el�trica fixada pelo usu�rio   
% % % subplot(1,2,1); 
show_fem(img_22,[1,1]); axis off
% % % title('imagem do objeto de estudo desejada')

% Plotando a distribui��o de potencial el�trico na borda do objeto de estudo
% % % xax = 1:length(pot_borda_obj_estudo);
% % % subplot(1,2,2); plot(xax,[pot_borda_obj_estudo]);
% % % xlabel('Contorno da Imagem');
% % % ylabel('Potencial El�trico');
% % % title('objeto de estudo')

% Salvando o resultado
saveas(gcf,'objeto_de_estudo.bmp');
        
end


