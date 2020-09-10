clear all; clc;

 %parameter
resize_size = 224 ;       %input("pls input resize_size:");
index_part  = 1   ;      %input("pls input index_part:");
resize_area = [224, 224]; %[resize_size, resize_size];


part_name    = dir('../UCF101/');
folder_input = ['../UCF101/',part_name(index_part+2).name];
folder_output = ['./TIM_',num2str(resize_area(1)),'by',num2str(resize_area(2)),'/',part_name(index_part+2).name,'/'];
interp_frames = 16;

INFO_DIR = dir(folder_input);
size_INFO_DIR = get_size_INFO_DIR(INFO_DIR);
num_film = size_INFO_DIR - 2;

%% main process
for index_film = 3:num_film+2
    film_folder = [folder_input,'/',INFO_DIR(index_film).name,'/'];
    images_per_film = dir([film_folder,'*.jpg']);
    images = get_images_per_film(images_per_film, film_folder, resize_area);
    TIM_images = get_TIM_data_per_film(images, interp_frames);
    disp(index_film-2);
    output_TIM_images(index_film-2, TIM_images, folder_output);
end



%% sub process
% Old version Matlab is not support sub process 
function output_TIM_images(index_film, images, folder_output)
    mkdir([folder_output,num2str(index_film)])
    [h,w,c,f] = size(images);
    num_images = floor(f);
    for index_images = 1:num_images
        image = images(:,:,:,index_images);
        image = uint8(image);
        image_path = [folder_output,num2str(index_film),'/',num2str(index_images),'.jpg'];
        imwrite(image,image_path);
    end
end



function [TIM_data] = get_TIM_data_per_film(images, interp_frames)
    images = double(images);
    [h, w, c, f] = size(images);
    imv = reshape(images, h * w * c, f);
    m = tim_getAniModel(imv);
    Z = tim_genAnimationData(m,0,1,interp_frames);
    TIM_data = reshape(Z, h, w, c, interp_frames); 
end


function [images] = get_images_per_film(images_per_film, film_folder, resize_area)
    images = zeros(resize_area(1), resize_area(2), 3, length(images_per_film));
    for index_image_per_film = 1:length(images_per_film)
        image_name = [film_folder, images_per_film(index_image_per_film).name];
        image = imread(image_name);
        image = imresize(image, resize_area, 'bicubic');
        images(:, :, :, index_image_per_film) = image;
    end    
end

function [size_need] = get_size_INFO_DIR(INFO_DIR)
    size_temp = size(INFO_DIR);
    size_need = size_temp(1);  % ÅÅ³ý . ºÍ .. ÎÄ¼þ¼Ð
    
    
    
    
end
