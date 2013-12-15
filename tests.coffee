test 'Verticies have the correct attributes', ->
	# testing name and default attributes
	telescopicText.reset()
	name_vertex = new telescopicText.Vertex('myName', 'myContent', null, null, null, null, null)
	equal(name_vertex.getName(), 'myName')
	equal(name_vertex.content, 'myContent')
	ok(name_vertex.children instanceof Array && name_vertex.children[0] instanceof Array)
	ok(name_vertex.children[0][0] == undefined)
	equal(name_vertex.getRemainAfterClick(),false)
	equal(name_vertex.getNext(),null)
	equal(name_vertex.getGraph().getName(),'telescopicDefaultID')
	equal(name_vertex.findClicksRemaining(), 1)

	equal(name_vertex.incoming_tree, false)
	equal(name_vertex.incoming_forward, false)
	equal(name_vertex.incoming_back, false)
	equal(name_vertex.incoming_cross, false)
	equal(name_vertex.getStarter(), false)
	equal(name_vertex.shouldBeVisible(), true)


	# testing non-default attributes
	telescopicText.reset()
	name_vertex = new telescopicText.Vertex('myName', 'myContent', [['foo'],['bar']], true, 'next', 'newGraphName', true)
	equal(name_vertex.children[0][0],'foo')
	equal(name_vertex.children[1][0],'bar')
	equal(name_vertex.getRemainAfterClick(),true)
	equal(name_vertex.getNext(),'next')
	equal(name_vertex.getGraph().getName(),'newGraphName')
	equal(name_vertex.getStarter(), true)
	equal(name_vertex.shouldBeVisible(), true)



test 'Verticies create the new relevant graph and insert themselves', ->
	# default graph case
	telescopicText.reset()
	foo = new telescopicText.Vertex("foo", null, null, true, null, null)
	equal(telescopicText.graphs['telescopicDefaultID'].getName(),
		'telescopicDefaultID') 
	equal(telescopicText.graphs['telescopicDefaultID'].getNode('foo'),
		foo)

	# named graph case
	telescopicText.reset()
	bar = new telescopicText.Vertex("bar", null, null, true, null, 'myGraph')
	equal(telescopicText.graphs['myGraph'].getName(),
		'myGraph')
	equal(telescopicText.graphs['myGraph'].getNode('bar'),
		bar)

	
test 'vertex.object returnVertexFromKeyOrObject', ->
	telescopicText.reset()
	vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null)
	
	equal(vertex_A.getGraph().returnVertexFromKeyOrObject('A'), vertex_A)
	equal(vertex_A.getGraph().returnVertexFromKeyOrObject(vertex_A), vertex_A)


test 'Vertex.setChildReferences references correct graph, and verticies', ->
	telescopicText.reset()
	vertex_A = new telescopicText.Vertex('A', 'a', [['D'],['B', 'C','nope']], null, 'B', null)
	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
	vertex_C = new telescopicText.Vertex('C', 'c', null, null, null, null)
	vertex_D = new telescopicText.Vertex('D', 'd', null, null, null, null)
	vertex_A.setChildrenReferences()

	# happy path
	equal(vertex_A.children[0][0], vertex_D)
	equal(vertex_A.children[1][0], vertex_B)
	equal(vertex_A.children[1][1], vertex_C)

	# sad path where vertex isn't found
	equal(vertex_A.children[1][2], undefined)

test 'Graph.graph1.setReferencesForChildrenThroughoutGraph sets all child references', ->
	telescopicText.reset()
	vertex_A = new telescopicText.Vertex('A', 'a', [['D'],['B']], null, 'B', null)
	vertex_B = new telescopicText.Vertex('B', 'b', [['C']], true, null, null)
	vertex_C = new telescopicText.Vertex('C', 'c', [['D']], null, null, null)
	vertex_D = new telescopicText.Vertex('D', 'd', null, null, null, null)
	telescopicText.graphs['telescopicDefaultID'].setReferencesForChildrenThroughoutGraph()

	equal(vertex_A.children[0][0], vertex_D)
	equal(vertex_A.children[1][0], vertex_B)
	equal(vertex_B.children[0][0], vertex_C)
	equal(vertex_C.children[0][0], vertex_D)

test 'telescopicText.Graph link', ->
	telescopicText.reset()
	vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null)
	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
	vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null)

	telescopicText.Graph.link(vertex_A, vertex_B)
	equal(vertex_A.getNext(),vertex_B)
	equal(vertex_B.getPrevious(),vertex_A)

	telescopicText.Graph.link(vertex_B, vertex_C)
	equal(vertex_B.getNext(),vertex_C)
	equal(vertex_C.getPrevious(),vertex_B)

