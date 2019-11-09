# This file must contain a function called my_method that triggers all the steps required in order to obtain

# *val_matrix: mandatory, (N, N) matrix of scores for links
# *p_matrix: optional, (N, N) matrix of p-values for links; if not available, None must be returned
# *lag_matrix: optional, (N, N) matrix of time lags for links; if not available, None must be returned

# Zip this file (together with other necessary files if you have further handmade packages) to upload as a code.zip. You do NOT need to upload files for packages that can be imported via pip or conda repositories. Once you upload your code, we are able to validate results including runtime estimates on the same machine. These results are then marked as "Validated" and users can use filters to only show validated results.


my_method <- function (data){
  
  N <- ncol(data)
  val_matrix <- array(rep(NaN, N*N), c(N, N))
  
  # Matrix of p-values
  p_matrix <-  array(rep(NaN, N*N), c(N, N))
  
  # Matrix of time lags
  lag_matrix <-  array(rep(NaN, N*N), c(N, N))
  lag3 <- -(150:148)
  lag2 <- -c(1, 149, 150)
  lag1 <- -c(1, 2 , 150)
  lag0 <- -c(1, 2, 3)
  values = array(rep(NaN, N*N*3), c(N, N, 3))  # Store the coeff
  pvalues = array(rep(NaN, N*N*3), c(N, N, 3))  # Store the p-values

  for (i in 1:N){
    y <- data[lag0,i]/(data[lag1,i])
    y[y == Inf] <- 0
    y[is.nan(y)] <- 0
    model <- lm(  y ~ 
                    data[lag1,1] + data[lag1,2] +
                    data[lag1,3]  + data[lag1,4] + data[lag1, 5] +
                    data[lag2,1] + data[lag2,2] + 
                    data[lag2,3]  + data[lag2,4] + data[lag2, 5] + 
                    data[lag3,1] + data[lag3,2] + 
                    data[lag3,3]  + data[lag3,4] + data[lag3, 5] )
    val <- coef(model)
    pval <- summary(model)$coefficients[,4] 
    pvalues[, i, 1] <- pval[2:6] 
    pvalues[, i, 2] <- pval[7:11] 
    pvalues[, i, 3] <- pval[12:16] 
    values[, i, 1] <- val[2:6] 
    values[, i, 2] <- val[7:11] 
    values[, i, 3] <- val[12:16]
  }
  

  lag_matrix <- apply(pvalues, MARGIN = c(1,2), function(x){
    which.min(x)
  })
  p_matrix <- apply(pvalues, MARGIN = c(1,2), function(x){
    min(x)
  })
  for (i in 1:5){
	  for (j in 1:5){
		  val_matrix[i,j] = abs(values[i,j, lag_matrix[i,j]])
	  }
  }
  p_matrix <- p_matrix * 3
  p_matrix[p_matrix > 1] <- 1

  return(list("val_matrix" = val_matrix, 
              "p_matrix" = p_matrix, 
              "lag_matrix" = lag_matrix ))
}
