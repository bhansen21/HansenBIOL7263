require(tidyverse)
require(ggthemes)
require(patchwork)
install.packages(c("ggthemes","patchwork"))

#generic ggplot template

# p1 <- ggplot(data = <Data>, mapping = aes(<Mapping>)) +
        # <geom_function>(aes(<mappings>)),
        #       stat=<stat>,
        #       position=<POSITION>)+
        #       <theme>(<axes, font, etc>)+
        #       <coordinate_function> +
        #       <facet_function>
# p1 #to output you have to call the ggplot object
# ggsave(plot = p1, filename= "myplot", width = 5, height = 3, units = "in", device = "svg")

#quick plotting - qplot function

?mpg

#generate simple histogram with qplot

qplot(x=mpg$cty)

# add color

qplot(x=mpg$cty, fill = I("goldenrod"), color = I("black"))

# simple density plot

qplot(x=mpg$hwy, geom="density")

# simple scatter plot with linear regression line

qplot(x=mpg$cty, y=mpg$hwy, geom=c("point", "smooth"), method="lm")
## 'geom_smooth()`using formula `y ~ x`

# we can color points by variable

qplot(x=mpg$cty, y=mpg$hwy, col = mpg$class, geom=c("point"))

# the regression is now applied to each class separately

qplot(x=mpg$cty, y=mpg$hwy, col = mpg$class, geom=c("point","smooth"), method="lm")
##`geom_smooth()` using formula 'y ~ x'

#basic boxplot

qplot(x=mpg$fl, y=mpg$cty, geom="boxplot", fill=I("green"))

# simple barplot

qplot(x=mpg$fl, geom="bar")

# bar plot with specified means

mpg_summary<-mpg %>%
  group_by(class) %>%
  summarise(mean_hwy = mean(hwy))
qplot(x=mpg_summary$class, y=mpg_summary$mean_hwy, geom="col")

# we can flip this plot by layering coord_flip

p + coord_flip()

# Full ggplots themes and fonts

p1 <- ggplot(data=mpg, mapping=aes(x=hwy, y=cty)) +
  geom_point()
print(p1)

# Now that we have created the plot object with p1 we can layer elements and themes onto it
p1 + theme_bw() # clean with gridlines

p1 + theme_classic() # no grid lines

p1 + theme_dark() # good for brightly colored points

p1 + theme_void() # shows data only

# if you must
p1 + theme_excel()

# Theme modifications control font and size of text 
# use theme parameters to modify font and font size.
p1 + theme_classic(base_size=25, base_family="sans")

# you can control specific elements
p1 + labs(x="highway gas milage (mpg)") + #replace the default label on the y-axis
  theme_classic() +
  theme(axis.title.x = element_text(size = 15, angle = 45, vjust = 0.5 )) # specifically change font size, angle, and position of x-axis label

# minor modifications
p1 <- ggplot(data=mpg) +
  aes(x=hwy,y=cty) +
  geom_point(size=7,
             shape=25,
             color="black",
             fill="hotpink") +
  labs(title="My graph title here",
       subtitle="An extended subtitle that will print below the main title",
       x="My x axis label",
       y="My y axis label") +
  xlim(0,50) +
  ylim(0,50)

p1
# I dont know why you have to include the p1 at the end of that line of code but if you dont it wont run

colors() # if just run this will tell you all the colors that are avaliable in base R


# mapping of a discrete variable to point color
p1 <- ggplot(data=mpg) +
  aes(x=hwy, y=cty, color=class) +
  geom_point(size=3)
p1

# mapping of a discrete variable to point shape (<= 6)
p1 <- ggplot(data=mpg) +
  aes(x=hwy, y=cty, shape=class) +
  geom_point(size=3)
p1

#mapping of a discrete variable to point size (not advised)
p1 <- ggplot(data=mpg) +
  aes(x=hwy, y=cty, size=class) +
  geom_point()
p1

# mapping a continuous variable to point size
p1 <- ggplot(data=mpg) +
  aes(x=hwy, y=cty, size=displ) +
  geom_point()
p1

# mapping a continuous variable to point color
p1 <- ggplot(data=mpg) +
  aes(x=hwy, y=cty, color=displ) +
  geom_point(size=5)
p1 # this changed the dots from a blue to black fade and increased the point size

# mapping two variables to different aesthetics
p1 <- ggplot(data=mpg) +
  aes(x=hwy, y=cty, shape=class, color=displ) +
  geom_point(size=5)
p1 # this gave points a bunch of weird shapes

# use shape for smaller number of categories
p1 <- ggplot(data=mpg) +
  aes(x=hwy, y=cty, shape=drv, color=fl) +
  geom_point(size=5) # use all 3 (size, shape, color) to indicate 5 attributes
p1 <- ggplot(data=mpg) +
  aes(x=hwy,
      y=cty, shape=drv,
      color=fl,
      size=displ) +
  geom_point()
p1

# mapping a variable to the same aesthetic in two different geoms
p1 <- ggplot(data=mpg) +
  aes(x=hwy, y=cty, color=drv) +
  geom_point(size=2) +
  geom_smooth(method="lm")
p1

# break out the drive types (note what fill affects)
p1 <- ggplot(data=mpg) +
  aes(x=hwy, y=cty, fill=drv) +
  geom_point(size=2) +
  geom_smooth(method="lm")
p1

# use both if you want points, lines, and confidence intervals colored
p1 <- ggplot(data=mpg) +
  aes(x=hwy, y=cty, color=drv, fill=drv) +
  geom_point(size=2) +
  geom_smooth(method="lm")
