class Vertex
	constructor: (@name, @content, @children=[[]], @remain_after_click=false ) ->
		@tree_edge
		@forward_edge
		@back_edge
		@cross_edge


prepareVerticies= (key) ->
	children = verticies[key].children

	set_index = 0
	while set_index < children.length
		child_index = 0
		while child_index < children[set_index].length
			child = children[set_index][child_index]
			children[set_index][child_index] = verticies[child]
			child_index +=1
		set_index += 1


		# for child_set in value.children
		# 	console.log child_set
		# 	for child in child_set
		# 		console.log child
		# 		child = verticies[child]
