test 'Verticies have the correct attributes', ->
	# testing name and default attributes
	name_vertex = new telescopicText.Vertex('myName', 'myContent', null, null, null, null)
	equal(name_vertex.getName(), 'myName')
	equal(name_vertex.content, 'myContent')
	ok(name_vertex.children instanceof Array && name_vertex.children[0] instanceof Array)
	ok(name_vertex.children[0][0] == undefined)
	equal(name_vertex.getRemainAfterClick(),false)
	equal(name_vertex.getNext(),null)
	equal(name_vertex.getGraph().getName(),'telescopicDefaultID')

	equal(name_vertex.tree_edge, null)
	equal(name_vertex.forward_edge, null)
	equal(name_vertex.back_edge, null)
	equal(name_vertex.cross_edge, null)

	# testing non-default attributes
	name_vertex = new telescopicText.Vertex('myName', 'myContent', [['foo'],['bar']], true, 'next', 'newGraphName')
	equal(name_vertex.children[0][0],'foo')
	equal(name_vertex.children[1][0],'bar')
	equal(name_vertex.getRemainAfterClick(),true)
	equal(name_vertex.getNext(),'next')
	equal(name_vertex.getGraph().getName(),'newGraphName')


test 'Verticies create the new relevant graph and insert themselves', ->
	# default graph case
	foo = new telescopicText.Vertex("foo", null, null, true, null, null)
	equal(telescopicText.graphs['telescopicDefaultID'].getName(),
		'telescopicDefaultID') 
	equal(telescopicText.graphs['telescopicDefaultID']['foo'],
		foo)

	# named graph case
	bar = new telescopicText.Vertex("bar", null, null, true, null, 'myGraph')
	equal(telescopicText.graphs['myGraph'].getName(),
		'myGraph')
	equal(telescopicText.graphs['myGraph']['bar'],
		bar)


test 'Vertex.setChildReferences references correct graph, and verticies', ->
	vertex_A = new telescopicText.Vertex('A', 'a', [['D'],['B', 'C','nope']], null, 'B', null)
	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
	vertex_C = new telescopicText.Vertex('C', 'c', null, null, null, null)
	vertex_D = new telescopicText.Vertex('D', 'd', null, null, null, null)
	vertex_A.setChildrenReferences()

	# happy path
	equal(vertex_A.children[0][0], vertex_D)
	equal(vertex_A.children[1][0], vertex_B)
	equal(vertex_A.children[1][1], vertex_C)

	# sad path
	equal(vertex_A.children[1][2], undefined)


# test 'Modify all JSON verticies so that they form a linked list', ->
	# telescopicText.graphs['telescopicDefaultID'].makeLinkedListStartingAt()


# 	makeVerticiesIntoLinkedList('A')

# 	equal(verticies['A'].next, verticies['B'])
# 	equal(verticies['B'].next, verticies['D'])
	
# 	equal(verticies['A'].previous, null)
# 	equal(verticies['B'].previous, verticies['A'])

# 	navigation_order = ''
# 	current_vertex = verticies['A'] 
# 	while current_vertex? 
# 		navigation_order = navigation_order.concat(current_vertex.content)
# 		current_vertex = current_vertex.next

# 	equal(navigation_order, 'abdgcehfivjuklmnopqrst')


# test 'Verticies can be unlinked', ->
# 	makeTestVerticies()
# 	makeVerticiesIntoLinkedList('A')

# 	verticies['A'].unlink()

# 	equal(verticies['A'].next, null)
# 	equal(verticies['A'].previous, null)

# 	equal(verticies['B'].previous, null)
# 	equal(verticies['B'].next, verticies['D'])

# 	verticies['E'].unlink
# 	equal(verticies['C'].next, verticies['H'])
# 	equal(verticies['H'].previous, verticies['C'])
# 	equal(verticies['E'].next, null)
# 	equal(verticies['E'].previous, null)
	
# test 'Verticies can be linked', ->
# 	makeTestVerticies()
# 	makeVerticiesIntoLinkedList('A')
# 	# need to call verticies can be unlinked before this works.
# 	verticies['A'] = new Vertex('A', 'a', [['C','B']], 1, 'B')
# 	verticies['A'].link()
# 	equal(verticies['A'].next, verticies['B'])
# 	equal(verticies['A'].previous, null)
# 	equal(verticies['B'].next, verticies['D'])
# 	equal(verticies['B'].previous, verticies['A'])

# 	verticies['E'] = new Vertex('E', 'e', [['F', 'J', 'I', 'H'], ['Q']], 1, 'H');
# 	verticies['E'].link
# 	equal(verticies['E'].next, verticies['H'])
# 	equal(verticies['E'].previous, verticies['C'])
# 	equal(verticies['C'].next, verticies['E'])
# 	equal(verticies['H'].previous, verticies['E'])



	# true

# test 'TText Method Basics', ->
	# shouldhave

	# reveal text
	# hide text

# attempting to make a stub:
# Had trouble assigning a prototype method to an object.
	# create a fake vertex to test
	# fake_vertex = {'name':'E', 'children':[['F'],['G','H']]}
	# fake_vertex.setChildrenReferences = telescopicText.Vertex.setChildrenReferences
	# telescopicText.graphs['telescopicDefaultID']['E']='eep'
	# telescopicText.graphs['telescopicDefaultID']['F']='fff'
	# telescopicText.graphs['telescopicDefaultID']['G']='gah'
	# telescopicText.graphs['telescopicDefaultID']['G']='huh'

	# fake_vertex.setChildrenReferences()
	# equal(fake_vertex.children[0][0], 'fff')
	# equal(fake_vertex.children[1][0], 'gah')
	# equal(fake_vertex.children[1][1], 'huh')

