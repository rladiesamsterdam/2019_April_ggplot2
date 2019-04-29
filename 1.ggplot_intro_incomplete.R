
#------------------------------------------
# --- GGplot workshop R-Ladies Amsterdam
# --- 30th April 2019
# --- Introductory exercise
#------------------------------------------

library(tidyverse)
library(reshape2)

# Choose in the menu: Session->Set working directory->to source file location
# Alternatively, specify the path to the data file if it's not located in the same folder as this script
folder_path = ""

# load the data set 
fastfood_calories = read.csv(paste0(folder_path, "fastfood_calories.csv"), stringsAsFactors = F)

# you may explore the dataset with these
#head(fastfood_calories)
#summary(fastfood_calories)

# check out the feature "Salad", what is unusual about it? 
# consider dropping the feature (discuss with others why you might want to do that)
fastfood_calories = fastfood_calories %>% select(-salad)

# --------- 1 ------------------
# 1.1 create the first plot, as we showed in the slides: 
# calories on x axis, total fat on y axis and colored by a restaurant label
g1 = ggplot(fastfood_calories, aes(
  x=..., #add your code here
  y=... #your code
  )) 

# 1.2 specify the dot size
g1 = g1 + geom_point(aes(color=restaurant), ... ) 

# 1.3 show the plot
g1  

# 1.4 inspect the layers of g1 manually (via text)
# You may also try to explore your ggplot object with str(g1) & class(g1)
g1[['layers']]

# 1.5 add labels to the plot:
# "Calories" to the x - axis, "Total fat, mg" to the y- axis and a title 
g1 = g1 + ... 

# 1.6 add a line through the scatter plot (also called smoothing curve; use "lm" for method) 
g1 = g1 + ... 

# --------- end of 1 ------------------

# --------- 2 ------------------

# 2.1. Plot a histogram for calories and specify the binwidth (tip: use 100), and a color for the histogram
g2 = ggplot(fastfood_calories, aes(x=calories)) + ...
g2

# --------- end of 2 ------------------

# --------- 3 ------------------
# 3.1. Let's try a box plot: plot total_fat for each restaurant (as in the slides)
# Add labels for x and y axis and a plot title
g3 = ggplot(fastfood_calories, aes( ... )) + ...
g3

# --------- end of 3 ------------------

# --------- 4 ------------------
# 4.1 We transform the dataset to make it more interesting. Run it and see what changed
fastfood_calories_subset = fastfood_calories %>% select(restaurant, calories, total_fat, fiber, sodium) %>% 
  group_by(restaurant)  %>% 
  mutate_if(is.numeric, funs(scale))
fastfood_calories_subset = melt(fastfood_calories_subset)

# 4.2 create a boplox for the fastfood_calories_subset; specify x=variable and y=value; fill by restaurant
g4 = ggplot(fastfood_calories_subset, aes(...)) + ...
g4
# NB: there will be a warning message that you can ignore for now 

# 4.3 change the theme
g4 = g4 + ...
g4

# --------- end of exercise ------------------

# EXTRA
# What are the advantages/ disadvantages of the above plot?
# Can you think of a better way to visualise the graph above?
