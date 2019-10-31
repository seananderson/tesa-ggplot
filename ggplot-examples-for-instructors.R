# if ggplot2 and dplyr are not already installed:
# install.packages("tidyverse")

library(ggplot2)
library(dplyr)
theme_set(theme_light())
# or:
# theme_set(ggsidekick::theme_sleek())
# install from: https://github.com/seananderson/ggsidekick

# Read data -----------------------------------------------------------

d <- readRDS("rock.rds")

d_ts <- group_by(d, year, species, sex) %>%
  summarise(median_weight = median(weight),
    lwr_weight = quantile(weight, probs = 0.25),
    upr_weight = quantile(weight, probs = 0.75)) %>%
  filter(sex == "female")

pop <- readRDS("data/pop-qcs-2015.rds")
qcs <- readRDS("data/qcs.rds")

ii <<- 0 # delete this line
gs <- function(width = 6, height = 3.6) { # delete this line
  ii <<- ii + 1 # delete this line
  ggsave(filename = paste0("figs/", id, "-", ii, ".pdf"), width = width, # delete this line
    height = height) # delete this line
} # delete this line
# delete this line
# A basic plot --------------------------------------------------------
id <- "basic"

ggplot(data = d, mapping = aes(x = length, y = weight, colour = species)) +
  geom_point()
gs()

# Aesthetics ----------------------------------------------------------
id <- "aes"

ggplot(d, aes(length, weight, colour = year)) +
  geom_point()
gs()

ggplot(d, aes(length, weight, size = weight)) +
  geom_point(shape = 21, alpha = 0.2)
gs()

ggplot(d, aes(length, weight, size = weight, colour = species)) +
  geom_point(shape = 21, alpha = 0.2)
gs()

ggplot(d, aes(length, weight)) +
  geom_point(aes(colour = species))
gs()

ggplot(d, aes(length, weight)) +
  geom_point(colour = "blue")
gs()

ggplot(d, aes(length, weight)) +
  geom_point(aes(colour = "blue"))
gs()

ggplot(d, aes(length, weight)) +
  geom_point(colour = "blue")
gs(width = 3)

ggplot(d, aes(length, weight)) +
  geom_point(aes(colour = "blue"))
gs(width = 3)

# Geoms ---------------------------------------------------------------
id <- "geom"

ggplot(d, aes(length, weight)) +
  geom_point()
gs()

ggplot(d, aes(length, weight)) +
  geom_hex()
gs()

ggplot(d, aes(species, weight)) +
  geom_boxplot()
gs()

ggplot(d, aes(species, weight)) +
  geom_boxplot() +
  coord_flip()
gs()

ggplot(d, aes(species, weight)) +
  geom_violin() +
  coord_flip()
gs()

ggplot(d, aes(species, weight, colour = sex)) +
  geom_violin() +
  coord_flip()
gs()

ggplot(d, aes(species, weight)) +
  geom_jitter(height = 0) +
  coord_flip()
gs()

ggplot(d, aes(species, weight)) +
  geom_violin() +
  geom_jitter(height = 0, width = 0.1, alpha = 0.1) +
  coord_flip()
gs()

ggplot(d, aes(weight)) + geom_histogram()
gs()

ggplot(d, aes(weight, fill = species)) +
  geom_histogram()
gs()

ggplot(d, aes(weight, fill = species)) +
  geom_histogram(position = "identity", alpha = 0.2)
gs()

ggplot(d, aes(weight, colour = species)) +
  geom_freqpoly()
gs()

ggplot(d_ts, aes(year, median_weight,
  colour = species)) + geom_line()
gs()

ggplot(d_ts, aes(year,
  median_weight)) +
  geom_ribbon(aes(ymin = lwr_weight, ymax = upr_weight, fill = species),
    alpha = 0.2)
gs()

ggplot(d_ts, aes(year, median_weight)) +
  geom_ribbon(aes(ymin = lwr_weight, ymax = upr_weight, fill = species),
    alpha = 0.2) +
  geom_line()
gs()

ggplot(d_ts, aes(year, median_weight)) +
  geom_ribbon(aes(ymin = lwr_weight, ymax = upr_weight,
    fill = species), alpha = 0.2) +
  geom_line(aes(colour = species))
gs()

ggplot(d_ts, aes(year, median_weight)) +
  geom_pointrange(aes(ymin = lwr_weight, ymax = upr_weight,
    colour = species), alpha = 0.5)
gs()

# Facets --------------------------------------------------------------
id <- "facets"

g <- ggplot(d, aes(length, weight, colour = species)) +
  geom_point(alpha = 0.2)
gs()

g + facet_wrap(~year)
gs()

g + facet_grid(sex~year)
gs()

g + facet_wrap(sex~year)
gs()

# Scales --------------------------------------------------------------
id <- "scales"

