#AllTweetsDaily.R

#start time
t1 <- Sys.time()

#load files
files <- list.files(path="E:/twitter/SickTweets",full.names=TRUE,pattern="RData")
dates <- strptime(basename(files),"%Y%b%d_%H.RData")
o <- order(dates)
files <- files[o]
dates <- dates[o]

tweets =  vector(length = 385)

xaxis <- seq(1,385,1)

#string of a particular date
x = as.Date(strptime(basename(files[1]),"%Y%b%d_%H.RData"))

for(i in 1:385){
	#files that match a particular date, x
	dayFiles <- which(as.Date(strptime(basename(files),"%Y%b%d_%H.RData")) == x)
	if(length(dayFiles)>0){
		for(j in 1:length(dayFiles)){
			load(files[dayFiles[j]])
			if(!is.null(sick)){
				a <- which(sick[,'County']!='NA')
				if(length(a) > 0) {
					tweets[i] <- tweets[i] + length(a)
				}
			}
		}
	}
	
	#goes to next date
	x <- x + 1
	print(x)
}
print(tweets)

plot(xaxis, tweets, xlab="Day", ylab="# of Tweets", ylim = c(min(tweets),max(tweets)), type = "p", pch = 20, col = "red")

#end time
t2 <- Sys.time()

#prints the time the program took to run 
print(t2-t1)


