%% getWeight.m
%MAT 128b Project 2
%function to retrieve WEIGHT data

function W = getWeight(digit)
    
    if digit == 0
        load W_0;
    elseif digit == 1
        load W_1;
    elseif digit == 2
        load W_2;
     elseif digit == 3
        load W_3;
    elseif digit == 4
        load W_4;
    elseif digit == 5
        load W_5;
    elseif digit == 6
        load W_6;
    elseif digit == 7
        load W_7;
    elseif digit == 8
        load W_8;
    elseif digit == 9
        load W_9;
    else
        disp('getTARGET.m Error: more than one digit passed, returned 0');
        W = 0;
    end





end