ggplot(d, aes(length, weight, colour = species)) +
  geom_point(alpha = 0.2)
gs()

ggplot(d, aes(length, weight, colour = species)) +
  geom_point(alpha = 0.2) +
  scale_color_brewer(palette = "Dark2")
gs()

ggplot(d, aes(length, weight, colour = year)) +
  geom_point(alpha = 0.2) +
  scale_color_viridis_c()
gs()

ggplot(d, aes(length, weight, colour = year)) +
  geom_point(alpha = 0.2) +
  scale_color_viridis_c() +
  scale_y_log10() +
  scale_x_log10()
gs()

ggplot(d, aes(length, weight, colour = sex)) +
  geom_point(alpha = 0.2) +
  scale_color_manual(values = c(female = "red", male = "blue"))
gs()

# Themes --------------------------------------------------------------
id <- "themes"

g <- ggplot(d, aes(length, weight, colour = species)) +
  geom_point(alpha = 0.2)
g
gs()

g + ggsidekick::theme_sleek()
gs()

g + theme_light()
gs()

g + theme_gray()
gs()

g + theme_minimal()
gs()

g + theme_dark()
gs()

g + theme_classic()
gs()

g + theme_bw()
gs()

g + theme_void()
gs()

g + ggthemes::theme_fivethirtyeight()
gs()

g + ggthemes::theme_excel() + ggthemes::scale_color_excel()
gs()

id <- "pop-case-study"

ggplot(pop, aes(X, Y)) + geom_point()
gs()

ggplot(pop, aes(X, Y, size = density)) +
  geom_point() +
  scale_size_area()
gs()

ggplot(pop, aes(X, Y, size = density)) +
  geom_point(shape = 21) +
  scale_size_area(max_size = 12)
gs()

ggplot(qcs, aes(X, Y)) +
  geom_point(data = pop, mapping = aes(size = density), shape = 21) +
  scale_size_area(max_size = 12) +
  geom_raster(aes(fill = depth)) +
  scale_fill_viridis_c()
gs()

ggplot(qcs, aes(X, Y)) +
  geom_raster(aes(fill = depth)) +
  scale_fill_viridis_c() +
  geom_point(data = pop, mapping = aes(size = density), shape = 21) +
  scale_size_area(max_size = 12)
gs()

g <- ggplot(qcs, aes(X, Y)) +
  geom_raster(aes(fill = depth)) +
  scale_fill_viridis_c() +
  geom_point(data = pop, mapping = aes(size = density), shape = 21) +
  scale_size_area(max_size = 12) +
  coord_fixed()
g
gs()

g <- g + labs(x = "UTMs East", y = "UTMs North",
  fill = "Depth (m)",
  size = expression(Density~kg/m^2),
  title = "POP Biomass Density",
  subtitle = "Queen Charlotte Sound")
g
gs()

# Statistics ----------------------------------------------------------
id <- "stats"

d_canary <- filter(d, species == "canary rockfish")
d_canary <- filter(d_canary, year == 2017)

ggplot(d_canary, aes(length, weight)) +
  geom_point() +
  geom_smooth()
gs()

ggplot(d_canary, aes(length, weight, colour = sex)) +
  geom_point() +
  geom_smooth()
gs()

ggplot(d_canary, aes(length, weight, colour = sex)) +
  geom_point() +
  geom_smooth(
    method = "glm", formula = y ~ log(x),
    method.args = list(family = Gamma(link = "log")))
gs()

ggplot(d_canary, aes(length, weight, colour = sex)) +
  geom_point() +
  geom_smooth(
    method = "glm", formula = y ~ log(x),
    method.args = list(family = Gamma(link = "log"))) +
  labs(x = "Length (cm)", y = "Weight (kg)", colour = "Sex") +
  scale_color_brewer(palette = "Dark2")
gs()

ggplot(d, aes(length, weight, colour = sex)) +
  geom_point(alpha = 0.1) +
  geom_smooth(
    method = "glm", formula = y ~ log(x),
    method.args = list(family = Gamma(link = "log"))) +
  labs(x = "Length (cm)", y = "Weight (kg)", colour = "Sex") +
  scale_color_brewer(palette = "Dark2") +
  facet_wrap(~species)
gs()

# Combining plots -----------------------------------------------------
id <- "combining-plots"

g1 <- ggplot(d, aes(length, weight)) +
  geom_point(aes(colour = species))

g2 <- ggplot(d_ts, aes(year, median_weight,
  colour = species)) + geom_line()

cowplot::plot_grid(g1, g2, ncol = 1, labels = "AUTO")
gs(width = 6, height = 6)

# Saving plots --------------------------------------------------------
id <- "saving-plots"

ggplot(d, aes(length, weight)) +
  geom_point(aes(colour = species))

ggsave("my-plot.pdf", width = 8, height = 6)
ggsave("my-plot.png", width = 8, height = 6)
