
library(here)
library(tidyverse)
#library(kableExtra)
library(DeclareDesign)
library(estimatr)
#library(styler)
library(coin)
#library(multcomp)
library(devtools)
library(randomizr)
#library(rcompanion) ## for pairwisePermutationTest()




## Primero, crear algunos datos,
##  y0 es la variable de resultado potencial para control
N <- 10
y0 <- c(0, 0, 0, 1, 1, 3, 4, 5, 190, 200)
## Diferentes efectos del tratamiento a nivel individual
tau <- c(10, 30, 200, 90, 10, 20, 30, 40, 90, 20)
## y1 es la variable de resultado potencial para tratamiento
y1 <- y0 + tau
# sd(y0)
# mean(y1)-mean(y0)
# mean(tau)
## T es el tratamiento asignado
set.seed(12345)
T <- complete_ra(N)
## Y es la variable de resultado observada
Y <- T * y1 + (1 - T) * y0
## Los datos
dat <- data.frame(Y = Y, T = T, y0 = y0, tau = tau, y1 = y1)
dat$Ybin <- as.numeric(dat$Y > 100)
# dat
# pvalue(oneway_test(Y~factor(T),data=dat,distribution=exact(),alternative="less"))
# pvalue(wilcox_test(Y~factor(T),data=dat,distribution=exact(),alternative="less"))


meanTT <- function(ys, z) {
  mean(ys[z == 1]) - mean(ys[z == 0])
}

observedMeanTT <- meanTT(ys = Y, z = T)
observedMeanTT

# Simulacion
repeatExperiment <- function(N) {
  complete_ra(N)
}

set.seed(123456)
possibleMeanDiffsH0 <- replicate(
  10000,
  meanTT(ys = Y, z = repeatExperiment(N = 10))
)

# Graph
plot(density(possibleMeanDiffsH0),
     ylim = c(0, .04),
     xlim = range(possibleMeanDiffsH0),
     lwd = 2,
     main = "", # Estadística de prueba de diferencia de medias ",
     xlab = "Diferencia de medias consistentes con H0",
     cex.lab = 1.0, cex.axis = 1
)
rug(possibleMeanDiffsH0)
rug(observedMeanTT, lwd = 3, ticksize = .51)
text(observedMeanTT + 20, .022, "Estadística de prueba observada")


# Valor P
pMeanTT <- mean(possibleMeanDiffsH0 >= observedMeanTT)
pMeanTT

# Libreria coin
library(coin)
set.seed(12345)
pMean2 <- coin::pvalue(oneway_test(Y ~ factor(T),
                                   data = dat,
                                   distribution = approximate(nresample = 1000), 
                                   alternative = "less"))

pMean2


## usando el paquete ri2
library(ri2)
thedesign <- declare_ra(N = N)
dat$Z <- dat$T
pMean4 <- conduct_ri(Y ~ Z,
                     declaration = thedesign,
                     sharp_hypothesis = 0, data = dat, sims = 1000
)
summary(pMean4)

# Test con OLS
lm1 <- lm(Y ~ T, data = dat)
summary(lm1)

library(estimatr)
difference_in_means(Y ~ T, data = dat)

lm1 <- lm_robust(Y ~ T, data = dat)
summary(lm1)


## SE de Neyman a mano (usado por difference_in_means)

# Funcion
varEstATE <- function(Y, T) {
  var(Y[T == 1]) / sum(T) + var(Y[T == 0]) / sum(1 - T)
}

# SE
seEstATE <- sqrt(varEstATE(dat$Y, dat$T))

# t de student
obsTStat <- observedMeanTT / seEstATE

# Valor p
c(
  observedTestStat = observedMeanTT,
  stderror = seEstATE,
  tstat = obsTStat,
  pval = 2 * min(
    pt(obsTStat, df = 8, lower.tail = TRUE),
    pt(obsTStat, df = 8, lower.tail = FALSE)
  )
)

2*pt(-abs(obsTStat),df=8) #Alternativa para test de dos colas. 




