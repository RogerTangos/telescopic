test 'forward click a node, vertex_A. test vertex_A visibility', ->
	telescopicText.reset()
	graph1 = makeTestVerticies()
	vertex_A = graph1.getNode('A')
	vertex_A.forward_click()

	equal(vertex_A.findClicksRemaining(), 0)
	equal(vertex_A.shouldBeVisible(), false)

test 'forward click a node, vertex_A. Test its children\'s visibility', ->
	telescopicText.reset()
	graph1 = makeTestVerticies()
	vertex_A = graph1.getNode('A')
	vertex_A.forward_click()