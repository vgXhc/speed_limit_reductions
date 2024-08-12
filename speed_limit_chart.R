library(tidyverse)

speed <- read_csv("data/Vision Zero speed limit reduction data .csv")

chart <- speed |> 
  mutate(inc_dec = if_else(pct_y_1 > pct_y_2, "decrease", "increase"),
         inc_dec_pct = pct_y_2 - pct_y_1,
         volume_y_2 = pct_y_2 * n_y_2) |> 
  ggplot(aes(pct_y_1, pct_y_2, color = inc_dec_pct, size = volume_y_2)) +
  geom_point() +
  scale_color_continuous_divergingx(name = "% pt decrease/increase", palette = 'RdBu', mid = 0) +
  # scale_color_distiller(name = "% pt decrease/increase", type = "div", palette = "BrBG") +
  scale_size(name = "Traffic volume after") +
  geom_abline(slope = 1, intercept = 0, linetype = 3) +
  labs(x = "Before reduction",
       y = "After reduction",
       title = "Effect of speed limit reductions in Madison",
       subtitle = "% of vehicles 5+ mph over initial speed limit") +
  xlim(0,45) +
  ylim(0,45) +
    theme_minimal()

ggsave("output/speed_chart.png", chart, width = 8, height = 5)
