function pot_borda_obj_estudo = obj_estudo(cod_img, n_eletr, val_cond)

%       pot_borda_obj_estudo = obj_estudo(cod_img, n_eletr, val_cond)
%                                                                      
% OBJ_ESTUDO - Calcula a distribuição de potenciais de borda no objeto de estudo criado pelo usuário  
% pot_borda_obj_estudo => distribuição de potenciais de borda no objeto de estudo
% cod_img => código da imagem pelo EIDORS
% n_eletr => nº de eletrodos de borda
% val_cond => valor de condutividade do objeto interno ao objeto de estudo
%                                                                          
% Autor: Reiga Ramalho Ribeiro                                          
% Aluno de Graduação em Eng. Biomédica - CTG / UFPE                     
% Data de criação: 04/06/13                                             
% Data de atualização: 13/06/13  


% Criando e fixando a distribuição de condutividade elétrica do objeto de estudo
imdl_2d = mk_common_model(cod_img, n_eletr);  
img_22 = mk_image(imdl_2d.fwd_model,1);

for i = 1:size(img_22.elem_data)
    img_22.elem_data(i) = 0.1;
end
figure; show_fem(img_22,[1,1,1]); axis off

pause(3)

n_elem1 = inputdlg('Número de elementos do objeto:','IMPORTANTE!');
n_elem = str2double(n_elem1);
for j = 1:n_elem
    pause(1)
    n1 = inputdlg(strcat('Número do Elemento',num2str(j),':'),'IMPORTANTE!');
    n = str2double(n1);
    img_22.elem_data(n) = val_cond;
end

% Resolvendo o problema direto para o objeto de estudo
pot_borda = potencial_borda(img_22);
pot_borda_obj_estudo = pot_borda.meas;

figure
% Mostrando objeto de estudo com distribuição de condutividade elétrica fixada pelo usuário   
% % % subplot(1,2,1); 
show_fem(img_22,[1,1]); axis off
% % % title('imagem do objeto de estudo desejada')

% Plotando a distribuição de potencial elétrico na borda do objeto de estudo
% % % xax = 1:length(pot_borda_obj_estudo);
% % % subplot(1,2,2); plot(xax,[pot_borda_obj_estudo]);
% % % xlabel('Contorno da Imagem');
% % % ylabel('Potencial Elétrico');
% % % title('objeto de estudo')

% Salvando o resultado
saveas(gcf,'objeto_de_estudo.bmp');
        
end


