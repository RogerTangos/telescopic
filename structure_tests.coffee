test 'find clicks remaining on unclickable link', ->
	telescopicText.reset()
	name_vertex = new telescopicText.Vertex('myName', 'myContent', null, null, null, null, null)

	equal(name_vertex.click_count, undefined)
	equal(name_vertex.findClicksRemaining(), 0)

test 'forward click a node, vertex_A. Test vertex_A visibility and clicks remaining', ->
	telescopicText.reset()
	graph1 = makeTestVerticies()
	vertex_A = graph1.getNode('A')
	equal(vertex_A.findClicksRemaining(), 1)
	
	vertex_A.forwardClick()
	equal(vertex_A.findClicksRemaining(), 0)
	equal(vertex_A.shouldBeVisible(), false)

test 'make sure hidden nodes give correct visibility.', ->
	telescopicText.reset()
	graph1 = makeTestVerticies()
	vertex_C = graph1.getNode('C')
	vertex_K = graph1.getNode('K')

	equal(vertex_C.shouldBeVisible(), false)
	equal(vertex_K.shouldBeVisible(), false)


test 'determine and record incoming tree, cross, and back edges', ->
	telescopicText.reset()
	graph1 = makeTestVerticies()
	vertex_A = graph1.getNode('A')
	vertex_B = graph1.getNode('B')
	vertex_C = graph1.getNode('C')

	### tree edges ###
	vertex_B.determineAndSetIncomingEdge(vertex_A)
	equal(vertex_B.incoming_tree, vertex_A)
	equal(vertex_B.incoming_forward, false)
	equal(vertex_B.incoming_back, false)
	equal(vertex_B.incoming_cross, false)

	vertex_C.determineAndSetIncomingEdge(vertex_A)	
	equal(vertex_C.incoming_tree, vertex_A)
	equal(vertex_C.incoming_forward, false)
	equal(vertex_C.incoming_back, false)
	equal(vertex_C.incoming_cross, false)

	### cross edge ###
	vertex_C.determineAndSetIncomingEdge(vertex_B)
	equal(vertex_C.incoming_tree, vertex_A)
	equal(vertex_C.incoming_cross[0], vertex_B)
	equal(vertex_C.incoming_back[0], undefined)
	equal(vertex_C.incoming_forward[0], undefined)

	### back edge ###
	vertex_A.determineAndSetIncomingEdge(vertex_C)
	equal(vertex_A.incoming_back[0],vertex_C)
	equal(vertex_A.incoming_tree[0], undefined)
	equal(vertex_A.incoming_forward[0], undefined)
	equal(vertex_A.incoming_tree, false)

test 'determine and record forward edges', ->
	telescopicText.reset()
	graph1 = makeTestVerticies()
	vertex_D = graph1.getNode('D')
	vertex_E = graph1.getNode('E')
	vertex_J = graph1.getNode('J')
	vertex_Q = graph1.getNode('Q')

	vertex_Q.incoming_tree = vertex_J
	vertex_J.incoming_tree = vertex_E
	vertex_E.incoming_tree = vertex_D

	vertex_Q.determineAndSetIncomingEdge(vertex_E)
	equal(vertex_Q.incoming_tree, vertex_J)
	equal(vertex_Q.incoming_back.length, 0)
	equal(vertex_Q.incoming_cross.length, 0)
	equal(vertex_Q.incoming_forward[0], vertex_E)

test 'forward click a nodes A, B, C. test edge matching.', ->
	telescopicText.reset()
	graph1 = makeTestVerticies()
	vertex_A = graph1.getNode('A')
	vertex_B = graph1.getNode('B')
	vertex_C = graph1.getNode('C')
	vertex_K = graph1.getNode('K')
	vertex_F = graph1.getNode('F')

	vertex_A.forwardClick()
	equal(vertex_B.incoming_tree, vertex_A)
	equal(vertex_C.incoming_tree, vertex_A)

	vertex_B.forwardClick()
	equal(vertex_C.incoming_cross[0], vertex_B)
	equal(vertex_K.incoming_tree, vertex_B)

	vertex_C.forwardClick()
	equal(vertex_A.incoming_back[0], vertex_C)
	equal(vertex_F.incoming_tree, vertex_C)


test 'forward click notes D, E, J, Q. test edge matching.', ->
	telescopicText.reset()
	graph1 = makeTestVerticies()
	vertex_D = graph1.getNode('D')
	vertex_E = graph1.getNode('E')
	vertex_J = graph1.getNode('J')
	vertex_Q = graph1.getNode('Q')

	vertex_D.forwardClick()
	equal(vertex_E.incoming_tree, vertex_D)

	vertex_E.forwardClick()
	equal(vertex_J.incoming_tree, vertex_E)

	vertex_J.forwardClick()
	equal(vertex_Q.incoming_tree, vertex_J)

	vertex_E.forwardClick()
	equal(vertex_Q.incoming_forward[0], vertex_E)

# 	equal(vertex_A.shouldBeVisible(), false)

# 	equal(vertex_B.incoming_tree, vertex_A)
# 	equal(vertex_B.findClicksRemaining, 1)
# 	equal(vertex_B.shouldBeVisible(), true)

# 	equal(vertex_C.incoming_tree, vertex_A)
# 	equal(vertex_C.findClicksRemaining, 2)
# 	equal(vertex_C.shouldBeVisible(), true)

