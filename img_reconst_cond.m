function imgr = img_reconst_cond(cod_img,n_eletr,pot_borda,val_cor)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%         imgr = img_reconst_cond(cod_img,n_eletr,pot_borda,val_cor)      %
%                                                                         %
% IMG_RECONST_COND - Calcula a distribui��o de condutividade el�trica     %
%                    no interior do objeto de estudo                      %
%                                                                         %
% cod_img => c�digo de identifica��o da malha do objeto                   %
% n_eletr => n�mero de eletrodos em torno do objeto                       %
% pot_borda => distribui��o de potenciais el�tricos na borda do objeto    %
% val_cor => valor da corrente el�trica (mA) aplicado na borda do objeto  %
%                                                                         %
% Autor: Reiga Ramalho Ribeiro                                            %
% Aluno de Gradua��o em Eng. Biom�dica - CTG / UFPE                       %
% Data de cria��o: 01/02/13                                               %
% Data de atualiza��o: 23/03/13                                           %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% Criando o objeto de estudo
imdl_2d = mk_common_model(cod_img, n_eletr);  
sim_img = mk_image(imdl_2d.fwd_model,1);
img_222 = sim_img;

% Fixando o padr�o de estimula��o de corrente 
stim =  mk_stim_patterns(n_eletr,1,'{ad}','{ad}',{},val_cor);
img_222.fwd_model.stimulation = stim;
img_222.elem_data = zeros(length(img_222.elem_data),1)+1e-01;

% Resolvendo o problema direto para distribui��o de condutividade homog�nea
vh_data = fwd_solve(img_222);

% Resolvendo o problema direto para distribui��o de condutividade n�o-homog�nea
vi_data = pot_borda;

% Calculando a distribui��o de condutividade no interior do objeto
imdl_2d.reconst_type = 'difference';
imgr = inv_solve(imdl_2d, vh_data, vi_data);

end

