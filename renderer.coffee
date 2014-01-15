telescopicText = {}
telescopicText.forward = true
telescopicText.graphs = {}
telescopicText.enableReversable = ->
	console.log 'reverse mode enabled'
	for key, value of this.graphs
		if /\[object\ telescopicText\.graph/.test(value.toString)
			value.reverseMode()
	console.log 'reverse mode enabled'
	this
telescopicText.enableForward = ->
	for key, value of this.graphs
		if /\[object\ telescopicText\.graph/.test(value.toString)
			value.forwardMode()
	console.log 'forward mode enabled'
	this

telescopicText.reset = -> telescopicText.graph({_name:'telescopicDefaultID'})
telescopicText.graph = (spec) ->
	### set defaults ###
	spec = spec || {}
	spec._name = spec._name || 'telescopicDefaultID' 
	### private attributes ###
	spec._startVertex
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
		spec._startVertex = that.getNode(startVertex)
		currentVertex = spec._startVertex
		nextVertex = that.getNode(currentVertex.getNext())

		if !spec._startVertex.getNext()
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

		that.setUpDom(spec._startVertex)
		that

	that.setUpDom = (startVertex) ->
		### define and clear target div ###
		id = 'tText-' + this.getName()
		tagElement = $('#'+id)
		tagElement.empty()

		### add first vertex ###
		vertex = startVertex
		startSpan = '<span style="display: none;" id = "'+ vertex.findDomId() + '">'
		endSpan = '</span>'
		spanObject = $(startSpan+ vertex.content + endSpan)
		tagElement.append(spanObject)
		vertex.setDomVisibility(spanObject)

		while vertex.getNext()
			vertex = vertex.getNext()
			startSpan = '<span style="display: none;" id = "'+ vertex.findDomId() + '">'
			spanObject = $(startSpan+ vertex.content + endSpan)
			tagElement.append(spanObject)
			vertex.setDomVisibility(spanObject)

	### linking/children functions ###
	that.setGraphChildReferences = ->
		for key, value of _nodes
			value.setChildrenReferences()
		that

	that.reverseMode= ->
		vertex = spec._startVertex



		console.log that.toString() + 'reverseMode enabled'

	that.forwardMode= ->
		console.log that.toString() + 'forwardMode enabled'


	that.toString= ->
		"[object telescopicText.graph " + spec._name + "]"

	return that

telescopicText.graph::toString = ->
	'[object telescopicText.graph]'

### class level functions ###
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


###################################
############# VERTEX ##############
###################################


telescopicText.vertex = (spec) ->
	### set defaults ###
	spec = spec || {}
	spec._starter = spec._starter || false
	spec._children = spec._children || []
	spec._remainAfterClick = spec._remainAfterClick  || false
	spec._next = spec._next || false
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
	that.incomingTree = []; that.incomingTree[0] = false
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
		that.incomingTree[0] = false
		that.incomingForward = []
		that.incomingBack = []
		that.incomingCross = []
	 
	### public functions meta info ###
	that.findClicksRemaining =->
		### ignore _remainAfterClick b/c it's not a click ###
		spec._children.length - spec._clickCount
	that.findDomId = -> 
		str = 'tText_' + spec._name
		str
	that.shouldBeVisible = ->
		# ### starter case ###
		# if that.children.length == 0
		# 	true
		if that.getStarter() && that.findClicksRemaining() > 0
			true
		else if that.getStarter() && that.getRemainAfterClick()
			true
			### not a starter node ###
		else if that.findClicksRemaining() > 0 && that.incomingTree[0]
			true
		else if that.incomingTree[0] && that.getRemainAfterClick()
			true
		else
			false		
	that.forwardDetermineAndSetIncomingEdge= (incomingVertex)->
		### assumes that incomingVertex is valid ###
		if !that.incomingTree[0] and !that.getStarter()
			that.incomingTree[0] = incomingVertex
		else if that.determineIfBackEdge(incomingVertex)
			that.incomingBack.push(incomingVertex)
		else if that.determineIfForwardEdge(incomingVertex)
			that.incomingForward.push(incomingVertex)
		else
			that.incomingCross.push(incomingVertex)
		that
	that.determineIfBackEdge = (incomingVertex) ->
		parentVertex = incomingVertex.incomingTree[0]

		while parentVertex
			if parentVertex == that
				return true
			else
				parentVertex = parentVertex.incomingTree[0]
		false
	that.determineIfForwardEdge = (incomingVertex) ->
		parentVertex = that.incomingTree[0]

		while parentVertex
			if parentVertex == incomingVertex
				return true
			else
				parentVertex = parentVertex.incomingTree[0]
		false
	that.shouldBeReverseClickable = ->
		### need to check to make sure that parent is on the same click index as the child ###
		if spec._clickCount == 0 &&
				that.shouldBeVisible() && 
				that.incomingTree[0] && 
				spec._clickCount == 0 &&
				that.incomingTree[0].findIndexOfChildInChildren(that) == that.incomingTree[0].getClickCount()-1
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
	that.userClick = ->
		if telescopicText.forward
			that.forwardClick()
		else
			that.reverseClick()

	that.forwardClick= ->
		### catch instance in which it shouldn't be clicked ###
		if that.findClicksRemaining() <= 0 or !that.shouldBeVisible()
			return that

		relevantChildren = spec._children[spec._clickCount]
		for child in relevantChildren
			child.receiveForwardClick(that)

		spec._clickCount +=1
		that.setDomVisibility()
		that

	that.receiveForwardClick= (incomingVertex)->
		that.forwardDetermineAndSetIncomingEdge(incomingVertex)
		that.setDomVisibility()
		that

	### reverse clicking utilities ###
	that.reverseClick= ->
		if !that.shouldBeReverseClickable()
			return that
		that.incomingTree[0].receiveReverseClickFromChild(that)
		that

	that.receiveReverseClickFromChild=(childVertex)->
		spec._clickCount += -1
		that.setDomVisibility()
		childIndex = that.findIndexOfChildInChildren(childVertex)
		for child in spec._children[childIndex]
			child.receiveReverseClickFromParent(that)
		that

	that.receiveReverseClickFromParent= (parentVertex)->
		if that.incomingTree[0] == parentVertex
			that.setEdgesToDefault()
			that.setDomVisibility()
		that

	### DOM manipulation ###
	that.setDomVisibility= (jQueryObject)->
		if !jQueryObject
			jQueryObject = $('#'+that.findDomId())
		
		jQueryObject.click ->
			that.userClick()
			
		if that.shouldBeVisible() && telescopicText.forward
			# that.setDomForwardVisibility(jQueryObject)

			if that.findClicksRemaining() > 0
				jQueryObject.addClass('tText_clickable')
			else
				jQueryObject.removeClass('tText_clickable')
			jQueryObject.show()

		else
			jQueryObject.hide()

		that

	that.setDomForwardVisibility = (jQueryObject) ->
		if that.findClicksRemaining() > 0
				jQueryObject.addClass('tText_clickable')
		else
			jQueryObject.removeClass('tText_clickable')
		jQueryObject.show()


	that.setDomReverseVisibility = (jQueryObject) ->
		true

	### override toString, so that inserting nodes as keys works. ###
	that.toString= ->
		"[object telescopicText.vertex " + spec._name + "]"

	### insert node into graph###
	spec._graph.setNode(spec._name, that)	
	return that

telescopicText.vertex::toString = ->
  "[object telescopicText.vertex]"


document.onkeyup= (event) ->
	if event.altKey
		telescopicText.forward = true
		telescopicText.enableForward()

document.onkeydown = (event) ->
	if telescopicText.forward && event.altKey 
		telescopicText.forward = false
		telescopicText.enableReversable()
	
