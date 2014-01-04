test 'linked list appears on page.', ->
	telescopicText.reset()
	graph1 = makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)
	ok($('#tText-graph1').children().length > 0)

test 'nodes are hidden and shown appropriately', ->
	telescopicText.reset()
	graph1 = makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)
	equal($('#tText_A').is(':visible'), true, 'starter nodes are visible')
	equal($('#tText_D').is(':visible'), true)
	equal($('#tText_G').is(':visible'), true)
	equal($('#tText_V').is(':visible'), true)

	equal($('#tText_B').is(':visible'), false, 'non-starter nodes are not visible')
	equal($('#tText_E').is(':visible'), false)

	equal($('#tText_Z').length, 0, 'markup nodes are not on the page')
	equal($('#tText_Y').length, 0)

test 'appropriate nodes dissapear, reappear after forwardClick()', ->
	graph1 = makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)
	vertexA.forwardClick()
	equal($('#tText_A').is(':visible'), false, 'A is not visible after click')
	equal($('#tText_B').is(':visible'), true, 'B appears after A click')
	equal($('#tText_C').is(':visible'), true, 'C appears after A click')

# test 'appropriate nodes appear after receiveForwardClick()', ->
# 	equal(1,1)