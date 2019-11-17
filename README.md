This repository contains pretty cool stuff!

We, the team of the [Copenhagen Causality Lab (CoCaLa)](https://www.math.ku.dk/english/research/spt/cocala/) participating in the [Causality 4 Climate NeurIPS competition](https://causeme.uv.es/neurips2019/), are posting the scripts here that generated our final competition submissions.

No documentation (yet) and (partly) unpolished as we posted this right after the competition closed ;-)

* [**logmap**.R](./logmap.R)
* [**ridge**.py](./ridge.py)
* [**selvar**.f](./selvar.f) + [**selvar**_method.py](./selvar_method.py)
* [**varvar**.py](./varvar.py)

# quick'n'rough docs

## logmap

naive fitting of the logistic map with linear regression for the quotient x_t / x_{t-1} 

## ridge

The method differences the data to obtain `y_t = X_t – X_{t-1}`, and regresses `y` on lagged versions of `X`.

The method performs ridge regression `y_t ~ X_{t-1}, …, X_{t-lags}`. The method takes the absolute values of the resulting coefficient matrix, as a proxy for the size of causal effects. If `lags > 1`, a coefficient matrix for each lag is produced, and they’re thus summed across lags.

This ridge regression is in fact repeated on a number of bootstrap samples, and the effect is aggregated by taking some quantile q of the estimated effects across bootstraps. In some sense, `q` can be seen as a bias-variance trade-off parameter, with `q = 1` being equal to the max effect across samples, which could have high variance.

## selvar

Var model with variable and lag selection with respect to predictive residual sum of squares. Edges can be scored with different criteria and p-values are computed for the likelihood-ratio test. 

## varvar

Repeatedly fits var(p) models on random bootstrap-subsamples of the data (where 1 <= p <= maxlags uniformly) and aggregates the absolute values of the coefficients to an overall score matrix.
