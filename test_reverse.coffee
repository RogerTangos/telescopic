test 'determine elibility for backClick; click A', ->
	telescopicText.reset()
	graph1 = makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)

	vertexA.forwardClick()
	telescopicText.forward = false

	equal(vertexC.isBackClickable(), true, "C should be back clickable")
	equal(vertexB.isBackClickable(), true, "B should be back clickable")

test 'determine elibility for backClick; click D G', ->
	telescopicText.reset()
	graph1 = makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)

	vertexD.forwardClick()
	vertexG.forwardClick() 
	telescopicText.forward = false

	equal(vertexE.isBackClickable(), true, "E should be back clickable")
	# equal(vertexB.isBackClickable(), true, "B should be back clickable")

test 'determine elibility for backClick; click A B', ->
	telescopicText.reset()
	graph1 = makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)

	vertexA.forwardClick()
	vertexB.forwardClick()
	telescopicText.forward = false

	equal(vertexC.isBackClickable(), false, "C should not be back clickable")
	equal(vertexB.isBackClickable(), false, "B should not be back clickable")
	equal(vertexK.isBackClickable(), true, "K should be back clickable")

	ok(true, "click C C L O N | F")
	vertexC.forwardClick()
	vertexC.forwardClick()
	vertexL.forwardClick()
	vertexO.forwardClick()
	vertexN.forwardClick()
	vertexF.forwardClick()

	equal(vertexM.isBackClickable(), true, "Vertex M should be back-clickable")

# test 'backward: A B D V U E <- C H K T U E', ->
# 	telescopicText.reset()
# 	graph1 = makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)
# 	$('#tText_A').click()
# 	$('#tText_B').click()
# 	$('#tText_D').click()
# 	$('#tText_V').click()
# 	$('#tText_U').click()
# 	$('#tText_E').click()

# 	telescopicText.forward = false
# 	telescopicText.toggleDirection()

# 	$('#tText_C').click()
# 	$('#tText_H').click()
# 	$('#tText_K').click()
# 	$('#tText_T').click()
# 	$('#tText_U').click()
# 	$('#tText_E').click() 

# 	telescopicText.forward = true
# 	telescopicText.toggleDirection()

# 	ok(telescopicText.testOriginalVisibility(), 'original visibility has returned')

# test 'backward D E H A C', ->
# 	telescopicText.reset()
# 	graph1 = makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)
# 	$('#tText_D').click()
# 	$('#tText_E').click()
# 	$('#tText_H').click()
# 	$('#tText_A').click()
# 	$('#tText_C').click()

# 	telescopicText.forward = false
# 	telescopicText.toggleDirection()

# 	$('#tText_B').click()
# 	$('#tText_F').click()
# 	$('#tText_S').click()
# 	$('#tText_E').click()

# 	ok(telescopicText.testOriginalVisibility(), 'original visibility has returned')


# telescopicText.testOriginalVisibility = () ->
# 	visibleCorrect = $('#tText_A').is(':visible') && 
# 		$('#tText_A').is(':visible') && 
# 		$('#tText_D').is(':visible') && 
# 		$('#tText_G').is(':visible') &&
# 		$('#tText_V').is(':visible' &&
# 		markupY.isVisible())

# 	hiddenCorrect = ! ($('#tText_B').is(':visible') ||
# 		$('#tText_C').is(':visible') ||
# 		$('#tText_E').is(':visible') ||
# 		$('#tText_H').is(':visible') ||
# 		$('#tText_F').is(':visible') ||
# 		$('#tText_I').is(':visible') ||
# 		$('#tText_M').is(':visible') ||
# 		$('#tText_L').is(':visible') ||
# 		$('#tText_K').is(':visible') ||
# 		$('#tText_J').is(':visible') ||
# 		$('#tText_N').is(':visible') ||
# 		$('#tText_O').is(':visible') ||
# 		$('#tText_P').is(':visible') ||
# 		$('#tText_Q').is(':visible') ||
# 		$('#tText_R').is(':visible') ||
# 		$('#tText_S').is(':visible') ||
# 		$('#tText_T').is(':visible') ||
# 		$('#tText_U').is(':visible') ||
# 		markupZ.isVisible() )

# 	visibleCorrect && hiddenCorrect
