test 'graphs generate on reset', ->
	telescopicText.reset()
	ok(telescopicText.graphs['telescopicDefaultID'])

test 'Verticies public spec attributes inc. edges are visible', ->
	# testing name and default attributes
	telescopicText.reset()
	nameVertex = makeDefaultVertex1()
	equal(nameVertex.content, 'myContent')
	equal(nameVertex.incomingTree[0], false)
	equal(nameVertex.incomingForward[0], undefined)
	equal(nameVertex.incomingBack[0], undefined)
	equal(nameVertex.incomingCross[0], undefined)


test 'Verticies private spec attributes have getters and setters', ->
	telescopicText.reset()
	nameVertex = makeDefaultVertex1()
	equal(nameVertex.getName(), 'myName')
	equal(nameVertex.getRemainAfterClick(), true)
	equal(nameVertex.getNext(), true)
	nameVertex.setNext(false)
	equal(nameVertex.getNext(), false)
	equal(nameVertex.getStarter(), true)
	ok(nameVertex.getChildren() instanceof Array)

test 'Vertex attributes default correctly.', ->
	telescopicText.reset()
	nameVertex = makeDefaultVertex2()
	ok(nameVertex.getChildren() instanceof Array)
	equal(nameVertex.getChildren()[0], undefined)
	equal(nameVertex.getRemainAfterClick(), false)
	equal(nameVertex.getGraph(), telescopicText.graphs['telescopicDefaultID'])
	equal(nameVertex.getStarter(), false)

test 'graph can get nodes from key or object', ->
	telescopicText.reset()
	makeTestVerticies()
		
	equal(vertexA.getGraph().getNode('A'), vertexA)
	equal(vertexA.getGraph().getNode(vertexA), vertexA)

test 'graph default characteristics', ->
	newGraph = telescopicText.graph()
	equal(newGraph.getName(), 'telescopicDefaultID')
	equal(newGraph.getNode('foo'), undefined)

test 'findEdgeType returns the type of edge a node\'s parent represents', ->
	telescopicText.reset()
	makeTestVerticies()
	vertexC.incomingTree = [vertexA]
	vertexC.incomingCross = [vertexF, vertexB]
	vertexC.incomingForward = [vertexE]
	vertexC.incomingBack = [vertexM]

	ok(vertexC.findEdgeType(vertexA) == "tree", "tree edge identified")
	ok(vertexC.findEdgeType(vertexB) == "cross", "cross edge identified")
	ok(vertexC.findEdgeType(vertexE) == "forward", "forward edge identified")
	ok(vertexC.findEdgeType(vertexM) == "back", "back edge identified")

test 'filterChildrenForTree returns a shortened array when using a tree schema', ->
	telescopicText.reset()
	makeTestVerticies()

	vertexJ.incomingTree = [vertexE]
	vertexI.incomingTree = [vertexE]
	vertexH.incomingTree = [vertexE]
	
	vertexF.incomingTree = [vertexC]
	vertexF.incomingCross = [vertexE]

	childArray = [vertexF, vertexJ, vertexI, vertexH]

	ok(vertexE.filterChildrenForTree(childArray) instanceof Array, "returns an array")
	equal(vertexE.filterChildrenForTree(childArray).indexOf(vertexF), -1, "vertexF does not have a tree edge")

test 'getChildren returns array based on index or child given, with default graph schema', ->
	telescopicText.reset()
	makeTestVerticies()
	ok(vertexC.getChildren(1) instanceof Array, "returns an array when passed an index")
	ok(vertexC.getChildren(1)[0] == "L", "array contains correct letter when passed an index")

	ok(vertexC.getChildren(vertexL) instanceof Array, "returns an array when passed a node object")
	ok(vertexC.getChildren(vertexL)[0] == "L", "array is correct letter when passed a node object")


test 'getChildren returns array based on index or child given, with tree schema', ->
	telescopicText.reset()
	makeTestVerticies()
	vertexJ.incomingTree = [vertexE]
	vertexI.incomingTree = [vertexE]
	vertexH.incomingTree = [vertexE]
	
	vertexF.incomingTree = [vertexC]
	vertexF.incomingCross = [vertexE]

	ok(vertexE.getChildren(vertexJ, "tree") instanceof Array)
	ok(vertexE.getChildren(vertexJ, "tree").length == 3)
	ok(vertexE.getChildren(vertexJ, "tree").indexOf(vertexF) == -1)
	ok(vertexE.getChildren(vertexJ, "tree").indexOf("F") == -1)

test 'getSiblings returns siblings from a tree or graph', ->
	telescopicText.reset()
	makeTestVerticies()

	vertexJ.incomingTree = [vertexE]
	vertexI.incomingTree = [vertexE]
	vertexH.incomingTree = [vertexE]
	
	vertexF.incomingTree = [vertexC]
	vertexF.incomingCross = [vertexE]

	# equal(vertexF.getSiblings("tree").length == 3, "F", "vertexF has F A Z as tree siblings")
	# equal(vertexF.getSiblings("tree").length == 3, "F", "the default behavior is to search for tree siblings")

	# ok(vertexF.getSiblings("cross").length == 4, "vertexF should have A F Z as siblings")
	# ok(vertexF.getSiblings().length == 4)


	ok(vertexJ.getSiblings("tree").length == 3)
	ok(vertexJ.getSiblings("tree")[1] == vertexJ.getSiblings()[1], "default behavior is to search for tree crossings")
	ok(vertexJ.getSiblings("tree").indexOf(vertexF) < 0)
	ok(vertexJ.getSiblings("tree").indexOf(vertexF) < 0)
	ok(vertexJ.getSiblings("tree").indexOf(vertexH) > -1, "VertexH should appear, because it is a tree crossing")

	ok(vertexF.getSiblings("cross").length == 4, "cross siblings are children from a parent tree")
	ok(vertexF.getSiblings("cross").indexOf(vertexA) < 0, "vertexA is a tree sibling, not a cross sibling")
	ok(vertexF.getSiblings("cross").indexOf(vertexA) < 0, "vertexA is a tree sibling, not a cross sibling")
	ok(vertexF.getSiblings("cross").indexOf(vertexF) > -1, "vertexF should appear")
	ok(vertexF.getSiblings("cross").indexOf(vertexJ) > -1, "vertexJ should appear")

	ok(vertexF.getSiblings("cross", false).indexOf(vertexF) < 0, "vertexF should not appear is we request the original vertex not to be included")

makeDefaultVertex1 = ->
	nameVertexSpec = {
		_name: 'myName',
		content: 'myContent',
		_children: [],
		_remainAfterClick: true,
		_next: true, 
		_graph: 'defaultID2',
		_starter: true}
	telescopicText.vertex(nameVertexSpec)

makeDefaultVertex2 = ->
	nameVertexSpec = {
		_name: 'myName',
		content: 'myContent',
		# _children: []
		# _remainAfterClick: true,
		_next: true
		# _graph: 'defaultID2',
		# _starter: true
	}
	return telescopicText.vertex(nameVertexSpec)

makeDefaultVertex3 = ->
	nameVertexSpec = {
		_name: 'myName',
		content: 'myContent',
		_children: [[a, b, c], [d, e]],
		_remainAfterClick: true,
		_next: true, 
		_graph: 'defaultID2',
		_starter: true}
	telescopicText.vertex(nameVertexSpec)
