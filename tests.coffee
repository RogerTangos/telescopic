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


# test 'Vertex.setChildReferences references correct graph, and verticies', ->
# 	telescopicText.reset()
# 	vertex_A = new telescopicText.Vertex('A', 'a', [['D'],['B', 'C','nope']], null, 'B', null)
# 	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
# 	vertex_C = new telescopicText.Vertex('C', 'c', null, null, null, null)
# 	vertex_D = new telescopicText.Vertex('D', 'd', null, null, null, null)
# 	vertex_A.setChildrenReferences()

# 	# happy path
# 	equal(vertex_A.children[0][0], vertex_D)
# 	equal(vertex_A.children[1][0], vertex_B)
# 	equal(vertex_A.children[1][1], vertex_C)

# 	# sad path where vertex isn't found
# 	equal(vertex_A.children[1][2], undefined)


# test 'Properly assign children', ->
# 	equal(1,1)

# test 'Vertex Meta Methods', ->
# 	telescopicText.reset()
# 	vertexA = makeDefaultVertexA()


# 	equal(nameVertex3.shouldBeVisible(), false)
# 	equal(nameVertex.findClicksRemaining(), 1)
# 	# findIndexOfChildInChildren


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






	
# test 'vertex.object returnVertexFromKeyOrObject', ->
# 	telescopicText.reset()
# 	vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null)
	
# 	equal(vertex_A.getGraph().returnVertexFromKeyOrObject('A'), vertex_A)
# 	equal(vertex_A.getGraph().returnVertexFromKeyOrObject(vertex_A), vertex_A)


# test 'Vertex.setChildReferences references correct graph, and verticies', ->
# 	telescopicText.reset()
# 	vertex_A = new telescopicText.Vertex('A', 'a', [['D'],['B', 'C','nope']], null, 'B', null)
# 	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
# 	vertex_C = new telescopicText.Vertex('C', 'c', null, null, null, null)
# 	vertex_D = new telescopicText.Vertex('D', 'd', null, null, null, null)
# 	vertex_A.setChildrenReferences()

# 	# happy path
# 	equal(vertex_A.children[0][0], vertex_D)
# 	equal(vertex_A.children[1][0], vertex_B)
# 	equal(vertex_A.children[1][1], vertex_C)

# 	# sad path where vertex isn't found
# 	equal(vertex_A.children[1][2], undefined)

# test 'Graph.graph1.setReferencesForChildrenThroughoutGraph sets all child references', ->
# 	telescopicText.reset()
# 	vertex_A = new telescopicText.Vertex('A', 'a', [['D'],['B']], null, 'B', null)
# 	vertex_B = new telescopicText.Vertex('B', 'b', [['C']], true, null, null)
# 	vertex_C = new telescopicText.Vertex('C', 'c', [['D']], null, null, null)
# 	vertex_D = new telescopicText.Vertex('D', 'd', null, null, null, null)
# 	telescopicText.graphs['telescopicDefaultID'].setReferencesForChildrenThroughoutGraph()

# 	equal(vertex_A.children[0][0], vertex_D)
# 	equal(vertex_A.children[1][0], vertex_B)
# 	equal(vertex_B.children[0][0], vertex_C)
# 	equal(vertex_C.children[0][0], vertex_D)

# test 'telescopicText.Graph link', ->
# 	telescopicText.reset()
# 	vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null)
# 	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
# 	vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null)

# 	telescopicText.Graph.link(vertex_A, vertex_B)
# 	equal(vertex_A.getNext(),vertex_B)
# 	equal(vertex_B.getPrevious(),vertex_A)

# 	telescopicText.Graph.link(vertex_B, vertex_C)
# 	equal(vertex_B.getNext(),vertex_C)
# 	equal(vertex_C.getPrevious(),vertex_B)

# test 'telescopicText.Graph dangerousUnlink', ->
# 	telescopicText.reset()
# 	vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null)
# 	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
# 	vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null)
# 	telescopicText.Graph.link(vertex_A, vertex_B)
# 	telescopicText.Graph.link(vertex_B, vertex_C)

# 	### unlink between nodes ###
# 	telescopicText.Graph.dangerousUnlink(vertex_B)
# 	equal(vertex_B.getNext(), null)
# 	equal(vertex_B.getPrevious(), null)
# 	equal(vertex_A.getNext(), null)
# 	equal(vertex_C.getPrevious(), null)

# 	### unlink end node ###
# 	telescopicText.reset()
# 	vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null)
# 	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
# 	vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null)
# 	telescopicText.Graph.link(vertex_A, vertex_B)
# 	telescopicText.Graph.link(vertex_B, vertex_C)

# 	telescopicText.Graph.dangerousUnlink(vertex_C)
# 	equal(vertex_C.getNext(), null)
# 	equal(vertex_C.getPrevious(), null)
# 	equal(vertex_B.getNext(), null)
# 	equal(vertex_B.getPrevious(), vertex_A)

