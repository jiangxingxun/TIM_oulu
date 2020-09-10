%% Generate animation data for temporal interpolation using graph embedding
%%
%% Code by Ziheng Zhou
%% Z. Zhou, G. Zhao, and M. Pietika ?inen. Towards a Practical Lipreading
%% System. In CVPR, 2011.

function synX = tim_genAnimationData(varargin)
% synX = tim_genAnimationData(model, 
%                         bpos, epos,   // bpos, epos \in [1/n,1]
%                         nframe);
% synX = tim_getAnimationData(model, 
%                         pos)          // an array storing all positions
%                                       // pos \in [1/n, 1]

if nargin ~= 2 && nargin ~= 4
    error('Invalid number of input arguments');
end

model = varargin{1};

if nargin==4
    bpos = varargin{2};
    epos = varargin{3};
    nframe = varargin{4};
    
    bpos = max(bpos,1/model.n);
    epos = max(bpos,epos);
    epos = min(epos,1);
    nframe = max(floor(nframe),1);
    
    if nframe > 1
        pos = bpos:(epos-bpos)/(nframe-1):epos;
    else
        pos = bpos;
    end
end

if nargin==2
    pos = varargin{2};
    pos(pos<1/model.n) = 1/model.n;
    pos(pos>1) = 1;
end
    
synX = zeros(size(model.U,1),length(pos));
n = model.n;

ndim = size(model.T,1);
for i = 1 : length(pos)
    v = zeros(ndim,1);
    for k = 1 : ndim
        v(k) = sin(pos(i)*k*pi+pi*(n-k)/(2*n));
    end
    synX(:,i)=model.U*(model.T'\(v.*model.m))+model.mu;
end
