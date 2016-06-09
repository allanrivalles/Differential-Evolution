function pot_borda = potencial_borda(rec_img)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%            pot_borda = potencial_borda(rec_img)                       %
%                                                                       %
% POTENCIAL_BORDA - Calcula a distribuição de potenciais elétricos      %       
%                   na borda do objeto de estudo                        %
% rec_img => objeto de estudo com distribuição interna                  %
%            de condutividade elétrica                                  %
%                                                                       %  
% Autor: Reiga Ramalho Ribeiro                                          %
% Aluno de Graduação em Eng. Biomédica - CTG / UFPE                     %
% Data de criação: 04/02/13                                             %
% Data de atualização: 13/06/13                                         %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% Resolvendo problema direto
pot_borda = fwd_solve(rec_img);

end