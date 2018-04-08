
# Functions ---------------------------------------------------------------

library(ggplot2)
library(tidyverse)
library(data.table)
library(XML)
library(RCurl)
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
library(stringr)
library(rvest)



# URL ---------------------------------------------------------------------

path<-"https://en.wikipedia.org/wiki/List_of_United_States_cities_by_population"
webpage <- getURL(path)
webpage <- readLines(tc <- textConnection(webpage)) 
close(tc)

# Fetch all web content
pagetree <- htmlTreeParse(webpage, error=function(...){}, useInternalNodes = TRUE, encoding = "UTF-8")

# Extract table header and contents
tablehead_us <- xpathSApply(pagetree, "//*/table/tr", xmlValue)


city <- c()
pop <- c()
hist_pop <- list()
for(i in 17:323){
	# Select a row from the table
	row <- tablehead_us[i]
	row <- strsplit(row,"\n")
	
	# Extract city name and population
	city[i - 16] <- gsub("\\[(.*?)\\]", "", row[[1]][[2]])
	pop[i - 16] <- as.numeric(gsub(",", "",row[[1]][[4]]))
	
	
	
	# Historical of each City ----------------------------------------------------
	
	cityname <- gsub(" ", "_",city[i-16])
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
	rm(df)
}	

most_pop_cities <- data.frame(city = city, pop = pop)
