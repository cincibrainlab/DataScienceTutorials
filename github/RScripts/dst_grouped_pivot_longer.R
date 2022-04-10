# Data Science Tutorials
# Double Grouped Column Pivot Longer
# 4/10/2022

# Dependencies
library(tidyverse)

# Shared Dataset
df <- read_csv("https://figshare.com/ndownloader/files/34762954")

df %>% head()

# Align Variable Names and Add Grouping Suffix

# Key function is rename_with
df_for_pivot <- df %>% rename_with(Sham1:DI13, .fn = ~ paste0(.x,"_PSD")) %>% 
  rename_with(DIN7Std:Sham1Std, .fn = ~ paste0(.x,"_SD")) %>% 
  rename_with(ends_with("Std_SD"), .fn = ~str_remove(.x, "Std"))

# Perform Pivot Wider with Grouped Columns
df_for_pivot %>% pivot_longer(cols = Sham1_PSD:Sham1_SD, 
                              names_to = c("DIN",".value"), names_sep = "_")
df %>% head()
