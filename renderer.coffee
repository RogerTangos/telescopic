# todo:
# Make Vertex part of the class verticies, to allow duplicate texts
# stub out tests
# integrate setVertexChildReferences into Vertex prototype
# integrate makeVerticiesIntoLinkedList into verticies

telescopicText = {}

telescopicText.graphs = {}	#place to store all graphs

telescopicText.reset= ->
	telescopicText.graphs = {}
	new telescopicText.Graph('telescopicDefaultID')

class telescopicText.Graph
	constructor: (name) ->
		telescopicText.graphs[name] = @

		### private ###
		nodes = {}

		###getters, setters###
		@getName = -> name

		@getNode = (key) ->
			node = nodes[key]

			if node == undefined
				console.log 'Graph "' + @.getName() + '" is missing a child, with key "' + key + '."'
			node

		@setNode = (key, value) ->
			nodes[key] = value


		### object-level methods ###

		@returnVertexFromKeyOrObject= (key_or_object) ->
			if key_or_object !instanceof telescopicText.Vertex
				key_or_object = @.getNode(key_or_object)
			else
				key_or_object


		@makeLinkedList= (start_vertex) ->
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
	constructor: (name, @content, @children=[[]], remain_after_click=false, next=null, graph="telescopicDefaultID") ->
		# The @symbol makes attributes public. Omitting the @ makes them private.
		
		# Make the graph, if it doesn't already exist
		# Make the graph attribute a reference
		# Insert node into the graph.
		if not telescopicText.graphs[graph]
			new telescopicText.Graph(graph)
		# take graph as string, turn it into a reference to the graph.  
		graph = telescopicText.graphs[graph]
		graph.setNode(name, @)
	
		@tree_edge
		@forward_edge
		@back_edge
		@cross_edge

		#private
		previous = null

		### getters, setters ###
		@getName = -> name
		@getGraph = -> graph

		@getNext = -> 
				next

		@setNext = (newNext) -> 
			next = newNext
		
		@getPrevious = -> previous
		@setPrevious= (newPrevious) ->
			previous = newPrevious

		@getRemainAfterClick = -> remain_after_click

		@setChildrenReferences= ->
			# can use returnVertexFromKeyOrObject, but at some later point
			set_index = 0
			while set_index < @.children.length
				child_index = 0
				while child_index < @.children[set_index].length
					child_key = @.children[set_index][child_index]
					child = graph.returnVertexFromKeyOrObject(child_key)  

					if child !instanceof telescopicText.Vertex
						console.log 'The key, "'+ child_key+ '", will be removed from vertex\'s child array.'
						@.children[set_index].splice(child_index,1)

					else
						@.children[set_index][child_index] = child
						child_index +=1
					
				set_index += 1

# create the default graph
telescopicText.reset()

