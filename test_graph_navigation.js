// Generated by CoffeeScript 1.6.3
var graphPatternOne;

test('find clicks remaining on unclickable link', function() {
  var vertexX;
  telescopicText.reset();
  vertexX = telescopicText.vertex({});
  equal(vertexX.getClickCount(), 0);
  return equal(vertexX.findClicksRemaining(), 0);
});

test('forward click a node, vertexA. Test vertexA visibility and clicks remaining', function() {
  var graph1;
  telescopicText.reset();
  graph1 = makeTestVerticies().setGraphChildReferences();
  equal(vertexA.findClicksRemaining(), 1);
  vertexA.forwardClick();
  equal(vertexA.findClicksRemaining(), 0);
  return equal(vertexA.shouldBeVisible(), false);
});

test('make sure hidden nodes give correct visibility.', function() {
  var graph1;
  telescopicText.reset();
  graph1 = makeTestVerticies().setGraphChildReferences();
  equal(vertexC.shouldBeVisible(), false);
  return equal(vertexK.shouldBeVisible(), false);
});

test('determine and record incoming tree edges', function() {
  var graph1;
  telescopicText.reset();
  graph1 = makeTestVerticies().setGraphChildReferences();
  /* tree edges*/

  vertexB.forwardDetermineAndSetIncomingEdge(vertexA);
  equal(vertexB.incomingTree, vertexA);
  equal(vertexB.incomingForward, false);
  equal(vertexB.incomingBack, false);
  equal(vertexB.incomingCross, false);
  vertexC.forwardDetermineAndSetIncomingEdge(vertexA);
  equal(vertexC.incomingTree, vertexA);
  equal(vertexC.incomingForward, false);
  equal(vertexC.incomingBack, false);
  return equal(vertexC.incomingCross, false);
});

test('determine and record cross and back edges', function() {
  var graph1;
  telescopicText.reset();
  graph1 = makeTestVerticies().setGraphChildReferences();
  vertexB.forwardDetermineAndSetIncomingEdge(vertexA);
  vertexC.forwardDetermineAndSetIncomingEdge(vertexA);
  /* cross edge*/

  vertexC.forwardDetermineAndSetIncomingEdge(vertexB);
  equal(vertexC.incomingTree, vertexA);
  equal(vertexC.incomingCross[0], vertexB);
  equal(vertexC.incomingBack[0], void 0);
  equal(vertexC.incomingForward[0], void 0);
  /* back edge*/

  vertexA.forwardDetermineAndSetIncomingEdge(vertexC);
  equal(vertexA.incomingBack[0], vertexC);
  equal(vertexA.incomingTree[0], void 0);
  equal(vertexA.incomingForward[0], void 0);
  return equal(vertexA.incomingTree, false);
});

test('determine and record forward edges', function() {
  var graph1;
  telescopicText.reset();
  graph1 = makeTestVerticies().setGraphChildReferences();
  vertexQ.incomingTree = vertexJ;
  vertexJ.incomingTree = vertexE;
  vertexE.incomingTree = vertexD;
  vertexQ.forwardDetermineAndSetIncomingEdge(vertexE);
  equal(vertexQ.incomingTree, vertexJ);
  equal(vertexQ.incomingBack.length, 0);
  equal(vertexQ.incomingCross.length, 0);
  return equal(vertexQ.incomingForward[0], vertexE);
});

test('forward click a nodes A, B, C. test edge matching.', function() {
  var graph1;
  telescopicText.reset();
  graph1 = makeTestVerticies().setGraphChildReferences();
  vertexA.forwardClick();
  equal(vertexB.incomingTree, vertexA);
  equal(vertexC.incomingTree, vertexA);
  vertexB.forwardClick();
  equal(vertexC.incomingCross[0], vertexB);
  equal(vertexK.incomingTree, vertexB);
  vertexC.forwardClick();
  equal(vertexA.incomingBack[0], vertexC);
  equal(vertexF.incomingTree, vertexC);
  telescopicText.reset();
  graph1 = makeTestVerticies().setGraphChildReferences();
  vertexD.forwardClick();
  equal(vertexE.incomingTree, vertexD);
  vertexE.forwardClick();
  equal(vertexJ.incomingTree, vertexE);
  vertexJ.forwardClick();
  equal(vertexQ.incomingTree, vertexJ);
  vertexE.forwardClick();
  return equal(vertexQ.incomingForward[0], vertexE);
});

