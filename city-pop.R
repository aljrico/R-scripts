
# Functions ---------------------------------------------------------------

library(ggplot2)
library(tidyverse)
library(data.table)
library(XML)
library(RCurl)
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
library(stringr)



# URL ---------------------------------------------------------------------

path<-"https://en.wikipedia.org/wiki/List_of_United_States_cities_by_population"
webpage <- getURL(path)
webpage <- readLines(tc <- textConnection(webpage)) 
close(tc)

# Fetch all web content
pagetree <- htmlTreeParse(webpage, error=function(...){}, useInternalNodes = TRUE, encoding = "UTF-8")

# Extract table header and contents
tablehead <- xpathSApply(pagetree, "//*/table/tr", xmlValue)


city <- c()
pop <- c()
for(i in 17:323){
	# Select a row from the table
	row <- tablehead[i]
	row <- strsplit(row,"\n")
	
	# Extract city name and population
	city[i - 16] <- gsub("\\[(.*?)\\]", "", row[[1]][[2]])
	pop[i - 16] <- as.numeric(gsub(",", "",row[[1]][[4]]))
	

# Repeat for each city ----------------------------------------------------
	cityname <- gsub(" ", "_",city[i-16])
	path <- paste0("https://en.wikipedia.org/wiki/",cityname)
	
	webpage <- getURL(path)
	webpage <- readLines(tc <- textConnection(webpage)) 
	close(tc)
	
	# Fetch all web content
	pagetree <- htmlTreeParse(webpage, error=function(...){}, useInternalNodes = TRUE, encoding = "UTF-8")
	
	# Extract table header and contents
	tablehead <- xpathSApply(pagetree, "//*/table/tr", xmlValue)	
	
	# Select a row from the table
	row <- tablehead[1]
	row <- strsplit(row,"\n")
	
	
	
}	

most_pop_cities <- data.frame(city = city, pop = pop)
