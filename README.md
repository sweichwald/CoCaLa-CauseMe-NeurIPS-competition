Please refer to the [tidybench](https://github.com/sweichwald/tidybench) code repository and our [accompanying paper](http://proceedings.mlr.press/v123/weichwald20a.html) for up to date implementations and descriptions of the algorithms that we used during the NeurIPS Causality 4 Climate competition.

We kindly ask you to cite our [accompanying paper](http://proceedings.mlr.press/v123/weichwald20a.html) in case you find our code useful:
```
@InProceedings{weichwald2020causal,
  title = {{Causal structure learning from time series: Large regression coefficients may predict causal links better in practice than small p-values}},
  author = {Weichwald, Sebastian and Jakobsen, Martin E. and Mogensen, Phillip B. and Petersen, Lasse and Thams, Nikolaj and Varando, Gherardo},
  publisher = {PMLR},
  series = {Proceedings of the NeurIPS 2019 Competition and Demonstration Track, Proceedings of Machine Learning Research},
  volume = {123},
  pages = {27--36},
  year = {2020},
  editor = {Hugo Jair Escalante and Raia Hadsell},
  pdf = {http://proceedings.mlr.press/v123/weichwald20a/weichwald20a.pdf},
  url = {http://proceedings.mlr.press/v123/weichwald20a.html},
}
```

The algorithms in this repository correspond to the ones implemented in [tidybench](https://github.com/sweichwald/tidybench) as follows:

* varvar --> `tidybench.slarac` (Subsampled Linear Auto-Regression Absolute Coefficients)

* ridge --> `tidybench.qrbs` (Quantiles of Ridge regressed Bootstrap Samples)

* varvar(lasso=True) --> `tidybench.lasar` (LASso Auto-Regression)

* selvar --> `tidybench.selvar` (Selective auto-regressive model)

---

Just a quick update:
__Our CoCaLa Team won the [Causality 4 Climate NeurIPS competition](https://causeme.uv.es/neurips2019/)!__
Among all 190 competitors, with 40 very active, we won the most categories with 18 out of 34, came in second place in all remaining 16 categories, and won the overall competition by achieving an average AUC-ROC score of 0.917 (2nd and 3rd place achieved 0.722 and 0.676, respectively).
Congrats and thanks to many great teams and thanks to the organisers for putting a fun competition together.
You can [check out our slides here](https://sweichwald.de/slides.html#neurips2019), [re-watch the NeurIPS session here](https://slideslive.com/38922052/competition-track-day-21), and read more on the [competition results](https://causeme.uv.es/neurips2019/static/img/Runge_NeurIPS_compressed.pdf).

---

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
