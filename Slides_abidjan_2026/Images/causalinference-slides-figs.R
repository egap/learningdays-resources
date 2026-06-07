## causalinference-slides-figs.R
## Nahomi Ichino
## May 2023

# comes after introducing the idea of tau_i = Y_i(1) - Y_i(0)

# new plot/slide indicated by: ##################################

N <- 12
m <- 6

set.seed(1231)
Y1 <- sample(c(2:8), N, replace=TRUE)
tau <- sample(c(rep(c(0,1), 6)), N, replace=FALSE)
Y0 <- Y1-tau

mean(Y1) # 5.25
mean(Y0) # 4.75
mean(tau) # 0.5

x <- rep(c(1:(N/3)),3)
y <- rep(c(1:3), times=N/3)

##################################
# say we have N units
png(file="fig01-units.png", width=960, height=760, pointsize=24)
# par(mar=c(0,0,0,0))

plot(x,y, lwd=2, cex=8,
     main="", xlab="", ylab="", axes=FALSE,
     xlim=c(0.75,(N/3)+0.25), ylim=c(0,3.25))
dev.off()

##################################
# they have Y(1)
png(file="fig02-Y1.png", width=960, height=760, pointsize=24)

plot(x,y, lwd=2, cex=8, col="red",
     main="", xlab="", ylab="", axes=FALSE,
     xlim=c(0.75,(N/3)+0.25), ylim=c(0,3.25))
# mean(Y1)
text(x,y, Y1, cex=2, col="red")
mtext("true average of Y(1) = 5.25", side=1, cex=2, col="red")
dev.off()

##################################
# our N units also have Y(0)

png(file="fig03-Y0.png", width=960, height=760, pointsize=24)

plot(x,y, lwd=2, cex=8, col="blue",
     main="", xlab="", ylab="", axes=FALSE,
     xlim=c(0.75,(N/3)+0.25), ylim=c(0,3.25))

text(x,y, Y0, cex=2, col="blue")
# mean(Y0) #4.75
mtext("true average of Y(0) = 4.75", side=1, cex=2, col="blue")
dev.off()
##################################
# a tau for each unit (show the Y(1) and Y(0) figs below?)

png(file="fig04-tau.png", width=960, height=760, pointsize=24)

plot(x,y, lwd=2, cex=8,
     main="", xlab="", ylab="", axes=FALSE,
     xlim=c(0.75,(N/3)+0.25), ylim=c(0,3.25))
text(x,y, tau, cex=2)
mean(tau) #0.5
mtext("true average treatment effect = 0.5", side=1, cex=2)
dev.off()

png(file="fig04-tau-noATE.png", width=960, height=760, pointsize=24)

plot(x,y, lwd=2, cex=8,
     main="", xlab="", ylab="", axes=FALSE,
     xlim=c(0.75,(N/3)+0.25), ylim=c(0,3.25))
text(x,y, tau, cex=2)
mean(tau) #0.5
# mtext("true average treatment effect = 0.5", side=1, cex=2)
dev.off()

##################################
# let's go back to the Y(1)

png(file="fig05-y1.png", width=960, height=760, pointsize=24)

plot(x,y, lwd=2, cex=8, col="red",
     main="", xlab="", ylab="", axes=FALSE,
     xlim=c(0.75,(N/3)+0.25), ylim=c(0,3.25))
text(x,y, Y1, cex=2, col="red")

dev.off()

##################################
# let's take a random sample of size N/2

png(file="fig06-y1-sample1.png", width=960, height=760, pointsize=24)

## sample 1 here:
sample1 <- sample(c(1:N), m)

plot(x[sample1],y[sample1], lwd=2, cex=8, col="red",
     main="", xlab="", ylab="", axes=FALSE,
     xlim=c(0.75,(N/3)+0.25), ylim=c(0,3.25))
text(x[sample1], y[sample1], Y1[sample1], cex=2, col="red")
mean(Y1[sample1])

mtext("average Y(1) of sample #1 = 5", side=1, cex=2, col="red")

dev.off()

##################################
# let's take another random sample

png(file="fig07-y1-sample2.png", width=960, height=760, pointsize=24)

## sample 2 here
sample2 <- sample(c(1:N), m)

plot(x[sample2],y[sample2], lwd=2, cex=8, col="red",
     main="", xlab="", ylab="", axes=FALSE,
     xlim=c(0.75,(N/3)+0.25), ylim=c(0,3.25))

text(x[sample2], y[sample2], Y1[sample2], cex=2, col="red")

mean(Y1[sample2])

mtext("average Y(1) of sample #2 = 5.5", side=1, cex=2, col="red")
dev.off()

##################################
# just for fun, let's take another random sample

png(file="fig08-y1-sample3.png", width=960, height=760, pointsize=24)

## sample 3 here:
sample3 <- sample(c(1:N), m)

plot(x[sample3],y[sample3], lwd=2, cex=8, col="red",
     main="", xlab="", ylab="", axes=FALSE,
     xlim=c(0.75,(N/3)+0.25), ylim=c(0,3.25))

text(x[sample3], y[sample3], Y1[sample3], cex=2, col="red")

mean(Y1[sample3])

mtext("average Y(1) of sample #3 = 5.67", side=1, cex=2, col="red")
dev.off()

##################################
# now let's go back to Y(0) TODO: change to show circles first only again

png(file="fig09-y0-novals.png", width=960, height=760, pointsize=24)

plot(x,y, lwd=2, cex=8, col="blue",
     main="", xlab="", ylab="", axes=FALSE,
     xlim=c(0.75,(N/3)+0.25), ylim=c(0,3.25))
