telescopicText.markup = (spec) ->
	that = telescopicText.vertex(spec)

	spec._wraps = {}
	spec._wrapLevel = {} #number of times wrap will need to be unwrapped.
	### overridden ###
	that.getRemainAfterClick = -> true
	that.getWrapLevel= (key) -> spec._wrapLevel[key]
	### remove unnecessary functions ###
	delete that.setDomVisibility 
	delete that.forwardClick
	delete that.reverseClick
	delete that.userClick

	### public methods ###
	that.getWraps = -> spec._wraps
	that.pushToIncomingTree = (incomingVertex) ->
		if that.incomingTree[0] == false
			that.incomingTree[0]= incomingVertex
		else
			that.incomingTree.push(incomingVertex)
		that
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

	that.setWrapLevel= (incomingVertex) ->
		

		#determine if element or html string
		isHtmlString = /^\<.+\>/.test(that.content)
		if isHtmlString
			spec._wrapLevel[incomingVertex]= 1
			### convert to html using jquery ### 
			htmlArray = $(that.content)
			current = htmlArray.children()

			while current[0]
				spec._wrapLevel[incomingVertex] += 1
				current = current.children()	
			
		else
			spec._wrapLevel[incomingVertex] = $(that.content).length

	that

	### forward clicks ###
	that.receiveForwardClick= (incomingVertex)->
		that.setWrapLevel(incomingVertex)
		### create arrays of linked lists. push them to
			wrapArray. Weird stuff with key not giving objects
			correctly. Hence, the .getName() shuffle ###
		spec._wraps[incomingVertex] = []
		wrapArray = spec._wraps[incomingVertex]
		nodeDict = this.createStartListForChildren(spec._clickCount)

		for key, value of nodeDict
			if value == true
				linkArray = [spec._graph.getNode(key)]
				next = spec._graph.getNode(key).getNext()
				if next
					nextName = next.getName()
				while nodeDict[nextName] == false
					linkArray.push(spec._graph.getNode(next))
					next = next.getNext()
					if next
						nextName = next.getName()
					else nextName = false

				wrapArray.push(linkArray)		

		spec._clickCount += 1

		that.wrap(incomingVertex)
		that.pushToIncomingTree(incomingVertex)
		that

	### reverse clicking utilities ###
	that.receiveReverseClickFromParent= (parentVertex)->
		that.unwrap(parentVertex)
		delete spec._wraps[parentVertex]
		delete spec._wrapLevel[parentVertex]
		
		### reset defaults ###
		that.setEdgesToDefault()
		spec._clickCount += -1
		that

	that

	### DOM manipulation ###
	that.wrap= (incomingVertex) ->
		verticies = spec._wraps[incomingVertex]

		for set in verticies
			vertexArray = []
			for vertex in set
				vertexArray.push(vertex.getName())

			selector = '#tText_' + vertexArray.join(', #tText_')
			$(selector).wrapAll(that.content)
		that

	that.unwrap= (incomingVertex) ->
		verticies = spec._wraps[incomingVertex]

		for set in verticies
			vertexArray = []
			for vertex in set
				vertexArray.push(vertex.getName())
			selector = '#tText_' + vertexArray.join(', #tText_')
			
			i = 0
			while i<spec._wrapLevel[incomingVertex]
				$(selector).unwrap()
				i++
		that

	
	that

telescopicText.markup::toString = ->
  "[object telescopicText.markup]"



