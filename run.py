import cmdstanpy
import numpy as np
import shutil
import sys


_, stan_file, output_file = sys.argv
model = cmdstanpy.CmdStanModel(stan_file=stan_file)
fit = model.sample({}, chains=1, fixed_param=True, iter_sampling=1, iter_warmup=1)
stdout_file, = fit.runset.stdout_files
shutil.copy(stdout_file, output_file)
success, = fit.success
print(output_file, f"success={success}")


if "matern-ok" in stan_file:
    assert success == 1
else:
    assert np.isnan(success)