test 'telescopicText.Graph dangerousUnlink', ->
	telescopicText.reset()
	vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null)
	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
	vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null)
	telescopicText.Graph.link(vertex_A, vertex_B)
	telescopicText.Graph.link(vertex_B, vertex_C)

	### unlink between nodes ###
	telescopicText.Graph.dangerousUnlink(vertex_B)
	equal(vertex_B.getNext(), null)
	equal(vertex_B.getPrevious(), null)
	equal(vertex_A.getNext(), null)
	equal(vertex_C.getPrevious(), null)

	### unlink end node ###
	telescopicText.reset()
	vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null)
	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
	vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null)
	telescopicText.Graph.link(vertex_A, vertex_B)
	telescopicText.Graph.link(vertex_B, vertex_C)

	telescopicText.Graph.dangerousUnlink(vertex_C)
	equal(vertex_C.getNext(), null)
	equal(vertex_C.getPrevious(), null)
	equal(vertex_B.getNext(), null)
	equal(vertex_B.getPrevious(), vertex_A)

	### unlink start node ###
	telescopicText.reset()
	vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null)
	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
	vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null)
	telescopicText.Graph.link(vertex_A, vertex_B)
	telescopicText.Graph.link(vertex_B, vertex_C)

	telescopicText.Graph.dangerousUnlink(vertex_A)
	equal(vertex_A.getNext(), null)
	equal(vertex_A.getPrevious(), null)
	equal(vertex_B.getNext(), vertex_C)
	equal(vertex_B.getPrevious(), null)

test 'telescopicText.Graph safeUnlink', ->
	### unlink middle node ###
	telescopicText.reset()
	vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null)
	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
	vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null)
	telescopicText.Graph.link(vertex_A, vertex_B)
	telescopicText.Graph.link(vertex_B, vertex_C)

	telescopicText.Graph.safeUnlink(vertex_B)
	equal(vertex_B.getNext(), null)
	equal(vertex_B.getPrevious(), null)
	equal(vertex_A.getNext(),vertex_C)
	equal(vertex_C.getPrevious(),vertex_A)

	### unlink end node ###
	telescopicText.reset()
	vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null)
	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
	vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null)
	telescopicText.Graph.link(vertex_A, vertex_B)
	telescopicText.Graph.link(vertex_B, vertex_C)

	telescopicText.Graph.safeUnlink(vertex_C)
	equal(vertex_C.getNext(), null)
	equal(vertex_C.getPrevious(), null)
	equal(vertex_B.getNext(), null)
	equal(vertex_B.getPrevious(), vertex_A)

	### unlink start node ###
	telescopicText.reset()
	vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null)
	vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null)
	vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null)
	telescopicText.Graph.link(vertex_A, vertex_B)
	telescopicText.Graph.link(vertex_B, vertex_C)

	telescopicText.Graph.safeUnlink(vertex_A)
	equal(vertex_A.getNext(), null)
	equal(vertex_A.getPrevious(), null)
	equal(vertex_B.getNext(), vertex_C)
	equal(vertex_B.getPrevious(), null)


test 'telescopicText.Graph makeLinkedList', ->
	# happy path (one starting node supplied)
	telescopicText.reset()
	vertex_A = new telescopicText.Vertex('A', 'a', null, null, 'B', null)
	vertex_B = new telescopicText.Vertex('B', 'b', null, true, 'C', null)
	vertex_C = new telescopicText.Vertex('C', 'c', null, null, null, null)
	telescopicText.graphs['telescopicDefaultID'].makeLinkedList(vertex_A)

	equal(vertex_A.getNext(),vertex_B)
	equal(vertex_B.getNext(),vertex_C)
	equal(vertex_C.getNext(),null)
	equal(vertex_A.getPrevious(),null)
	equal(vertex_B.getPrevious(),vertex_A)
	equal(vertex_C.getPrevious(),vertex_B)


	# Sad path - infinite unary loop
	telescopicText.reset()
	vertex_A = new telescopicText.Vertex('A', 'a', null, null, 'A', null)
	telescopicText.graphs['telescopicDefaultID'].makeLinkedList(vertex_A)
	equal(vertex_A.getNext(),null)
	equal(vertex_A.getPrevious(), null)

	# Sad path - infinite long loop
	telescopicText.reset()
	vertex_A = new telescopicText.Vertex('A', 'a', null, null, 'B', null)
	vertex_B = new telescopicText.Vertex('B', 'b', null, true, 'C', null)
	vertex_C = new telescopicText.Vertex('C', 'c', null, null, 'A', null)
	
	telescopicText.graphs['telescopicDefaultID'].makeLinkedList(vertex_A)
	equal(vertex_C.getNext(),null)
	equal(vertex_A.getNext(),vertex_B)

# test 'create a tree edge', ->



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

