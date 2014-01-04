// Generated by CoffeeScript 1.6.3
var telescopicText;

telescopicText = {};

telescopicText.graphs = {};

telescopicText.reset = function() {
  return telescopicText.graph({
    _name: 'telescopicDefaultID'
  });
};

telescopicText.graph = function(spec) {
  /* set defaults*/

  var that, _nodes;
  spec = spec || {};
  spec._name = spec._name || 'telescopicDefaultID';
  /* private attributes*/

  that = {};
  _nodes = {};
  /* constructor. default text, and insert into graphs*/

  telescopicText.graphs[spec._name] = that;
  /* public functions*/

  that.getName = function() {
    return spec._name;
  };
  that.getNode = function(keyOrVertex) {
    /* in case get the vertex's key*/

    var node;
    if (keyOrVertex instanceof Object) {
      keyOrVertex = keyOrVertex.getName();
    }
    node = _nodes[keyOrVertex];
    if (node === void 0) {
      console.log('Graph "' + that.getName() + '" is missing a child, with key "' + keyOrVertex + '."');
      void 0;
    }
    return node;
  };
  that.setNode = function(key, value) {
    _nodes[key] = value;
    return that;
  };
  that.makeLinkedList = function(startVertex) {
    var currentVertex, nextVertex;
    startVertex = that.getNode(startVertex);
    currentVertex = startVertex;
    nextVertex = that.getNode(currentVertex.getNext());
    if (!startVertex.getNext()) {
      console.log('Careful! This graph only has one vertex linked.');
      +'and that seems pretty silly to me.';
    }
    while (nextVertex) {
      if (nextVertex === startVertex) {
        currentVertex.setNext(null);
        nextVertex.setPrevious(null);
        console.log("Your linked list is cyclical when it should be linear. " + "Did not link the start and end nodes.");
        nextVertex = false;
      } else {
        telescopicText.graph.link(currentVertex, nextVertex);
        currentVertex = nextVertex;
        nextVertex = that.getNode(currentVertex.getNext());
      }
    }
    that.setUpDom(startVertex);
    return that;
  };
  that.setUpDom = function(startVertex) {
    /* define and clear target div*/

    var endSpan, id, startSpan, tagElement, vertex, _results;
    id = 'tText-' + this.getName();
    tagElement = $('#' + id);
    tagElement.empty();
    /* add first vertex*/

    vertex = startVertex;
    startSpan = '<span style="display: none;" id = "' + vertex.findDomId() + '">';
    endSpan = '</span>';
    tagElement.append(startSpan + vertex.content + endSpan);
    vertex.setDomVisibility();
    _results = [];
    while (vertex.getNext()) {
      vertex = vertex.getNext();
      startSpan = '<span style="display: none;" id = "' + vertex.findDomId() + '">';
      endSpan = '</span>';
      tagElement.append(startSpan + vertex.content + endSpan);
      _results.push(vertex.setDomVisibility());
    }
    return _results;
  };
  /* linking/children functions*/

  that.setGraphChildReferences = function() {
    var key, value;
    for (key in _nodes) {
      value = _nodes[key];
      value.setChildrenReferences();
    }
    return that;
  };
  return that;
};

/* object level functions*/


telescopicText.graph.link = function(fromVertex, toVertex) {
  fromVertex.setNext(toVertex);
  return toVertex.setPrevious(fromVertex);
};

telescopicText.graph.dangerousUnlink = function(vertex) {
  var next, previous;
  next = vertex.getNext();
  previous = vertex.getPrevious();
  vertex.setNext(null);
  vertex.setPrevious(null);
  if (next) {
    next.setPrevious(null);
  }
  if (previous) {
    return previous.setNext(null);
  }
};

telescopicText.graph.safeUnlink = function(vertex) {
  var next, previous;
  next = vertex.getNext();
  previous = vertex.getPrevious();
  vertex.setNext(null);
  vertex.setPrevious(null);
  if (next) {
    next.setPrevious(previous);
  }
  if (previous) {
    return previous.setNext(next);
  }
};

