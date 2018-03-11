%% getMNISTdata.m
%MAT 128b Project 2
%function to retrieve MNIST data

function data = getMNISTdata(digit, train)

    load mnistdata;
    if digit == 0
        if train == 1
            data = train0;
        else
            data = test0;
        end
    elseif digit == 1
        if train == 1
            data = train1;
        else
            data = test1;
        end
    elseif digit == 2
        if train == 1
            data = train2;
        else
            data = test2;
        end
     elseif digit == 3
        if train == 1
            data = train3;
        else
            data = test3;
        end
    elseif digit == 4
        if train == 1
            data = train4;
        else
            data = test4;
        end
    elseif digit == 5
        if train == 1
            data = train5;
        else
            data = test5;
        end
    elseif digit == 6
        if train == 1
            data = train6;
        else
            data = test6;
        end
    elseif digit == 7
        if train == 1
            data = train7;
        else
            data = test7;
        end
    elseif digit == 8
        if train == 1
            data = train8;
        else
            data = test8;
        end    
    elseif digit == 9
        if train == 1
            data = train9;
        else
            data = test9;
        end
    else
        disp('getMNISTdata.m Error: digit not found, returned 0');
        data = 0;
    end

end