#note to self: setChildrenReferences uses this, but should use that.
# for some reason it works. That's fucked up.
# you are also working on edge assignment w/ forward

### add all private attributes to spec by convention.### 

telescopicText = {}
telescopicText.graphs = {}
telescopicText.reset = -> telescopicText.graph({_name:'telescopicDefaultID'})
telescopicText.graph = (spec) ->
	### set defaults ###
	spec = spec || {}
	spec._name = spec._name || 'telescopicDefaultID' 
	### private attributes ###
	that = {}
	_nodes = {}
	### constructor. default text, and insert into graphs ###
	telescopicText.graphs[spec._name] = that
	### public functions ###
	that.getName = -> spec._name
	that.getNode = (keyOrVertex) ->
		### in case get the vertex's key ###
		if keyOrVertex instanceof Object
			keyOrVertex = keyOrVertex.getName()
		node = _nodes[keyOrVertex]
		if node == undefined
			console.log 'Graph "' + that.getName() + 
			'" is missing a child, with key "' + keyOrVertex + '."'
			undefined
		node
	that.setNode = (key, value) ->
		_nodes[key] = value
		that

	that.makeLinkedList = (startVertex) ->
		startVertex = that.getNode(startVertex)
		currentVertex = startVertex
		nextVertex = that.getNode(currentVertex.getNext())

		if !startVertex.getNext()
			console.log 'Careful! This graph only has one vertex linked.' 
			+ 'and that seems pretty silly to me.'

		while nextVertex
			if nextVertex == startVertex
				currentVertex.setNext(null)
				nextVertex.setPrevious(null)
				console.log "Your linked list is cyclical when it should be linear. " + 
				"Did not link the start and end nodes."
				nextVertex = false
			else 
				telescopicText.graph.link(currentVertex, nextVertex)
				currentVertex = nextVertex
				nextVertex = that.getNode(currentVertex.getNext())
		that


	### linking/children functions ###
	that.setGraphChildReferences = ->
		for key, value of _nodes
			value.setChildrenReferences()
		that

	return that

### object level functions ###
telescopicText.graph.link= (fromVertex, toVertex) ->
	#link two vertexes. needs to be passed vertex objects, not just their keys
	fromVertex.setNext(toVertex)
	toVertex.setPrevious(fromVertex)
telescopicText.graph.dangerousUnlink = (vertex) ->
	#unlink a vertex. needs to be passed a vertex objects, not just its keys
		next = vertex.getNext()
		previous = vertex.getPrevious()

		vertex.setNext(null)
		vertex.setPrevious(null) 

		if next
			next.setPrevious(null)
		if previous
			previous.setNext(null)
telescopicText.graph.safeUnlink = (vertex) ->
	next = vertex.getNext()
	previous = vertex.getPrevious()

	vertex.setNext(null)
	vertex.setPrevious(null)

	if next
		next.setPrevious(previous)
	if previous
		previous.setNext(next)