text(x,y, Y0, cex=2, col="blue")
mean(Y0) #4.75

mtext("true average of Y(0) = 4.75", side=1, cex=2, col="blue")
dev.off()

##################################
# we can do the same thing about sampling

png(file="fig10-y0-sample1.png", width=960, height=760, pointsize=24)

plot(x[-sample1],y[-sample1], lwd=2, cex=8, col="blue",
     main="", xlab="", ylab="", axes=FALSE,
     xlim=c(0.75,(N/3)+0.25), ylim=c(0,3.25))
text(x[-sample1], y[-sample1], Y0[-sample1], cex=2, col="blue")
mean(Y0[-sample1])

mtext("average Y(0) of sample #1 = 4.83", side=1, cex=2, col="blue")
dev.off()

##################################
# every time you sample Y(1), you're assigning treatment to those units.
# and you're simultaneously randomly sampling those other units to learn about Y(0) by
# assigning those other units to control.

png(file="fig11-assignedcondition.png", width=960, height=760, pointsize=24)

col_sample1 <- rep("red", N)
col_sample1[-sample1] <- "blue"
y_sample1 <- "D=1"
y_sample1[-sample1] <- "D=0"

plot(x,y, lwd=2, cex=8, col=col_sample1,
     main="", xlab="", ylab="", axes=FALSE,
     xlim=c(0.75,(N/3)+0.25), ylim=c(0,3.25))
text(x[sample1], y[sample1], "D=1", cex=1.5, col="red")
text(x[-sample1], y[-sample1], "D=0", cex=1.5, col="blue")

dev.off()


png(file="fig11-randomassignment1.png", width=960, height=760, pointsize=24)

col_sample1 <- rep("red", N)
col_sample1[-sample1] <- "blue"
y_sample1 <- Y1
y_sample1[-sample1] <- Y0

plot(x,y, lwd=2, cex=8, col=col_sample1,
     main="", xlab="", ylab="", axes=FALSE,
     xlim=c(0.75,(N/3)+0.25), ylim=c(0,3.25))
text(x[sample1], y[sample1], Y1[sample1], cex=2, col="red")
text(x[-sample1], y[-sample1], Y0[-sample1], cex=2, col="blue")

mtext("5 - 4.83 = 0.17", side=1, cex=2)
dev.off()

##################################
# let's do another sample,
# note you get a different answer, this time it's a little larger than the truth

png(file="fig12-randomassignment2.png", width=960, height=760, pointsize=24)

col_sample2 <- rep("red", N)
col_sample2[-sample2] <- "blue"
y_sample2 <- Y1
y_sample2[-sample2] <- Y0

plot(x,y, lwd=2, cex=8, col=col_sample2,
     main="", xlab="", ylab="", axes=FALSE,
     xlim=c(0.75,(N/3)+0.25), ylim=c(0,3.25))
text(x[sample2], y[sample2], Y1[sample2], cex=2, col="red")
text(x[-sample2], y[-sample2], Y0[-sample2], cex=2, col="blue")

mean(Y1[sample2])
mean(Y0[-sample2])

mtext("5.5 - 4.5 = 1", side=1, cex=2)
dev.off()


##################################
# attrition
# let's say we don't observe units with Y(1)=3 when under treatment

png(file="fig01-attritY1.png", width=960, height=760, pointsize=24)

pch4 <- rep(1,length(Y1))
pch4[which(Y1==3)] <- 13
mean(Y1[which(Y1>3)])

plot(x,y, lwd=2, lty=2, pch=pch4, cex=8, col="red",
     main="", xlab="", ylab="", axes=FALSE,
     xlim=c(0.75,(N/3)+0.25), ylim=c(0,3.25))
# mean(Y1)
text(x,y, Y1, cex=2, col="red")
mtext("true average of observed Y(1) = 6", side=1, cex=2, col="red")
dev.off()

##################################
# attrition
# let's say we don't observe units with Y(0)>6 when under control

png(file="fig02-attritY0.png", width=960, height=760, pointsize=24)

pch5 <- rep(13,length(Y0))
pch5[which(Y0<7)] <- 1
mean(Y0[which(Y0<7)])

plot(x,y, lwd=2, cex=8, pch=pch5, col="blue",
     main="", xlab="", ylab="", axes=FALSE,
     xlim=c(0.75,(N/3)+0.25), ylim=c(0,3.25))

text(x,y, Y0, cex=2, col="blue")
# mean(Y0) #4.75
mtext("true average of observed Y(0) = 4.2", side=1, cex=2, col="blue")
dev.off()


##################################
## for 2024 LD causal inference slides:
## complete randomization 6 of 12

y1 <- c(7,5,3,3,5,8,6,5,3,7,6,5)
tau <- c(1,1,1,0,0,0,1,1,1,0,0,0)
y0 <- y1-tau

library(randomizr)
m1 <- declare_ra(N=12,m=6)
perms <- obtain_permutation_matrix(m1)

y1est <- t(as.matrix(y1, nrow=1))
y1estdist <- y1est%*%perms/6

y0est <- t(as.matrix(y0, nrow=1))
y0estdist <- y0est%*%(1-perms)/6


tau1 <- y1estdist-y0estdist


png(file="fig-y1dist.png", width=960, height=600, pointsize=24)

hist(y1estdist, col="red", breaks=16, main="Distribution of sample averages of Y(1)", xlab="")
abline(v=mean(y1), lwd=2)

dev.off()

png(file="fig-taudist.png", width=960, height=400, pointsize=24)
hist(tau1, col="purple", breaks=16, main="Distribution of ATE estimates", xlab="")
abline(v=mean(tau1), lwd=4)

dev.off()
