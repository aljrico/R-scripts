
# Sudoku Solver -----------------------------------------------------------

data <- matrix(nrow=9, ncol=9)

f1 <- c(NA, 4, NA, NA, 9, NA, NA, 8, NA)
f2 <- c(NA, NA, NA, 5, 4, 7, NA, 6, NA)
f3 <- c(NA, NA, NA, NA, NA, 2, 5, NA, 7)
f4 <- c(NA, NA, 4, NA, 6, NA, NA, 2, 5)
f5 <- c(NA, NA, 8, NA, NA, NA, 1, NA, NA)
f6 <- c(9, 1, NA, NA, 3, NA, 6, NA, NA)
f7 <- c(4, NA, 6, 3, NA, NA, NA, NA, 2)
f8 <- c(NA, NA, NA, 9, 2, 6, NA, NA, NA)
f9 <- c(NA, 9, NA, NA, 8, NA, NA, 5, NA)

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
				if(6<=i & j<=3){remove <- unique(data[7:9, 1:3])}
				if(6<=i & 4<=j & j<=6){remove <- unique(data[7:9, 4:6])}
				if(6<=i & 7<=j){remove <- unique(data[7:9, 7:9])}
				poss <- poss[! poss %in% remove]
				
				if(length(poss) == 1){data[i,j] <- poss}
			}
		}
	}
	if(!is.na(data)){break}
}
data
