#let's look at a log likelihood plot
xvals<-seq(from=-1, to=1, length.out=1000)
plot(xvals, log(sapply(xvals, dnorm, mean=0, sd=4)), type="l", bty="n", xlab="value", ylab="Log likelihood",ylim=c(-2,2))
abline(h=0, lty="dotted")
sd.vector <- seq(from=1, to=0.05, length.out=5)
for (iterator in sequence(length(sd.vector))) {
  lines(xvals, log(sapply(xvals, dnorm, mean=0, sd=sd.vector[iterator])))
}

#What? A positive log likelihood? Let's look at that in non-log space:
plot(xvals, sapply(xvals, dnorm, mean=0, sd=0.05), type="l", bty="n", xlab="value", ylab="Likelihood")
#How can we have a likelihood greater than 1?


#set up for next visualization
par(mfcol=c(3,3))





#Let's go back to coin flipping in R. Let's have three hypotheses:
prob.heads.hypotheses <- c(0.1, 0.5, 0.8) 


prior.on.hypotheses <- c(-------------------) #add your own here. What is the prob of c(0.1, 0.5, etc.
prior.on.hypotheses <- prior.on.hypotheses/sum(prior.on.hypotheses) #priors should sum to 1

#next assume our next flips we get 2/3 heads
num.flips <- 3
num.heads <- round(num.flips*2/3)

#how to calculate the likelihood?
likelihood.data.given.hypotheses <- c(----, -----, ----)

#hint: ?dbinom




#Now, write a function for Bayes Rule. Assume that the three hypotheses are the only ones possible

#store the posteriors as the vector posterior.on.hypotheses
posterior.on.hypotheses<-stuff()

barplot(prior.on.hypotheses, main="Prior")
barplot(likelihood.data.given.hypotheses, main="Likelihood")
barplot(posterior.on.hypotheses, main="Posterior")

#Now, try again with different priors
#And try again with different sample size (num.heads)





#Let's model evolution with a trend. 
#We're going to go very basic for this. Our tree is a polytomy.
ntaxa<-10
sd.along.branch <- 0.3
trend.direction<-rnorm(1, 1, sd=0.5)
starting.state<-rnorm(1, sd=0.1)
tips<-rnorm(20,mean=trend.direction+starting.state, sd=sd.along.branch)
par(mfcol=c(1,1))
plot(x=c(0,1), y=range(c(starting.state, tips)), bty="n", xlab="time", ylab="state", type="n")
for (i in sequence(ntaxa)) {
  lines(c(0,1), c(starting.state, tips[i])) 
}

#Now:
#Step 1: Program way to calculate likelihood of the observed tip.data. 
GetLogLikelihood <- function(starting.state, trend.direction, sd.along.branch, tips) {
  individual.log.likelihoods<- ----SOMETHING----- #using log
    overall.log.likelihood <- -----SOMETHING------
    return(overall.log.likelihood)
}

#Does anyone see a problem at this point?

require(akima)
nreps=400
starting.vector <- rnorm(400, starting.state, .2)
trend.vector <- rnorm(400, trend.direction, .2)
likelihood.values<-rep(NA,nreps)
for (i in sequence(nreps)) {
  likelihood.values[i] <- GetLogLikelihood(starting.vector[i], trend.vector[i], sd.along.branch, tips)
}

plot(starting.vector + trend.vector, likelihood.values, xlab="Trend + Starting", ylab="Log Likelihood", bty="n", pch=".")

#looks good, right?

rescaled.likelihood<-max(likelihood.values) - likelihood.values


interpolated.points<-interp(x=starting.vector, y=trend.vector, z= rescaled.likelihood, linear=FALSE, extrap=TRUE, xo=seq(min(starting.vector), max(starting.vector), length = 400), yo=seq(min(trend.vector), max(trend.vector), length = 400))

contour(interpolated.points, xlim=range(starting.vector),ylim=range(trend.vector), xlab="Starting state", ylab="Trend", levels=c(2,5,10),add=FALSE,lwd=1, bty="n", asp=1)

#How would a prior affect this?