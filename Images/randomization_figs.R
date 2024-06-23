## randomization_figs.R
##
## Nahomi Ichino, April 2023, for EGAP Learning Days
## for lecture slides on randomization

library(plotrix)


## simple randomization
png(file="simple_randomization.png", width=960, height=760, pointsize=36)
par(mar=c(0,0,0,0))
s=.5
r=.08
plot(c(-1,3.5*s), c(24,-2), type="n", main="", xlab="", ylab="", axes=FALSE)

draw.circle(0,0,r, col="#009E73")
draw.circle(s,0,r, col="#009E73")
draw.circle(2*s,0,r, col="#009E73")

draw.circle(0,3,r)
draw.circle(s,3,r, col="#009E73")
draw.circle(2*s,3,r, col="#009E73")

draw.circle(0,6,r, col="#009E73")
draw.circle(s,6,r)
draw.circle(2*s,6,r, col="#009E73")

draw.circle(0,9,r, col="#009E73")
draw.circle(s,9,r, col="#009E73")
draw.circle(2*s,9,r)

draw.circle(0,12,r)
draw.circle(s,12,r)
draw.circle(2*s,12,r, col="#009E73")

draw.circle(0,15,r)
draw.circle(s,15,r, col="#009E73")
draw.circle(2*s,15,r)

draw.circle(0,18,r, col="#009E73")
draw.circle(s,18,r)
draw.circle(2*s,18,r)

draw.circle(0,21,r)
draw.circle(s,21,r)
draw.circle(2*s,21,r)

text(0,24, "a")
text(s,24, "b")
text(2*s,24, "c")

text(-s, 21, "1")
text(-s, 18, "2")
text(-s, 15, "3")
text(-s, 12, "4")
text(-s, 9, "5")
text(-s, 6, "6")
text(-s, 3, "7")
text(-s, 0, "8")

dev.off()



## complete randomization
png(file="complete_randomization.png", width=960, height=960, pointsize=36)
par(mar=c(0,0,0,0))

x=.5
r=.09
l=1
plot(c(-1,2), c(8,0), type="n", main="", xlab="", ylab="", axes=FALSE)
# plot(c(-1,4), c(20,-2), type="n", main="", xlab="", ylab="", axes=FALSE)

# draw.circle(0,0,r)
# draw.circle(x,0,r)
# draw.circle(2*x,0,r)
# draw.circle(3*x,0,r)

draw.circle(0,l,r)
draw.circle(x,l,r)
draw.circle(2*x,l,r, col="#009E73")
draw.circle(3*x,l,r, col="#009E73")

draw.circle(0,l*2,r)
draw.circle(x,l*2,r, col="#009E73")
draw.circle(2*x,l*2,r)
draw.circle(3*x,l*2,r, col="#009E73")

draw.circle(0,l*3,r)
draw.circle(x,l*3,r, col="#009E73")
draw.circle(2*x,l*3,r, col="#009E73")
draw.circle(3*x,l*3,r)

draw.circle(0,l*4,r, col="#009E73")
draw.circle(x,l*4,r)
draw.circle(2*x,l*4,r)
draw.circle(3*x,l*4,r, col="#009E73")

draw.circle(0,l*5,r, col="#009E73")
draw.circle(x,l*5,r)
draw.circle(2*x,l*5,r, col="#009E73")
draw.circle(3*x,l*5,r)

draw.circle(0,l*6,r, col="#009E73")
draw.circle(x,l*6,r, col="#009E73")
draw.circle(2*x,l*6,r)
draw.circle(3*x,l*6,r)

text(0, 7, "a")
text(x, 7, "b")
text(x*2, 7, "c")
text(x*3, 7, "d")

text(-x, 6, "1")
text(-x, 5, "2")
text(-x, 4, "3")
text(-x, 3, "4")
text(-x, 2, "5")
text(-x, 1, "6")

dev.off()


## complete randomization
png(file="complete_randomization_wide.png", width=960, height=500, pointsize=36)
par(mar=c(0,0,0,0))

x=1
r=.15
l=1
plot( c(6.5,0), c(-1,4.5), type="n", main="", xlab="", ylab="", axes=FALSE)
# plot(c(-1,4), c(20,-2), type="n", main="", xlab="", ylab="", axes=FALSE)

