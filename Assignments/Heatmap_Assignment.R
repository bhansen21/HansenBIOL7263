library(ggplot2)

HeatmapAssign <- read.csv("MAH_assignment_data.csv")

ggplot(HeatmapAssign,
       aes(x = Sample, y = Gene, fill = Expression)) +
  geom_tile() +
facet_grid(~Tissue, switch= "x", scales = "free_x", space = "free_x") +
  ggtitle(label = "Salamander Tissues") +
  theme(plot.title = element_text(face="bold"),
        legend.title = element_text(face = "bold"), 
        axis.title = element_text(face="bold"), 
        axis.text.y =element_text(color = "black"), 
        axis.text.x =element_text(angle = 270, hjust = 0, color = "black"), 
        axis.ticks= element_blank(),
        plot.background=element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank())
  

