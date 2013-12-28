### add all private attributes to spec by convention.### 

telescopicText = {}
telescopicText.graphs = {}
telescopicText.reset = ->
	telescopicText.graph({_name:'telescopicDefaultID'})

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
			console.log 'Graph "' + @.getName() + 
			'" is missing a child, with key "' + keyOrVertex + '."'
			undefined
		node
	that.setNode = (key, value) ->
		_nodes[key] = value
		that

	### linking/children functions ###
	that.setReferencesForChildrenThroughoutGraph = ->
		for key, value of _nodes
			value.setChildrenReferences()

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


telescopicText.vertex = (spec) ->
	### set defaults ###
	spec = spec || {}
	spec._starter = spec._starter || false
	spec._children = spec._children || []
	spec._remainAfterClick = spec._remainAfterClick  || false
	### constructor  ###
	if not telescopicText.graphs[spec._graph]
		spec._graph = telescopicText.graph({_name: spec._graph})
	else
		spec._graph = telescopicText.graphs[spec._graph]
	### private attributes ###
	that = {}
	spec._previous = null
	spec._click_count = 0
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
	that.getClickCount = -> spec._click_count
	that.getChildren = -> spec._children
	that.getRemainAfterClick = -> spec._remainAfterClick
	 
	### public functions meta info ###
	that.findClicksRemaining =->
		### ignore _remainAfterClick b/c it's not a click ###
		that.children.length - spec._click_count

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

	### insert node into graph###
	spec._graph.setNode(spec._name, that)	
	return that