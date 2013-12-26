telescopicText = {}

telescopicText.graphs = {}	#place to store all graphs

telescopicText.reset= ->
	telescopicText.graphs = {}
	new telescopicText.Graph('telescopicDefaultID')

class telescopicText.Graph
	constructor: (_name) ->
		### shortcut to reference graphs ###
		telescopicText.graphs[_name] = @

		### private ###
		_nodes = {}

		###getters, setters###
		@getName = -> _name

		@getNode = (key) ->
			node = _nodes[key]
			if node == undefined
				console.log 'Graph "' + @.getName() + '" is missing a child, with key "' + key + '."'
				null
			node

		@setNode = (key, value) ->
			_nodes[key] = value


		### object-level methods ###
		@returnVertexFromKeyOrObject= (key_or_object) ->
			if key_or_object !instanceof telescopicText.Vertex
				key_or_object = @.getNode(key_or_object)
			else
				key_or_object


		@makeLinkedList= (start_vertex) ->
			start_vertex = @.returnVertexFromKeyOrObject(start_vertex)
			current_vertex = start_vertex
			next_vertex = @.returnVertexFromKeyOrObject(current_vertex.getNext())

			if !start_vertex.getNext()
				console.log 'Careful! This graph only has one vertex linked.' 
				+ 'and that seems pretty silly to me.'

			while next_vertex
				if next_vertex == start_vertex
					current_vertex.setNext(null)
					next_vertex.setPrevious(null)
					console.log "Your linked list is cyclical when it should be linear. " + 
					"Did not link the start and end nodes."
					next_vertex = false
				else 
					@.constructor.link(current_vertex, next_vertex)
					current_vertex = next_vertex
					next_vertex = @.returnVertexFromKeyOrObject(current_vertex.getNext())

		@setReferencesForChildrenThroughoutGraph= () ->
			for key, value of _nodes
				value.setChildrenReferences()

	### class method ###
	@link= (from_vertex, to_vertex) -> 
	#link two vertexes. needs to be passed vertex objects, not just their keys
		from_vertex.setNext(to_vertex)
		to_vertex.setPrevious(from_vertex)

	@dangerousUnlink =(vertex) ->
	#unlink a vertex. needs to be passed a vertex objects, not just its keys
		next = vertex.getNext()
		previous = vertex.getPrevious()

		vertex.setNext(null)
		vertex.setPrevious(null) 

		if next
			next.setPrevious(null)
		if previous
			previous.setNext(null)

	@safeUnlink= (vertex) ->
	#unlink a vertex. needs to be passed a vertex object, not just its keys
		next = vertex.getNext()
		previous = vertex.getPrevious()

		vertex.setNext(null)
		vertex.setPrevious(null)

		if next
			next.setPrevious(previous)
		if previous
			previous.setNext(next)