test('visibility when forward clicking', function() {
  var graph1;
  telescopicText.reset();
  graph1 = makeTestVerticies().setGraphChildReferences();
  ok(!vertexB.shouldBeVisible() && !vertexC.shouldBeVisible() && !vertexK.shouldBeVisible() && !vertexF.shouldBeVisible());
  /* happy path. vertexA "clicked" while visible*/

  vertexA.forwardClick();
  ok(vertexB.shouldBeVisible() && vertexC.shouldBeVisible());
  ok(!vertexA.shouldBeVisible() && !vertexK.shouldBeVisible() && !vertexF.shouldBeVisible());
  /* sad path. vertexA "clicked" while it should be invisible*/

  vertexA.forwardClick();
  ok(vertexB.shouldBeVisible() && vertexC.shouldBeVisible());
  ok(!vertexA.shouldBeVisible() && !vertexK.shouldBeVisible() && !vertexF.shouldBeVisible() && !vertexL.shouldBeVisible());
  /*sad path. vertexL "clicked" while it should be invisible*/

  vertexL.forwardClick();
  ok(vertexB.shouldBeVisible() && vertexC.shouldBeVisible());
  ok(!vertexA.shouldBeVisible() && !vertexK.shouldBeVisible() && !vertexF.shouldBeVisible() && !vertexL.shouldBeVisible());
  vertexB.forwardClick();
  ok(vertexK.shouldBeVisible(), vertexC.shouldBeVisible());
  ok(!vertexA.shouldBeVisible() && !vertexB.shouldBeVisible() && !vertexF.shouldBeVisible() && !vertexL.shouldBeVisible());
  /* test case for vertex with multiple sets of children*/

  vertexC.forwardClick();
  ok(vertexC.shouldBeVisible() && vertexF.shouldBeVisible());
  ok(!vertexA.shouldBeVisible() && !vertexB.shouldBeVisible() && !vertexL.shouldBeVisible());
  /* test set [1] of children and _remain_after_click*/

  vertexC.forwardClick();
  ok(vertexC.shouldBeVisible() && vertexF.shouldBeVisible() && vertexL.shouldBeVisible());
  return ok(!vertexA.shouldBeVisible() && !vertexB.shouldBeVisible());
});

test('find index of child in children', function() {
  var graph1;
  graph1 = makeTestVerticies().setGraphChildReferences();
  graphPatternOne();
  equal(vertexC.findIndexOfChildInChildren(vertexL), 1);
  equal(vertexC.findIndexOfChildInChildren(vertexF), 0);
  return equal(vertexA.findIndexOfChildInChildren(vertexC), 0);
});

test('determine elibility for reverseClick', function() {
  var graph1;
  graph1 = makeTestVerticies().setGraphChildReferences();
  graphPatternOne();
  ok(vertexL.shouldBeReverseClickable() && vertexK.shouldBeReverseClickable);
  return ok(!vertexF.shouldBeReverseClickable() && !vertexC.shouldBeReverseClickable() && !vertexA.shouldBeReverseClickable() && !vertexB.shouldBeReverseClickable() && !vertexA.shouldBeReverseClickable());
});

test('reverse click', function() {
  var graph1;
  graph1 = makeTestVerticies().setGraphChildReferences();
  graphPatternOne();
  /* sad path. vertexF should not be clickable.*/

  vertexF.reverseClick();
  ok(vertexF.shouldBeVisible() && vertexL.shouldBeVisible() && vertexC.shouldBeVisible() && vertexK.shouldBeVisible());
  ok(!vertexB.shouldBeVisible() && !vertexA.shouldBeVisible());
  /* happy path. vertexL should be clickable*/

  vertexL.reverseClick();
  ok(vertexC.shouldBeVisible() && vertexF.shouldBeVisible() && vertexK.shouldBeVisible());
  return ok(!vertexA.shouldBeVisible() && !vertexB.shouldBeVisible() && !vertexL.shouldBeVisible());
});

/* helper function*/


graphPatternOne = function() {
  vertexA.forwardClick();
  vertexB.forwardClick();
  vertexC.forwardClick();
  return vertexC.forwardClick();
};
