#AllSickTweets.R

#start time
t1 <- Sys.time()

#opens files (8639)
files <- list.files(path="E:/twitter/SickTweets",full.names=TRUE,pattern="RData")
dates <- strptime(basename(files),"%Y%b%d_%H.RData")
o <- order(dates)
files <- files[o]
dates <- dates[o]

#declare x for plotting purposes
x <- seq(1,length(files),1)

#creates vector to hold number of sick tweets per hour
time <- vector(length=length(x))

#loops through each file
for(i in 1:length(files)){
	#loads file
	load(files[i])
	#makes sure the sick dataframe is there
	if(!is.null(sick)){
		#creates a vector "a" with all files
		a <- which(sick[,'County']!='NA')
		#makes sure there are files in vector
		if(length(a)>0){
			#assigns the sum of all a sick tweets in "a" to "b"
			b <- sum(sick[a,'Sick']==1)
			#assigns the number of sick tweets in the file to the ith space in time vector
			time[i] <- b
		}
	}
	#prints the file number
	cat(i,"\n")
}

#plots the sick tweets per hour
plot(x,time,xlab="Time",ylab="# of Sick Tweets", ylim=c(min(time),max(time)),type = "p",pch = 20, col = "red")

#end time
t2 <- Sys.time

#prints the time the program took to run
print(t2-t1)