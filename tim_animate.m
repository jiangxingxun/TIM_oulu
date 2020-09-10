%% Main function for normalising an image sequence through temporal
%% interpolation
%%
%% Animates an image sequence directory
%%
%% Usage: animate(image_directory, length_of_normalised_sequence,
%% output_directory)
%% e.g. animate('~/indir',10,'~/outdir')
% ChangeLog
% re-visit the input argument and directly use video data
% change the input argement (for image output and video output) Sept 14,
% 2016
function tim_animate(varargin)

if nargin ~= 2 && nargin ~= 4
    error('Invalid number of input arguments');
end

data = varargin{1};
expandtonum = varargin{2};

if nargin == 4
    outputdir = varargin{3};
    flag = varargin{4};
    
end

N = ndims(data);

if N == 4 % color
    [h, w, c, f] = size(data);
    imv = reshape(data, h * w * c, f);
    %create animation
    m = tim_getAniModel(imv);
    Z = tim_genAnimationData(m,0,1,expandtonum);
    TIM_data = reshape(Z, h, w, c, expandtonum);
end

if N == 3
    [h, w, f] = size(data);
    imv = reshape(data, h * w, f);
    m = tim_getAniModel(imv);
    Z = tim_genAnimationData(m,0,1,expandtonum);
    TIM_data = reshape(Z, h, w, expandtonum);
end

if nargin == 4
    
    if strcmp(lower(flag), 'image')
        %extract images
        for j = 1 : expandtonum
            if N == 3
                imwrite(uint8(TIM_data(:, :, j)), strcat(outputdir,'/',num2str(j),'.bmp'));
            end
            if N == 4
                imwrite(uint8(TIM_data(:, :, :, j)), strcat(outputdir,'/',num2str(j),'.bmp'));
            end
        end
    else
        outName = outputdir;% subject+micro+emo.avi
        vidOut = VideoWriter(outName);
        vidOut.FrameRate = 15;
        open(vidOut);
        
        if N == 4
            for i = 1 : expandtonum
                img_data = uint8(TIM_data(:, :, :, i));
                writeVideo(vidOut, img_data);
            end
            close(vidOut);
        end
        
        
        if N == 3
            for i = 1 : expandtonum
                img_data = uint8(TIM_data(:, :, i));
                writeVideo(vidOut, img_data);
            end
            close(vidOut);
        end
    end
end