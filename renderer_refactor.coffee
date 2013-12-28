### add all private attributes to spec by convention.### 

telescopicText = {}
telescopicText.graphs = {}
telescopicText.reset = ->
	telescopicText.graphs = {}
	telescopicText.graph({_name:'telescopicDefaultID'})

## functional inheritance
telescopicText.graph = (spec) ->

	### private ###
	that = {}
	_nodes = {}

	### public ###
	that.getName= ->
		spec._name
	
	that.getNode = (key) ->
		node = _nodes[key]
		if node == undefined
			console.log 'Graph "' + @.getName() + 
			'" is missing a child, with key "' + key + '."'
			null
		node

	that.setNode = (key, value) ->
		_nodes[key] = value
		that

	### insert graph into graphs object ###
	telescopicText.graphs[spec._name] = that

	return that

telescopicText.vertex = (spec) ->
	### constructor necessities ###
	if not telescopicText.graphs[spec._graph]
		spec._graph = telescopicText.graph({_name: spec._graph})
	else
		spec._graph = telescopicText.graphs[spec._graph]
	# spec._graph.setNode(spec._name, that)

	### private attributes ###
	that = {}
	spec._previous = null
	spec._click_count = 0
	
	### public attributes ###
	that.content = spec.content
	
	### public functions ###
	that.getStarter = -> spec._starter
	that.getName = -> spec._name
	that.getGraph = -> spec._graph
	that.getNext = -> spec._next
	that.setNext = (newNext) -> spec._next = newNext
	that.getPrevious = -> spec._previous
	that.setPrevious = -> spec._previous = newPrevious
	that.getClickCount = -> spec._click_count
	that.getChildren = -> spec._children or []
	 
	### public functions meta info ###
	that.getRemainAfterClick = -> spec._remain_after_click 
	that.findClicksRemaining =->
		### ignore _remain_after_click b/c it's not a click ###
		that.children.length - spec._click_count
	
	return that

# foo = telescopicText.graph(_name: 'myGraph')
# foo.setNode('foo', 'bar')
# foo.getName()
# foo.getNode('DNE')
# foo.getNode('foo')