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

	return that

telescopicText.vertex = (spec) ->
	### set defaults ###
	spec = spec || {}
	spec._starter = spec._starter || false
	spec._children = spec._children || []
	spec._remain_after_click = spec._remain_after_click  || false
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
	that.getRemainAfterClick = -> spec._remain_after_click
	 
	### public functions meta info ###
	that.findClicksRemaining =->
		### ignore _remain_after_click b/c it's not a click ###
		that.children.length - spec._click_count

	### insert node into graph###
	spec._graph.setNode(spec._name, that)
	
	return that