require(tidyverse)
install.packages(c("sp","rgdal","raster","rgeos","geosphere","dismo"))
library(sp) # classes for vector data (polygons, points, lines)
library(rgdal) # basic operations for spatial data
library(raster) # handles rasters
library(rgeos) # methods for vector files
library(geosphere) # more methods for vector files
library(dismo) # species distribution modeling tools

# load a raster

biol<-raster("WORLDCLIM_Rasters/wc2.1_10m_bio_1.tif")
plot(biol) # this makes a map
biol

biol_f <- biol * (9/5)+32
plot(biol_f)

clim_stack <- stack(list.files("WORLDCLIM_Rasters", full.names = TRUE, pattern = ".tif"))

plot(clim_stack, nc = 5) # nc plots five columns of the 19 rasters

clim_stack

my_clim_stack <- stack(
  raster('WORLDCLIM_Rasters/wc2.1_10m_bio_2.tif'),
  raster('WORLDCLIM_Rasters/wc2.1_10m_bio_4.tif'),
  raster('WORLDCLIM_Rasters/wc2.1_10m_bio_17.tif')
)
#Look up the variable on https://www.worldclim.org/data/bioclim.html and rename the variable with a more descriptive name.  
names(my_clim_stack) <- c("mean_diurnal_range", "temperature_seasonality", "precip_driest_quarter")

plot(my_clim_stack)

pairs(my_clim_stack) #pairs is a base R function that plots univariate distribution and bivariate relationships

countries <- shapefile("Country_Shapefiles/ne_10m_admin_0_countries.shp")
countries

head(countries)

nrow(countries) # how many rows?
countries$wantToBeHere <- FALSE # add a column
mexico <- subset(countries, NAME=='Mexico') # subset using subset command
uzbek <- countries[countries$NAME=='Uzbekistan', ] # subset by row
sovereign <- countries[ , 4] # 4th column... but still has all shapes associated with it
countries[ , 'SOVEREIGNT']  # 4th column again... still has all shapes associated with it
countriesDf <- as.data.frame(countries) # remove shape data but keep data frame

plot(countries, col='goldenrod', border='darkblue') 

dev.new()

plot(my_clim_stack[[2]]) # plot mean annual temperature
plot(countries, add=TRUE) # add countries shapefile

my_sites <- as.data.frame(click(n=10))

names(my_sites) <- c('longitude', 'latitude')
my_sites

env <- as.data.frame(extract(my_clim_stack, my_sites))
env


