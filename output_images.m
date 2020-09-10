clear all;clc;

load TIM16_ourdatabae_RGB_112by112;
data_input = TIM16_ourdatabase_RGB;
len_data_input = length(data_input);

for index_data_input = 1:len_data_input
    mkdir(num2str(index_data_input));
    images = data_input{index_data_input};
    [h,w,c,f] = size(images);
    num_images = floor(f);
    for index_images = 1:num_images
        image = images(:,:,:,index_images);
        image = uint8(image);
        image_path = ['./',num2str(index_data_input),'/',num2str(index_images),'.jpg'];
        imwrite(image,image_path);
    end
end

