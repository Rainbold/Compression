function [ R ] = decode_doc( data_in, white_tree, black_tree )
	type = class(data_in);
	if strcmp(type, 'char')
		data = data_in - '0';
	else
		data = data_in;
	end

	indice = 1;
	mem = 0;
	L = [];
	R = {};
	s = 1;
	c = 1;
	eol = 0;
	l = length(data);
	i = 1;
	while(i <= l)
		indice = indice * 2 + 1 * data(i);
		if(s == 1 && white_tree(indice) > -1) % Blanc
			if(white_tree(indice) >= 64)
				if(white_tree(indice) == 8193) % EOL
					R{c, 1} = L;
					c = c+1;
					mem = 0;
					indice = 1;
					L = [];
					if eol == 0
						i = fix(i/8 + 1)*8;
					end
					eol = 1;
				else % not EOL
					mem = white_tree(indice);
					indice = 1;
				end
			else % < 64
				L = [L (white_tree(indice)+mem)];
				s = 0;
				mem = 0;
				indice = 1;
				eol = 0;
			end
		elseif(s == 0 && black_tree(indice) > -1) % Noir
			if(black_tree(indice) >= 64)
				if(black_tree(indice) == 8193) % EOL
					R{c, 1} = L;
					c = c+1;
					s = 1;
					mem = 0;
					indice = 1;
					L = [];
					if eol == 0
						i = fix(i/8 + 1)*8;
					end
					eol = 1;
				else % not EOL
					mem = black_tree(indice);
					indice = 1;
				end
			else % < 64
				L = [L (black_tree(indice)+mem)];
				s = 1;
				mem = 0;
				indice = 1;
				eol = 0;
			end
		end
		i = i+1;
	end
end