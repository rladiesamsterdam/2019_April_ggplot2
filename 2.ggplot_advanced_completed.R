#------------------------------------------
# --- GGplot workshop R-Ladies Amsterdam
# --- 30th April 2019
# --- Advanced exercise
#------------------------------------------

library(tidyverse)
library(reshape2)

#----- 0. Skip this step if you preloaded your data in intro exercise! ------ 
# Choose in the menu: Session->Set working directory->to source file location
# Alternatively, specify the path to the data file if it's not located in the same folder as this script
folder_path = ""

# load the data set 
fastfood_calories = read.csv(paste0(folder_path, "fastfood_calories.csv"), stringsAsFactors = F)

# We transform the dataset to make it more interesting. Run it and see what changed
fastfood_calories_subset = fastfood_calories %>% select(restaurant, calories, total_fat, vit_c, fiber, sodium) %>% 
  group_by(restaurant)  %>% 
  mutate_if(is.numeric, funs(scale))
fastfood_calories_subset = melt(fastfood_calories_subset)

#----- End of 0. Skip this step if you preloaded your data in intro exercise! ------ 

# --------- 5 ------------------
# We will reuse the idea of plot g4, but just add facet_wrap. Compare 2 plots: what plot do you find the most informative? 
# For what purpose would you like to use each of them? 
# tip: don't forget to use the tilda sign (~) in facet_wrap
g5 = ggplot(fastfood_calories_subset, aes(x=variable, y=value, fill=variable)) + geom_boxplot() +
      facet_wrap(~restaurant)
g5

# --------- end of 5 ------------------

# --------- 6 ------------------
# Boxplot doesn't show clearly the data distribution. Try to use violin plot instead and see the difference. 
# Tip: check https://ggplot2.tidyverse.org/reference/ to find out which geom you need
# Keep facet_wrap from previous plot
g6 = ggplot(fastfood_calories_subset, aes(x=variable, y=value, fill=variable)) + geom_violin() +
  facet_wrap(~restaurant)
g6

# --------- end of 6 ------------------

# --------- 7 -----------------
# Plot two histograms together: 1) for calories, 2) for cal_fat; specify the same binwidth, fill with contrasting colors and specify the alpha level
g7 = ggplot()  
g7 = g7 + geom_histogram(data=fastfood_calories, aes(x=calories), binwidth=100, fill="blue", alpha=0.5) +
  geom_histogram(data=fastfood_calories, aes(x=cal_fat), fill="orange", alpha=0.3, binwidth=100) 

# Add a dashed vertical line for mean value for calories on the 1st histogram
# Tip: look up geom_vline() in https://ggplot2.tidyverse.org/reference/
g7 = g7 + geom_vline(data=fastfood_calories, aes(xintercept=mean(calories)),
                       color="blue", linetype="dashed", size=0.5) 


# Add a dashed vertical line for mean value for cal_fat on the 2nd histogram 
g7 = g7 + geom_vline(data=fastfood_calories, aes(xintercept=mean(cal_fat)),
                      color="orange", linetype="dashed", size=0.5)
g7
# --------- end of 7 -----------------


# --------- 8 -----------------
# Reproduce the plot from the slides (see slide 46)
fastfood_calories_subset_Subway = fastfood_calories %>% filter(restaurant=="Subway") %>%
  select(calories, total_fat, sodium) %>% 
  mutate_all(scale)
fastfood_calories_subset_Subway = melt(fastfood_calories_subset_Subway)

g8 = ggplot(fastfood_calories_subset_Subway, aes(x=variable, y=value)) + geom_violin(fill="#808000") + 
  xlab(" ") + ylab("Value") + ggtitle("Scaled values for Subway restaurant")
g8 = g8 + geom_jitter() + theme_classic()
g8
# --------- end of advance exercise -----------------


head(fastfood_calories)
 ggplot(fastfood_calories_subset, aes(x= restaurant)) + 
   geom_bar() + position_stack()
 