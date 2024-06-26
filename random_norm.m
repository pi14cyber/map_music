function [outputArg1] = random_norm(inputArg1, coef_ceil, coef)
%RANDOM_NORM Summary of this function goes here
%   Detailed explanation goes here
randomizer = (inputArg1*coef_ceil-ceil(inputArg1*coef_ceil))*coef;
outputArg1 = normalize(randomizer,"range");
end

