// Generated by CoffeeScript 1.6.3
var telescopicText;

telescopicText = {};

telescopicText.graphs = {};

telescopicText.reset = function() {
  telescopicText.graphs = {};
  return new telescopicText.Graph('telescopicDefaultID');
};

telescopicText.Graph = (function() {
  function Graph(name) {
    var nodes;
    telescopicText.graphs[name] = this;
    /* private*/

    nodes = {};
    /*getters, setters*/

    this.getName = function() {
      return name;
    };
    this.getNode = function(key) {
      var node;
      node = nodes[key];
      if (node === void 0) {
        console.log('Graph "' + this.getName() + '" is missing a child, with key "' + key + '."');
      }
      return node;
    };
    this.setNode = function(key, value) {
      return nodes[key] = value;
    };
    /* object-level methods*/

    this.returnVertexFromKeyOrObject = function(key_or_object) {
      if (!(key_or_object instanceof telescopicText.Vertex)) {
        return key_or_object = this.getNode(key_or_object);
      } else {
        return key_or_object;
      }
    };
    this.makeLinkedList = function(start_vertex) {
      var current_vertex, next_vertex, _results;
      current_vertex = start_vertex;
      next_vertex = this.returnVertexFromKeyOrObject(current_vertex.getNext());
      if (!start_vertex.getNext()) {
        console.log('Careful! This graph only has one vertex linked.');
        +'and that seems pretty silly to me.';
      }
      _results = [];
      while (next_vertex) {
        if (next_vertex === start_vertex) {
          current_vertex.setNext(null);
          next_vertex.setPrevious(null);
          console.log("Your linked list is cyclical when it should be linear. " + "Did not link the start and end nodes.");
          _results.push(next_vertex = false);
        } else {
          this.constructor.link(current_vertex, next_vertex);
          current_vertex = next_vertex;
          _results.push(next_vertex = this.returnVertexFromKeyOrObject(current_vertex.getNext()));
        }
      }
      return _results;
    };
  }

  /* class method*/


  Graph.link = function(from_vertex, to_vertex) {
    from_vertex.setNext(to_vertex);
    return to_vertex.setPrevious(from_vertex);
  };

  Graph.dangerousUnlink = function(vertex) {
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

  Graph.safeUnlink = function(vertex) {
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

  return Graph;

})();

telescopicText.Vertex = (function() {
  function Vertex(name, content, children, remain_after_click, next, graph) {
    var previous;
    this.content = content;
    this.children = children != null ? children : [[]];
    if (remain_after_click == null) {
      remain_after_click = false;
    }
    if (next == null) {
      next = null;
    }
    if (graph == null) {
      graph = "telescopicDefaultID";
    }
    if (!telescopicText.graphs[graph]) {
      new telescopicText.Graph(graph);
    }
    graph = telescopicText.graphs[graph];
    graph.setNode(name, this);
    this.tree_edge;
    this.forward_edge;
    this.back_edge;
    this.cross_edge;
    previous = null;
    /* getters, setters*/

    this.getName = function() {
      return name;
    };
    this.getGraph = function() {
      return graph;
    };
    this.getNext = function() {
      return next;
    };
    this.setNext = function(newNext) {
      return next = newNext;
    };
    this.getPrevious = function() {
      return previous;
    };
    this.setPrevious = function(newPrevious) {
      return previous = newPrevious;
    };
    this.getRemainAfterClick = function() {
      return remain_after_click;
    };
    this.setChildrenReferences = function() {
      var child, child_index, child_key, set_index, _results;
      set_index = 0;
      _results = [];
      while (set_index < this.children.length) {
        child_index = 0;
        while (child_index < this.children[set_index].length) {
          child_key = this.children[set_index][child_index];
          child = graph.returnVertexFromKeyOrObject(child_key);
          if (!(child instanceof telescopicText.Vertex)) {
            console.log('The key, "' + child_key + '", will be removed from vertex\'s child array.');
            this.children[set_index].splice(child_index, 1);
          } else {
            this.children[set_index][child_index] = child;
            child_index += 1;
          }
        }
        _results.push(set_index += 1);
      }
      return _results;
    };
  }

  return Vertex;

})();

telescopicText.reset();
