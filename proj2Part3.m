%% proj2Part3.m
%MAT 128b Project 2
%Load MNIST data of handwritten digits
clear; clc; close all;

%% Create neuron
input;
weight;
n = length(input);

for i = 1:n
    NET = NET + input(i)*weight(i);    
end

OUT = (1+(e^(-NET)))^-1;