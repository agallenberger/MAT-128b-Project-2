%% neural_net2.m
%MAT 128b Project 2 - Part 4, 5, 6, 7...
%Create neural net
clear; clc; close all;
load mnistdata;

%% Initialize neural net parameters
digit = 5;
train = 1; %if 0, will use test digit instead
layers = 100; %number of hidden layers
trainingRate = .05; %within the interval [0.1, 0.01]

%% Load INPUT and TARGET data
T(1,:) = mean(train0); 
T(2,:) = mean(train1); 
T(3,:) = mean(train2); 
T(4,:) = mean(train3); 
T(5,:) = mean(train4); 
T(6,:) = mean(train5); 
T(7,:) = mean(train6); 
T(8,:) = mean(train7); 
T(9,:) = mean(train8); 
T(10,:) = mean(train9);
input = double(logical(getMNISTdata(digit,train)));
n = length(input(1,:));

%% Initialize OUT and NET functions
F = @(NET) 1./(1+exp(-NET));
NET = @(input, weight) sum(input.*weight);


