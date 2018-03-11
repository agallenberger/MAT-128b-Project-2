%% getTARGET.m
%MAT 128b Project 2
%function to retrieve TARGET data

function TARGET = getTARGET(digit)

    load mnistdata;
    if digit == 0
        TARGET = mean(train0);
    elseif digit == 1
        TARGET = mean(train1);
    elseif digit == 2
        TARGET = mean(train2);
     elseif digit == 3
        TARGET = mean(train3);
    elseif digit == 4
        TARGET = mean(train4);
    elseif digit == 5
        TARGET = mean(train5);
    elseif digit == 6
        TARGET = mean(train6);
    elseif digit == 7
        TARGET = mean(train7);
    elseif digit == 8
        TARGET = mean(train8);    
    elseif digit == 9
        TARGET = mean(train9);
    else
        disp('getTARGET.m Error: digit not found, returned 0');
        TARGET = 0;
    end
    
end