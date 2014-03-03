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

test 'appropriate nodes reappear, dissapear after reverseClick() - test 1', ->
	graph1 = makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)
	vertexA.forwardClick()
	equal($('#tText_B').is(':visible'), true)
	
	vertexB.forwardClick()
	equal($('#tText_B').is(':visible'), false)
	equal($('#tText_C').is(':visible'), true)
	
	vertexC.reverseClick()
	equal($('#tText_C').is(':visible'), false, 'a and be forward clicked. c reverse clicked.')
	equal($('#tText_B').is(':visible'), false)
	equal($('#tText_A').is(':visible'), true)

test 'verticies are wrapped after foward click', ->
	graph1 = makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)
	vertexA.forwardClick()
	vertexC.forwardClick()

	equal(1,1)

test 'user clicks an individual vertex', ->
	graph1 = makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)
	$('#tText_A').click()
	equal($('#tText_A').is(':visible'), false)
	equal($('#tText_B').is(':visible'), true)
	equal($('#tText_C').is(':visible'), true)

test 'graph.forward is false when alt downkey', ->
	graph1 = makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)
	equal(telescopicText.forward, true)
	e = jQuery.Event("keydown")
	e.altKey = true
	$(document).trigger(e)
	equal(telescopicText.forward, false)


test 'graph.forward is true when alt keyup', ->
	graph1 = makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)
	telescopicText.forward = false
	e = jQuery.Event("keyup")
	e.altKey = true
	$(document).trigger(e)
	equal(telescopicText.forward, true)

test 'verticies are correctly highlighted during keydown', ->
	telescopicText.reset()
	graph1 = makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)
	$('#tText_A').click()

	equal(telescopicText.forward, true)
	e = jQuery.Event("keydown")
	e.altKey = true
	$(document).trigger(e)

	
	ok($('#tText_B').hasClass('tText_reversable'))
	equal($('#tText_A').is(':visible'), false)









