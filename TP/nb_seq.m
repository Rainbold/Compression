function [ ligne_out ] = nb_seq( ligne_in )
    ligne_out = diff([ 0 find(diff(ligne_in)) length(ligne_in)]);
    if(ligne_in(1) == 0)
        ligne_out = [0 ligne_out];
    end
end




