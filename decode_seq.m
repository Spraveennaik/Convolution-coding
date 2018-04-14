%At the caller function, err_bit=[], index=1, prev_state=[0]

function [err_bit, prev_state, index, error] = decode_seq(code_wd, err_bit, index, prev_state, error)
    %disp(prev_state);
    curr_state = prev_state(length(prev_state));
    next_state = [floor(curr_state/2), floor(curr_state/2)+8];
    curr_code = zeros(2);
    for i = 1:2
        curr_code(i) = 2*(bitxor(bitxor(floor(next_state(i)/8), mod(floor(next_state(i)/4),2)), mod(next_state(i),2)));
        curr_code(i) = curr_code(i) + bitxor(bitxor(floor(next_state(i)/8), mod(floor(next_state(i)/4),2)), mod(floor(next_state(i)/2),2));
    end
    
    if(index > length(code_wd))
        %disp(prev_state);
       return;
    end
    
    if(curr_code(1) == code_wd(index)*2+code_wd(index+1))
        prev_state = [prev_state, next_state(1)];
        index = index + 2;
        [b, c, index1, d] = decode_seq(code_wd, err_bit, index, prev_state, error);
        if(index1>length(code_wd))
            prev_state = c;
            index = index1;
            err_bit = b;
            error = d;
            return;
        end
        err_bit = [err_bit, 2];
        prev_state = [prev_state, next_state(2)];
        error = 1;
        [b, c, index1, d] = decode_seq(code_wd, err_bit, index, prev_state, error);
        if(index1>length(code_wd))
            index = index1;
            prev_state = c;
            err_bit = b;
            return;
        end
  
    elseif(curr_code(2) == code_wd(index)*2+code_wd(index+1))
        prev_state = [prev_state, next_state(2)];
        index = index + 2;
        [b, c, index1, d] = decode_seq(code_wd, err_bit, index, prev_state, error);
        if(index1>length(code_wd))
            index = index1;
            err_bit = b;
            error = d;
            prev_state = c;
            return;
        end
        err_bit = [err_bit, 2];
        prev_state = [prev_state, next_state(1)];
        error = 1;
        [b, c, index1, d] = decode_seq(code_wd, err_bit, index, prev_state, error);
        if(index1>length(code_wd))
            index = index1;
            prev_state = c;
            error = d;
            err_bit = b;
            return;
        end
        
    else
        prev_state = [prev_state, next_state(1)];
        index = index + 2;
        error = 1;
        err_bit = [err_bit, 1];
        if(sum(err_bit) > 5)
            err_bit = [err_bit(1:length(err_bit)-1), []];
            l = length(prev_state);
            prev_state = [prev_state(1:l-1), []];
            index = index - 2;
            return;
        end
        [b, c, index1, d] = decode_seq(code_wd, err_bit, index, prev_state, error);
        if(index1>length(code_wd))
            index = index1;
            err_bit = b;
            error = d;
            prev_state = c;
            return;
        end
        prev_state = [prev_state, next_state(2)];
        index = index + 2;
        error = 1;
        err_bit = [err_bit, 1];
        if(sum(err_bit) > 5)
            err_bit = [err_bit(1:length(err_bit)-1), []];
            l = length(prev_state);
            prev_state = [prev_state(1:l-1), []];
            index = index - 2;
            return;
        end
        [b, c, index1, d] = decode_seq(code_wd, err_bit, index, prev_state, error);
        if(index1>length(code_wd))
            index = index1;
            prev_state = c;
            error = d;
            err_bit = b;
            return;
        end
    end
    err_bit = [err_bit(1:length(err_bit)-1), []];
    l = length(prev_state);
    prev_state = [prev_state(1:l-1), []];
    index = index - 2;
    return;
end