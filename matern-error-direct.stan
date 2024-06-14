transformed data {
  // We use the same data for every example so just include it here. The only parameter
  // we define directly here is the dimensionality of the space.
  int p = 1;
  #include transformed_data.stan
}

generated quantities {
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
    matrix[k, k] cov22 = gp_matern32_cov(x[predecessors], 1.3, {0.7});
    print("ok");
    offset_ += k;
  }
  real success = 1;
}
