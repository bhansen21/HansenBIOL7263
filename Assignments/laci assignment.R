install.packages("ggfortify")
install.packages("devtools")
install.packages("remotes") 
install.packages("rgl")
install.packages("pca3d")

str(iris)
summary(iris)


# create factor
group_species <- factor(iris$Species,
                        levels = c("versicolor", "virginica", "setosa"))

summary(group_species)

#check correlation
round(cor(iris[,1:4]), 2)

#PCA
iris_pca <- prcomp(iris[,1:4],
                   center = TRUE,
                   scale. = TRUE,
                   cor = TRUE,
                   scores=TRUE)

View(iris)
summary(iris_pca)

## plots
library(ggfortify)
#plot our pc components
iris_pca_plot <- autoplot(iris_pca,
                          data=iris,
                          colour= 'Species'
                          )
iris_pca_plot

# screeplot - how many pcs to actually keep
iris_pca_scree <- plot(iris_pca, type="lines")

#biplot
iris_pca_biplot <- biplot(iris_pca)

#3-dimensional
library(pca3d)

pca3d(iris_pca, group=group_species)
pca3d(iris_pca, components = 1:3, group=group_species)

#visualize with interactive plot
snapshotPCA3d(file="first3pcs.png")

#create figure for saving 
pca2d(iris_pca, group=group_species,
      legend="topright")

## Alternative method

# Different pca set-up - princomp
# correlation vs. covariance matrix
Iris_pca <- princomp(iris[,1:4],
                     center = TRUE,   # mean of 0
                     scale. = TRUE,   # STD of 1 
                     cor = TRUE,
                     scores = TRUE)
library(rgl)

plot3d(Iris_pca$scores[,1:3])

# text3d(Iris_pca$scores[,1:3],
#        texts=rownames(iris),
#        col="red")
text3d(Iris_pca$loadings[,1:3],
       texts=rownames(Iris_pca$loadings),
       col="red")
