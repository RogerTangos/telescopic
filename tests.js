// Generated by CoffeeScript 1.6.3
test('Verticies have the correct default attributes', function() {
  var name_vertex;
  telescopicText.reset();
  name_vertex = new telescopicText.Vertex('myName', 'myContent', null, null, null, null, null);
  equal(name_vertex.getName(), 'myName');
  equal(name_vertex.content, 'myContent');
  ok(name_vertex.children instanceof Array);
  ok(name_vertex.children[0] === void 0);
  equal(name_vertex.getRemainAfterClick(), false);
  equal(name_vertex.getNext(), null);
  equal(name_vertex.getGraph().getName(), 'telescopicDefaultID');
  equal(name_vertex.incoming_tree, false);
  equal(name_vertex.incoming_forward[0], void 0);
  equal(name_vertex.incoming_back[0], void 0);
  equal(name_vertex.incoming_cross[0], void 0);
  equal(name_vertex.getStarter(), false);
  return equal(name_vertex.shouldBeVisible(), true);
});

test('Verticies have correct non-default attributes', function() {
  var name_vertex;
  telescopicText.reset();
  name_vertex = new telescopicText.Vertex('myName', 'myContent', [['foo'], ['bar']], true, 'next', 'newGraphName', true);
  equal(name_vertex.children[0][0], 'foo');
  equal(name_vertex.children[1][0], 'bar');
  equal(name_vertex.getRemainAfterClick(), true);
  equal(name_vertex.getNext(), 'next');
  equal(name_vertex.getGraph().getName(), 'newGraphName');
  equal(name_vertex.getStarter(), true);
  return equal(name_vertex.shouldBeVisible(), true);
});

test('Verticies create the new relevant graph and insert themselves', function() {
  var bar, foo;
  telescopicText.reset();
  foo = new telescopicText.Vertex("foo", null, null, true, null, null);
  equal(telescopicText.graphs['telescopicDefaultID'].getName(), 'telescopicDefaultID');
  equal(telescopicText.graphs['telescopicDefaultID'].getNode('foo'), foo);
  telescopicText.reset();
  bar = new telescopicText.Vertex("bar", null, null, true, null, 'myGraph');
  equal(telescopicText.graphs['myGraph'].getName(), 'myGraph');
  return equal(telescopicText.graphs['myGraph'].getNode('bar'), bar);
});

test('vertex.object returnVertexFromKeyOrObject', function() {
  var vertex_A;
  telescopicText.reset();
  vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null);
  equal(vertex_A.getGraph().returnVertexFromKeyOrObject('A'), vertex_A);
  return equal(vertex_A.getGraph().returnVertexFromKeyOrObject(vertex_A), vertex_A);
});

test('Vertex.setChildReferences references correct graph, and verticies', function() {
  var vertex_A, vertex_B, vertex_C, vertex_D;
  telescopicText.reset();
  vertex_A = new telescopicText.Vertex('A', 'a', [['D'], ['B', 'C', 'nope']], null, 'B', null);
  vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null);
  vertex_C = new telescopicText.Vertex('C', 'c', null, null, null, null);
  vertex_D = new telescopicText.Vertex('D', 'd', null, null, null, null);
  vertex_A.setChildrenReferences();
  equal(vertex_A.children[0][0], vertex_D);
  equal(vertex_A.children[1][0], vertex_B);
  equal(vertex_A.children[1][1], vertex_C);
  return equal(vertex_A.children[1][2], void 0);
});

test('Graph.graph1.setReferencesForChildrenThroughoutGraph sets all child references', function() {
  var vertex_A, vertex_B, vertex_C, vertex_D;
  telescopicText.reset();
  vertex_A = new telescopicText.Vertex('A', 'a', [['D'], ['B']], null, 'B', null);
  vertex_B = new telescopicText.Vertex('B', 'b', [['C']], true, null, null);
  vertex_C = new telescopicText.Vertex('C', 'c', [['D']], null, null, null);
  vertex_D = new telescopicText.Vertex('D', 'd', null, null, null, null);
  telescopicText.graphs['telescopicDefaultID'].setReferencesForChildrenThroughoutGraph();
  equal(vertex_A.children[0][0], vertex_D);
  equal(vertex_A.children[1][0], vertex_B);
  equal(vertex_B.children[0][0], vertex_C);
  return equal(vertex_C.children[0][0], vertex_D);
});

test('telescopicText.Graph link', function() {
  var vertex_A, vertex_B, vertex_C;
  telescopicText.reset();
  vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null);
  vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null);
  vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null);
  telescopicText.Graph.link(vertex_A, vertex_B);
  equal(vertex_A.getNext(), vertex_B);
  equal(vertex_B.getPrevious(), vertex_A);
  telescopicText.Graph.link(vertex_B, vertex_C);
  equal(vertex_B.getNext(), vertex_C);
  return equal(vertex_C.getPrevious(), vertex_B);
});

