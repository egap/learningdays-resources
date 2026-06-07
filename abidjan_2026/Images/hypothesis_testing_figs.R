## hypothesis_testing_figs.R
## Nahomi Ichino

## plot 1: null distribution
set.seed(12345)
y0 <- rnorm(1000, 0, 1)
vals <- quantile(y0, probs=c(0.025, 0.95, 0.975))



## plot 2: null distribution, with top and bottom 2.5% indicated, add 2.5%, 90%, 2.5% 
vals[1]
vals[3]

## plot 3: plot 2 with values for 2.5th and 97.5th percentile
vals[1]
vals[3]

## plot 4: plot 3 with an ATE estimate in the top 2.5%
est1 <- 2.7
  
## plot 5: plot 4 with an ATE estimate in the top 5% but not in  the top 2.5%
est2 <- 1.9

## plot 6: null distribution with just the bottom 95% and top 5%
vals[2]

## plot 7: plot 6 with ATE estimate in the top 5% but not in the top 2.5%
vals[2]
est2


