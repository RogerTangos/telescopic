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
	
	vertex_A.forward_click()
	equal(vertex_A.findClicksRemaining(), 0)
	equal(vertex_A.shouldBeVisible(), false)

test 'make sure hidden nodes give correct visibility.', ->
	telescopicText.reset()
	graph1 = makeTestVerticies()
	vertex_C = graph1.getNode('C')
	vertex_K = graph1.getNode('K')

	equal(vertex_C.shouldBeVisible(), false)
	equal(vertex_K.shouldBeVisible(), false)


test 'forward click a node, vertex_A. Test its children\'s visibility', ->
	telescopicText.reset()
	graph1 = makeTestVerticies()
	vertex_A = graph1.getNode('A')
	vertex_B = graph1.getNode('B')
	vertex_C = graph1.getNode('C')
	vertex_A.forward_click()

	equal(vertex_B.incoming_tree, vertex_A)
	equal(vertex_B.findClicksRemaining, 1)
	equal(vertex_B.shouldBeVisible(), true)

	equal(vertex_C.incoming_tree, vertex_A)
	equal(vertex_C.findClicksRemaining, 2)
	equal(vertex_C.shouldBeVisible(), true)