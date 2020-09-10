function output_TIM_images(images, folder_output, films_name)
    mkdir([folder_output, films_name])
    [h,w,c,f] = size(images);
    num_images = floor(f);
    for index_images = 1:num_images
        image = images(:,:,:,index_images);
        image = uint8(image);
        image_path = [folder_output,films_name,'/',num2str(index_images, "%5d"),'.jpg'];
        imwrite(image,image_path);
    end
end
