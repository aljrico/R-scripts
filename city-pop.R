




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

# Extract url to cities websites
links <- mytable[[4]] %>% html_nodes("td:nth-child(2) a") %>% html_attr("href")
links <- links[!grepl("#", links)]


# Cleaning
most_pop_cities <- most_pop_cities[,c(4,2)]
colnames(most_pop_cities) <- c("pop", "city")
most_pop_cities$city <- gsub("\\[(.*?)\\]", "", most_pop_cities$city)
most_pop_cities$pop <- as.numeric(gsub(",", "", most_pop_cities$pop))

	
# Historical of each City ----------------------------------------------------

citynames <- gsub(" ", "_",most_pop_cities$city)

# Function
getHistPop <- function(link){
	path <- paste0("https://en.wikipedia.org",link)
		url <- path
	mytable <- read_html(url) %>% 
		html_nodes("table")
		
	tr <- which(grepl("toccolours", mytable))[[1]]
	
		
		# Cleaning	
	df <- mytable[[tr]] %>% html_table(fill = TRUE, header = NA)
	df <- df[-1, c(1,2)]
	df[,2] <- as.numeric(gsub(",", "",df[,2]))
	#if(df[nrow(df),1] != 2016){df[nrow,1] == 2016}
	df[,1] <- as.integer(gsub("[^0-9\\.]", "" ,df[,1]))
	df <- df[complete.cases(df),]
	colnames(df) <- c("year", "population")
	return(df)
}

hist_pop <- list()
for(i in 1:length(links)){
	hist_pop[[i]] <- getHistPop(links[[i]])
	names(hist_pop)[[i]] <- citynames[[i]]
}