test('telescopicText.Graph dangerousUnlink', function() {
  var vertex_A, vertex_B, vertex_C;
  telescopicText.reset();
  vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null);
  vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null);
  vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null);
  telescopicText.Graph.link(vertex_A, vertex_B);
  telescopicText.Graph.link(vertex_B, vertex_C);
  /* unlink between nodes*/

  telescopicText.Graph.dangerousUnlink(vertex_B);
  equal(vertex_B.getNext(), null);
  equal(vertex_B.getPrevious(), null);
  equal(vertex_A.getNext(), null);
  equal(vertex_C.getPrevious(), null);
  /* unlink end node*/

  telescopicText.reset();
  vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null);
  vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null);
  vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null);
  telescopicText.Graph.link(vertex_A, vertex_B);
  telescopicText.Graph.link(vertex_B, vertex_C);
  telescopicText.Graph.dangerousUnlink(vertex_C);
  equal(vertex_C.getNext(), null);
  equal(vertex_C.getPrevious(), null);
  equal(vertex_B.getNext(), null);
  equal(vertex_B.getPrevious(), vertex_A);
  /* unlink start node*/

  telescopicText.reset();
  vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null);
  vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null);
  vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null);
  telescopicText.Graph.link(vertex_A, vertex_B);
  telescopicText.Graph.link(vertex_B, vertex_C);
  telescopicText.Graph.dangerousUnlink(vertex_A);
  equal(vertex_A.getNext(), null);
  equal(vertex_A.getPrevious(), null);
  equal(vertex_B.getNext(), vertex_C);
  return equal(vertex_B.getPrevious(), null);
});

test('telescopicText.Graph safeUnlink', function() {
  /* unlink middle node*/

  var vertex_A, vertex_B, vertex_C;
  telescopicText.reset();
  vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null);
  vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null);
  vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null);
  telescopicText.Graph.link(vertex_A, vertex_B);
  telescopicText.Graph.link(vertex_B, vertex_C);
  telescopicText.Graph.safeUnlink(vertex_B);
  equal(vertex_B.getNext(), null);
  equal(vertex_B.getPrevious(), null);
  equal(vertex_A.getNext(), vertex_C);
  equal(vertex_C.getPrevious(), vertex_A);
  /* unlink end node*/

  telescopicText.reset();
  vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null);
  vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null);
  vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null);
  telescopicText.Graph.link(vertex_A, vertex_B);
  telescopicText.Graph.link(vertex_B, vertex_C);
  telescopicText.Graph.safeUnlink(vertex_C);
  equal(vertex_C.getNext(), null);
  equal(vertex_C.getPrevious(), null);
  equal(vertex_B.getNext(), null);
  equal(vertex_B.getPrevious(), vertex_A);
  /* unlink start node*/

  telescopicText.reset();
  vertex_A = new telescopicText.Vertex('A', 'a', null, null, null, null);
  vertex_B = new telescopicText.Vertex('B', 'b', null, true, null, null);
  vertex_C = new telescopicText.Vertex('C', 'c', null, true, null, null);
  telescopicText.Graph.link(vertex_A, vertex_B);
  telescopicText.Graph.link(vertex_B, vertex_C);
  telescopicText.Graph.safeUnlink(vertex_A);
  equal(vertex_A.getNext(), null);
  equal(vertex_A.getPrevious(), null);
  equal(vertex_B.getNext(), vertex_C);
  return equal(vertex_B.getPrevious(), null);
});

test('telescopicText.Graph makeLinkedList', function() {
  var vertex_A, vertex_B, vertex_C;
  telescopicText.reset();
  vertex_A = new telescopicText.Vertex('A', 'a', null, null, 'B', null);
  vertex_B = new telescopicText.Vertex('B', 'b', null, true, 'C', null);
  vertex_C = new telescopicText.Vertex('C', 'c', null, null, null, null);
  telescopicText.graphs['telescopicDefaultID'].makeLinkedList(vertex_A);
  equal(vertex_A.getNext(), vertex_B);
  equal(vertex_B.getNext(), vertex_C);
  equal(vertex_C.getNext(), null);
  equal(vertex_A.getPrevious(), null);
  equal(vertex_B.getPrevious(), vertex_A);
  equal(vertex_C.getPrevious(), vertex_B);
  telescopicText.reset();
  vertex_A = new telescopicText.Vertex('A', 'a', null, null, 'A', null);
  telescopicText.graphs['telescopicDefaultID'].makeLinkedList(vertex_A);
  equal(vertex_A.getNext(), null);
  equal(vertex_A.getPrevious(), null);
  telescopicText.reset();
  vertex_A = new telescopicText.Vertex('A', 'a', null, null, 'B', null);
  vertex_B = new telescopicText.Vertex('B', 'b', null, true, 'C', null);
  vertex_C = new telescopicText.Vertex('C', 'c', null, null, 'A', null);
  telescopicText.graphs['telescopicDefaultID'].makeLinkedList(vertex_A);
  equal(vertex_C.getNext(), null);
  return equal(vertex_A.getNext(), vertex_B);
});
