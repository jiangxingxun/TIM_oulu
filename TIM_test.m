clear all; clc;
load ourdatabase_RGB_112_by_112;

data_rgb = ourdatabase_RGB;

for i = 1:length(data_rgb)
    i
    im = double(data_rgb{i});
    [h, w, c, f] = size(im);
    imv = reshape(im, h * w * c, f);
    m = tim_getAniModel(imv);
    Z = tim_genAnimationData(m,0,1,16);
    TIM_data = reshape(Z, h, w, c, 16);
    TIM16_ourdatabase_RGB{i} = TIM_data;
end

save TIM16_ourdatabae_RGB_112by112 TIM16_ourdatabase_RGB