telescopicText.vertex = function(spec) {
  /* set defaults*/

  var that;
  spec = spec || {};
  spec._starter = spec._starter || false;
  spec._children = spec._children || [];
  spec._remainAfterClick = spec._remainAfterClick || false;
  spec._next = spec._next || false;
  /* constructor*/

  if (!telescopicText.graphs[spec._graph]) {
    spec._graph = telescopicText.graph({
      _name: spec._graph
    });
  } else {
    spec._graph = telescopicText.graphs[spec._graph];
  }
  /* private attributes*/

  that = {};
  spec._previous = null;
  spec._clickCount = 0;
  /* public attributes*/

  that.content = spec.content;
  that.incomingTree = [];
  that.incomingTree[0] = false;
  that.incomingForward = [];
  that.incomingBack = [];
  that.incomingCross = [];
  /* public functions*/

  that.getStarter = function() {
    return spec._starter;
  };
  that.getName = function() {
    return spec._name;
  };
  that.getGraph = function() {
    return spec._graph;
  };
  that.getNext = function() {
    return spec._next;
  };
  that.setNext = function(newNext) {
    return spec._next = newNext;
  };
  that.getPrevious = function() {
    return spec._previous;
  };
  that.setPrevious = function(newPrevious) {
    return spec._previous = newPrevious;
  };
  that.getClickCount = function() {
    return spec._clickCount;
  };
  that.getChildren = function() {
    return spec._children;
  };
  that.getRemainAfterClick = function() {
    return spec._remainAfterClick;
  };
  that.setEdgesToDefault = function() {
    that.incomingTree[0] = false;
    that.incomingForward = [];
    that.incomingBack = [];
    return that.incomingCross = [];
  };
  /* public functions meta info*/

  that.findClicksRemaining = function() {
    /* ignore _remainAfterClick b/c it's not a click*/

    return spec._children.length - spec._clickCount;
  };
  that.findDomId = function() {
    var str;
    str = 'tText_' + spec._name;
    return str;
  };
  that.shouldBeVisible = function() {
    if (that.getStarter() && that.findClicksRemaining() > 0) {
      return true;
    } else if (that.getStarter() && that.getRemainAfterClick()) {
      return true;
      /* not a starter node*/

    } else if (that.findClicksRemaining() > 0 && that.incomingTree[0]) {
      return true;
    } else if (that.incomingTree[0] && that.getRemainAfterClick()) {
      return true;
    } else {
      return false;
    }
  };
  that.forwardDetermineAndSetIncomingEdge = function(incomingVertex) {
    /* assumes that incomingVertex is valid*/

    if (!that.incomingTree[0] && !that.getStarter()) {
      that.incomingTree[0] = incomingVertex;
    } else if (that.determineIfBackEdge(incomingVertex)) {
      that.incomingBack.push(incomingVertex);
    } else if (that.determineIfForwardEdge(incomingVertex)) {
      that.incomingForward.push(incomingVertex);
    } else {
      that.incomingCross.push(incomingVertex);
    }
    return that;
  };
  that.determineIfBackEdge = function(incomingVertex) {
    var parentVertex;
    parentVertex = incomingVertex.incomingTree[0];
    while (parentVertex) {
      if (parentVertex === that) {
        return true;
      } else {
        parentVertex = parentVertex.incomingTree[0];
      }
    }
    return false;
  };
  that.determineIfForwardEdge = function(incomingVertex) {
    var parentVertex;
    parentVertex = that.incomingTree[0];
    while (parentVertex) {
      if (parentVertex === incomingVertex) {
        return true;
      } else {
        parentVertex = parentVertex.incomingTree[0];
      }
    }
    return false;
  };
  that.shouldBeReverseClickable = function() {
    /* need to check to make sure that parent is on the same click index as the child*/

    if (spec._clickCount === 0 && that.shouldBeVisible() && that.incomingTree[0] && spec._clickCount === 0 && that.incomingTree[0].findIndexOfChildInChildren(that) === that.incomingTree[0].getClickCount() - 1) {
      return true;
    } else {
      return false;
    }
  };
  /* linking utilities*/

  that.setChildrenReferences = function() {
    var child, childIndex, childKey, setIndex;
    setIndex = 0;
    while (setIndex < spec._children.length) {
      childIndex = 0;
      while (childIndex < spec._children[setIndex].length) {
        childKey = spec._children[setIndex][childIndex];
        child = spec._graph.getNode(childKey);
        if (child === void 0) {
          console.log('The key, "' + childKey + '", will be removed from vertex\'s child array.');
          spec._children[setIndex].splice(childIndex, 1);
        } else {
          spec._children[setIndex][childIndex] = child;
          childIndex += 1;
        }
      }
      setIndex += 1;
    }
    return that;
  };
  that.findIndexOfChildInChildren = function(chidVertex) {
    var child, childIndex, row, _i, _j, _len, _len1, _ref;
    childIndex = 0;
    _ref = spec._children;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      row = _ref[_i];
      for (_j = 0, _len1 = row.length; _j < _len1; _j++) {
        child = row[_j];
        if (child === chidVertex) {
          return childIndex;
        }
      }
      childIndex += 1;
    }
    return false;
  };
  /* clicking utilities*/

  that.forwardClick = function() {
    /* catch instance in which it shouldn't be clicked*/

    var child, relevantChildren, _i, _len;
    if (that.findClicksRemaining() <= 0 || !that.shouldBeVisible()) {
      return that;
    }
    relevantChildren = spec._children[spec._clickCount];
    for (_i = 0, _len = relevantChildren.length; _i < _len; _i++) {
      child = relevantChildren[_i];
      child.receiveForwardClick(that);
    }
    spec._clickCount += 1;
    that.setDomVisibility();
    return that;
  };
  that.receiveForwardClick = function(incomingVertex) {
    that.forwardDetermineAndSetIncomingEdge(incomingVertex);
    that.setDomVisibility();
    return that;
  };
  /* reverse clicking utilities*/

  that.reverseClick = function() {
    if (!that.shouldBeReverseClickable()) {
      return that;
    }
    that.incomingTree[0].receiveReverseClickFromChild(that);
    return that;
  };
  that.receiveReverseClickFromChild = function(childVertex) {
    var child, childIndex, _i, _len, _ref;
    spec._clickCount += -1;
    childIndex = that.findIndexOfChildInChildren(childVertex);
    _ref = spec._children[childIndex];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      child = _ref[_i];
      child.receiveReverseClickFromParent(that);
    }
    return that;
  };
  that.receiveReverseClickFromParent = function(parentVertex) {
    if (that.incomingTree[0] === parentVertex) {
      that.setEdgesToDefault();
    }
    return that;
  };
  /* DOM manipulation*/

  that.setDomVisibility = function() {
    var jquerySelector;
    jquerySelector = $('#' + that.findDomId());
    if (that.shouldBeVisible()) {
      return jquerySelector.show();
    } else {
      return jquerySelector.hide();
    }
  };
  /* override toString, so that inserting nodes as keys works.*/

  that.toString = function() {
    return "[object telescopicText.vertex " + spec._name + "]";
  };
  /* insert node into graph*/

  spec._graph.setNode(spec._name, that);
  return that;
};

telescopicText.vertex.prototype.toString = function() {
  return "[object telescopicText.vertex]";
};
