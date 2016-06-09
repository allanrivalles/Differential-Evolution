function [rank_ind,n_cal_erro] = avaliacao_aptidao(img_cruz,n_ind,cod_img,n_eletr,pot_borda_obj_estudo,n_cal_erro)

%            rank_ind = avaliacao_aptidao(img,n_ind,cod_img,n_eletr,pot_borda_obj_estudo)                   
%                                                                      
% AVALIACAO_APTIDAO - Calcula o erro relativo para os indiv�duos (poss�veis solu��es)
% rank_ind - vetor de erros relativos dos indiv�duos
% img => os indiv�duos com distribui��o interna                  
%            de condutividade el�trica aleat�rio 
% n_ind => n�mero de indiv�duos
% cod_img => c�digo da imagem pelo EIDORS
% n_eletr => n� de eletrodos de borda
% pot_borda_obj_estudo => distribui��o de potencial de borda no objeto de estudo
%                                                                          
% Autor: Reiga Ramalho Ribeiro                                          
% Aluno de Gradua��o em Eng. Biom�dica - CTG / UFPE                     
% Data de cria��o: 28/05/13                                             
% Data de atualiza��o: 13/06/13      

imdl_2d = mk_common_model(cod_img, n_eletr);  
img_dpe = mk_image(imdl_2d.fwd_model,1);
for j = 1:n_ind
    % Resolvendo o problema direto para os indiv�duos
    img_dpe.elem_data = img_cruz(j).elem_data;
    
    pot_borda = potencial_borda(img_dpe);
    
    % Calculando o erro relativo dos indiv�duos
    soma = 0;
    soma2 = 0;
    v = length(pot_borda.meas);
    for i = 1:v
        soma = soma + (pot_borda_obj_estudo(i) - pot_borda.meas(i))^2;
        soma2 = soma2 + (pot_borda_obj_estudo(i))^2;
    end
    Erro = sqrt(soma/soma2); % Valor entre 0 e 1
    rank_ind(j) = Erro;
    n_cal_erro = n_cal_erro + 1;
end

end



