function [n_it,temp,erro] = Evol_Dif(F,CR,n_ind,cod_img,n_eletr,pot_borda_obj_estudo,iter_max)

[img,n_elem] = populacao_inicial (n_ind,cod_img,n_eletr);

n_cal_erro = 0;
[rank_ind_obj_estudo,n_cal_erro] = avaliacao_aptidao(img,n_ind,cod_img,n_eletr,pot_borda_obj_estudo,n_cal_erro);

rank_min = min(rank_ind_obj_estudo)

tic
f = 1;
n_ger = 0;
while f ~= 2

n_ger = n_ger+1

img_cruz = mutacao_crossover(img,n_ind,cod_img,n_eletr,n_elem,CR,F,rank_ind_obj_estudo);

[rank_ind_final,n_cal_erro] = avaliacao_aptidao(img_cruz,n_ind,cod_img,n_eletr,pot_borda_obj_estudo,n_cal_erro);

for i = 1:n_ind
    if rank_ind_final(i) <= rank_ind_obj_estudo(i)
        img(i).elem_data = img_cruz(i).elem_data;
        rank_ind_obj_estudo(i) = rank_ind_final(i);
    else 
        rank_ind_obj_estudo(i) = rank_ind_obj_estudo(i);
        img(i).elem_data = img(i).elem_data;
    end
end

rank_min = min(rank_ind_obj_estudo)

% Criando um vetor de iterações, um de tempo de execução (min) e um de erro relativo mínimo 
n_it(n_ger) = n_ger;
temp(n_ger) = toc/60;
erro(n_ger) = rank_min;

if (n_ger == 50)||(n_ger == 100)||(n_ger == 150)||(n_ger == 200)||(n_ger == 250)||(n_ger == 300)||(n_ger == 350)||(n_ger == 400)||(n_ger == 450)||(n_ger == 500)

imdl_1d = mk_common_model(cod_img, n_eletr);  
rec_img = mk_image(imdl_1d.fwd_model,1);
for k = 1:n_ind
    if rank_ind_obj_estudo(k) == rank_min
        a(:,1) = img(k).elem_data;
        rec_img.elem_data = a;
        pot_borda = potencial_borda(rec_img);
        pot_borda_procurado = pot_borda.meas;
    end
end

% Resolvendo o problema inverso
erro_procurado = rank_min;
val_cor = 0.1;
imgr = img_reconst_cond(cod_img,n_eletr,pot_borda_procurado,val_cor);
figure; 
% % % subplot(1,2,1);
show_fem(imgr,[1,1]); axis off
% % % title(strcat('Solução Procurada - erro relativo', num2str(erro_procurado)));
        
% Plotando os potenciais de borda do individuo procurado e salvando o resultado
% % % xax = 1:length(pot_borda.meas);
% % % subplot(1,2,2); plot(xax,pot_borda_procurado);
% % % xlabel('Contorno da Imagem');
% % % ylabel('Potencial Elétrico');
% % % title('solução procurada pós-filtro');
saveas(gcf,strcat('imagem_resultado',num2str(n_ger),'.bmp'));

% Mostrando o gráfico Erro Relativo X Nº de Gerações
figure
plot(n_it,erro,'*-');
% % % title(strcat('Comportamento das Gerações para CR:',num2str(CR)));
xlabel('Number of generations');
ylabel('Relative error');
saveas(gcf,strcat('Erro Relativo X Nº de Gerações',num2str(n_ger),'.bmp'));

if n_ger == iter_max
    f = 2;
    num_de_calculos_de_erro = n_cal_erro
end

end

end

end