# 	### unlink start node ###
# 	telescopicText.reset()
# 	vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null)
# 	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
# 	vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null)
# 	telescopicText.Graph.link(vertex_A, vertex_B)
# 	telescopicText.Graph.link(vertex_B, vertex_C)

# 	telescopicText.Graph.dangerousUnlink(vertex_A)
# 	equal(vertex_A.getNext(), null)
# 	equal(vertex_A.getPrevious(), null)
# 	equal(vertex_B.getNext(), vertex_C)
# 	equal(vertex_B.getPrevious(), null)

# test 'telescopicText.Graph safeUnlink', ->
# 	### unlink middle node ###
# 	telescopicText.reset()
# 	vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null)
# 	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
# 	vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null)
# 	telescopicText.Graph.link(vertex_A, vertex_B)
# 	telescopicText.Graph.link(vertex_B, vertex_C)

# 	telescopicText.Graph.safeUnlink(vertex_B)
# 	equal(vertex_B.getNext(), null)
# 	equal(vertex_B.getPrevious(), null)
# 	equal(vertex_A.getNext(),vertex_C)
# 	equal(vertex_C.getPrevious(),vertex_A)

# 	### unlink end node ###
# 	telescopicText.reset()
# 	vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null)
# 	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
# 	vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null)
# 	telescopicText.Graph.link(vertex_A, vertex_B)
# 	telescopicText.Graph.link(vertex_B, vertex_C)

# 	telescopicText.Graph.safeUnlink(vertex_C)
# 	equal(vertex_C.getNext(), null)
# 	equal(vertex_C.getPrevious(), null)
# 	equal(vertex_B.getNext(), null)
# 	equal(vertex_B.getPrevious(), vertex_A)

# 	### unlink start node ###
# 	telescopicText.reset()
# 	vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null)
# 	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
# 	vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null)
# 	telescopicText.Graph.link(vertex_A, vertex_B)
# 	telescopicText.Graph.link(vertex_B, vertex_C)

# 	telescopicText.Graph.safeUnlink(vertex_A)
# 	equal(vertex_A.getNext(), null)
# 	equal(vertex_A.getPrevious(), null)
# 	equal(vertex_B.getNext(), vertex_C)
# 	equal(vertex_B.getPrevious(), null)


# test 'telescopicText.Graph makeLinkedList', ->
# 	# happy path (one starting node supplied)
# 	telescopicText.reset()
# 	vertex_A = new telescopicText.Vertex('A', 'a', null, null, 'B', null)
# 	vertex_B = new telescopicText.Vertex('B', 'b', null, true, 'C', null)
# 	vertex_C = new telescopicText.Vertex('C', 'c', null, null, null, null)
# 	telescopicText.graphs['telescopicDefaultID'].makeLinkedList(vertex_A)

# 	equal(vertex_A.getNext(),vertex_B)
# 	equal(vertex_B.getNext(),vertex_C)
# 	equal(vertex_C.getNext(),null)
# 	equal(vertex_A.getPrevious(),null)
# 	equal(vertex_B.getPrevious(),vertex_A)
# 	equal(vertex_C.getPrevious(),vertex_B)


# 	# Sad path - infinite unary loop
# 	telescopicText.reset()
# 	vertex_A = new telescopicText.Vertex('A', 'a', null, null, 'A', null)
# 	telescopicText.graphs['telescopicDefaultID'].makeLinkedList(vertex_A)
# 	equal(vertex_A.getNext(),null)
# 	equal(vertex_A.getPrevious(), null)

# 	# Sad path - infinite long loop
# 	telescopicText.reset()
# 	vertex_A = new telescopicText.Vertex('A', 'a', null, null, 'B', null)
# 	vertex_B = new telescopicText.Vertex('B', 'b', null, true, 'C', null)
# 	vertex_C = new telescopicText.Vertex('C', 'c', null, null, 'A', null)
	
# 	telescopicText.graphs['telescopicDefaultID'].makeLinkedList(vertex_A)
# 	equal(vertex_C.getNext(),null)
# 	equal(vertex_A.getNext(),vertex_B)

# # test 'create a tree edge', ->



# attempting to make a stub:
# Had trouble assigning a prototype method to an object.
# create a fake vertex to test
# fake_vertex = {'name':'E', 'children':[['F'],['G','H']]}
# fake_vertex.setChildrenReferences = telescopicText.Vertex.setChildrenReferences
# telescopicText.graphs['telescopicDefaultID']['E']='eep'
# telescopicText.graphs['telescopicDefaultID']['F']='fff'
# telescopicText.graphs['telescopicDefaultID']['G']='gah'
# telescopicText.graphs['telescopicDefaultID']['G']='huh'

# fake_vertex.setChildrenReferences()
# equal(fake_vertex.children[0][0], 'fff')
# equal(fake_vertex.children[1][0], 'gah')
# equal(fake_vertex.children[1][1], 'huh')
