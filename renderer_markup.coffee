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
		wrapArray = spec._wraps[incomingVertex]
		set = spec._children[spec._clickCount]
		nodeDict = {}

		### make dict using vertex names. verticies are true
		 	if they start a link  or are alone. 
		 	false if they are linked later. ###
		for child in set
			nodeDict[child.getName()] = true

		for child in set
			if nodeDict[child.getPrevious().getName()] == undefined
				nodeDict[child] = false

		### create arrays of linked lists. push them to
			spec._wraps ###
		for key, value of nodeDict
			if value == true
				linkArray = [value]
				next = spec._graph.getNode(key).getNext().getName()
				while nodeDict[next] == false
					linkArray.push(next)
					next = next.getNext().getName()
			wrapArray.push(linkArray)


		spec._clickCount += 1
		that._incomingTree.push(incomingVertex)
		that




	### reverse clicking utilities ###
	that.receiveReverseClickFromChild=(childVertex)->
		null

	that.receiveReverseClickFromParent= (parentVertex)->
		null

	### insert node into graph###
	# spec._graph.setNode(spec._name, that)
	that





