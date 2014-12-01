function [ data ] = input_file( filepath )
    
    a = fopen(filepath, 'r');
    data = [];
    while(~feof(a))
        b = fgetl(a);
        c = strsplit(b, '\t');
        data = [data; c];
    end
    fclose(a);
end

