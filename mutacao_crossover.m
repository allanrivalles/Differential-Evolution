function img_cruz = mutacao_crossover(img,n_ind,cod_img,n_eletr,n_elem,CR,F,rank_ind_obj_estudo)

rank_min = min(rank_ind_obj_estudo);
for i = 1:n_ind
    if rank_min == rank_ind_obj_estudo(i)
        img_min(:,1) = img(i).elem_data;
    end
end
       
imdl_1d = mk_common_model(cod_img, n_eletr);  
img_mut = mk_image(imdl_1d.fwd_model,1);
% % % for i = 1:n_ind
% % %     if i <= n_ind-2
% % %     img_mut(i).elem_data = img_min(:,1) + F(i)*(img_min(:,1)-img(i).elem_data) + F(i)*(img(i+1).elem_data-img(i+2).elem_data);
% % %     else if i == n_ind-1
% % %         img_mut(i).elem_data = img_min(:,1) + F(i)*(img_min(:,1)-img(i).elem_data) + F(i)*(img(i+1).elem_data-img(i-1).elem_data);
% % %         else if i == n_ind
% % %                 img_mut(i).elem_data = img_min(:,1) + F(i)*(img_min(:,1)-img(i).elem_data) + F(i)*(img(i-2).elem_data-img(i-1).elem_data);
% % %             end
% % %         end
% % %     end 
% % % end
  
for i = 1:n_ind
% % %     j1 = abs(randi(n_ind)); 
% % %     j2 = abs(randi(n_ind));
    j3 = abs(randi(n_ind));
    j4 = abs(randi(n_ind));
    img_mut(i).elem_data = img(i).elem_data + F(i)*(img_min(:,1)-img(i).elem_data) + F(i)*(img(j3).elem_data-img(j4).elem_data);  
end

imdl_1d = mk_common_model(cod_img, n_eletr);
img_cruz = mk_image(imdl_1d.fwd_model,1);
I = n_elem*rand(1);
r = rand(1,n_elem);
for k = 1:n_ind
    for j = 1:n_elem
        if (r(j) > CR) && (j ~= I)
            a(j,1) = img(k).elem_data(j);
        else if (r(j) <= CR) || (j == I)
                a(j,1) = img_mut(k).elem_data(j);
            end
        end
    end
    img_cruz(k).elem_data = a;
end

end