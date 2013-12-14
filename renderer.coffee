# todo:
# Make Vertex part of the class verticies, to allow duplicate texts
# stub out tests
# integrate setVertexChildReferences into Vertex prototype
# integrate makeVerticiesIntoLinkedList into verticies

telescopicText = {}

telescopicText.graphs = {}	#place to store all graphs

class telescopicText.Graph
	constructor: (name) ->
		telescopicText.graphs[name] = @

		### private ###
		nodes = {}

		###getters, setters###
		@getName = -> name

		@getNode = (key) ->
			nodes[key]

		@setNode = (key, value) ->
			nodes[key] = value


		### class method###
		@makeLinkedList= (startVertex) ->
			if !startVertex
				for key, value of nodes
					console.log 'key: ' + key  + 'bar'

			current_vertex = startVertex
			if !startVertex.getNext()
				console.log 'Warning: This graph only has one vertex linked'

			while current_vertex.getNext()
				next_key = current_vertex.getNext()
				next_vertex = @.getNode(next_key)
				current_vertex.setNext(next_vertex)
				current_vertex = next_vertex

			
	
	# current_vertex = verticies[start_key]

	# while next_vertex_available
	# 	next_key = current_vertex.next
	# 	if next_key?
	# 		current_vertex.next = verticies[next_key]
	# 		current_vertex.previous = previous_vertex

	# 		previous_vertex = current_vertex
	# 		current_vertex = verticies[next_key]
	# 	else
	# 		next_vertex_available = false




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

		@getNext = -> next
		@setNext = (newNext) -> 
			next = newNext
		
		@getPrevious = -> previous



		@getRemainAfterClick = -> remain_after_click

		@setChildrenReferences= ->
			set_index = 0
			while set_index < @.children.length
				child_index = 0
				while child_index < @.children[set_index].length
					child = @.children[set_index][child_index]

					if !graph.getNode(child)
						missing_child = @.children[set_index][child_index]
						console.log 'Vertex ' + @.name + ' in graph "' + graph.getName() + '" is missing a child, "' + missing_child + '". It will be removed from the vertex children.'
						@.children[set_index].splice(child_index,1)

					else
						@.children[set_index][child_index] = graph.getNode(child)
						child_index +=1
					
				set_index += 1

# create the default graph
new telescopicText.Graph('telescopicDefaultID')


	# unlink: ->
	# 	# careful with this function. If you unlink a node, you also make
	# 	# its edges unavailable to the user... so its children may never
	# 	# be reached.
	# 	current_previous = @.previous
	# 	current_next = @.next

	# 	if @.previous?
	# 		current_previous.next = @.current_next

	# 	if @.next?
	# 		current_next.previous = @.current_previous
			
	# 	@.next = null
	# 	@.previous = null

	# link: (after, before)->



# makeVerticiesIntoLinkedList= (start_key) ->
# 	next_vertex_available = true
# 	previous_vertex = null
# 	current_vertex = verticies[start_key]

# 	while next_vertex_available
# 		next_key = current_vertex.next
# 		if next_key?
# 			current_vertex.next = verticies[next_key]
# 			current_vertex.previous = previous_vertex

# 			previous_vertex = current_vertex
# 			current_vertex = verticies[next_key]
# 		else
# 			next_vertex_available = false

# 	null
