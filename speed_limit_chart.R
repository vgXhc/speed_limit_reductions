library(tidyverse)

speed <- read_csv("data/Vision Zero speed limit reduction data .csv")

speed |> 
  mutate(inc_dec = if_else(pct_y_1 > pct_y_2, "decrease", "increase"),
         volume_y_2 = pct_y_2 * n_y_2) |> 
  ggplot(aes(pct_y_1, pct_y_2, color = inc_dec, size = volume_y_2)) +
  geom_point() +
  scale_color_viridis_d(name = "Increase/decrease") +
  scale_size(name = "Traffic volume after") +
  geom_abline(slope = 1, intercept = 0, linetype = 3) +
  labs(x = "Before reduction",
       y = "After reduction",
       title = "Effect of speed limit reductions in Madison",
       subtitle = "% of vehicles 5+ mph over initial speed limit") +
  xlim(0,45) +
  ylim(0,45) +
    theme_minimal()
