
# Sudoku Solver -----------------------------------------------------------

data <- matrix(nrow=9, ncol=9)

f1 <- c(2, NA, NA, 8, NA, 4, NA, NA, 6)
f2 <- c(NA, NA, 6, NA, NA, NA, 5, NA, NA)
f3 <- c(NA, 7, 4, NA, NA, NA, 9, 2, NA)
f4 <- c(3, NA, NA, NA, 4, NA, NA, NA, 7)
f5 <- c(NA, NA, NA, 3, NA, 5, NA, NA, NA)
f6 <- c(4, NA, NA, NA, 6, NA, NA, NA, 9)
f7 <- c(NA, 1, 9, NA, NA, NA, 7, 4, NA)
f8 <- c(NA, NA, 8, NA, NA, NA, 2, NA, NA)
f9 <- c(5, NA, NA, 6, NA, 8, NA, NA, 1)

data = t(as.matrix(cbind(f1, f2, f3, f4, f5, f6, f7, f8, f9)))
original <- data
repeat{
	i <- 1
	j <- 1
	print(sum(is.na(data)))
	for(i in 1:9){
		for(j in 1:9){
			if(is.na(data[i,j])){
				poss <- c(1:9)
				
				remove <- unique(data[i,])
				poss <- poss[! poss %in% remove]
				
				remove <- unique(data[, j])
				poss <- poss[! poss %in% remove]
				
				if(i<=3 & j<=3){remove <- unique(data[1:3, 1:3])}
				if(i<=3 & 4<=j & j<=6){remove <- unique(data[1:3, 4:6])}
				if(i<=3 & 7<=j){remove <- unique(data[1:3, 7:9])}
				if(4<=i & i<=6 & j<=3){remove <- unique(data[4:6, 1:3])}
				if(4<=i & i<=6 & 4<=j & j<=6){remove <- unique(data[4:6, 4:6])}
				if(4<=i & i<=6 & 7<=j){remove <- unique(data[4:6, 7:9])}
				if(7<=i & j<=3){remove <- unique(data[7:9, 1:3])}
				if(7<=i & 4<=j & j<=6){remove <- unique(data[7:9, 4:6])}
				if(7<=i & 7<=j){remove <- unique(data[7:9, 7:9])}
				poss <- poss[! poss %in% remove]
				
				if(length(poss) == 1){data[i,j] <- poss}
			}
		}
	}
	if(sum(is.na(data))==0){break}
}
data
