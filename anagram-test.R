# Anagram Test ------------------------------------------------------------
# Author: Alejandro Jiménez Rico <aljrico@gmail.com>

# Words sample
test1 <- c("yellow", "lolwey")
test2 <- c("blue", "blau")
test3 <- c("lol", "lolol")
test4 <- c("purple", "relpup")


# Selecting the words to test
w1 <- test4[1]
w2 <- test4[2]

# Defining function
anagram.test <- function(w1,w2){
	
	if (!is.character(w1) | !is.character(w2)) stop("This test just works with WORDS, made of characters. Make sure your input is a string.")
	
	a <- paste(sort(unlist(strsplit(w1, ""))), collapse = "")
	b <- paste(sort(unlist(strsplit(w2, ""))), collapse = "")

	if (a == b) print("Yes, this is an anagram.")
	if (a != b) print("Nope, this is NOT an anagram.")

}

# Calling function
anagram.test(w1,w2)
