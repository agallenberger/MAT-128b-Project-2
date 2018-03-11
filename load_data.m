%% load_data.m
%MAT 128b Project 2 - Part 1 & 2
%Load MNIST data & Plot it
clear; clc; close all;
load mnistdata;

%% Select digit
digit = 5;
train = 1; %if 0, will use test digit instead

%% Visualize a selected train/test digit
TestTrainDigit = getMNIST(digit, train);
    
%Plot the desired digit
f1 = figure; 
for i = 1:3
   digitImage = reshape(TestTrainDigit(i,:), 28, 28);
   subplot(1,3,i); 
   image(rot90(flipud(digitImage), -1));
   colormap(gray(256)); 
   axis square tight off; 
end 

%% Plot the average train digits   
digitImage_mean = zeros(28,28,10);
for i = 1:10 
    digitImage_mean(:,:,i) = reshape(getTARGET(i-1),28,28);
end 

f2 = figure; 
for i = 1:10 
    subplot(2,5,i) 
    image(rot90(flipud(digitImage_mean(:,:,i)),-1)); 
    colormap(gray(256)); 
    axis square tight off; 
end