int num_nodes = 10;

array[num_nodes] vector[p] x;

for (i in 1 : num_nodes) {
x[i] = rep_vector(i + 0.1, p);
}

int num_edges_ = (num_nodes * (num_nodes - 1)) %/% 2;
array[2, num_edges_] int edges;

int edge = 1;
for (i in 1 : num_nodes) {
for (j in 1 : i - 1) {
    edges[1, edge] = j;
    edges[2, edge] = i;
    edge += 1;
}
}

array [num_nodes] int degrees;
for (i in 1:num_nodes) {
degrees[i] = i - 1;
}
