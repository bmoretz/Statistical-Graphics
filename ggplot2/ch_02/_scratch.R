require(data.table)
require(ggplot2)
require(dplyr)
require(mgcv)
require(MASS)
require(ggthemes)

mpg

# 1.) List fine functions that you could use to get more information about the mpg dataset.

head(mpg)
summary(mpg)
View(mpg)
str(mpg)
glimpse(mpg)
class(mpg)

# 2.) How can you find out what other datasets are included with ggplot2?
pkg.data <- data(package = "ggplot2")
pkgs <- as.data.table(pkg.data$results)[,3:4]

pkgs

# 2.3
ggplot(mpg, aes(x = displ, y = hwy)) +
	geom_point()

# 2.4

ggplot(mpg, aes(displ, cty, colour = class)) +
	geom_point()

ggplot(mpg, aes(displ, hwy)) + geom_point(aes(colour = "blue"))
ggplot(mpg, aes(displ, hwy)) + geom_point(colour = "blue")

ggplot(mpg, aes(displ, hwy)) +
	geom_point() +
	facet_wrap(~class)

?facet_wrap

# 2.6, Geoms

ggplot(mpg, aes(displ, hwy)) +
	geom_point() +
	geom_smooth()

ggplot(mpg, aes(displ, hwy)) +
	geom_point() +
	geom_smooth(se = FALSE)

ggplot(mpg, aes(displ, hwy)) +
	geom_point() +
	geom_smooth(span = 0.2)

ggplot(mpg, aes(displ, hwy)) +
	geom_point() +
	geom_smooth(span = 1)

ggplot(mpg, aes(displ, hwy)) +
	geom_point() +
	geom_smooth(method = "gam", formula = y ~ s(x))

p1 <- ggplot(mpg, aes(displ, hwy)) +
	geom_point() +
	geom_smooth(method = "lm")

# debug data
ggplot_build(p1)$data

ggplot(mpg, aes(displ, hwy)) +
	geom_point() +
	geom_smooth(method = "rlm")

ggplot(mpg, aes(drv, hwy)) +
	geom_point()

ggplot(mpg, aes(drv, hwy)) + geom_jitter()
ggplot(mpg, aes(drv, hwy)) + geom_boxplot()
ggplot(mpg, aes(drv, hwy)) + geom_violin()

ggplot(mpg, aes(hwy)) + geom_histogram()

ggplot(mpg, aes(hwy)) + geom_freqpoly()

ggplot(mpg, aes(hwy)) + geom_freqpoly( binwidth = 2.5 )
ggplot(mpg, aes(hwy)) + geom_freqpoly(binwidth = 1)

ggplot(mpg, aes(displ, colour = drv)) +
	geom_freqpoly(binwidth = 0.5)

ggplot(mpg, aes(displ, fill = drv)) +
	geom_histogram(binwidth = 0.5) +
	facet_wrap(~drv, ncol = 1)

ggplot(mpg, aes(manufacturer)) +
	geom_bar()

drugs <- data.frame(
	 drug = c("a", "b", "c"),
	 effect = c(4.2, 9.7, 6.1))

ggplot(drugs, aes(drug, effect)) + geom_bar(stat = "identity")
ggplot(drugs, aes(drug, effect)) + geom_point()

ggplot(economics, aes(date, unemploy / pop)) +
	geom_line()

ggplot(economics, aes(date, uempmed)) +
	geom_line()

ggplot(economics, aes(unemploy / pop, uempmed)) +
	geom_point() +
	geom_path()

year <- function(x) as.POSIXlt(x)$year + 1900
ggplot(economics, aes(unemploy / pop, uempmed)) +
	geom_path(color = "grey50") +
	geom_point(aes(colour = year(date)))

head(mpg)

? reorder

head(diamonds)

ggplot(mpg, aes(reorder(class, hwy, fun = mean), hwy)) + geom_boxplot()


# 2.7

ggplot(mpg, aes(cty, hwy)) +
	geom_point(alpha = 1 / 3)

ggplot(mpg, aes(cty, hwy)) +
	geom_point(alpha = 1 / 3) +
	xlab("city driving (mpg)") +
	ylab("highway driving (mpg)")

ggplot(mpg, aes(cty, hwy)) +
	geom_point(alpha = 1 / 3) +
	xlab(NULL) +
	ylab(NULL)

ggplot(mpg, aes(drv, hwy)) +
	geom_jitter(width = 0.25)

ggplot(mpg, aes(drv, hwy)) +
	geom_jitter(width = 0.25) +
	xlim("f", "r") +
	ylim(20, 30)

ggplot(mpg, aes(drv, hwy)) +
	geom_jitter(width = 0.25, na.rm = TRUE) +
	ylim(NA, 30)

# 2.8

p <- ggplot(mpg, aes(displ, hwy, color = factor(cyl))) +
	geom_point()

print(p)

ggsave("plot.png", width = 5, height = 5)

summary(p)

# Cars with Theme Example

ggplot(mtcars, aes(x = wt, y = mpg, colour = factor(gear))) +
  geom_point() +
  ggtitle("Cars") +
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_fivethirtyeight("cyl") +
  theme_fivethirtyeight()


require(ggplot2)
require(GGally)
data(diamonds, package = "ggplot2")
diamonds.samp <- diamonds[sample(1:dim(diamonds)[1], 200),]

# Custom Example  ( almost directly from help page)
pm <- ggpairs(
 diamonds.samp[, 1:5],
 mapping = ggplot2::aes(color = cut),
 upper = list(continuous = wrap("density", alpha = 0.5), combo = "box"),
 lower = list(continuous = wrap("points", alpha = 0.3, size = 0.1),
              combo = wrap("dot", alpha = 0.4, size = 0.2)),
 title = "Diamonds"
)

pm