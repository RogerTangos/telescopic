telescopicText.markup = (spec) ->
	that = telescopicText.vertex(spec)

	spec._wraps = {}
	### overridden ###
	that.getRemainAfterClick = -> true
	that.forwardClick = undefined
	that.reverseClick = undefined

	### public methods ###
	that.getWraps = -> spec._wraps
	that.createStartListForChildren = (childSetIndex) ->
		set = spec._children[childSetIndex]
		nodeDict = {}

		for child in set
			nodeDict[child.getName()] = true

		for child in set
			previous = nodeDict[child.getPrevious().getName()]
			if previous != undefined
				nodeDict[child.getName()] = false

		nodeDict

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
			wrapArray. Weird stuff with key not giving objects
			correctly. Hence, the .getName() shuffle ###
		for key, value of nodeDict
			if value == true
				linkArray = [spec._graph.getNode(key)]
				next = spec._graph.getNode(key).getNext().getName()
				while nodeDict[next] == false
					linkArray.push(spec._graph.getNode(next))
					next = next.getNext().getName()
				
				wrapArray.push(linkArray)


		spec._clickCount += 1

		### need to set up a separate method to clear this out ###
		that.incomingTree.push(incomingVertex)
		that




	### reverse clicking utilities ###
	that.receiveReverseClickFromChild=(childVertex)->
		null

	that.receiveReverseClickFromParent= (parentVertex)->
		null

	### insert node into graph###
	# spec._graph.setNode(spec._name, that)
	that





