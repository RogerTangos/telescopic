test '.markup is linked with children like any other vertex', ->
	makeYAndZ()
	graph1 = makeTestVerticies().setGraphChildReferences()
	equal(markupZ.getChildren()[0][0], vertexH, "children of markupZ reference correctly")
	equal(markupY.getChildren()[0][0], vertexO)

test '.markup has desired attributes', ->
	makeYAndZ()
	graph1 = makeTestVerticies().makeLinkedList(vertexA)

	equal(markupZ.getStarter(), false)
	equal(markupY.getStarter(), true)

	equal(markupZ.getName(), 'Z')
	equal(markupY.getName(), 'Y')
	
	equal(markupZ.getGraph(), graph1, 'getGraph() gives graph1')
	equal(markupY.getGraph(), graph1)

	equal(markupZ._next, null, 'next is null')
	equal(markupY._next, null)

	equal(markupZ._previous, null, 'previous is null')
	equal(markupY._previous, null)

	equal(markupZ.getClickCount(), 0, "click count is 0 when initialized")
	equal(markupY.getClickCount(), 0)

	equal(markupZ.getChildren()[0][0], 'H', "children of markupZ correct")
	equal(markupY.getChildren()[0][0], 'O')

	equal(markupZ.getRemainAfterClick(), true)
	equal(markupY.getRemainAfterClick(), true)

	equal(markupZ.incomingTree[0], false)
	equal(markupY.incomingTree[0], false)

	equal(markupZ.incomingForward[0], undefined)
	equal(markupY.incomingForward[0], undefined)

	equal(markupZ.incomingBack[0], undefined)
	equal(markupY.incomingBack[0], undefined)

	equal(markupZ.incomingCross[0], undefined)
	equal(markupY.incomingCross[0], undefined)


test '.markup has no forwardClick or reverseClick', ->
	makeYAndZ()
	makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)

	# equal(markupY.forwardClick(), undefined)
	equal(markupY.forwardClick, undefined, 'forward click is undefined')
	equal(markupZ.forwardClick, undefined)

	equal(markupY.reverseClick, undefined, 'reverse click is undefined')
	equal(markupZ.reverseClick, undefined)

test '.markup .getWraps() initializes objects based on next. objects.', ->
	makeYAndZ()
	makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)

	ok(isEmpty(markupZ.getWraps), 'markups created w. empty spec._wraps and getWraps()')
	ok(isEmpty(markupY.getWraps))

test '.markup separate contigious from non-contigious verticies', ->
	makeYAndZ()
	makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)

	equal(markupY.createStartListForChildren(0)['O'], true)
	equal(markupY.createStartListForChildren(1)['O'], undefined)
	equal(markupY.createStartListForChildren(1)['K'], true)
	equal(markupY.createStartListForChildren(1)['L'], false)
	equal(markupY.createStartListForChildren(1)['P'], true)


test '.markup determineWraps returns key-value lists based on the incoming vertex', ->
	makeYAndZ()
	makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)

	markupY.receiveForwardClick(vertexP)
	equal(markupY.getWraps()[vertexP][0][0], vertexO, 'markupY wraps vertexO the 
		first time')
	markupY.receiveForwardClick(vertexR)
	equal(markupY.getWraps()[vertexP][0][0], vertexO, 'markupY still wraps vertexO the second time')
	equal(markupY.getWraps()[vertexR][0][0], vertexK, 'markupK warps correctly')
	equal(markupY.getWraps()[vertexR][0][1], vertexL)
	equal(markupY.getWraps()[vertexR][1][0], vertexP)

	markupZ.receiveForwardClick(vertexC)
	equal(markupZ.getWraps()[vertexC][0][0], vertexH, 'markupZ is activated the first time')
	markupZ.receiveForwardClick(vertexG)
	equal(markupZ.getWraps()[vertexG][0][0], vertexQ, 'markupZ is activated the second time')
	equal(markupZ.getWraps()[vertexG][1][0], vertexS)
	equal(markupZ.getWraps()[vertexG][1][1], vertexT)

test '.markup can upwrap', ->
	makeYAndZ()
	makeTestVerticies().setGraphChildReferences().makeLinkedList(vertexA)

	markupY.receiveReverseClickFromParent(vertexP)
		.receiveReverseClickFromParent(vertexR)
	markupY.receiveReverseClickFromParent(vertexP)
		.receiveReverseClickFromParent(vertexR)

	equal(markupY.getWraps()[vertexP], undefined, 
		'receiveReverseClickFromParent worked for vertexY')
	equal(markupY.getWraps()[vertexR], undefined)

	markupZ.receiveReverseClickFromParent(vertexC)
		.receiveReverseClickFromParent(vertexG)
	markupZ.receiveReverseClickFromParent(vertexC)
		.receiveReverseClickFromParent(vertexG)
	equal(markupZ.getWraps()[vertexC], undefined, 
		'receiveReverseClickFromParent worked for vertexZ')
	equal(markupZ.getWraps()[vertexG], undefined)


makeYAndZ = ->
	telescopicText.reset()
	window.markupY = telescopicText.markup({
		_name: 'Y',
		content: '<em></em>',
		_children: [['O'],['L','K', 'P']],
		_graph: 'graph1',
		_starter: true})
	window.markupZ = telescopicText.markup({
		_name: 'Z',
		content:'<p><div></div></p>'
		_children:[['H'],['Q','S','T']],
		_graph: 'graph1',
		_starter: false})

isEmpty = (obj) ->
  for key of obj
    return false  if obj.hasOwnProperty(key)
  true

