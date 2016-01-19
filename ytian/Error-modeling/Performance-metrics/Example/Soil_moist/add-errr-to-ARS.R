
   to.read=file("ARS-3hr.1gd4r", "rb")
   x =readBin(to.read, numeric(), n=5849, size=4, endian="big")
   close(to.read)

# model 1
beta1=2.0
beta2=0.8

xbar=mean(x) 
alpha1=0
alpha2=(beta1-beta2)*xbar 

n=length(x) 
sigma1=0.02
sigma2=0.01

sigmax2=mean( (x-xbar)^2 ) 

y1=alpha1+beta1*x + rnorm(n, 0, sigma1) 
y2=alpha2+beta2*x + rnorm(n, 0, sigma2) 

ybar1=mean(y1) 
ybar2=mean(y2) 

outF1=file("ARS-y1.1gd4r", "wb")
  writeBin(y1, outF1, size=4, endian="big") 
close(outF1) 

outF2=file("ARS-y2.1gd4r", "wb")
  writeBin(y2, outF2, size=4, endian="big") 
close(outF2) 

lamda1=mean ( (x-xbar)*(y1-ybar1) ) / mean( (x-xbar)^2 ) 
lamda2=mean ( (x-xbar)*(y2-ybar2) ) / mean( (x-xbar)^2 ) 

delta1=ybar1/lamda1 - xbar 
delta2=ybar2/lamda2 - xbar 

# for model 1
# conventional stufff
cat("\nModel 1\n") 
cat("-------------------------------------------\n") 

cat("lamda=", round(lamda1, 3), "  delta=", round(delta1, 3), "  sigma=", round(sigma1, 3), "\n\n") 

bias1=ybar1-xbar 
nbias1=(lamda1-1)*xbar+lamda1*delta1
cat(paste("Bias=", round(bias1, 3), "  Derived=", round(nbias1, 3), "\n"))

mse1=mean( (y1-x)^2 ) 
nmse1=bias1^2 + (lamda1-1)^2*sigmax2+sigma1^2
cat(paste(" MSE=", round(mse1, 3), "  Derived=", round(nmse1, 3),  "\n"))

ss1=1 - mse1/sigmax2
nss1= 1 - nmse1/sigmax2
cat(paste("  SS=", round(ss1, 3), "  Derived=", round(nss1, 3),  "\n"))

cc1=cor(y1, x) 
ncc1=lamda1*sqrt( sigmax2/ ( lamda1^2*sigmax2 + sigma1^2) ) 
cat(paste("  CC=", round(cc1, 3), "  Derived=", round(ncc1, 3),  "\n"))

# for model 2
# conventional stufff
cat("\nModel 2\n")
cat("-------------------------------------------\n")

cat("lamda=", round(lamda2, 3), "  delta=", round(delta2, 3), "  sigma=", round(sigma2, 3), "\n\n")

bias2=ybar2-xbar
nbias2=(lamda2-1)*xbar+lamda2*delta2
cat(paste("Bias=", round(bias2, 3), "  Derived=", round(nbias2, 3), "\n"))

mse2=mean( (y2-x)^2 )
nmse2=bias2^2 + (lamda2-1)^2*sigmax2+sigma2^2
cat(paste(" MSE=", round(mse2, 3), "  Derived=", round(nmse2, 3),  "\n"))

ss2=1 - mse2/sigmax2
nss2= 1 - nmse2/sigmax2
cat(paste("  SS=", round(ss2, 3), "  Derived=", round(nss2, 3),  "\n"))

cc2=cor(y2, x)
ncc2=lamda2*sqrt( sigmax2/ ( lamda2^2*sigmax2 + sigma2^2) )
cat(paste("  CC=", round(cc2, 3), "  Derived=", round(ncc2, 3),  "\n"))

