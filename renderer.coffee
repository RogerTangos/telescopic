class Vertex
	constructor: (@name, @content, @children=[[]], @remain_after_click=false, @next) ->
		@tree_edge
		@forward_edge
		@back_edge
		@cross_edge

	unlink: ->
		console.log 'unlink called'
		current_previous = @.previous
		current_next = @.next

		if @.previous?
			current_previous.next = @.current_next

		if @.next?
			current_next.previous = @.current_previous
			
		@.next = null
		@.previous = null


setVertexChildReferences= (key) ->
	children = verticies[key].children

	set_index = 0
	while set_index < children.length
		child_index = 0
		while child_index < children[set_index].length
			child = children[set_index][child_index]
			children[set_index][child_index] = verticies[child]
			child_index +=1
		set_index += 1

makeVerticiesIntoLinkedList= (start_key) ->
	next_vertex_available = true
	previous_vertex = null
	current_vertex = verticies[start_key]

	while next_vertex_available
		next_key = current_vertex.next
		if next_key?
			current_vertex.next = verticies[next_key]
			current_vertex.previous = previous_vertex

			previous_vertex = current_vertex
			current_vertex = verticies[next_key]
		else
			next_vertex_available = false

	null
