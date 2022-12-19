library(stats)
library(ggplot2)
pheromone_data <- read.csv("pheromone_data.csv")
pheromone_data1 <- as.matrix(pheromone_data[,-1])
rownames(pheromone_data1) <- pheromone_data[,1]

heatmap(pheromone_data1)

# labels are cut off and have things that look like phylogenies, clustering. Madison doesnt use clustering in R because she doesnt know how its quantifying this

heatmap(pheromone_data1,
        Colv = NA, # no column clustering
        Rowv = NA, # no row clustering
        margins = c(7,5), # changing the margins
        cexCol = 1, # changing the size of the column names, this makes them smaller
        main = "Pheromone Gene Expression", # adds title
        xlab = "Groups", # x title
        ylab = "Gene")  # y title

heatmap(pheromone_data1,
        Colv = NA, # no column clustering
        Rowv = NA, # no row clustering
        margins = c(7,5), # changing the margins
        cexCol = 1, # changing the size of the column names, this makes them smaller
        col = terrain.colors(10), # number inside tells you how many colors do you want inside your heatmap. want what best visualizes your data. 
        main = "Pheromone Gene Expression", # adds title
        xlab = "Groups", # x title
        ylab = "Gene")  # y title

pheromone_data2 <- read.csv("pheromone_data2.csv")
# using ggplot to make heatmaps instead of the base heatmap package in R
ggplot(pheromone_data2,
       aes(x = Sample, y = Gene, fill = Expression)) +
  geom_tile()

#customize it
ggplot(pheromone_data2,
       aes(x = Sample, y = Gene, fill = Expression)) +
  geom_tile(colour = "black", size = 0.5) +
  scale_fill_gradient(low = "black", high = "blue") +
  theme_grey(base_size = 12) +
  theme(axis.ticks = element_blank(), 
        plot.background = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank())

#customize it again
ggplot(pheromone_data2,
       aes(x = Sample, y = Gene, fill = Expression)) +
  geom_tile(colour = "black", size = 0.5) +
  scale_fill_gradient(low = "black", high = "blue") +
  theme_grey(base_size = 12) +
  theme(plot.title = element_text(face = "bold"),
        legend.title = element_text(face = "bold"),
        axis.title = element_text(face = "bold"), 
        axis.text.y = element_text(color = "black"),
        axis.text.x = element_text(angle = 270, hjust = 0, color = "black"),
        axis.ticks = element_blank(), 
        plot.background = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank())


# facet our heat map
ggplot(pheromone_data2,
       aes(x = Sample, y = Gene, fill = Expression)) +
  geom_tile(colour = "black", size = 0.5) +
  scale_fill_gradient(low = "black", high = "blue") +
  theme_grey(base_size = 12) +
  facet_grid(~ Gland) +
ggtitle(label = "Pheromone Gene Expression") +
  scale_x_discrete(labels = c('D.brim', 'E.tyn M', 'E.tyn P', 'P.alb', 'D.brim', 'E.tyn M', 'E.tyn P', 'P.alb')) +
  theme(plot.title = element_text(face = "bold"),
        legend.title = element_text(face = "bold"),
        axis.title = element_text(face = "bold"),
        axis.title.x = element_blank(),
        axis.text.y = element_text(color = "black"),
        axis.text.x = element_text(angle = 270, hjust = 0, color = "black"),
        axis.ticks = element_blank(), 
        plot.background = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank())

# change to only columns with data
ggplot(pheromone_data2,
       aes(x = Sample, y = Gene, fill = Expression)) +
  geom_tile(colour = "black", size = 0.5) +
  scale_fill_gradient(low = "black", high = "blue") +
  theme_grey(base_size = 12) +
  facet_grid(~ Gland, switch = "x", scales = "free_x", space = "free_x") +
  ggtitle(label = "Pheromone Gene Expression") +
  scale_x_discrete(labels = c('D.brim', 'E.tyn M', 'E.tyn P', 'P.alb', 'D.brim', 'E.tyn M', 'E.tyn P', 'P.alb')) +
  theme(plot.title = element_text(face = "bold"),
        strip.placement = "outside", 
        legend.title = element_text(face = "bold"),
        axis.title = element_text(face = "bold"),
        axis.title.x = element_blank(),
        axis.text.y = element_text(color = "black"),
        axis.text.x = element_text(color = "black"),
        axis.ticks = element_blank(), 
        plot.background = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank())
