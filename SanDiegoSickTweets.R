#start time
t1 <- Sys.time()

#opens files (8639)
files <- list.files(path="E:/twitter/SickTweets",full.names=TRUE,pattern="RData")
dates <- strptime(basename(files),"%Y%b%d_%H.RData")
o <- order(dates)
files <- files[o]
dates <- dates[o]

#declare x values for plotting purposes
x <- seq(1,length(file),1)

#creates vector to hold number of sick tweets in San Diego per hour
time <- vector(length=length(x))

#loops through each file
for(i in 1:length(files)){
	#loads file
	load(files[i])
	#checks to make sure sick dataframe exists
	if(!is.null(sick)){
		#creates a vector with all tweets from San Diego
		a <- which(sick[,'County']=='193')
		#makes sure there are files in the vector
		if(length(a)>0){
			#assigns to the number of sick tweets in "a" to "b" 
			b <- sum(sick[a,'Sick']==1)
			#assigns the number of sick tweets to the ith value of the time vector
			time[i] <- b
		}
	}
	#prints file number
	cat(i,"\n")
}

#plots the number of sick tweets in San Diego per hour
plot(x,time,xlab="Time",ylab="# of Sick Tweets", ylim=c(min(time),max(time)),type = "p",pch = 20, col = "red")

#end time
t2 <- Sys.time()

#prints the time it took to run the program 
print(t2-t1)