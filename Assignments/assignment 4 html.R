library(dplyr)
library(tidyverse)
MBT_ebird<-read_csv("https://github.com/mbtoomey/Biol_7263/blob/main/Data/MBT_ebird.csv?raw=true") 
head(MBT_ebird)
MBT_ebird <- group_by(MBT_ebird, year)
ungroup(MBT_ebird)

#this pulled just a column of the years
MBT_years <- select(MBT_ebird, matches("year"))

# this pulled the coulmns i wanted but did not consolidate the years like i wanted it too
MBT_years2 <- select(MBT_ebird, common_name, count, year)

#this returned a tibble with the year and total amount of birds seen for that year each in their own column
summarize(MBT_ebird, birdtotal=max(count_tot, na.rm=TRUE))
# in 2020 the most individual birds were observed at 3154. 

#filter for just the 2020 data
MBT_ebird2020 <- filter(MBT_ebird, year == 2020)

MBT_ebird2020 <- group_by(MBT_ebird2020, scientific_name)
#this give us the amount of species record for 2020 (146) and the following value is a 1 indicating the year 2020
dim(summarize(MBT_ebird2020))

MBT_ebird <- group_by(MBT_ebird, location, common_name, count)
dim(summarize(MBT_ebird))
ungroup(MBT_ebird)


#this put out a tibble with coulmns dgrouped by location, common name, count, and rwbb
summarize(MBT_ebird, rwbb=max(count_tot, na.rm=TRUE))

#this pulled out only the entries for RWBB
MBT_ebirdRWBB <- filter(MBT_ebird, common_name == "Red-winged Blackbird")
# i dont know why you have to do this step 
MBT_ebirdRWBB <- group_by(MBT_ebirdRWBB, location)
# this takes the data that has been summarized by location and condeses the count_tot of each bird observed in a state and condenses it 
summarize(MBT_ebirdRWBB, RWBB_sum=sum(count_tot))

MBT_ebird_duration <- filter(MBT_ebird, duration <= "200" | duration >= "5")
MBT_ebird_duration <- filter(MBT_ebird_duration, duration != "0")
MBT_ebird_duration <- filter(MBT_ebird_duration, duration != "2")

MBT_ebirdmutate <- mutate(MBT_ebird_duration, rate = n_distinct(common_name)/(duration))

MBT_ebirdmean %>% group_by(year) %>%
mutate(yrmean = mean(rate))
view(MBT_ebirdmean)

#create a list of 10 
MBT_ebird10 <- MBT_ebird %>%
count(common_name) %>%
arrange(by=(desc(n))) 
MBT_ebird10 <- as.list(MBT_ebird10$common_name[1:10])

#convert this list to a tibble

