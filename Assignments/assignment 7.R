library(ggplot2)
library(tidyverse)
library(dplyr)
read.csv(github.com/mbtoomey/Biol_7263/blob/main/Data/MBT_ebird.csv?)
assign6 <- read.csv("https://github.com/mbtoomey/Biol_7263/blob/main/Data/MBT_ebird.csv?raw=true")
view(assign6)
assign6cut <- transmute(assign6, scientific_name = scientific_name, count = count, month = month, year = year, location = location,)
view(assign6cut)
summarize(assign6cut, n_distinct(scientific_name))


assign6tt <- assign6 %>% 
  group_by(location, year, month) %>% 
  summarize(n_distinct(scientific_name), 
            .groups ="drop")
assign6tt <- assign6tt %>%
  rename("n_distinct(scientific_name)") = "species")

ggplot(sum, aes(x=month, y=n_distinct, color=year)) +
  geom_point() + facet_wrap(~location)

#GIS in R

library(sp)
library(rgdal)
library(raster)
library(rgeos)
library(geosphere)
library(dismo)

bio1 <- raster("WORLDCLIM_Rasters/wc2.1_10m_bio_1.tif")
plot(bio1)

my_clim_stack <- stack(
  raster('WORLDCLIM_Rasters/wc2.1_10m_bio_7.tif'),
  raster('WORLDCLIM_Rasters/wc2.1_10m_bio_14.tif'),
  raster('WORLDCLIM_Rasters/wc2.1_10m_bio_11.tif')
)
plot(my_clim_stack)

names(my_clim_stack) <- c("Temp_Annual_Range", "Precip_Driest_Month", "Mean_Temp_Coldest") 
plot(my_clim_stack)

dev.new()

my_sites <- as.data.frame(click(n=10))
names(my_sites) <- c('longitude', 'latitude')
my_sites
env <- as.data.frame(extract(my_clim_stack, my_sites))
env
my_sites <- cbind(my_sites, env)
my_sites

myCrs <- projection(my_clim_stack) # get projection info

# make into points file
my_sites_shape <- SpatialPointsDataFrame(coords=my_sites, data=my_sites, proj4string=CRS(myCrs))
my_sites_shape

plot(my_clim_stack[[2]])
points(my_sites_shape, pch=16)

writeOGR(mySitesShape, 'My_locations', 'my_sites_shape', driver='ESRI Shapefile')
projection(my_sites_shape)
projection(countries)