# draw.circle(0,0,r)
# draw.circle(x,0,r)
# draw.circle(2*x,0,r)
# draw.circle(3*x,0,r)

draw.circle(l,0,r)
draw.circle(l,x,r)
draw.circle(l,2*x,r, col="#009E73")
draw.circle(l,3*x,r, col="#009E73")

draw.circle(l*2,0,r)
draw.circle(l*2,x,r, col="#009E73")
draw.circle(l*2,2*x,r)
draw.circle(l*2,3*x,r, col="#009E73")

draw.circle(l*3,0,r)
draw.circle(l*3,x,r, col="#009E73")
draw.circle(l*3,2*x,r, col="#009E73")
draw.circle(l*3,3*x,r)

draw.circle(l*4,0,r, col="#009E73")
draw.circle(l*4,x,r)
draw.circle(l*4,2*x,r)
draw.circle(l*4,3*x,r, col="#009E73")

draw.circle(l*5,0,r, col="#009E73")
draw.circle(l*5,x,r)
draw.circle(l*5,2*x,r, col="#009E73")
draw.circle(l*5,3*x,r)

draw.circle(l*6,0,r, col="#009E73")
draw.circle(l*6,x,r, col="#009E73")
draw.circle(l*6,2*x,r)
draw.circle(l*6,3*x,r)

text(l,4*x,"1")
text(2*l,4*x,"2")
text(3*l,4*x,"3")
text(4*l,4*x,"4")
text(5*l,4*x,"5")
text(6*l,4*x,"6")

text(0, 3*x, "a")
text(0, 2*x, "b")
text(0, 1*x, "c")
text(0, 0, "d")

segments(x0=1.5*l, y0=-0.5*x, x1=1.5*l, y1=4.5*x, lty=2)
segments(x0=2.5*l, y0=-0.5*x, x1=2.5*l, y1=4.5*x, lty=2)
segments(x0=3.5*l, y0=-0.5*x, x1=3.5*l, y1=4.5*x, lty=2)
segments(x0=4.5*l, y0=-0.5*x, x1=4.5*l, y1=4.5*x, lty=2)
segments(x0=5.5*l, y0=-0.5*x, x1=5.5*l, y1=4.5*x, lty=2)


dev.off()


## block randomization
png(file="block_randomization.png", width=960, height=300, pointsize=36)
par(mar=c(0,0,0,0))

x=.5
r=.09
l=1
plot(c(-1,4), c(2.5,-1), type="n", main="", xlab="", ylab="", axes=FALSE)

draw.circle(0,0,r, col="#009E73")
draw.circle(x,0,r)
draw.circle(2*x,0,r, col="#009E73")

draw.circle(0,1,r, col="#009E73")
draw.circle(x,1,r)
draw.circle(2*x,1,r)

draw.circle(4*x,0,r, col="#009E73")
draw.circle(5*x,0,r, col="#009E73")
draw.circle(6*x,0,r)
draw.circle(4*x,1,r)
draw.circle(5*x,1,r)
draw.circle(6*x,1,r, col="#009E73")


text(x, 2, "Block A")
text(x*5, 2, "Block B")

segments(x0=1.5, y0=-0.5, x1=1.5, y1=2.5, lty=2)
segments(x0=-0.5, y0=2.5, x1=3.5, y1=2.5, lty=2)
segments(x0=-0.5, y0=-0.5, x1=3.5, y1=-0.5, lty=2)
segments(x0=-0.5, y0=-0.5, x1=-0.5, y1=2.5, lty=2)
segments(x0=3.5, y0=-0.5, x1=3.5, y1=2.5, lty=2)


dev.off()


## simple randomization
png(file="simple_randomization_wide.png", width=800, height=500, pointsize=36)
par(mar=c(0,0,0,0))
s=.5
r=.6
plot(c(24,-3), c(-0.5,3.5*s), type="n", main="", xlab="", ylab="", axes=FALSE)

draw.circle(0,0,r, col="#009E73")
draw.circle(0,s,r, col="#009E73")
draw.circle(0,2*s,r, col="#009E73")

