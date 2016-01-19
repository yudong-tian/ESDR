
# $Id: add-err-v2.R,v 1.3 2014/11/04 16:53:04 ytian Exp $ 
# Read the data and plot Fig. 1.  

my_sd <- function(x) { 
    sqrt( mean(x^2)-mean(x)*mean(x)) 
}

print_metrics <- function(x, y, n, icol) { 

    lab=c("a)", "c)", "b)", "d)") 
    xbar=mean(x) 
    ybar=mean(y) 
    sigmax2=mean( (x-xbar)^2 ) 
    lamda=mean ( (x-xbar)*(y-ybar) ) / mean( (x-xbar)^2 ) 
    delta=ybar - lamda * xbar 
    sigma = sqrt( mean( (y-lamda*x-delta)^2 ) ) 

    # conventional ones
    mse=mean( (y-x)^2 ) 
    bias = ybar - xbar
    cc = cor(y, x) 
    ss = 1 - mse/sigmax2
    cod = cc^2

    # derived from new metrics 
    nbias=(lamda-1)*xbar+delta
    nmse=nbias^2 + (lamda-1)^2*sigmax2+sigma^2
    ncc=lamda*sqrt( sigmax2/ ( lamda^2*sigmax2 + sigma^2) )
    nss=1 - nmse/sigmax2 
    ncod = ncc^2
    

    cat("lamda=", round(lamda, 3), "  delta=", round(delta, 3), "  sigma=", round(sigma, 3), "\n\n")

    cat(paste("Bias=", round(bias, 3), "  Derived=", round(nbias, 3), "\n"))
    cat(paste(" MSE=", round(mse, 3), "  Derived=", round(nmse, 3),  "\n"))
    cat(paste("  CC=", round(cc, 3), "  Derived=", round(ncc, 3),  "\n"))
    cat(paste("  SS=", round(ss, 3), "  Derived=", round(nss, 3),  "\n"))
    cat(paste(" CoD=", round(cod, 3), "  Derived=", round(ncod, 3),  "\n"))
  
    # plot the time series 
    tx=ts(x[1:n], frequency=12, start=c(2000, 8)) 
    ty=ts(y[1:n], frequency=12, start=c(2000, 8)) 
    plot.ts(tx, type="l", ylim=c(-10, 22), col="black", lwd=1.5, ylab="Temp. (deg)", cex.axis=1.0, cex.lab=1.0) 
    lines.ts(ty, col="blue", lty=3, lwd=2.0) 
    legend("topright", legend=c("Measured", "Truth"), lty=c(3, 1), cex=1.2, lwd=c(2.0, 1.2), col=c("blue", "black")) 
    # label each panel 
    text(2000.5, 20, lab[(icol-1)*2+1], cex=2, pos=4) 
    # scatter plot
    plot(x[1:n], y[1:n], xlim=c(-10, 15), ylim=c(-10, 22), cex=1, cex.axis=1.0, cex.lab=1.0,
             xlab="Reference Temp. (deg)", ylab="Estimated Temp. (deg)", col="blue") 
    abline(delta, lamda, lwd=2.0, col="blue", lty=3) 
    abline(0, 1, lwd=1.5, col="black") 
    text(10, 8.2,  paste("Bias=", round(bias, 1), sep=""), cex=1.2, pos=4) 
    text(10, 6,    paste("MSE=", round(mse, 1), sep=""), cex=1.2, pos=4) 
    text(10, 3.8,  paste("CC  =", round(cc, 2), sep=""), cex=1.2, pos=4) 
    text(10, 1.6,  paste("CoD=", round(cod, 2), sep=""), cex=1.2, pos=4) 
    text(10, -0.6, paste("SS =", round(ss, 2), sep=""), cex=1.2, pos=4) 

    text(10, -4-0.8,  bquote(paste(lambda, "=", .(round(lamda, 1)), sep="")), cex=1.6, pos=4) 
    text(10, -4-3,  bquote(paste(delta, "=", .(round(delta, 1)), sep="")), cex=1.6, pos=4) 
    text(10, -4-5.2, bquote(paste(sigma, "=", .(round(sigma, 1)), sep="")), cex=1.6, pos=4) 

    # label panel
    text(-10.2, 20, lab[(icol-1)*2+2], cex=2, pos=4) 
                        
}


# start of main program 

xdata = read.table("x.dat") 
y1data = read.table("y1.dat") 
y2data = read.table("y2.dat") 

x=xdata$V1
y1=y1data$V1
y2=y2data$V1

n=length(x) 

x11(width=11, height=8.5)
par(mfcol=c(2,2), mai=c(0.8, 0.8, 0.05, 0.3), mgp=c(2.5, 1, 0))
layout(matrix(c(1, 2, 3, 4), 2, 2, byrow=F), widths=c(1, 1), heights=c(3, 4))
par(bg="white")

print_metrics(x, y1, n, 1) 

print_metrics(x, y2, n, 2) 

dev.copy(postscript, "Fig1.ps", horizontal=T)
dev.off()




