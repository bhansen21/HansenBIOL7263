banding<-read.csv("SD_banding_data.csv")
view(banding)
install.packages("MuMIn")
install.packages("AICcmodavg")
library(MuMIn)
library(AICcmodavg)

glm_example<-glm(mass~tarsus+wing, data=banding, family=gaussian)
glm_example
summary(glm_example)
anova(glm_example, test="F")

AIC(glm_example)
AICc(glm_example)

banding_na<-na.omit(banding)
mass_model<-glm(mass~tarsus*wing+fat+species, data=banding_na, family = gaussian, na.action = na.fail)

AICc_models<-dredge(mass_model, 
                    rank="AICc",
                    fixed= "species")
View(AICc_models)

model_list<-get.models(AICc_models, subset=1:5)

model_list[1]

madavg_table<-aictab(model_list, second.ord = TRUE, sort=TRUE)

madavg_table

#Trick: create a list of model names
model_name_list<-NULL #make an empty list

for (i in 1:5){
  model_name_list = c(model_name_list, as.character(model_list[[i]][['formula']]))
} #loop through model output to extract formula for each model


model_name_list

model_name_listb <- model_name_list[seq(3, length(model_name_list), 3)] #select every third element from list and put it in a new list

model_name_list

madavg_table<-aictab(model_list, second.ord = TRUE, sort=TRUE, modnames = model_name_listb)

View(madavg_table)
