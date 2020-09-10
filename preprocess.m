clear all; clc;

num_film = 2;
ourdatabase_RGB = cell(1,2);
resize_area = [112, 112];

films = cell(1, num_film);
for index_film = 1:num_film
    film_folder = ['./films/film_',num2str(index_film),'/'];
    images_per_film = dir([film_folder,'*.jpg']);
    images = zeros(112, 112, 3, length(images_per_film));
    for index_image_per_film = 1:length(images_per_film)
        image_name = [film_folder, images_per_film(index_image_per_film).name];
        image = imread(image_name);
        image = imresize(image, resize_area, 'bicubic');
        images(:, :, :, index_image_per_film) = image;
    end
    films{index_film} = images;
end

ourdatabase_RGB = films;

save ourdatabase_RGB_112_by_112 ourdatabase_RGB
