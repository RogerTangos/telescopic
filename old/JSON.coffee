makeTestVerticies = ->
	new telescopicText.Vertex('A', 'a', [['C', 'B']], false, 'B', 'graph1', true);
	new telescopicText.Vertex('B', 'b', [['C','K']], false, 'D', 'graph1')
	new telescopicText.Vertex('C', 'c', [['A','F'],['L']], true, 'E', 'graph1')
	new telescopicText.Vertex('D', 'd', [['E']], false, 'G', 'graph1', true)
	new telescopicText.Vertex('E', 'e', [['F','J','I','H'],['Q']], false, 'H', 'graph1')
	new telescopicText.Vertex('F', 'f', [['M']], false, 'I', 'graph1')
	new telescopicText.Vertex('G', 'g', [['E']], true, 'C', 'graph1', true)
	new telescopicText.Vertex('H', 'h', [['S','T']], false, 'F', 'graph1')
	new telescopicText.Vertex('I', 'i', null, false, 'V', 'graph1')
	new telescopicText.Vertex('J', 'j', [['Q']], false, 'U', 'graph1')
	new telescopicText.Vertex('K', 'k', [['J']], false, 'L', 'graph1')
	new telescopicText.Vertex('L', 'l', [['O']], false, 'M', 'graph1')
	new telescopicText.Vertex('M', 'm', [['O']], false, 'N', 'graph1')
	new telescopicText.Vertex('N', 'n', [['M']], false, 'O', 'graph1')
	new telescopicText.Vertex('O', 'o', [['N']], false, 'P', 'graph1')
	new telescopicText.Vertex('P', 'p', [['K']], false, 'Q', 'graph1')
	new telescopicText.Vertex('Q', 'q', [['P','R']], false, 'R', 'graph1')
	new telescopicText.Vertex('R', 'r', [['S']], false, 'S', 'graph1')
	new telescopicText.Vertex('S', 's', null, false, 'T', 'graph1')
	new telescopicText.Vertex('T', 't', null, false, null, 'graph1')
	new telescopicText.Vertex('U', 'u', [['V']], false, 'K', 'graph1')
	new telescopicText.Vertex('V', 'v', [['U']], false, 'J', 'graph1', true)

	graph1 = telescopicText.graphs['graph1']
	graph1.makeLinkedList('A')
	graph1.setReferencesForChildrenThroughoutGraph()
	graph1


