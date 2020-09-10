%% Create animation model for temporal interpolation using graph embedding
%%
%% Code by Ziheng Zhou
%% Z. Zhou, G. Zhao, and M. Pietika ?inen. Towards a Practical Lipreading
%% System. In CVPR, 2011.

function model = tim_getAniModel(X)

X = double(X);

if size(X,3) > 1
    Y = zeros(size(X,1)*size(X,2),size(X,3));
    for i = 1 : size(X,3)
        Y(:,i) = mat2vec(X(:,:,i));
    end
    X = Y;
end

N = size(X,2);

mu = mean(X,2);
X = X - repmat(mu,1,N);

[U,S,V] = svd(X,'econ');
S(N,:) = [];
S(:,N) = [];
V(:,N) = [];
U(:,N) = [];

if rank(S) < N-1
    S = S + 0.01;
end

Y = S*V';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graph Embedding
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
W = tim_getPathWeightMatrix(N);
L = tim_getLapacian(W);
Y_temp_1 = Y*Y';
Y_temp_2 = Y*L*Y';
size_Y_temp_1 = size(Y_temp_1);
size_1_Y_temp_1 = size_Y_temp_1(1);
level_temp = min(min(Y_temp_1));
pro_to_advoid_singular = rand(size_1_Y_temp_1).*ones(size_1_Y_temp_1).*0.001;

% ori program
%[T,E] = eig((Y_temp_1)\(Y_temp_2));
% modified by jiangxingxun
[T,E] = eig((Y_temp_1+pro_to_advoid_singular)\(Y_temp_2));
E = diag(E);
[E,I] = sort(E);
T = T(:,I);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% From Y'v_j = m_j*v_j^L (eigenvectors of graph Laplacian L), 
% we have y_i'*v_j = m_j*v_j^L(i)
% Let i=1, then m_j = y_1'*v_j/v_j^L(1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m = zeros(N-1,1);
for j = 1 : N-1
    m(j) = Y(:,1)'*T(:,j)/sin(1/N*j*pi+pi*(N-j)/(2*N));
end

model.T = T;
model.U = U;
model.m = m;
model.mu = mu;
model.E = E;
model.n = N;
