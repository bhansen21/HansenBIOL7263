library(tidyverse)
part1 <- read_csv("https://raw.githubusercontent.com/mbtoomey/Biol_7263/main/Data/assignment6part1.csv")
part2 <- read_csv("https://raw.githubusercontent.com/mbtoomey/Biol_7263/main/Data/assignment6part2.csv")

#creating new columns from imported data set
part1_tib <- part1 %>% pivot_longer(cols = !ID,
               names_to = c("Sample", "Sex", "Treatment"),
               names_sep = c("_"),
               values_drop_na = TRUE) %>% 
  pivot_wider(names_from = ID, values_from = value)
  
#creating new columns from imported data set
part2_tib <- part2 %>% pivot_longer(cols = !ID, 
                 names_to = c("Sample", "Treatment"), 
                 names_sep = c("\\."),
                 values_drop_na = TRUE) %>%
  pivot_wider(names_from = ID, values_from = value)

#merge two data sets together
merge_12 <- part1_tib %>%
  full_join(part2_tib)

library(readr)
#writing to a CSV file in my results folder
write_csv(merge_12, "Results/merge_12results.csv")

#starting question 2
# creating a new file from csv i made
newtib <- read_csv("Results/merge_12results.csv")
newtib <- mutate(newtib, resid_mass = mass/body_length)
newtib <- group_by(newtib, Treatment)
newtibSD <- summarize(newtib, mean_rmass=mean(resid_mass, na.rm=TRUE),
                      SD_rmass=sd(resid_mass, na.rm=TRUE))
ungroup(newtib)

#restarting question 2
newtib <- read_csv("Results/merge_12results.csv")
#create a residual mass column titled resid_mass
newtib$resid_mass <- newtib$mass/newtib$body_length
options(dplyr.summarise.inform = FALSE)
newtib_SD <- newtib %>%
  group_by(Sex, Treatment) %>%
  summarise(mean= mean(resid_mass, na.rm= TRUE),
            SD=sd(resid_mass, na.rm=TRUE))
view(newtib_SD)

#create a new csv with this new data
write_csv(newtib_SD, "Results/newtib_SD_Restults.csv")
