function(lap) {
	laplen <- length(lap[,2])
	# take the difference between the first and last sample for the lap, should really take the time from the next lap
	lt <- (lap[laplen,2] - lap[1,2])/1000.0
	KW <- max(lap[,13])
	gms <- 9.80665
	# lap number, time in seconds, time converted to MM:SS.mmm format
	lapinfo <- data.frame(num=lap[1,1], seconds=lt, minutes=sprintf("%d:%02d.%03d", lt%/%60, round(lt%%60), (1000*lt)%%1000),
		# speed and power
		maxMph=max(lap[,3]), maxKW=round(KW), maxBhp=round(KW/0.745699872),
		# acceleration and braking
		maxLateralG=round(max(lap[6])/gms, 2), maxAccelG=round(max(lap[7])/gms, 2),
		maxBrakeG=-round(min(lap[7])/gms, 2), maxBrakePedal=round(max(lap[9]),1),
		# charge at start of lap, max temp for all brakes
		startChargePct=round(lap[1,14]), maxBrakeTempPct=round(max(lap[,19:22])*100),
		# inverter and battery max temp percentages
		maxFrontInverter=round(max(lap[, 23])*100), maxRearInverter=round(max(lap[,24])*100),
		maxBatteryTemp=round(max(lap[,25])*100))
	return(lapinfo)
}