class telescopicText.Vertex
	constructor: (_name, @content, @children=[], _remain_after_click=false, _next=null, _graph="telescopicDefaultID", _starter=false) ->
		# The @symbol makes attributes public. Omitting the @ makes them private.
		
		# Make the graph, if it doesn't already exist
		# Make the graph attribute a reference
		# Insert node into the graph.
		if not telescopicText.graphs[_graph]
			new telescopicText.Graph(_graph)
		# take graph as string, turn it into a reference to the graph.  
		_graph = telescopicText.graphs[_graph]
		_graph.setNode(_name, @)
	
		@setEdgesToDefault= ->
			@incoming_tree = false;
			@incoming_forward = []
			@incoming_back = []
			@incoming_cross = []
		@setEdgesToDefault()

		### private variables ### 
		_previous = null
		_click_count = 0

		### getters, setters ###
		@getStarter = -> _starter #intentionally, no setter method.
		@getName = -> _name
		@getGraph = -> _graph
		@getNext = -> _next
		@setNext = (newNext) -> 
			_next = newNext
		@getPrevious = -> _previous
		@setPrevious= (newPrevious) ->
			_previous = newPrevious


		### meta information ###
		@getClickCount= -> _click_count
		@getRemainAfterClick = -> _remain_after_click
		@findClicksRemaining = -> 
			### doesn't take _remain_after_click into account, because
				that wouldn't count as a click ### 
			@.children.length - _click_count
		@findIndexOfChildInChildren =(child_vertex)->
			child_index = 0
			for row in children
				for child in row
					if child == child_vertex
						return child_index
				child_index +=1
			false
		
		### visibility information ###
		@shouldBeVisible = ->
			# ### starter case ###
			# if @.children.length == 0
			# 	true
			if @.getStarter() && @.findClicksRemaining() > 0
				true
			else if @.getStarter() && @.getRemainAfterClick()
				true
				### not a starter node ###
			else if @.findClicksRemaining() > 0 && @.incoming_tree
				true
			else if @.incoming_tree && @.getRemainAfterClick()
				true
			else
				false			
		@shouldBeReverseClickable = ->
			### need to check to make sure that parent is on the same click index as the child ###
			if _click_count == 0 &&
					@.shouldBeVisible() && 
					@.incoming_tree && 
					_click_count == 0 &&
					@.incoming_tree.findIndexOfChildInChildren(@) == @.incoming_tree.getClickCount()-1
				return true
			else
				return false


		@forwardDetermineAndSetIncomingEdge= (incoming_vertex)->
			### assumes that incoming_vertex is valid ###
			if !@.incoming_tree and !@.getStarter()
				@.incoming_tree = incoming_vertex
			else if @.determineIfBackEdge(incoming_vertex)
				@.incoming_back.push(incoming_vertex)
			else if @.determineIfForwardEdge(incoming_vertex)
				@.incoming_forward.push(incoming_vertex)
			else
				@.incoming_cross.push(incoming_vertex)
		@determineIfBackEdge = (incoming_vertex) ->
			parent_vertex = incoming_vertex.incoming_tree

			while parent_vertex
				if parent_vertex == @
					return true
				else
					parent_vertex = parent_vertex.incoming_tree
			false
		@determineIfForwardEdge = (incoming_vertex) ->
			parent_vertex = @.incoming_tree

			while parent_vertex
				if parent_vertex == incoming_vertex
					return true
				else
					parent_vertex = parent_vertex.incoming_tree

			false

		### clicking ###
		@forwardClick= ->
			### catch instance in which it shouldn't be clicked ###
			if @.findClicksRemaining() <= 0 or !@shouldBeVisible()
				return @

			relevant_children = @.children[_click_count]
			for child in relevant_children
				child.receiveForwardClick(@)

			_click_count +=1
			@
		@receiveForwardClick= (incoming_vertex)->
			@forwardDetermineAndSetIncomingEdge(incoming_vertex)
			@

		@reverseClick= ->
			if !@shouldBeReverseClickable()
				return @
			@incoming_tree.receiveReverseClickFromChild(@)
			@


		@receiveReverseClickFromChild=(child_vertex)->
			_click_count += -1
			child_index = @findIndexOfChildInChildren(child_vertex)
			for child in @.children[child_index]
				child.receiveReverseClickFromParent(@)
			@

		@receiveReverseClickFromParent= (parent_vertex)->
			if @incoming_tree == parent_vertex
				@setEdgesToDefault()
			@


		@setChildrenReferences= ->
			# can use returnVertexFromKeyOrObject, but at some later point
			set_index = 0
			while set_index < @.children.length
				child_index = 0
				while child_index < @.children[set_index].length
					child_key = @.children[set_index][child_index]
					child = _graph.returnVertexFromKeyOrObject(child_key)  

					if child !instanceof telescopicText.Vertex
						console.log 'The key, "'+ child_key+ '", will be removed from vertex\'s child array.'
						@.children[set_index].splice(child_index,1)

					else
						@.children[set_index][child_index] = child
						child_index +=1
					
				set_index += 1

# create the default graph
telescopicText.reset()

