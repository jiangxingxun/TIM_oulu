%% Get the Lapacian
%%
%% Code by Ziheng Zhou
%% Z. Zhou, G. Zhao, and M. Pietika ?inen. Towards a Practical Lipreading
%% System. In CVPR, 2011.

function L = tim_getLapacian(W)

N = size(W,1);
D = zeros(N,N);
D((0:N-1)*N+(1:N)) = sum(W);
L = D - W;
