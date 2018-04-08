
# Functions ---------------------------------------------------------------

library(ggplot2)
library(tidyverse)
library(data.table)
library(XML)
library(RCurl)
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
library(stringr)
library(rvest)



# Most Populated Cities ---------------------------------------------------------------------

# URL
path<-"https://en.wikipedia.org/wiki/List_of_United_States_cities_by_population"
webpage <- getURL(path)
url <- webpage

# Fetch HTML
mytable <- read_html(url) %>% 
	html_nodes("table")

# Extract table of interest
most_pop_cities <- mytable[[4]] %>% html_table(fill = TRUE, header = NA)

# Cleaning
most_pop_cities <- most_pop_cities[,c(4,2)]
colnames(most_pop_cities) <- c("pop", "city")
most_pop_cities$city <- gsub("\\[(.*?)\\]", "", most_pop_cities$city)
most_pop_cities$pop <- as.numeric(gsub(",", "", most_pop_cities$pop))

	
# Historical of each City ----------------------------------------------------

cityname <- gsub(" ", "_",most_pop_cities$city)

function(cityname){
	if(cityname == "New_York") {cityname <- paste0(cityname, "_City")}
	if(cityname == "Phoenix"){cityname <- paste0("Phoenix,_Arizona")}
	path <- paste0("https://en.wikipedia.org/wiki/",cityname)
		url <- path
	mytable <- read_html(url) %>% 
		html_nodes("table")
		
	tr <- which(grepl("toccolours", mytable))
	
		
		# Cleaning	
	df <- mytable[[tr]] %>% html_table(fill = TRUE, header = NA)
	df <- df[-1, c(1,2)]
	df[,2] <- as.numeric(gsub(",", "",df[,2]))
	df <- df[complete.cases(df),]
		hist_pop[[cityname]] <- df
	return(hist_pop)
}
