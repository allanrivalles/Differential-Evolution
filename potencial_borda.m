function pot_borda = potencial_borda(rec_img)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
%            pot_borda = potencial_borda(rec_img)                       %
%                                                                       %
% POTENCIAL_BORDA - Calcula a distribui��o de potenciais el�tricos      %       
%                   na borda do objeto de estudo                        %
% rec_img => objeto de estudo com distribui��o interna                  %
%            de condutividade el�trica                                  %
%                                                                       %  
% Autor: Reiga Ramalho Ribeiro                                          %
% Aluno de Gradua��o em Eng. Biom�dica - CTG / UFPE                     %
% Data de cria��o: 04/02/13                                             %
% Data de atualiza��o: 13/06/13                                         %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% Resolvendo problema direto
pot_borda = fwd_solve(rec_img);

end