# if ggplot2 and dplyr are not already installed:
# install.packages("tidyverse")

library(ggplot2)
library(dplyr)
theme_set(theme_light())
# or:
# theme_set(ggsidekick::theme_sleek())
# install from: https://github.com/seananderson/ggsidekick

# Read data -----------------------------------------------------------

d <- readRDS("data/rock.rds")

d_ts <- group_by(d, year, species, sex) %>%
  summarise(median_weight = median(weight),
    lwr_weight = quantile(weight, probs = 0.25),
    upr_weight = quantile(weight, probs = 0.75)) %>%
  filter(sex == "female")

pop <- readRDS("data/pop-qcs-2015.rds")
qcs <- readRDS("data/qcs.rds")

# A basic plot --------------------------------------------------------

ggplot(data = d, mapping = aes(x = length, y = weight, colour = species)) +
  geom_point()

# Aesthetics ----------------------------------------------------------

ggplot(d, aes(length, weight, colour = year)) +
  geom_point()

ggplot(d, aes(length, weight, size = weight)) +
  geom_point(shape = 21, alpha = 0.2)

ggplot(d, aes(length, weight, size = weight, colour = species)) +
  geom_point(shape = 21, alpha = 0.2)

ggplot(d, aes(length, weight)) +
  geom_point(aes(colour = species))

ggplot(d, aes(length, weight)) +
  geom_point(colour = "blue")

ggplot(d, aes(length, weight)) +
  geom_point(aes(colour = "blue"))

ggplot(d, aes(length, weight)) +
  geom_point(colour = "blue")

ggplot(d, aes(length, weight)) +
  geom_point(aes(colour = "blue"))

# Geoms ---------------------------------------------------------------

ggplot(d, aes(length, weight)) +
  geom_point()

ggplot(d, aes(length, weight)) +
  geom_hex()

ggplot(d, aes(species, weight)) +
  geom_boxplot()

ggplot(d, aes(species, weight)) +
  geom_boxplot() +
  coord_flip()

ggplot(d, aes(species, weight)) +
  geom_violin() +
  coord_flip()

ggplot(d, aes(species, weight, colour = sex)) +
  geom_violin() +
  coord_flip()

ggplot(d, aes(species, weight)) +
  geom_jitter(height = 0) +
  coord_flip()

ggplot(d, aes(species, weight)) +
  geom_violin() +
  geom_jitter(height = 0, width = 0.1, alpha = 0.1) +
  coord_flip()

ggplot(d, aes(weight)) + geom_histogram()

ggplot(d, aes(weight, fill = species)) +
  geom_histogram()

ggplot(d, aes(weight, fill = species)) +
  geom_histogram(position = "identity", alpha = 0.2)

ggplot(d, aes(weight, colour = species)) +
  geom_freqpoly()

ggplot(d_ts, aes(year, median_weight,
  colour = species)) + geom_line()

ggplot(d_ts, aes(year,
  median_weight)) +
  geom_ribbon(aes(ymin = lwr_weight, ymax = upr_weight, fill = species),
    alpha = 0.2)

ggplot(d_ts, aes(year, median_weight)) +
  geom_ribbon(aes(ymin = lwr_weight, ymax = upr_weight, fill = species),
    alpha = 0.2) +
  geom_line()

ggplot(d_ts, aes(year, median_weight)) +
  geom_ribbon(aes(ymin = lwr_weight, ymax = upr_weight,
    fill = species), alpha = 0.2) +
  geom_line(aes(colour = species))

ggplot(d_ts, aes(year, median_weight)) +
  geom_pointrange(aes(ymin = lwr_weight, ymax = upr_weight,
    colour = species), alpha = 0.5)

# Facets --------------------------------------------------------------

g <- ggplot(d, aes(length, weight, colour = species)) +
  geom_point(alpha = 0.2)

g + facet_wrap(~year)

g + facet_grid(sex~year)

g + facet_wrap(sex~year)

# Scales --------------------------------------------------------------

ggplot(d, aes(length, weight, colour = species)) +
  geom_point(alpha = 0.2)

ggplot(d, aes(length, weight, colour = species)) +
  geom_point(alpha = 0.2) +
  scale_color_brewer(palette = "Dark2")

