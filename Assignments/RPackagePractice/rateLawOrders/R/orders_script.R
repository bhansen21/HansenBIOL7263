#' Add First Order and Second Order Columns
#'
#' Takes absorbance or concentration data for a reaction and finds the first order and second order values so that all possible order plots can be graphed later
#' @name all_orders
#' @param The dataset for which we are converting, containing a Time and Absorbance column
#' @return A new table with the following columns: Time, zero_order, first_order, second_order
#' @examples all_orders(dataset)

library("dplyr") #to allow us to use the 'mutate' and 'rename' functions

all_orders <- function(dataset) {
  mutate (dataset,
          first_order = log(Absorbance),
          second_order = 1/Absorbance
  ) %>%
    rename (zero_order = Absorbance)
}

#' Create Zero Order, First Order, and Second Order Plots
#'
#' Uses the dataset to create plots for each rate law order. Useful for checking to see which plot is most linear in order to determine the order of the reaction with respect to that reactant.
#' @name plot_orders
#' @param The dataset for which we are converting, which should already have columns added for the first order and second order data. The expected column labels are Time, zero_order, first_order, and second_order.
#' @return Three plots, one for a zero order reaction, one for first order, and one for second order.
#' @examples plot_orders(dataset)
