verticies = {}

verticies['A'] = new Vertex('A', 'a', [['C','B']], 1)
verticies['B'] = new Vertex('B', 'b', [['C','K']], 1)
verticies['C'] = new Vertex('C', 'c', [['A','F'],['L']], 2)
verticies['D'] = new Vertex('D', 'd', [['E']], 1)
verticies['E'] = new Vertex('E', 'e', [['F','J','I','H'],['Q']], 1)
verticies['F'] = new Vertex('F', 'f', [['M']], 1)
verticies['G'] = new Vertex('G', 'g', [['E']], 2)
verticies['H'] = new Vertex('H', 'h', [['S','T']], 1)
verticies['I'] = new Vertex('I', 'i', null, 1)
verticies['J'] = new Vertex('J', 'j', [['Q']], 1)
verticies['K'] = new Vertex('K', 'k', [['J']], 1)
verticies['L'] = new Vertex('L', 'l', [['O']], 1)
verticies['M'] = new Vertex('M', 'm', [['O']], 1)
verticies['N'] = new Vertex('N', 'n', [['M']], 1)
verticies['O'] = new Vertex('O', 'o', [['N']], 1)
verticies['P'] = new Vertex('P', 'p', [['K']], 1)
verticies['Q'] = new Vertex('Q', 'q', [['P','R']], 1)
verticies['R'] = new Vertex('R', 'r', [['S']], 1)
verticies['S'] = new Vertex('S', 's', null, 1)
verticies['T'] = new Vertex('T', 't', null, 1)
verticies['U'] = new Vertex('U', 'u', [['V']], 1)
verticies['V'] = new Vertex('V', 'v', [['U']], 1)