telescopicText.vertex = (spec) ->
	### set defaults ###
	spec = spec || {}
	spec._starter = spec._starter || false
	spec._children = spec._children || []
	spec._remainAfterClick = spec._remainAfterClick  || false
	spec._next = spec._next || null
	### constructor  ###
	if not telescopicText.graphs[spec._graph]
		spec._graph = telescopicText.graph({_name: spec._graph})
	else
		spec._graph = telescopicText.graphs[spec._graph]
	### private attributes ###
	that = {}
	spec._previous = null
	spec._clickCount = 0
	### public attributes ###
	that.content = spec.content
	that.incomingTree = false
	that.incomingForward = []
	that.incomingBack = []
	that.incomingCross = []
	### public functions ###
	that.getStarter = -> spec._starter
	that.getName = -> spec._name
	that.getGraph = -> spec._graph
	that.getNext = -> spec._next
	that.setNext = (newNext) -> spec._next = newNext
	that.getPrevious = -> spec._previous
	that.setPrevious = (newPrevious) -> spec._previous = newPrevious
	that.getClickCount = -> spec._clickCount
	that.getChildren = -> spec._children
	that.getRemainAfterClick = -> spec._remainAfterClick
	that.setEdgesToDefault = ->
		that.incomingTree = false
		that.incomingForward = []
		that.incomingBack = []
		that.incomingCross = []
	 
	### public functions meta info ###
	that.findClicksRemaining =->
		### ignore _remainAfterClick b/c it's not a click ###
		spec._children.length - spec._clickCount
	that.shouldBeVisible = ->
		# ### starter case ###
		# if that.children.length == 0
		# 	true
		if that.getStarter() && that.findClicksRemaining() > 0
			true
		else if that.getStarter() && that.getRemainAfterClick()
			true
			### not a starter node ###
		else if that.findClicksRemaining() > 0 && that.incomingTree
			true
		else if that.incomingTree && that.getRemainAfterClick()
			true
		else
			false		
	that.forwardDetermineAndSetIncomingEdge= (incomingVertex)->
		### assumes that incomingVertex is valid ###
		if !that.incomingTree and !that.getStarter()
			that.incomingTree = incomingVertex
		else if that.determineIfBackEdge(incomingVertex)
			that.incomingBack.push(incomingVertex)
		else if that.determineIfForwardEdge(incomingVertex)
			that.incomingForward.push(incomingVertex)
		else
			that.incomingCross.push(incomingVertex)
		that
	that.determineIfBackEdge = (incomingVertex) ->
		parentVertex = incomingVertex.incomingTree

		while parentVertex
			if parentVertex == that
				return true
			else
				parentVertex = parentVertex.incomingTree
		false
	that.determineIfForwardEdge = (incomingVertex) ->
		parentVertex = that.incomingTree

		while parentVertex
			if parentVertex == incomingVertex
				return true
			else
				parentVertex = parentVertex.incomingTree
		false

	that.shouldBeReverseClickable = ->
		### need to check to make sure that parent is on the same click index as the child ###
		if spec._clickCount == 0 &&
				that.shouldBeVisible() && 
				that.incomingTree && 
				spec._clickCount == 0 &&
				that.incomingTree.findIndexOfChildInChildren(that) == that.incomingTree.getClickCount()-1
			return true
		else
			return false

	### linking utilities ###
	that.setChildrenReferences = ->
		setIndex = 0
		while setIndex < spec._children.length
			childIndex = 0
			while childIndex < spec._children[setIndex].length
				childKey = spec._children[setIndex][childIndex]
				child = spec._graph.getNode(childKey)  
				if child == undefined
					console.log 'The key, "'+ childKey+ '", will be removed from vertex\'s child array.'
					spec._children[setIndex].splice(childIndex,1)
				else
					spec._children[setIndex][childIndex] = child
					childIndex +=1
			setIndex += 1
		that

	that.findIndexOfChildInChildren =(chidVertex)->
		childIndex = 0
		for row in spec._children
			for child in row
				if child == chidVertex
					return childIndex
			childIndex +=1
		false

	### clicking utilities ###
	that.forwardClick= ->
		### catch instance in which it shouldn't be clicked ###
		if that.findClicksRemaining() <= 0 or !that.shouldBeVisible()
			return that

		relevantChildren = spec._children[spec._clickCount]
		for child in relevantChildren
			child.receiveForwardClick(that)

		spec._clickCount +=1
		that

	that.receiveForwardClick= (incomingVertex)->
		that.forwardDetermineAndSetIncomingEdge(incomingVertex)
		that

	### reverse clicking utilities ###
	that.reverseClick= ->
		if !that.shouldBeReverseClickable()
			return that
		that.incomingTree.receiveReverseClickFromChild(that)
		that

	that.receiveReverseClickFromChild=(childVertex)->
		spec._clickCount += -1
		childIndex = that.findIndexOfChildInChildren(childVertex)
		for child in spec._children[childIndex]
			child.receiveReverseClickFromParent(that)
		that

	that.receiveReverseClickFromParent= (parentVertex)->
		if that.incomingTree == parentVertex
			that.setEdgesToDefault()
		that


	### insert node into graph###
	spec._graph.setNode(spec._name, that)	
	return that



telescopicText.markup = (spec) ->
	that = telescopicText.markup(spec)
	### set defaults ###
	spec = spec || {}
	spec._starter = spec._starter || false
	spec._children = spec._children || []
	spec._remainAfterClick = undefined
	spec._next = spec._next || null
	### constructor  ###
	if not telescopicText.graphs[spec._graph]
		spec._graph = telescopicText.graph({_name: spec._graph})
	else
		spec._graph = telescopicText.graphs[spec._graph]
	


	that.forwardClick = undefined
	

	that.receiveForwardClick= (incomingVertex)->
		that.forwardDetermineAndSetIncomingEdge(incomingVertex)
		that

	### reverse clicking utilities ###
	that.reverseClick= ->
		null

	that.receiveReverseClickFromChild=(childVertex)->
		null

	that.receiveReverseClickFromParent= (parentVertex)->
		null

	that