draw.circle(3,0,r)
draw.circle(3,s,r, col="#009E73")
draw.circle(3,2*s,r, col="#009E73")

draw.circle(6,0,r, col="#009E73")
draw.circle(6,s,r)
draw.circle(6,2*s,r, col="#009E73")

draw.circle(9,0,r, col="#009E73")
draw.circle(9,s,r, col="#009E73")
draw.circle(9,2*s,r)

draw.circle(12,0,r)
draw.circle(12,s,r)
draw.circle(12,2*s,r, col="#009E73")

draw.circle(15,0,r)
draw.circle(15,s,r, col="#009E73")
draw.circle(15,2*s,r)

draw.circle(18,0,r, col="#009E73")
draw.circle(18,s,r)
draw.circle(18,2*s,r)

draw.circle(21,0,r)
draw.circle(21,s,r)
draw.circle(21,2*s,r)

# text(-2,0, "c")
# text(-2,s, "b")
# text(-2,2*s, "a")

h=3

text(21, h*s,"8")
text(18, h*s,"7")
text(15, h*s,"6")
text(12, h*s,"5")
text(9, h*s,"4")
text(6, h*s,"3")
text(3, h*s,"2")
text(0, h*s,"1")

for(i in 0:6){
  segments(x0=1.5+3*i, y0=-0.5*s, x1=1.5+3*i, y1=3.25*s, lty=2)
}



dev.off()


## block randomization with diff prob of treatment assignment
png(file="block_randomization_diffprob.png", width=960, height=300, pointsize=36)
par(mar=c(0,0,0,0))

x=.5
r=.09
l=1
plot(c(-1,4), c(2.5,-1), type="n", main="", xlab="", ylab="", axes=FALSE)

draw.circle(0,0,r, col="#009E73")
draw.circle(x,0,r)
draw.circle(2*x,0,r, col="#009E73")

draw.circle(0,1,r, col="#009E73")
draw.circle(x,1,r)
draw.circle(2*x,1,r)

draw.circle(4*x,0,r, col="#009E73")
draw.circle(5*x,0,r)
draw.circle(6*x,0,r)
draw.circle(4*x,1,r)
draw.circle(5*x,1,r)
draw.circle(6*x,1,r, col="#009E73")


text(x, 2, "Block A")
text(x*5, 2, "Block B")

segments(x0=1.5, y0=-0.5, x1=1.5, y1=2.5, lty=2)
segments(x0=-0.5, y0=2.5, x1=3.5, y1=2.5, lty=2)
segments(x0=-0.5, y0=-0.5, x1=3.5, y1=-0.5, lty=2)
segments(x0=-0.5, y0=-0.5, x1=-0.5, y1=2.5, lty=2)
segments(x0=3.5, y0=-0.5, x1=3.5, y1=2.5, lty=2)


dev.off()


## block randomization with different block sizes
png(file="block_randomization_diffsize.png", width=960, height=300, pointsize=36)
par(mar=c(0,0,0,0))

x=.5
r=.09
l=1
plot(c(-1,4), c(2.5,-1), type="n", main="", xlab="", ylab="", axes=FALSE)

draw.circle(0,0,r, col="#009E73")
draw.circle(x,0,r)
draw.circle(2*x,0,r, col="#009E73")
draw.circle(3*x,0,r)

draw.circle(0,1,r, col="#009E73")
draw.circle(x,1,r, col="#009E73")
draw.circle(2*x,1,r)
draw.circle(3*x,1,r)

draw.circle(5*x,0,r, col="#009E73")
draw.circle(6*x,0,r)
draw.circle(5*x,1,r)
draw.circle(6*x,1,r, col="#009E73")


text(x*1.5, 2, "Block A")
text(x*5.5, 2, "Block B")

segments(x0=2, y0=-0.5, x1=2, y1=2.5, lty=2)
segments(x0=-0.5, y0=2.5, x1=3.5, y1=2.5, lty=2)
segments(x0=-0.5, y0=-0.5, x1=3.5, y1=-0.5, lty=2)
segments(x0=-0.5, y0=-0.5, x1=-0.5, y1=2.5, lty=2)
segments(x0=3.5, y0=-0.5, x1=3.5, y1=2.5, lty=2)


