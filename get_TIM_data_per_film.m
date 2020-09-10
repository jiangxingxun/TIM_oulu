function [TIM_data] = get_TIM_data_per_film(images, interp_frames)
    images = double(images);
    [h, w, c, f] = size(images);
    imv = reshape(images, h * w * c, f);
    m = tim_getAniModel(imv);
    Z = tim_genAnimationData(m,0,1,interp_frames);
    TIM_data = reshape(Z, h, w, c, interp_frames); 
end