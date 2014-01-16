// Generated by CoffeeScript 1.6.3
var telescopicText;

telescopicText = {};

telescopicText.forward = true;

telescopicText.graphs = {};

telescopicText.toggleDirection = function() {
  var key, value, _ref;
  _ref = this.graphs;
  for (key in _ref) {
    value = _ref[key];
    if (/\[object\ telescopicText\.graph/.test(value.toString)) {
      value.toggleDirectionMode();
    }
  }
  console.log('direction toggled');
  return this;
};

telescopicText.reset = function() {
  telescopicText.graph({
    _name: 'telescopicDefaultID'
  });
  return telescopicText.forward = true;
};

telescopicText.graph = function(spec) {
  /* set defaults*/

  var that, _nodes;
  spec = spec || {};
  spec._name = spec._name || 'telescopicDefaultID';
  /* private attributes*/

  spec._startVertex = null;
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
    spec._startVertex = that.getNode(startVertex);
    currentVertex = spec._startVertex;
    nextVertex = that.getNode(currentVertex.getNext());
    if (!spec._startVertex.getNext()) {
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
    that.setUpDom(spec._startVertex);
    return that;
  };
  that.setUpDom = function(startVertex) {
    /* define and clear target div*/

    var endSpan, id, spanObject, startSpan, tagElement, vertex, _results;
    id = 'tText-' + this.getName();
    tagElement = $('#' + id);
    tagElement.empty();
    /* add first vertex*/

    vertex = startVertex;
    startSpan = '<span style="display: none;" id = "' + vertex.findDomId() + '">';
    endSpan = '</span>';
    spanObject = $(startSpan + vertex.content + endSpan);
    tagElement.append(spanObject);
    vertex.bindClick(spanObject);
    vertex.setDomVisibility(spanObject);
    _results = [];
    while (vertex.getNext()) {
      vertex = vertex.getNext();
      startSpan = '<span style="display: none;" id = "' + vertex.findDomId() + '">';
      spanObject = $(startSpan + vertex.content + endSpan);
      tagElement.append(spanObject);
      vertex.bindClick(spanObject);
      _results.push(vertex.setDomVisibility(spanObject));
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
  that.toggleDirectionMode = function() {
    var vertex;
    if (!spec._startVertex) {
      console.log(this.toString() + 'has not been made into ' + 'a linked list. You must call .makeLinkedList(startVertex) ' + 'before attempting to reverse this graph.');
      return this;
    }
    vertex = spec._startVertex;
    while (vertex) {
      vertex.setDomVisibility();
      vertex = vertex.getNext();
    }
    console.log(that.toString() + 'toggleDirectionMode run');
    return this;
  };
  that.toString = function() {
    return "[object telescopicText.graph " + spec._name + "]";
  };
  return that;
};

telescopicText.graph.prototype.toString = function() {
  return '[object telescopicText.graph]';
};

/* class level functions*/


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
    if (spec._starter || that.incomingTree[0]) {
      if (spec._children.length === 0) {
        return true;
      } else if (spec._remainAfterClick) {
        return true;
      } else if (that.findClicksRemaining() > 0) {
        return true;
      } else {
        return false;
      }
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

  that.userClick = function() {
    if (telescopicText.forward) {
      return that.forwardClick();
    } else {
      return that.reverseClick();
    }
  };
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
    that.setDomVisibility();
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
      that.setDomVisibility();
    }
    return that;
  };
  /* DOM manipulation*/

  that.bindClick = function(jQueryObject) {
    if (!jQueryObject) {
      jQueryObject = $('#' + that.findDomId());
    }
    return jQueryObject.click(function() {
      return that.userClick();
    });
  };
  that.setDomVisibility = function(jQueryObject) {
    if (!jQueryObject) {
      jQueryObject = $('#' + that.findDomId());
    }
    if (!that.shouldBeVisible()) {
      jQueryObject.hide();
      return that;
    }
    if (telescopicText.forward) {
      that.setDomForwardVisibility(jQueryObject);
    } else if (!telescopicText.forward) {
      that.setDomReverseVisibility(jQueryObject);
    }
    jQueryObject.show();
    return that;
  };
  that.setDomForwardVisibility = function(jQueryObject) {
    jQueryObject.removeClass('tText_reversable');
    if (that.findClicksRemaining() > 0) {
      jQueryObject.addClass('tText_clickable');
    } else {
      jQueryObject.removeClass('tText_clickable');
    }
    return that;
  };
  that.setDomReverseVisibility = function(jQueryObject) {
    jQueryObject.removeClass('tText_clickable');
    if (that.shouldBeReverseClickable()) {
      jQueryObject.addClass('tText_reversable');
    }
    return that;
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

document.onkeyup = function(event) {
  /* event.altkey doesn't work on all browser*/

  if (event.altKey || event.keyCode === 18) {
    telescopicText.forward = true;
    return telescopicText.toggleDirection();
  }
};

document.onkeydown = function(event) {
  if (telescopicText.forward && (event.altKey || event.keyCode === 18)) {
    telescopicText.forward = false;
    return telescopicText.toggleDirection();
  }
};
