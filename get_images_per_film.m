function [images] = get_images_per_film(images_per_film, film_folder, resize_area)
    images = zeros(resize_area(1), resize_area(2), 3, length(images_per_film));
    for index_image_per_film = 1:length(images_per_film)
        image_name = [film_folder, images_per_film(index_image_per_film).name];
        image = imread(image_name);
        image = imresize(image, resize_area, 'bicubic');
        images(:, :, :, index_image_per_film) = image;
    end    
end