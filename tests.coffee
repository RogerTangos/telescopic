test 'Vertex Attribute Basics', ->
	vertex_B = new Vertex('B', 'b', null, true, 'D')
	vertex_C = new Vertex('C', 'c', null, null, 'G')
	vertex_A = new Vertex('A', 'a', null, null, 'B')
	vertex_A.children = [[vertex_B], [vertex_C]]

	notEqual(vertex_B.children, null)
	equal(vertex_B.children.length, 1)
	equal(vertex_B.children[0][0], null)
	equal(vertex_B.remain_after_click, true)

	equal(vertex_A.name, 'A')
	equal(vertex_A.content, 'a')
	equal(vertex_A.remain_after_click, false)
	equal(vertex_A.children.length, 2)
	equal(vertex_A.children[0][0], vertex_B)
	equal(vertex_A.children[1][0], vertex_C)

	equal(vertex_A.tree_edge, null)
	equal(vertex_A.forward_edge, null)
	equal(vertex_A.back_edge, null)
	equal(vertex_A.cross_edge, null)

	equal(vertex_A.next, 'B')
	equal(vertex_B.next, 'D')
	equal(vertex_C.next, 'G')

test 'Modify JSON verticies\' children so that they are pointers', ->
	setVertexChildReferences('A')

	equal(verticies['A'].children[0][0], verticies['C'])
	equal(verticies['A'].children[0][1], verticies['B'])

	notEqual(verticies['A'].children[0][0], 'C')
	notEqual(verticies['A'].children[0][1], 'B')

test 'Modify all JSON verticies so that they form a linked list', ->
	makeVerticiesIntoLinkedList('A')

	equal(verticies['A'].next, verticies['B'])
	equal(verticies['B'].next, verticies['D'])
	
	equal(verticies['A'].previous, null)
	equal(verticies['B'].previous, verticies['A'])

	navigation_order = ''
	current_vertex = verticies['A'] 
	while current_vertex? 
		navigation_order = navigation_order.concat(current_vertex.content)
		current_vertex = current_vertex.next
	equal(navigation_order, 'abdgcehfivjuklmnopqrst')


test 'Verticies can be unlinked', ->
	verticies['A'].unlink()
	
	equal(verticies['A'].next, null)
	equal(verticies['A'].previous, null)

	equal(verticies['B'].previous, null)
	equal(verticies['B'].next, verticies['D'])

	verticies['E'].unlink
	equal(verticies['C'].next, verticies['H'])
	equal(verticies['H'].previous, verticies['C'])
	equal(verticies['E'].next, null)
	equal(verticies['E'].previous, null)

# test 'Verticies can be linked', ->
	# true

# test 'TText Method Basics', ->
	# shouldhave

	# reveal text
	# hide text