dev.off()


## cluster randomization
png(file="cluster_randomization.png", width=960, height=300, pointsize=36)
par(mar=c(0,0,0,0))

x=.7
r=.2
l=1
plot(c(-1,15*x+1), c(3.5,-1), type="n", main="", xlab="", ylab="", axes=FALSE)

draw.circle(0,0,r, col="#009E73")
draw.circle(x,0,r, col="#009E73")
draw.circle(2*x,0,r, col="#009E73")

draw.circle(4*x,0,r, col="#009E73")
draw.circle(5*x,0,r, col="#009E73")
draw.circle(6*x,0,r, col="#009E73")

draw.circle(8*x,0,r)
draw.circle(9*x,0,r)
draw.circle(10*x,0,r)

draw.circle(12*x,0,r)
draw.circle(13*x,0,r)
draw.circle(14*x,0,r)

text(x, 1, "Cluster E")
text(x*5, 1, "Cluster F")
text(x*9, 1, "Cluster G")
text(x*13, 1, "Cluster H")

draw.circle(0,2,r)
draw.circle(x,2,r)
draw.circle(2*x,2,r)

draw.circle(4*x,2,r, col="#009E73")
draw.circle(5*x,2,r, col="#009E73")
draw.circle(6*x,2,r, col="#009E73")

draw.circle(8*x,2,r, col="#009E73")
draw.circle(9*x,2,r, col="#009E73")
draw.circle(10*x,2,r, col="#009E73")

draw.circle(12*x,2,r)
draw.circle(13*x,2,r)
draw.circle(14*x,2,r)

text(x, 3, "Cluster A")
text(x*5, 3, "Cluster B")
text(x*9, 3, "Cluster C")
text(x*13, 3, "Cluster D")


segments(x0=-1*x, y0=-0.5, x1=-1*x, y1=3.5, lty=2)
segments(x0=3*x, y0=-0.5, x1=3*x, y1=3.5, lty=2)
segments(x0=7*x, y0=-0.5, x1=7*x, y1=3.5, lty=2)
segments(x0=11*x, y0=-0.5, x1=11*x, y1=3.5, lty=2)
segments(x0=15*x, y0=-0.5, x1=15*x, y1=3.5, lty=2)

segments(x0=-1*x, y0=-0.5, x1=15*x, y1=-0.5, lty=2)
segments(x0=-1*x, y0=1.5, x1=15*x, y1=1.5, lty=2)
segments(x0=-1*x, y0=3.5, x1=15*x, y1=3.5, lty=2)



dev.off()



## block-cluster randomization
png(file="blockcluster_randomization.png", width=960, height=480, pointsize=36)
par(mar=c(0,0,0,0))

x=.5
r=.09
l=1
plot(c(-1,15*x+1), c(5.5,-1), type="n", main="", xlab="", ylab="", axes=FALSE)

draw.circle(0,0,r, col="#009E73")
draw.circle(x,0,r, col="#009E73")
draw.circle(2*x,0,r, col="#009E73")

draw.circle(4*x,0,r)
draw.circle(5*x,0,r)
draw.circle(6*x,0,r)

draw.circle(8*x,0,r, col="#009E73")
draw.circle(9*x,0,r, col="#009E73")
draw.circle(10*x,0,r, col="#009E73")

draw.circle(12*x,0,r)
draw.circle(13*x,0,r)
draw.circle(14*x,0,r)

text(x, 1, "Cluster E")
text(x*5, 1, "Cluster F")
text(x*9, 1, "Cluster G")
text(x*13, 1, "Cluster H")
text(x*3, 2, "Block 3")
text(x*11, 2, "Block 4")

draw.circle(0,3,r)
draw.circle(x,3,r)
draw.circle(2*x,3,r)

draw.circle(4*x,3,r, col="#009E73")
draw.circle(5*x,3,r, col="#009E73")
draw.circle(6*x,3,r, col="#009E73")

draw.circle(8*x,3,r, col="#009E73")
draw.circle(9*x,3,r, col="#009E73")
draw.circle(10*x,3,r, col="#009E73")

