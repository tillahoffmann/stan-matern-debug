transformed data {
  // We use the same data for every example so just include it here. The only parameter
  // we define directly here is the dimensionality of the space.
  int p = 2;
  #include transformed_data.stan
}

generated quantities {
  int offset_ = 1;
  // Iterate over all nodes.
  for (i in 1 : size(x)) {
    // Get the parents of the node.
    int k = degrees[i];
    array [k] int predecessors = segment(edges[1], offset_, k);
    // Nothing to be done here if there are no parents.
    if (k == 0) {
        continue;
    }
    // Print out the variables for debugging.
    print(
      "k=", k,
      "; x=", x,
      "; predecessors=", predecessors,
      "; x[predecessors]=", x[predecessors]
    );
    // Evaluate the covariance.
    matrix[k, k] cov22 = gp_matern32_cov(x[predecessors], 1.3, {0.7, 0.7});
    // Print that we've made it past the evaluation.
    print("ok");
    offset_ += k;
  }
  real success = 1;
}
