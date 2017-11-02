
# Sudoku Solver -----------------------------------------------------------
# Author: Alejandro Jiménez Rico <aljrico@gmail.com>

# Disclaimer: This sudoku solver does not handle problems in a 'hard' category. This category system is the usual used in many publications, which differentiates EASY, MEDIUM and HARD. This script is able to solve those classified as EASY or MEDIUM, but not HARD. Further work is needed.


data <- matrix(nrow=9, ncol=9)
alt <- array(dim=c(9,9,9))

f1 <- c(NA, NA, 9, NA, NA, 2, 4, NA, NA)
f2 <- c(NA, 7, 4, NA, 9, 1, NA, NA, NA)
f3 <- c(NA, NA, NA, 4, NA, NA, 6, 9, 7)
f4 <- c(2, 9, 8, NA, NA, NA, 7, NA, NA)
f5 <- c(NA, 1, NA, NA, NA, NA, NA, 2, NA)
f6 <- c(NA, NA, 3, NA, NA, NA, 8, 5, 1)
f7 <- c(1, 8, 6, NA, NA, 4, NA, NA, NA)
f8 <- c(NA, NA, NA, 8, 3, NA, 1, 6, NA)
f9 <- c(NA, NA, 2, 1, NA, NA, 9, NA, NA)

k <- 0

data = t(as.matrix(cbind(f1, f2, f3, f4, f5, f6, f7, f8, f9)))
original <- data
repeat{
	print(sum(is.na(data)))
	
	# This double loop solves all sudokus classified as 'easy'.
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
	
	# This triple loop manages to solve every 'medium' difficulty sudoku.
	for(k in 1:9){
		for(i in 1:3){
			for(j in 1:3){
				if(!k %in% data[i,] & !k %in% data[,j] & !k %in% data[1:3, 1:3] & is.na(data[i,j])){alt[i,j,k] <- k}
				
			}
		}
		if(sum(!is.na(alt[,,k])) == 1){
			dum <- which(alt[,,k] == k, arr.ind = TRUE)
			data[dum[1,1], dum[1,2]] <- k
			}
	}
	
	
	if(sum(is.na(data))==0){break}
}
data

