

install.packages(c("devtools", "roxygen2"))
library("devtools") # for 'create_package' function now, and other functions later
library("roxygen2") # automatically generates some of the package documentation for you

create_package("rateLawOrders")
