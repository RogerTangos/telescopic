test 'vertex sets child references on command', ->
	telescopicText.reset()
	makeTestVerticies()
	vertexA.setChildrenReferences()

	# happy path. vertices found.
	equal(vertexA.getChildren()[0][0], vertexC)
	equal(vertexA.getChildren()[0][1], vertexB)

	# sad path where vertex isn't found
	equal(vertexA.getChildren()[1], undefined)