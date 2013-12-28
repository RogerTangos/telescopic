// Generated by CoffeeScript 1.6.3
var makeDefaultVertex1, makeDefaultVertex2;

test('graphs generate on reset', function() {
  telescopicText.reset();
  return ok(telescopicText.graphs['telescopicDefaultID']);
});

test('Verticies public spec attributes inc. edges are visible', function() {
  var nameVertex;
  telescopicText.reset();
  nameVertex = makeDefaultVertex1();
  equal(nameVertex.content, 'myContent');
  equal(nameVertex.incomingTree, false);
  equal(nameVertex.incomingForward[0], void 0);
  equal(nameVertex.incomingBack[0], void 0);
  return equal(nameVertex.incomingCross[0], void 0);
});

test('Verticies private spec attributes have getters and setters', function() {
  var nameVertex;
  telescopicText.reset();
  nameVertex = makeDefaultVertex1();
  equal(nameVertex.getName(), 'myName');
  equal(nameVertex.getRemainAfterClick(), true);
  equal(nameVertex.getNext(), true);
  nameVertex.setNext(false);
  equal(nameVertex.getNext(), false);
  equal(nameVertex.getStarter(), true);
  return ok(nameVertex.getChildren() instanceof Array);
});

test('Vertex attributes default correctly.', function() {
  var nameVertex;
  telescopicText.reset();
  nameVertex = makeDefaultVertex2();
  ok(nameVertex.getChildren() instanceof Array);
  equal(nameVertex.getChildren()[0], void 0);
  equal(nameVertex.getRemainAfterClick(), false);
  equal(nameVertex.getGraph(), telescopicText.graphs['telescopicDefaultID']);
  return equal(nameVertex.getStarter(), false);
});

test('graph can get nodes from key or object', function() {
  telescopicText.reset();
  makeTestVerticies();
  equal(vertexA.getGraph().getNode('A'), vertexA);
  return equal(vertexA.getGraph().getNode(vertexA), vertexA);
});

test('graph default characteristics', function() {
  var newGraph;
  newGraph = telescopicText.graph();
  equal(newGraph.getName(), 'telescopicDefaultID');
  return equal(newGraph.getNode('foo'), void 0);
});

makeDefaultVertex1 = function() {
  var nameVertexSpec;
  nameVertexSpec = {
    _name: 'myName',
    content: 'myContent',
    _children: [],
    _remainAfterClick: true,
    _next: true,
    _graph: 'defaultID2',
    _starter: true
  };
  return telescopicText.vertex(nameVertexSpec);
};

makeDefaultVertex2 = function() {
  var nameVertexSpec;
  nameVertexSpec = {
    _name: 'myName',
    content: 'myContent',
    _next: true
  };
  return telescopicText.vertex(nameVertexSpec);
};