p1

# group allows for grouping by a variable without a specifying a color, size, shape. here the grouping only affects how the fit line is plotted 
p1 <- ggplot(data=mpg) +
  aes(x=hwy, y=cty, group=drv) +
  geom_point(size=2) +
  geom_smooth(method="lm")
p1

## Mapping aesthetics within geoms 
# now use aesthetic mappings within each geom to over-ride defaults 
#subset the data frame to pull out what you need
p1 <- ggplot(data=mpg) +
  aes(x=hwy, y=cty, col=drv) +
  geom_point(data=mpg[mpg$drv=="4",]) +
  geom_smooth()
p1

# instead of subsetting, just map an aesthetic 
p1 <- ggplot(data=mpg) +
  aes(x=hwy, y=cty) +
  geom_point(aes(color=drv)) +
  geom_smooth()
p1

# conversely, map the smoother, but not the points
p1 <- ggplot(data=mpg) +
  aes(x=hwy, y=cty) +
  geom_point() +
  geom_smooth(aes(color=drv))
p1

# also, subset in the first layer to eliminate some data entirely
# instead of subsetting, just map an aesthetic
p1 <- ggplot(data=mpg[mpg$drv!="4",]) +
  aes(x=hwy, y=cty) +
  geom_point(aes(color=drv)) +
  geom_smooth()
p1

### lotting multiple panel graphs with patchwork
g1 <-ggplot(data=mpg) +
  aes(x=hwy,y=cty) +
  geom_point() +
  geom_smooth()
g1

# to add color and change to a bar graph then can do
g2 <- ggplot(data=mpg) +
  aes(x=fl,fill=I("maroon4"),color=I("black")) +
  geom_bar(stat="count") +
  theme(legend.position="none")
g2

# make skinnier bar graph in a different color
g3 <- ggplot(data=mpg) +
  aes(x=hwy, fill=I("slateblue"),color=I("black")) +
  geom_histogram()
g3

# to make a box plot can do
g4 <- ggplot(data=mpg) +
  aes(x=fl, y=cty, fill=fl) +
  geom_boxplot() +
  theme(legend.position="none")
g4

# place two plots horizontally
require(ggplot2)
require(patchwork)
g1+g2
# needed to have pathwork loaded and it wasnt so i had to require(patchwork)

# place 3 plots vertically 
g1+g2+g3+plot_layout(ncol=1)

# change relative area of each plot
g1+g2+plot_layout(ncol=1, heights=c(2,1))

g1+g2+plot_layout(ncol=2, widths=c(1,2))

# add a spacer plot (under construction)
g1 + plot_spacer() + g2

# use nested layouts
g1 + {
  g2 + {
    g3 + 
      g4 + 
      plot_layout(ncol=1)
  }
} +
  plot_layout(ncol=1)

# - operator for subtrack placement
g1 + g2 - g3 + plot_layout(ncol=1)

# / for intuitive layouts
(g1 | g2 | g3)/g4

(g1 | g2)/(g3 | g4)

# add title to patchwork
g1 + g2 + plot_annotation('This is a title', caption = 'Made with patchwork' )

# Change styling of patchwork elements
g1 + g2 +
  plot_annotation(
    title = 'This is a title',
    caption = 'made with patchwork',
    theme = theme(plot.title = element_text(size = 16))
  )

# Add tags to plots
g1 / (g2 | g3) +
  plot_annotation(tag_levels = 'a')

# Swapping axis orientation for multipannel plot

g3a <- g3 + scale_x_reverse()
g3b <- g3 + scale_y_reverse() 
g3c <- g3 + scale_x_reverse() + scale_y_reverse()

(g3 | g3a)/(g3b | g3c)

(g3 + coord_flip() | g3a + coord_flip())/(g3b + coord_flip() | g3c + coord_flip())

# faceting variables to generate multiple plots

# basic faceting with variables split by row, column, or both

m1 <- ggplot(data=mpg) + 
  aes(x=hwy,y=cty) + 
  geom_point() 

m1 +  facet_grid(class~fl)

m1 + facet_grid(class~fl, scales="free_y")

m1 + facet_grid(class~fl, scales="free")

m1 + facet_grid(.~class)

m1 + facet_grid(class~.)

# use facet wrap when variables are not crossed
m1 + facet_grid(.~class)

m1 +  facet_wrap(~class)

m1 + facet_wrap(~class + fl)

m1 + facet_wrap(~class + fl, drop=FALSE)

m1 + facet_grid(class~fl)

# use facet with other aesthetic mapping within rows or columns

m1 <- ggplot(data=mpg) +                                         
  aes(x=displ,y=cty,color=drv) + 
  geom_point() 

m1 + facet_grid(.~class)

# easy to switch to other geoms
m1 <- ggplot(data=mpg) +                                        
  aes(x=displ,y=hwy,color=drv) + 
  geom_smooth(se=FALSE,method="lm") 

m1 + facet_grid(.~class)

# fitting with boxplots over a continuous variable
m1 <- ggplot(data=mpg) +  
  aes(x=hwy,y=cty) + 
  geom_boxplot()

m1 + facet_grid(.~class)

# add a group and fill mapping for subgroups
m1 <- ggplot(data=mpg) +                                        
  aes(x=displ,y=hwy,group=drv,fill=drv) + 
  geom_boxplot()

m1 + facet_grid(.~class)