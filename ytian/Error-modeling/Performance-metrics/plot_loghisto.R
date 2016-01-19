
# $Id: plot_loghisto.R,v 1.1 2013/11/24 23:00:08 ytian Exp ytian $ 
# Plot PDF of various space/time scales

loghist_compare3 <- function (src, dst1, dst2, title)   {
  # find the range of data
  x0=min(min(src, na.rm=T), min(dst1, na.rm=T), min(dst2, na.rm=T))
  x1=max(max(src, na.rm=T), max(dst1, na.rm=T), max(dst2, na.rm=T))
  x0=-20 
  x1=20 
  # number of bins for histogram and CDF
  hbins=80
  hsize=(x1-x0)/hbins

  hs = hist(src, plot=F, breaks=c(x0+hsize*0:hbins))
  hd1 = hist(dst1, plot=F, breaks=c(x0+hsize*0:hbins))
  hd2 = hist(dst2, plot=F, breaks=c(x0+hsize*0:hbins))
  ymax=max(hs$counts/sum(hs$counts), hd1$counts/sum(hd1$counts), 
           hd2$counts/sum(hd2$counts)) 
  plot(hs$mids, hs$counts/sum(hs$counts), type="l", col="black", xlab="log(x) or log(y)",
     ylab="Frequency", 
     xlim=c(-8, 8), 
     lwd=3, mgp=c(2, 1, 0), ylim=c(0, ymax),
     main=title)

  lines(hd1$mids, hd1$counts/sum(hd1$counts), xlim=c(x0, x1), type="l", lty=2, lwd=3, col="black")

  lines(hd2$mids, hd2$counts/sum(hd2$counts), xlim=c(x0, x1), type="l", lty=3, lwd=3, col="black")

  legend("topleft", c("x", "y0", "y"), cex=1, 
lty=c(1, 2, 3), lwd=c(3, 3, 3),col=c("black", "black", "black"), bty="o" )

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

x=rlnorm(nc, 0, 3) 

#postscript(file="compare-pdf.ps", horizontal=F)
#cat("ifile=", ifile, "\n")

par(mfcol=c(2,1))
par(bg="white")
opt <- options(scipen = 10)

alpha=1.2 
beta=1.0
sigma=1.5
noise=rlnorm(nc, 0, sigma) 
y0= exp(alpha)* (x**beta) 
y = y0 * noise 

loghist_compare3(log(x), log(y0), log(y), "alpha=1.2, beta=1, sigma=1.5") 

alpha=0 
beta=0.6
sigma=1.5
noise=rlnorm(nc, 0, sigma) 

y0= exp(alpha)* (x**beta) 
y = y0 * noise 

loghist_compare3(log(x), log(y0), log(y), "alpha=0, beta=0.6, sigma=1.5") 


dev.copy(postscript, "compare-pdf.ps", horizontal=F) 
dev.off()



