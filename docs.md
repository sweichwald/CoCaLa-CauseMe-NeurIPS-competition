**Ridge**

The method differences the data to obtain `y_t = X_t – X_{t-1}`, and regresses `y` on lagged versions of `X`.

The method performs ridge regression `y_t ~ X_{t-1}, …, X_{t-lags}`. The method takes the absolute values of the resulting coefficient matrix, as a proxy for the size of causal effects. If `lags > 1`, a coefficient matrix for each lag is produced, and they’re thus summed across lags.

This ridge regression is in fact repeated on a number of bootstrap samples, and the effect is aggregated by taking some quantile q of the estimated effects across bootstraps. In some sense, `q` can be seen as a bias-variance trade-off parameter, with `q = 1` being equal to the max effect across samples, which could have high variance.
