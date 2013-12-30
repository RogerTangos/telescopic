test 'find clicks remaining on unclickable link', ->
	telescopicText.reset()
	name_vertex = new telescopicText.Vertex('myName', 'myContent', 
		null, null, null, null, null)

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
	vertex_B.forwardDetermineAndSetIncomingEdge(vertex_A)
	equal(vertex_B.incoming_tree, vertex_A)
	equal(vertex_B.incoming_forward, false)
	equal(vertex_B.incoming_back, false)
	equal(vertex_B.incoming_cross, false)

	vertex_C.forwardDetermineAndSetIncomingEdge(vertex_A)	
	equal(vertex_C.incoming_tree, vertex_A)
	equal(vertex_C.incoming_forward, false)
	equal(vertex_C.incoming_back, false)
	equal(vertex_C.incoming_cross, false)

	### cross edge ###
	vertex_C.forwardDetermineAndSetIncomingEdge(vertex_B)
	equal(vertex_C.incoming_tree, vertex_A)
	equal(vertex_C.incoming_cross[0], vertex_B)
	equal(vertex_C.incoming_back[0], undefined)
	equal(vertex_C.incoming_forward[0], undefined)

	### back edge ###
	vertex_A.forwardDetermineAndSetIncomingEdge(vertex_C)
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

	vertex_Q.forwardDetermineAndSetIncomingEdge(vertex_E)
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

test 'visibility when forward clicking', ->
	telescopicText.reset()
	graph1 = makeTestVerticies()
	vertex_A = graph1.getNode('A')
	vertex_B = graph1.getNode('B')
	vertex_C = graph1.getNode('C')
	vertex_K = graph1.getNode('K')
	vertex_F = graph1.getNode('F')
	vertex_L = graph1.getNode('L')

	ok(!vertex_B.shouldBeVisible() && 
		!vertex_C.shouldBeVisible() && 
		!vertex_K.shouldBeVisible() && 
		!vertex_F.shouldBeVisible())

	### happy path. vertex_A "clicked" while visible ###
	vertex_A.forwardClick()
	ok(vertex_B.shouldBeVisible() && vertex_C.shouldBeVisible())
	ok(!vertex_A.shouldBeVisible() && !vertex_K.shouldBeVisible() && 
		!vertex_F.shouldBeVisible())

	### sad path. vertex_A "clicked" while it should be invisible ###
	vertex_A.forwardClick()
	ok(vertex_B.shouldBeVisible() && vertex_C.shouldBeVisible())
	ok(!vertex_A.shouldBeVisible() && 
		!vertex_K.shouldBeVisible() && 
		!vertex_F.shouldBeVisible() && 
		!vertex_L.shouldBeVisible())

	###sad path. vertex_L "clicked" while it should be invisible ###
	vertex_L.forwardClick()
	ok(vertex_B.shouldBeVisible() && vertex_C.shouldBeVisible())
	ok(!vertex_A.shouldBeVisible() && 
		!vertex_K.shouldBeVisible() && 
		!vertex_F.shouldBeVisible() && 
		!vertex_L.shouldBeVisible())

	vertex_B.forwardClick()
	ok(vertex_K.shouldBeVisible(), vertex_C.shouldBeVisible())
	ok(!vertex_A.shouldBeVisible() && 
		!vertex_B.shouldBeVisible() &&
		!vertex_F.shouldBeVisible() &&
		!vertex_L.shouldBeVisible())

	### test case for vertex with multiple sets of children ###
	vertex_C.forwardClick()
	ok(vertex_C.shouldBeVisible() && vertex_F.shouldBeVisible())
	ok(!vertex_A.shouldBeVisible() && 
		!vertex_B.shouldBeVisible() &&
		!vertex_L.shouldBeVisible())

	### test set [1] of children and _remain_after_click### 
	vertex_C.forwardClick()
	ok(vertex_C.shouldBeVisible() && 
		vertex_F.shouldBeVisible() && 
		vertex_L.shouldBeVisible())
		ok(!vertex_A.shouldBeVisible() && 
		!vertex_B.shouldBeVisible())

test 'find index of child in children', ->
	g = graphPatternOne()
	equal(g.vertex_C.findIndexOfChildInChildren(g.vertex_L), 1)
	equal(g.vertex_C.findIndexOfChildInChildren(g.vertex_F), 0)
	equal(g.vertex_A.findIndexOfChildInChildren(g.vertex_C), 0)


test 'determine elibility for reverseClick', ->
	g = graphPatternOne()
	ok(g.vertex_L.shouldBeReverseClickable() &&
		g.vertex_K.shouldBeReverseClickable)
	ok(!g.vertex_F.shouldBeReverseClickable() &&
		!g.vertex_C.shouldBeReverseClickable() &&
		!g.vertex_A.shouldBeReverseClickable() &&
		!g.vertex_B.shouldBeReverseClickable() &&
		!g.vertex_A.shouldBeReverseClickable())

test 'reverse click', ->
	g = graphPatternOne()
	
	### sad path. vertex_F should not be clickable. ###
	g.vertex_F.reverseClick()
	ok(g.vertex_F.shouldBeVisible() &&
		g.vertex_L.shouldBeVisible() &&
		g.vertex_C.shouldBeVisible() &&
		g.vertex_K.shouldBeVisible())
	ok(!g.vertex_B.shouldBeVisible() &&
		!g.vertex_A.shouldBeVisible())

	### happy path. vertex_L should be clickable ###
	g.vertex_L.reverseClick()
	ok(g.vertex_C.shouldBeVisible() && 
		g.vertex_F.shouldBeVisible() &&
		g.vertex_K.shouldBeVisible())

	ok(!g.vertex_A.shouldBeVisible() &&
		!g.vertex_B.shouldBeVisible() &&
		!g.vertex_L.shouldBeVisible())


### helper function ###
graphPatternOne= ->
	result = {}
	result.graph1 = makeTestVerticies()
	result.vertex_A = result.graph1.getNode('A')
	result.vertex_B = result.graph1.getNode('B')
	result.vertex_C = result.graph1.getNode('C')
	result.vertex_K = result.graph1.getNode('K')
	result.vertex_F = result.graph1.getNode('F')
	result.vertex_L = result.graph1.getNode('L')
	result.vertex_A.forwardClick()
	result.vertex_B.forwardClick()
	result.vertex_C.forwardClick()
	result.vertex_C.forwardClick()
	result
