library(tidyverse)
library(ggplot2)

set.seed(123)  # for reproducibility

# Create a mock dataset with 30 rows
margin <- runif(36, 0.2, 0.5)

data <- tibble(
  Analysis = as.factor(rep(paste("Analysis", 1:3), each = 12)),
  Group = rep(c("Group 1", "Group 2"), length.out = 36),
  Exposure = rep(paste("Exposure", rep(1:6, each = 2)), 3),
  HR = round(runif(36, 0.5, 2.5), 2),
  CI_Lower = round(HR - margin, 2),
  CI_Upper = round(HR + margin, 2)
)
str(data)
# Using facet_wrap 

data |> 
  ggplot(aes(y = Exposure, x = HR)) + 
  geom_point(aes(color = Group), position = position_dodge(width = 0.5)) +
  geom_errorbar(aes(xmin = CI_Lower, xmax = CI_Upper, color = Group), 
                position = position_dodge(width = 0.5), 
                width=0.3) +
  labs(x = "Hazard Ratio", y = "Exposure") +
  facet_wrap(~Analysis)

  
# Using facet_grid
data |> 
  ggplot(aes(y = Exposure, x = HR)) + 
  geom_point(aes(color = Group), position = position_dodge(width = 0.5)) +
  geom_errorbar(aes(xmin = CI_Lower, xmax = CI_Upper, color = Group), 
                position = position_dodge(width = 0.5), 
                width=0.3) +
  labs(x = "Hazard Ratio", y = "Exposure") +
  facet_grid(Analysis ~ .)  # moving analysis to right or left of the "~" can change the facet

data |> 
  ggplot(aes(y = Exposure, x = HR)) + 
  geom_point() +
  geom_errorbar(aes(xmin = CI_Lower, xmax = CI_Upper), 
                width=0.3) +
  labs(x = "Hazard Ratio", y = "Exposure") +
  facet_grid(Analysis ~ Group)  # this is another way to present the data without using position_dodge 
