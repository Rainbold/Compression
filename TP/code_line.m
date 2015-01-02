function [ line_out ] = code_line ( line_in, white, black )
    s = 0; % variable pour changer du blanc au noir et vis versa
    line_out = '';
    for i=1:length(line_in)
        v = line_in(i);
        if(v >= 64)
            code = fix(v/64)*64;
            rest = v - code;
            if(s == 0)
                [~, id1] = ismember(int2str(code), white);
                [~, id2] = ismember(int2str(rest), white);
                line_out = strcat(line_out, white{id1, 2}, white{id2, 2});
                s = 1;
            else
                [~, id1] = ismember(int2str(code), black);
                [~, id2] = ismember(int2str(rest), black);
                line_out = strcat(line_out, black{id1, 2}, black{id2, 2});
                s = 0;
            end
        else % < 64
            if(s == 0)
                [~, id1] = ismember(int2str(v), white);
                line_out = strcat(line_out, white{id1, 2});
                s = 1;
            else
                [~, id1] = ismember(int2str(v), black);
                line_out = strcat(line_out, black{id1, 2});
                s = 0;
            end
        end
    end
    % Ajout de EOL
    line_out = strcat(line_out, '000000000001');
    
    % Padding
    l = length(line_out);
    nb_padding = fix(l/8 + 1)*8 - l;
    padding = strrep(int2str(zeros(1, nb_padding)), ' ', '');
    line_out = strcat(line_out,  padding);
    
end