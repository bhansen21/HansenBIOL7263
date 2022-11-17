# install geomorph package
install.packages("geomorph", dependencies = TRUE)
# load geomorph package
library(geomorph)
# when i load this package it does pull up xquartz in my computer, may need some system like this to run properly 

# create a folder with the images you want to compare, must be jpegs. there are other packages that allow you to analyze other file types. 
# I created a folder in my assignments folder titled "my work"

# set working directory to the folder with your images

# this allowed all the files in my folder that are jpegs to be made into a filelist 
filelist <- list.files(pattern = "*.jpeg")

# this pulled up my first image 
# first it is going to have you set a scale, because our scale is 3 this means we need to set a scale that is 3 mm long
digitize2d(filelist, nlandmarks = 11, scale = 3, tpsfile = "shrimp3.tps", verbose = TRUE)
# after setting a scale it will ask you if you want to keep it, if you like what you have then enter "y"
# now it is asking you to set your landmark points. I want to measure features of the claw. The amount of landmarks I have to set is 11, this number can be changed to more or less depending on the specimen you have. 

# after digitizing this all the points have been landmarked in shrimp.tps

mydata <- readland.tps("shrimp3.tps", specID= "ID")

#lets you view your data
mydata

# this worked
Y.gpa <- gpagen(mydata, print.progress = FALSE)
ref <- mshape(Y.gpa$coords)

#this worked. the 2 is the second number in the dataset ? lol
plotRefToTarget(ref, Y.gpa$coords[,,2], method="TPS")

#magnifies the difference X3
plotRefToTarget(ref, Y.gpa$coords[,,2], mag=3, method="TPS")

#shows the displacement between landmarks, it is comparing the reference and target specimen
plotRefToTarget(ref, Y.gpa$coords[,,2], mag=3, method="vector")

#showing both plots of data the reference and the target
plotRefToTarget(ref, Y.gpa$coords[,,2], mag=3, method="points")

#moving onto something different
findMeanSpec(Y.gpa$coords)
# returens the name of the specimen and the number it is

# can plot all specimens 
Y.gpa <- gpagen(mydata, print.progress = FALSE)

# this takes the data and however many photos you have with landmarks and takes the mean between all of the points
plotAllSpecimens(Y.gpa$coords, label=T, plot.param = list(pt.bg = "green", mean.cex=1, link.col= "red", txt.pos=3, txt.cex=1))

mydata <- readland.tps("shrimp.tps", specID = "ID", readcurves = TRUE, warnmsg = TRUE)

mydata <- readland.tps("shrimp.tps", specID = "ID")
mydata[,,1]
      [,1]            [,2]
[1,] 4831.8150917743 2686.47178789939
[2,] 5015.36369816451 2411.14887831407
[3,] 4024.20122365738 3016.85927940177
[4,] 4317.87899388171 2411.14887831407
[5,] 4483.0727396329 2870.0203942896
[6,] 4740.0407885792 2374.43915703603
[7,] 3602.03942895989 2851.66553365058
[8,] 5052.07341944256 2668.11692726037
[9,] 4107.25359284825 2411.55369469277
[10,] 3639.78725811927 2613.20583908566
[11,] 3878.10342876542 2484.88174719928

head(mydata)
is.matrix(mydata)

for (i in 1:length(mydata)){
  trymatrix <- as.matrix(read.table(mydata[i]))
  coords <- rbind(coords, tmp)
}
coords <- arrayspeces(coords, p, k)
dimnames(coords)[[3]] <- names

help(arrayspecs)

arrayspecs

mat1.data <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
mat1 <- matrix(mat1.data, nrow=3, ncol=3, byrow=TRUE)
mat1

mat2.shrimp <- ((4831.8150917743 2686.47178789939), (5015.36369816451 2411.14887831407), (4024.20122365738 3016.85927940177), (4317.87899388171 2411.14887831407), (4483.0727396329 2870.0203942896), (4740.0407885792 2374.43915703603), (3602.03942895989 2851.66553365058), (5052.07341944256 2668.11692726037), (4107.25359284825 2411.55369469277), (3639.78725811927 2613.20583908566), (3878.10342876542 2484.88174719928))
mat2 <- matrix(mat2.shrimp, nrow=2, ncol=11, byrow=TRUE)



library(geomorph)
filelist <- list.files(pattern = "*.jpeg")
digitize2d(filelist, nlandmarks = 11, scale = 3, tpsfile = "shrimp4.tps", verbose = TRUE)

mydata <- readland.tps("shrimp4.tps", specID= "ID") 


Y.gpa <- gpagen(mydata, print.progress = FALSE) 
ref <- mshape(Y.gpa$coords)

plotRefToTarget(ref, Y.gpa$coords[,,2], method="TPS")

plotRefToTarget(ref, Y.gpa$coords[,,2], mag=3, method="vector")

plotRefToTarget(ref, Y.gpa$coords[,,2], mag=3, method="points")
findMeanSpec(Y.gpa$coords)
Y.gpa <- gpagen(mydata, print.progress = FALSE)

plotAllSpecimens(Y.gpa$coords, label=T, plot.param = list(pt.bg = "green", mean.cex=1, link.col= "red", txt.pos=3, txt.cex=1))
