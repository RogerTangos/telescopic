makeTestVerticies = ->
	window.vertexA = telescopicText.vertex(
		_name: 'A',
		content: 'a',
		_children: [['C', 'B']],
		_next: 'B',
		_remainAfterClick: false,
		_graph: 'graph1',
		_starter: true);
	window.vertexB = telescopicText.vertex({
		_name: 'B', 
		content: 'b', 
		_children: [['C','K']], 
		_remainAfterClick: false,
		_next: 'D', 
		_graph: 'graph1',
		_starter: false
		})
	window.vertexC = telescopicText.vertex({
		_name: 'C',
		content:'c',
		_children: [['A','F'],['L']],
		_remainAfterClick: true,
		_next: 'E',
		_graph: 'graph1'})
	window.vertexD = telescopicText.vertex({
		_name: 'D',
		content:'d',
		_children: [['E']],
		_remainAfterClick: false,
		_next: 'G',
		_graph: 'graph1',
		_starter: true})
	window.vertexE = telescopicText.vertex({
		_name: 'E',
		content:'e',
		_children: [['F','J','I','H'],['Q']],
		_remainAfterClick: false,
		_next: 'H',
		_graph: 'graph1'})
	window.vertexF = telescopicText.vertex({
		_name: 'F',
		content:'f',
		_children: [['M']],
		_remainAfterClick: false,
		_next: 'I',
		_graph: 'graph1'})
	window.vertexG = telescopicText.vertex({
		_name: 'G',
		content:'g',
		_children: [['E']],
		_remainAfterClick: true,
		_next: 'C',
		_graph: 'graph1',
		_starter: true})
	window.vertexH = telescopicText.vertex({
		_name: 'H',
		content:'h',
		_children: [['S','T']],
		_remainAfterClick: false,
		_next: 'F',
		_graph: 'graph1'})
	window.vertexI = telescopicText.vertex({
		_name: 'I',
		content:'i',
		_children: null,
		_remainAfterClick: false,
		_next: 'V',
		_graph: 'graph1'})
	window.vertexJ = telescopicText.vertex({
		_name: 'J',
		content:'j',
		_children: [['Q']],
		_remainAfterClick: false,
		_next: 'U',
		_graph: 'graph1'})
	window.vertexK = telescopicText.vertex({
		_name: 'K',
		content:'k',
		_children: [['J']],
		_remainAfterClick: false,
		_next: 'L',
		_graph: 'graph1'})
	window.vertexL = telescopicText.vertex({
		_name: 'L',
		content:'l',
		_children: [['O']],
		_remainAfterClick: false,
		_next: 'M',
		_graph: 'graph1'})
	window.vertexM = telescopicText.vertex({
		_name: 'M',
		content:'m',
		_children: [['O']],
		_remainAfterClick: false,
		_next: 'N',
		_graph: 'graph1'})
	window.vertexN = telescopicText.vertex({
		_name: 'N',
		content:'n',
		_children: [['M']],
		_remainAfterClick: false,
		_next: 'O',
		_graph: 'graph1'})
	window.vertexO = telescopicText.vertex({
		_name: 'O',
		content:'o',
		_children: [['N']],
		_remainAfterClick: false,
		_next: 'P',
		_graph: 'graph1'})
	window.vertexP = telescopicText.vertex({
		_name: 'P',
		content:'p',
		_children: [['K']],
		_remainAfterClick: false,
		_next: 'Q',
		_graph: 'graph1'})
	window.vertexQ = telescopicText.vertex({
		_name: 'Q',
		content:'q',
		_children: [['P','R']],
		_remainAfterClick: false,
		_next: 'R',
		_graph: 'graph1'})
	window.vertexR = telescopicText.vertex({
		_name: 'R',
		content:'r',
		_children: [['S']],
		_remainAfterClick: false,
		_next: 'S',
		_graph: 'graph1'})
	window.vertexS = telescopicText.vertex({
		_name: 'S',
		content:'s',
		_children: null, 
		_remainAfterClick: false,
		_next: 'T',
		_graph: 'graph1'})
	window.vertexT = telescopicText.vertex({
		_name: 'T',
		content:'t',
		_children: null,
		_remainAfterClick: false,
		_next: null, 
		_graph: 'graph1'})
	window.vertexU = telescopicText.vertex({
		_name: 'U',
		content:'u',
		_children: [['V']],
		_remainAfterClick: false,
		_next: 'K',
		_graph: 'graph1'})
	window.vertexV = telescopicText.vertex({
		_name: 'V',
		content:'v',
		_children: [['U']],
		_remainAfterClick: false,
		_next: 'J',
		_graph: 'graph1',
		_starter: true})

	# graph1.makeLinkedList('A')
	# graph1.setReferencesForChildrenThroughoutGraph()
	graph1 = telescopicText.graphs['graph1']
	graph1


