%% Main function for normalising an image sequence through temporal
%% interpolation
%%
%% Animates an image sequence directory
%%
%% Usage: animate(image_directory, length_of_normalised_sequence,
%% output_directory)
%% e.g. animate('~/indir',10,'~/outdir')

function output = tim_animate2mat(varargin)

if nargin ~= 1 && nargin ~= 2
    error('Invalid number of input arguments');
end

if nargin == 1
    data = varargin{1};
    expandtonum = 10; % default
end
    
if nargin == 2
data = varargin{1};
expandtonum = varargin{2};
end

img_num = size(data, 3);
%load images
for j = 1 : img_num %skip . and ..
    im = data(:, :, j);
    if j == 1
        imagesize = size(im);
    end
    imv(:,j) = im(:); %vectorise image
end


%create animation
m = tim_getAniModel(imv);
Z = tim_genAnimationData(m,0,1,expandtonum);

%extract images
output = zeros(imagesize(1),imagesize(2), expandtonum);
for j = 1 : expandtonum
    output(:, :, j) = reshape(Z(:,j),imagesize(1),imagesize(2)); %monochrome
end


