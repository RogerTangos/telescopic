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



