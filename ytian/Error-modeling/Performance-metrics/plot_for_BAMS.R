
# $Id: plot_for_BAMS.R,v 1.2 2014/05/16 22:39:17 ytian Exp ytian $ 
# Plot the effect of delta, lamda and sigma on PDF 

pdf_compare <- function (src, dst, dlambda, ddelta, dsigma, lab)   {
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
  ymax=max(hs$counts/sum(hs$counts), hd$counts/sum(hd$counts))  

  plot(hs$mids, hs$counts/sum(hs$counts), type="l", col="black", xlab="x or y",
     ylab="Frequency", 
     #xlim=c(x0, x1), 
     xlim=c(-10, 15), yaxt='n', xaxt='n', 
     lwd=3, mgp=c(2.5, 1, 0), ylim=c(0, 0.2), col.tick="white", cex.axis=1.0, cex.lab=2) 

#  title(paste(lab, expression(lambda=3), ", ", expression(delta=ddelta), ", ",  
#         expression(sigma=dsigma) ) )

  #title(expression(paste(lab, lambda=dlambda)) ) 
  #mtext(paste(lab, " ", bquote(lambda==.(dlambda))), side=3) 
  mtext(bquote(paste(.(lab), " ", lambda==.(dlambda), ", ", 
                                  delta==.(ddelta), ", ", 
                                  sigma==.(dsigma))), 
                                  side=3, line=0.25, cex=2) 

  lines(hd$mids, hd$counts/sum(hd$counts), xlim=c(x0, x1), type="l", lty=2, lwd=3, col="black")

  legend("topleft", c("x", "y"), cex=2, 
   lty=c(1, 2), lwd=c(3, 3),col=c("black",  "black"), bty="n" )

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
delta=0
sigma=0
noise=rnorm(nc, 0, sigma) 

y=lamda*(x+delta) + noise

pdf_compare(x, y, lamda, delta, sigma, "a)") 

# displacement error only
lamda=1
delta=3 
sigma=0
noise=rnorm(nc, 0, sigma)

y=lamda*(x+delta) + noise

pdf_compare(x, y, lamda, delta, sigma, "b)") 

# random error only
lamda=1
delta=0
sigma=4
noise=rnorm(nc, 0, sigma)

y=lamda*(x+delta) + noise

pdf_compare(x, y, lamda, delta, sigma, "c)") 

dev.copy(postscript, "compare_pdf_BAMS.ps", horizontal=T) 
dev.off()



