
# $Id: plot_for_BAMS2.R,v 1.1 2014/05/19 21:55:03 ytian Exp ytian $ 
# Plot the effect of delta, lamda and sigma on PDF 

pdf_compare <- function (src, dst, dst2) { 
  # find the range of data
  x0=min(min(src, na.rm=T), min(dst, na.rm=T)) 
  x1=max(max(src, na.rm=T), max(dst, na.rm=T)) 

  x0=-40 
  x1=40

  # number of bins for histogram and CDF
  hbins=80
  hsize=(x1-x0)/hbins

  hs = hist(src, plot=F, breaks=c(x0+hsize*0:hbins), warn.unused=F)
  hd = hist(dst, plot=F, breaks=c(x0+hsize*0:hbins), warn.unused=F)
  hd2 = hist(dst2, plot=F, breaks=c(x0+hsize*0:hbins), warn.unused=F)
  ymax=max(hs$counts/sum(hs$counts), hd$counts/sum(hd$counts))  

  plot(hs$mids, hs$counts/sum(hs$counts), type="l", col="black", xlab="x or y",
     ylab="Frequency", 
     #xlim=c(x0, x1), 
     xlim=c(-10, 15), yaxt='n', xaxt='n', 
     lwd=4, mgp=c(2.5, 1, 0), ylim=c(0, 0.22), col.tick="white", cex.axis=1.0, cex.lab=2) 

#  title(paste(lab, expression(lambda=3), ", ", expression(delta=ddelta), ", ",  
#         expression(sigma=dsigma) ) )

  #title(expression(paste(lab, lambda=dlambda)) ) 
  #mtext(paste(lab, " ", bquote(lambda==.(dlambda))), side=3) 

  lines(hd$mids, hd$counts/sum(hd$counts), type="l", lty=5, lwd=3, col="red")
  lines(hd2$mids, hd2$counts/sum(hd2$counts), type="l", lty=5, lwd=3, col="blue")

#  legend("topleft", c("x", "y"), cex=2, 
#   lty=c(1, 2), lwd=c(3, 3),col=c("black",  "black"), bty="n" )

}


# main program 
# Usage: Rscript plot_loghisto.R alpha beta errtype
# Example:
# > Rscript plot_loghisto.R 1.0 1.0 gamma 

args <- commandArgs(trailingOnly = TRUE)

#if (length(args) != 3) {
#  cat ("Usage: Rscript plot_loghisto.R alpha beta errtype \n")
#  quit(save="no")
#} 


nc=200000

x=rnorm(nc, 3, 3) 

par(mfrow=c(2,3))
par(bg="white")
opt <- options(scipen = 10)

# scale error only
lamda=1.5 
lamda2=0.75 
delta=0
sigma=0
noise=rnorm(nc, 0, sigma) 

y=lamda*(x+delta) + noise
y2=lamda2*(x+delta) + noise
pdf_compare(x, y, y2) 

legend(-13, 0.24, c(expression(lambda > 1), expression(lambda < 1)), cex=2, 
 lty=c(5, 5), lwd=c(3, 3),col=c("red",  "blue"), bty="n", seg.len=1) 

mtext(bquote(paste("a) Effect of ", lambda)), side=3, line=0.25, cex=2) 

# displacement error only
lamda=1
delta=3 
delta2=-3 
sigma=0
noise=rnorm(nc, 0, sigma)

y=lamda*(x+delta) + noise
y2=lamda*(x+delta2) + noise

pdf_compare(x, y, y2) 

legend(-13, 0.24, c(expression(delta > 0), expression(delta < 0 )), cex=2, 
 lty=c(5, 5), lwd=c(3, 3),col=c("red",  "blue"), bty="n", seg.len=1)

mtext(bquote(paste("b) Effect of ", delta)), side=3, line=0.25, cex=2) 

# random error only
lamda=1
delta=0
sigma=2
sigma2=4
noise=rnorm(nc, 0, sigma)
noise2=rnorm(nc, 0, sigma2)

y=lamda*(x+delta) + noise
y2=lamda*(x+delta) + noise2

pdf_compare(x, y, y2) 

legend(-13, 0.24, c(expression(sigma == sigma[1]), expression(sigma > sigma[1])), cex=2, 
 lty=c(5, 5), lwd=c(3, 3),col=c("red",  "blue"), bty="n", seg.len=1)

mtext(bquote(paste("c) Effect of ", sigma)), side=3, line=0.25, cex=2) 



dev.copy(postscript, "compare_pdf_BAMS2.ps", horizontal=T) 
dev.off()



