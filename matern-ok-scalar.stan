functions {

  void gp_inv_graph(array[] vector x, array[,] int edges, array[] int degrees) {
    // In a real application, we would transform white noise to a Gaussian
    // process realization. We don't return anything here to debug.
    int offset_ = 1;
    for (i in 1 : size(x)) {
        int k = degrees[i];
        array [k] int predecessors = segment(edges[1], offset_, k);
        if (k == 0) {
            continue;
        }
        print(
          "k=", k,
          "; x=", x,
          "; predecessors=", predecessors,
          "; x[predecessors]=", x[predecessors]
        );
        matrix[k, k] cov22 = gp_matern32_cov(x[predecessors], 1.3, 0.7);
        print("ok");
        offset_ += k;
    }
  }
}

transformed data {
  // We use the same data for every example so just include it here. The only parameter
  // we define directly here is the dimensionality of the space.
  int p = 1;
  #include transformed_data.stan
}

generated quantities {
  gp_inv_graph(x, edges, degrees);
  real success = 1;
}
