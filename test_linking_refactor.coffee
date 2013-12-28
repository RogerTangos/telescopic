test 'vertex sets child references on command', ->
	telescopicText.reset()
	makeTestVerticies()
	vertexA.setChildrenReferences()

	# happy path. vertices found.
	equal(vertexA.getChildren()[0][0], vertexC)
	equal(vertexA.getChildren()[0][1], vertexB)

	# sad path where vertex isn't found
	equal(vertexA.getChildren()[1], undefined)

	# sad path where a specified child doesn't exist
	badVertexBMod = telescopicText.vertex({
		_name: 'B', 
		content: 'b', 
		_children: [['C','noSuchKey', 'K']], 
		_remainAfterClick: false,
		_next: 'D', 
		_graph: 'graph1',
		_starter: false
		})
	badVertexBMod.setChildrenReferences()
	equal(badVertexBMod.getChildren()[0][1], vertexK)

test 'Graph.graph1.setReferencesForChildrenThroughoutGraph sets all child references', ->
	telescopicText.reset()
	makeTestVerticies().setReferencesForChildrenThroughoutGraph()
	equal(1,1)
	equal(vertexA.getChildren()[0][0], vertexC)
	equal(vertexA.getChildren()[0][1], vertexB)
	equal(vertexB.getChildren()[0][0], vertexC)
	equal(vertexB.getChildren()[0][1], vertexK)
	equal(vertexC.getChildren()[0][0], vertexA)
	equal(vertexC.getChildren()[0][1], vertexF)
	equal(vertexC.getChildren()[1][0], vertexL)

test 'telescopicText.Graph link', ->
	telescopicText.reset()
	graph1 = makeTestVerticies()

	telescopicText.graph.link(vertexA, vertexB)
	equal(vertexA.getNext(),vertexB)
	equal(vertexB.getPrevious(),vertexA)

	telescopicText.graph.link(vertexB, vertexC)
	equal(vertexB.getNext(), vertexC)
	equal(vertexC.getPrevious(),vertexB)


test 'telescopicText.graph dangerousUnlink', ->
	telescopicText.reset()
	graph1 = makeTestVerticies()
	telescopicText.graph.link(vertexA, vertexB)
	telescopicText.graph.link(vertexB, vertexC)

	### unlink between nodes ###
	telescopicText.graph.dangerousUnlink(vertexB)
	equal(vertexB.getNext(), null)
	equal(vertexB.getPrevious(), null)
	equal(vertexA.getNext(), null)
	equal(vertexC.getPrevious(), null)

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