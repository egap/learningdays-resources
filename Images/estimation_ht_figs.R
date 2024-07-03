## estimation_ht_figs.R
## Nahomi Ichino
## figs for est-HT-1-slides-en-fr.Rmd

## Estimator 1: Linear Regression for simple experiment

library(plotrix)


## simple randomization
set.seed(202406)
y1 <- rnorm(50,3,0.5)
z1 <- jitter(rep(1,50))
y0 <- rnorm(50,1,0.5)
z0 <- jitter(rep(0,50))
y2 <- rnorm(50,6,0.5)
z2 <- jitter(rep(1,50))

miny <- min(c(y0,y1))
maxy <- max(c(y0,y1))

png(file="diff-in-means.png", width=760, height=760, pointsize=36)
# par(mar=c(3,3,2,2))

plot(c(-0.25,1.25), c(0, 4.5), type="n", main="", xlab="Z", ylab="Y", axes=FALSE)
axis(1, at=c(0,1))
axis(2, at=c(0,2,4), las=2, pos=-0.25)
axis(2, at=c(1,3), labels=c("1", "3"), las=2, pos=-0.25)
points(z0,y0)
points(z1,y1)
points(0,1, pch=15, col="blue", cex=2)
points(1,3, pch=15, col="red", cex=2)
# segments(x0=0, y0=1, x1=1, y1=3)

dev.off()


png(file="regression1.png", width=760, height=760, pointsize=36)
# par(mar=c(2,3,1,1))

plot(c(-0.25,1.25), c(0, 4.5), type="n", main="", xlab="Z", ylab="Y", axes=FALSE)
axis(1, at=c(0,1))
axis(2, at=c(0,2,4), las=2, pos=-0.25)
axis(2, at=c(1,3), labels=c(expression(paste(hat(beta[0]))), expression(paste(hat(beta[0])+hat(beta[1])))), las=2, pos=-0.25)
points(z0,y0)
points(z1,y1)
segments(x0=0, y0=1, x1=1, y1=3)
points(0,1, pch=15, col="blue")
points(1,3, pch=15, col="red")

dev.off()

png(file="regression2.png", width=760, height=760, pointsize=30)
par(mar=c(2,3,1,1))

plot(c(-0.25,1.25), c(0, 7.5), type="n", main="", xlab="Z", ylab="Y", axes=FALSE)
axis(1, at=c(0,1), labels=c("Neither", expression(paste(Z[A], ",", Z[B]))))
axis(2, at=c(0,2,4,5,7), las=2, pos=-0.25)
axis(2, at=c(1,3,6), labels=c(expression(paste(hat(alpha))), expression(paste(hat(alpha)+hat(beta[A]))), expression(paste(hat(alpha)+hat(beta[B])))), las=2, pos=-0.25)
points(z0,y0, col="blue")
points(z1,y1, col="red")
points(z2,y2, col="green")
segments(x0=0, y0=1, x1=1, y1=3)
segments(x0=0, y0=1, x1=1, y1=6)
points(0,1, pch=15, col="blue", cex=1)
points(1,3, pch=15, col="red", cex=1)
points(1,6, pch=15, col="green", cex=1)
dev.off()

## hypothesis testing
set.seed(23456)
x <- rnorm(60000)
y <- dnorm(x, 0, 1)

png(file="HT1-null.png", width=760, height=180, pointsize=12)
par(mar=c(2.5,1,1,1))
plot(x, y, type = "n", axes=FALSE, ylab="", xlab="")
axis(1, at=c(-3,-2,-1,0,1,2,3))
curve(dnorm(x,0,1), add=TRUE)
abline(v=0, lty=2)
dev.off()


png(file="HT2-null5percent.png", width=760, height=180, pointsize=12)
par(mar=c(2.5,1,1,1))
plot(x, y, type = "n", axes=FALSE, ylab="", xlab="")
axis(1, at=c(-3,-2,-1,0,1,2,3))
x2 <- seq(quantile(x,0.025),quantile(x,0.975),0.01)
y2 <- dnorm(x2, 0, 1)
x2 <- c(quantile(x,0.025), x2, quantile(x,0.975))
y2 <- c(0,y2,0)
polygon(x2,y2, col="yellow", border=NA)
curve(dnorm(x,0,1), add=TRUE)
abline(v=0, lty=2)
segments(x0=quantile(x,0.025),y0=0,
         x1=quantile(x,0.025),y1=dnorm(quantile(x,0.025)))
segments(x0=quantile(x,0.975),y0=0,
         x1=quantile(x,0.975),y1=dnorm(quantile(x,0.975)))
dev.off()


