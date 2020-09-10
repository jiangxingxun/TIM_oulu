%% parameter
resize_area = [resize_size, resize_size]

part_name    = dir('../hmdb51_allframe/');
folder_input = ['../hmdb51_allframe/',part_name(index_part+2).name];   % +2: 排除之前的. 和 .. 目录
folder_output = ['./TIM_',num2str(resize_area(1)),'by',num2str(resize_area(2)),'/',part_name(index_part+2).name,'/'];

INFO_DIR = dir(folder_input);
size_INFO_DIR = get_size_INFO_DIR(INFO_DIR);

indexs_film_tobeclear = [];
for index_film = 1:size_INFO_DIR
	if strcmp(INFO_DIR(index_film).name, '.') || strcmp(INFO_DIR(index_film).name,'..')  % 排除之前的. 和 .. 目录
		indexs_film_tobeclear = [indexs_film_tobeclear, index_film];
	end
end
INFO_DIR(indexs_film_tobeclear) = [];

%% main process
num_film = size_INFO_DIR - 2;
for index_film =1:num_film
    film_folder = [folder_input,'/',INFO_DIR(index_film).name,'/'];
    images_per_film = dir([film_folder,'*.jpg']);
    films_name = INFO_DIR(index_film).name;
    images = get_images_per_film(images_per_film, film_folder, resize_area);
    TIM_images = get_TIM_data_per_film(images, interp_frames);
    disp(index_film);
    output_TIM_images(TIM_images, folder_output, films_name);
end

