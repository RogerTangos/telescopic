telescopicText.markup = (spec) ->
	that = telescopicText.vertex(spec)

	spec._wraps = {}
	### overridden ###
	that.getRemainAfterClick = -> true
	that.forwardClick = undefined
	that.reverseClick = undefined

	### public methods ###
	that.getWraps = -> spec._wraps

	### forward clicks ###
	that.receiveForwardClick= (incomingVertex)->
		spec._wraps[incomingVertex] = []

		for child in 


	### reverse clicking utilities ###
	that.receiveReverseClickFromChild=(childVertex)->
		null

	that.receiveReverseClickFromParent= (parentVertex)->
		null

	### insert node into graph###
	# spec._graph.setNode(spec._name, that)
	that





