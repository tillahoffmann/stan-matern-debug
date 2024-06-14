// Number of nodes in the graph.
int num_nodes = 10;

// Dummy locations for each node.
array[num_nodes] vector[p] x = rep_array(zeros_vector(p), num_nodes);


// Number of edges in the graph.
int num_edges_ = (num_nodes * (num_nodes - 1)) %/% 2;
// Edge list of {{parents ...}, {children ...}}.
array[2, num_edges_] int edges;
// Number of outgoing edges towards parents for each node.
array [num_nodes] int degrees;

// Create a complete directed acyclic graph and store the degrees.
int edge = 1;
for (i in 1 : num_nodes) {
  degrees[i] = i - 1;
  for (j in 1 : i - 1) {
      edges[1, edge] = j;
      edges[2, edge] = i;
      edge += 1;
  }
}