draw.circle(12*x,3,r)
draw.circle(13*x,3,r)
draw.circle(14*x,3,r)

text(x, 4, "Cluster A")
text(x*5, 4, "Cluster B")
text(x*9, 4, "Cluster C")
text(x*13, 4, "Cluster D")
text(x*3, 5, "Block 1")
text(x*11, 5, "Block 2")

segments(x0=-1*x, y0=-0.5, x1=-1*x, y1=5.5, lty=1)
segments(x0=15*x, y0=-0.5, x1=15*x, y1=5.5, lty=1)
segments(x0=-1*x, y0=-0.5, x1=15*x, y1=-0.5, lty=1)
segments(x0=-1*x, y0=2.5, x1=15*x, y1=2.5, lty=1)
segments(x0=-1*x, y0=5.5, x1=15*x, y1=5.5, lty=1)
segments(x0=7*x, y0=-0.5, x1=7*x, y1=5.5, lty=1)


segments(x0=3*x, y0=-0.5, x1=3*x, y1=1.5, lty=1)
segments(x0=3*x, y0=2.5, x1=3*x, y1=4.5, lty=2)

segments(x0=11*x, y0=-0.5, x1=11*x, y1=1.5, lty=2)
segments(x0=11*x, y0=2.5, x1=11*x, y1=4.5, lty=2)

dev.off()


## delayed access design
png(file="./Images/delayed_access.png", width=960, height=480, pointsize=36)
par(mar=c(0,0,0,0))

x=.5
r=.09
l=1
plot(c(-1,5*x+1), c(3.5,-1), type="n", main="", xlab="", ylab="", axes=FALSE)

draw.circle(x,0,r)
draw.circle(2*x,0,r, col="#009E73")
draw.circle(3*x,0,r)
draw.circle(5*x,0,r)

draw.circle(0,1,r, col="#009E73")
draw.circle(x,1,r)
draw.circle(2*x,1,r)
draw.circle(3*x,1,r)
draw.circle(5*x,1,r)

draw.circle(0,2,r)
draw.circle(x,2,r)
draw.circle(2*x,2,r)
draw.circle(3*x,2,r)
draw.circle(4*x,2,r, col="#009E73")
draw.circle(5*x,2,r)

text(-x, 2, "t=1")
text(-x, 1, "t=2")
text(-x, 0, "t=3")


segments(x0=-1.5*x, y0=1.5, x1=6*x, y1=1.5, lty=2)
segments(x0=-1.5*x, y0=0.5, x1=6*x, y1=0.5, lty=2)



dev.off()


## multiarm
png(file="multiarm_design_wide.png", width=800, height=500, pointsize=36)
par(mar=c(0,0,0,0))
s=.5
r=.6
plot(c(16,-3), c(-0.5,3.5*s), type="n", main="", xlab="", ylab="", axes=FALSE)

draw.circle(0,0,r, col="#009E73")
draw.circle(0,s,r)
draw.circle(0,2*s,r, col="#CC79A7")

draw.circle(3,0,r)
draw.circle(3,s,r, col="#009E73")
draw.circle(3,2*s,r, col="#CC79A7")

draw.circle(6,0,r, col="#CC79A7")
draw.circle(6,s,r)
draw.circle(6,2*s,r, col="#009E73")

draw.circle(9,0,r)
draw.circle(9,s,r, col="#CC79A7")
draw.circle(9,2*s,r, col="#009E73")

draw.circle(12,0,r, col="#009E73")
draw.circle(12,s,r, col="#CC79A7")
draw.circle(12,2*s,r)

draw.circle(15,0,r, col="#CC79A7")
draw.circle(15,s,r, col="#009E73")
draw.circle(15,2*s,r)

text(-2,0, "c")
text(-2,s, "b")
text(-2,2*s, "a")

h=3

text(15, h*s,"6")
text(12, h*s,"5")
text(9, h*s,"4")
text(6, h*s,"3")
text(3, h*s,"2")
text(0, h*s,"1")

for(i in 0:4){
  segments(x0=1.5+3*i, y0=-0.5*s, x1=1.5+3*i, y1=2.5*s, lty=2)
}



dev.off()

