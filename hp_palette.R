library(tidyverse)
library(data.table)
library(RcppRoll)
devtools::install_github("aljrico/harrypotter")
library(harrypotter)

a <- rnorm(1e5)
b <- rnorm(1e5) + 2*rexp(1e5) + rnorm(1e5)*rnorm(1e5)

cbind(a,b) %>% as_tibble() %>% 
	ggplot() + 
	geom_point(aes(y = a, x = b, colour = b))  +
	scale_colour_hp(discrete = FALSE, movie = 4)


