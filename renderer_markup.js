// Generated by CoffeeScript 1.6.3
telescopicText.markup = function(spec) {
  var that;
  that = telescopicText.vertex(spec);
  spec._wraps = {};
  /* overridden*/

  that.getRemainAfterClick = function() {
    return true;
  };
  that.forwardClick = void 0;
  that.reverseClick = void 0;
  /* public methods*/

  that.getWraps = function() {
    return spec._wraps;
  };
  that.createStartListForChildren = function(childSetIndex) {
    var child, nodeDict, previous, set, _i, _j, _len, _len1;
    set = spec._children[childSetIndex];
    nodeDict = {};
    for (_i = 0, _len = set.length; _i < _len; _i++) {
      child = set[_i];
      nodeDict[child.getName()] = true;
    }
    for (_j = 0, _len1 = set.length; _j < _len1; _j++) {
      child = set[_j];
      previous = nodeDict[child.getPrevious().getName()];
      if (previous !== void 0) {
        nodeDict[child.getName()] = false;
      }
    }
    return nodeDict;
  };
  /* forward clicks*/

  that.receiveForwardClick = function(incomingVertex) {
    var child, key, linkArray, next, nodeDict, set, value, wrapArray, _i, _j, _len, _len1;
    spec._wraps[incomingVertex] = [];
    wrapArray = spec._wraps[incomingVertex];
    set = spec._children[spec._clickCount];
    nodeDict = {};
    /* make dict using vertex names. verticies are true
    		 	if they start a link  or are alone. 
    		 	false if they are linked later.
    */

    for (_i = 0, _len = set.length; _i < _len; _i++) {
      child = set[_i];
      nodeDict[child.getName()] = true;
    }
    for (_j = 0, _len1 = set.length; _j < _len1; _j++) {
      child = set[_j];
      if (nodeDict[child.getPrevious().getName()] === void 0) {
        nodeDict[child] = false;
      }
    }
    /* create arrays of linked lists. push them to
    			wrapArray. Weird stuff with key not giving objects
    			correctly. Hence, the .getName() shuffle
    */

    for (key in nodeDict) {
      value = nodeDict[key];
      if (value === true) {
        linkArray = [spec._graph.getNode(key)];
        next = spec._graph.getNode(key).getNext().getName();
        while (nodeDict[next] === false) {
          linkArray.push(spec._graph.getNode(next));
          next = next.getNext().getName();
        }
        wrapArray.push(linkArray);
      }
    }
    spec._clickCount += 1;
    /* need to set up a separate method to clear this out*/

    that.incomingTree.push(incomingVertex);
    return that;
  };
  /* reverse clicking utilities*/

  that.receiveReverseClickFromChild = function(childVertex) {
    return null;
  };
  that.receiveReverseClickFromParent = function(parentVertex) {
    return null;
  };
  /* insert node into graph*/

  return that;
};