png(file="HT3-twosidedrejectonly.png", width=760, height=180, pointsize=12)
par(mar=c(2.5,1,1,1))
plot(x, y, type = "n", axes=FALSE, ylab="", xlab="")
axis(1, at=c(-3,-2,-1,0,1,2,3))
x2 <- seq(quantile(x,0.025),quantile(x,0.975),0.01)
y2 <- dnorm(x2, 0, 1)
x2 <- c(quantile(x,0.025), x2, quantile(x,0.975))
y2 <- c(0,y2,0)
polygon(x2,y2, col="yellow", border=NA)
curve(dnorm(x,0,1), add=TRUE)
abline(v=0, lty=2)
segments(x0=quantile(x,0.025),y0=0,
         x1=quantile(x,0.025),y1=dnorm(quantile(x,0.025)))
segments(x0=quantile(x,0.975),y0=0,
         x1=quantile(x,0.975),y1=dnorm(quantile(x,0.975)))
abline(v=2.5, col="red")
dev.off()

png(file="HT4-twosided.png", width=760, height=180, pointsize=12)
par(mar=c(2.5,1,1,1))
plot(x, y, type = "n", axes=FALSE, ylab="", xlab="")
axis(1, at=c(-3,-2,-1,0,1,2,3))
x2 <- seq(quantile(x,0.025),quantile(x,0.975),0.01)
y2 <- dnorm(x2, 0, 1)
x2 <- c(quantile(x,0.025), x2, quantile(x,0.975))
y2 <- c(0,y2,0)
polygon(x2,y2, col="yellow", border=NA)
curve(dnorm(x,0,1), add=TRUE)
abline(v=0, lty=2)
segments(x0=quantile(x,0.025),y0=0,
         x1=quantile(x,0.025),y1=dnorm(quantile(x,0.025)))
segments(x0=quantile(x,0.975),y0=0,
         x1=quantile(x,0.975),y1=dnorm(quantile(x,0.975)))
abline(v=2.5, col="red")
abline(v=1.75, col="blue")
dev.off()

png(file="HT5-onesided5pc.png", width=760, height=180, pointsize=12)
par(mar=c(2.5,1,1,1))
plot(x, y, type = "n", axes=FALSE, ylab="", xlab="")
axis(1, at=c(-3,-2,-1,0,1,2,3))
x2 <- seq(quantile(x,0),quantile(x,0.95),0.01)
y2 <- dnorm(x2, 0, 1)
x2 <- c(quantile(x,0), x2, quantile(x,0.95))
y2 <- c(0,y2,0)
polygon(x2,y2, col="orange", border=NA)
segments(x0=quantile(x,0.95),y0=0,
         x1=quantile(x,0.95),y1=dnorm(quantile(x,0.95)))
curve(dnorm(x,0,1), add=TRUE)
abline(v=0, lty=2)
abline(v=1.75, col="blue")
abline(v=2.5, col="red")
dev.off()


## FOR ONE-SIDED
png(file="HT6-pvalue.png", width=760, height=180, pointsize=12)
par(mar=c(2.5,1,1,1))
plot(x, y, type = "n", axes=FALSE, ylab="", xlab="")
axis(1, at=c(-3,-2,-1,0,1,2,3))
# x2 <- seq(quantile(x,0.025),quantile(x,0.975),0.01)
# y2 <- dnorm(x2, 0, 1)
# x2 <- c(quantile(x,0.025), x2, quantile(x,0.975))
# y2 <- c(0,y2,0)
# polygon(x2,y2, col="yellow", border=NA)
x2 <- seq(quantile(x,0),quantile(x,0.95),0.01)
y2 <- dnorm(x2, 0, 1)
x2 <- c(quantile(x,0), x2, quantile(x,0.95))
y2 <- c(0,y2,0)
polygon(x2,y2, col="orange", border=NA)
segments(x0=quantile(x,0.95),y0=0,
         x1=quantile(x,0.95),y1=dnorm(quantile(x,0.95)))
x2 <- seq(2.5, quantile(x,1),0.01)
y2 <- dnorm(x2, 0, 1)
x2 <- c(2.5, x2, quantile(x,1))
y2 <- c(0,y2,0)
polygon(x2,y2, col="red", border=NA)

curve(dnorm(x,0,1), add=TRUE)
abline(v=0, lty=2)
# segments(x0=quantile(x,0.025),y0=0,
#          x1=quantile(x,0.025),y1=dnorm(quantile(x,0.025)))
# segments(x0=quantile(x,0.975),y0=0,
#          x1=quantile(x,0.975),y1=dnorm(quantile(x,0.975)))
abline(v=2.5, col="red")
dev.off()

mean(x>=2.5) #0.00625


## regression with blocks
blocks <- c("J","J","J","K","K","K","L","L","L")
z <- c(0,1,0,1,0,0,1,0,0)
y <- c(4,3,2,3,0,2,4,0,2)

round(summary(lm(y~z+as.factor(blocks)))$coef,3)
