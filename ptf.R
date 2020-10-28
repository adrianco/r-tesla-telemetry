function(trackfile) {
	tf <- read.csv(trackfile)
	if (length(names(tf)) != 29) {
		warning("expected 29 columns in tesla telemetry file")
		return()
	}
	#Remove lap 0
	tf <- tf[(tf[,1]!=0),]
	# create list of separate laps
	laps <<- split(tf, tf[,1])
	lapl <- lapply(laps, plap)
	lapdf <<- data.frame(t(sapply(lapl,c)))
}
