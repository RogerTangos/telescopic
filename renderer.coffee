class Vertex
	constructor: (@name, @content, @children, @repeatability=1) ->
		@tree_edge
		@forward_edge
		@back_edge
		@cross_edge
		


test 'Vertex Basics', ->
	vertex_B = new Vertex('B', 'b', null, null)
	vertex_C = new Vertex('C', 'c', null, null)
	vertex_A = new Vertex('A', 'a', null, null)
	vertex_A.children = [[vertex_B], [vertex_C]]

	equal(vertex_A.name, 'A')
	equal(vertex_A.content, 'a')
	equal(vertex_A.repeatability, 1)
	equal(vertex_A.children.length, 2)
	equal(vertex_A.children[0][0], vertex_B)
	equal(vertex_A.children[1][0], vertex_C)