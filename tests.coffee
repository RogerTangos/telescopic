test 'Vertex Class Basics', ->
	vertex_B = new Vertex('B', 'b', null, null)
	vertex_C = new Vertex('C', 'c', null, null)
	vertex_A = new Vertex('A', 'a', null, null)
	vertex_A.children = [[vertex_B], [vertex_C]]

	notEqual(vertex_B.children, null)
	equal(vertex_B.children.length, 1)
	equal(vertex_B.children[0][0], null)

	equal(vertex_A.name, 'A')
	equal(vertex_A.content, 'a')
	equal(vertex_A.showings, 1)
	equal(vertex_A.children.length, 2)
	equal(vertex_A.children[0][0], vertex_B)
	equal(vertex_A.children[1][0], vertex_C)

	equal(vertex_A.tree_edge, null)
	equal(vertex_A.forward_edge, null)
	equal(vertex_A.back_edge, null)
	equal(vertex_A.cross_edge, null)

test 'Vertex Matching'
	equal(verticies['A'].children[0][0], verticies['C'])
	equal(verticies['A'].children[0][1], verticies['B'])

	notEqual(verticies['A'].children[0][0], 'C')
	notEqual(verticies['A'].children[0][1], 'B')