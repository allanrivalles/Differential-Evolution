cod_img = 'b2d2c'; n_eletr = 16; val_cond = 5; n_ind = 100; iter_max = 500; CR = 0.9; F = 2*rand(1,n_ind);

% Iniciando o EIDORS
run /path/to/eidors/startup.m

pot_borda_obj_estudo = obj_estudo(cod_img, n_eletr, val_cond);

[n_it,temp,erro] = Evol_Dif(F,CR,n_ind,cod_img,n_eletr,pot_borda_obj_estudo,iter_max);

Mat_iter_temp_erro = [n_it' temp' erro'];

save Mat_iter_temp_erro