ggplot(d, aes(length, weight, colour = year)) +
  geom_point(alpha = 0.2) +
  scale_color_viridis_c()

ggplot(d, aes(length, weight, colour = year)) +
  geom_point(alpha = 0.2) +
  scale_color_viridis_c() +
  scale_y_log10() +
  scale_x_log10()

ggplot(d, aes(length, weight, colour = sex)) +
  geom_point(alpha = 0.2) +
  scale_color_manual(values = c(female = "red", male = "blue"))

# Themes --------------------------------------------------------------

g <- ggplot(d, aes(length, weight, colour = species)) +
  geom_point(alpha = 0.2)
g

g + ggsidekick::theme_sleek()

g + theme_light()

g + theme_gray()

g + theme_minimal()

g + theme_dark()

g + theme_classic()

g + theme_bw()

g + theme_void()

g + ggthemes::theme_fivethirtyeight()

g + ggthemes::theme_excel() + ggthemes::scale_color_excel()


ggplot(pop, aes(X, Y)) + geom_point()

ggplot(pop, aes(X, Y, size = density)) +
  geom_point() +
  scale_size_area()

ggplot(pop, aes(X, Y, size = density)) +
  geom_point(shape = 21) +
  scale_size_area(max_size = 12)

ggplot(qcs, aes(X, Y)) +
  geom_point(data = pop, mapping = aes(size = density), shape = 21) +
  scale_size_area(max_size = 12) +
  geom_raster(aes(fill = depth)) +
  scale_fill_viridis_c()

ggplot(qcs, aes(X, Y)) +
  geom_raster(aes(fill = depth)) +
  scale_fill_viridis_c() +
  geom_point(data = pop, mapping = aes(size = density), shape = 21) +
  scale_size_area(max_size = 12)

g <- ggplot(qcs, aes(X, Y)) +
  geom_raster(aes(fill = depth)) +
  scale_fill_viridis_c() +
  geom_point(data = pop, mapping = aes(size = density), shape = 21) +
  scale_size_area(max_size = 12) +
  coord_fixed()
g

g <- g + labs(x = "UTMs East", y = "UTMs North",
  fill = "Depth (m)",
  size = expression(Density~kg/m^2),
  title = "POP Biomass Density",
  subtitle = "Queen Charlotte Sound")
g

# Statistics ----------------------------------------------------------

d_canary <- filter(d, species == "canary rockfish")
d_canary <- filter(d_canary, year == 2017)

ggplot(d_canary, aes(length, weight)) +
  geom_point() +
  geom_smooth()

ggplot(d_canary, aes(length, weight, colour = sex)) +
  geom_point() +
  geom_smooth()

ggplot(d_canary, aes(length, weight, colour = sex)) +
  geom_point() +
  geom_smooth(
    method = "glm", formula = y ~ log(x),
    method.args = list(family = Gamma(link = "log")))

ggplot(d_canary, aes(length, weight, colour = sex)) +
  geom_point() +
  geom_smooth(
    method = "glm", formula = y ~ log(x),
    method.args = list(family = Gamma(link = "log"))) +
  labs(x = "Length (cm)", y = "Weight (kg)", colour = "Sex") +
  scale_color_brewer(palette = "Dark2")

ggplot(d, aes(length, weight, colour = sex)) +
  geom_point(alpha = 0.1) +
  geom_smooth(
    method = "glm", formula = y ~ log(x),
    method.args = list(family = Gamma(link = "log"))) +
  labs(x = "Length (cm)", y = "Weight (kg)", colour = "Sex") +
  scale_color_brewer(palette = "Dark2") +
  facet_wrap(~species)

# Combining plots -----------------------------------------------------

g1 <- ggplot(d, aes(length, weight)) +
  geom_point(aes(colour = species))

g2 <- ggplot(d_ts, aes(year, median_weight,
  colour = species)) + geom_line()

cowplot::plot_grid(g1, g2, ncol = 1, labels = "AUTO")

# Saving plots --------------------------------------------------------

ggplot(d, aes(length, weight)) +
  geom_point(aes(colour = species))

ggsave("my-plot.pdf", width = 8, height = 6)
ggsave("my-plot.png", width = 8, height = 6)
