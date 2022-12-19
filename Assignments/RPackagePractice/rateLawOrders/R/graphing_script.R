library("ggplot2")
library("patchwork")

plot_orders <- function(dataset) {

  zero_plot <- ggplot(data=dataset, aes(x=Time, y=zero_order, group=1)) +
    geom_line()+
    geom_point()

  first_plot <- ggplot(data=dataset, aes(x=Time, y=first_order, group=1)) +
    geom_line()+
    geom_point()

  second_plot <- ggplot(data=dataset, aes(x=Time, y=second_order, group=1)) +
    geom_line()+
    geom_point()

  all_plots <- (zero_plot + first_plot) / second_plot
  all_plots
}
