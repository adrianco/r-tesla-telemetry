# r-tesla-telemetry
Simple code in R to process Tesla Telemetry files collected by a Tesla Model 3 Performance in Track Mode. See rs-tesla-telemetry for an RStudio Shiny App version. This code is for command line old-school R users, and was created before I figured out how to use RStudio and connect it to Github.

Files are saved to the USB data logger port that is also used for Sentry videos. There's a silent video file of the track mode session, and a CSV format file named telemetry-v1-date-time.csv, there are 29 columns of data.

This is the header line for the csv
```
Lap,Elapsed Time (ms),Speed (MPH),Latitude (decimal),Longitude (decimal),Lateral Acceleration (m/s^2),Longitudinal Acceleration (m/s^2),Throttle Position (%),Brake Pressure (bar),Steering Angle (deg),Steering Angle Rate (deg/s),Yaw Rate (rad/s),Power Level (KW),State of Charge (%),Tire Pressure Front Left (bar),Tire Pressure Front Right (bar),Tire Pressure Rear Left (bar),Tire Pressure Rear Right (bar),Brake Temperature Front Left (% est.),Brake Temperature Front Right (% est.),Brake Temperature Rear Left (% est.),Brake Temperature Rear Right (% est.),Front Inverter Temp (%),Rear Inverter Temp (%),Battery Temp (%),Tire Slip Front Left (% est.),Tire Slip Front Right (% est.),Tire Slip Rear Left (% est.),Tire Slip Rear Right (% est.)
```

Here are the names after reading into R
```
> names(laps[[1]])
 [1] "Lap"                                   
 [2] "Elapsed.Time..ms."                     
 [3] "Speed..MPH."                           
 [4] "Latitude..decimal."                    
 [5] "Longitude..decimal."                   
 [6] "Lateral.Acceleration..m.s.2."          
 [7] "Longitudinal.Acceleration..m.s.2."     
 [8] "Throttle.Position...."                 
 [9] "Brake.Pressure..bar."                  
[10] "Steering.Angle..deg."                  
[11] "Steering.Angle.Rate..deg.s."           
[12] "Yaw.Rate..rad.s."                      
[13] "Power.Level..KW."                      
[14] "State.of.Charge...."                   
[15] "Tire.Pressure.Front.Left..bar."        
[16] "Tire.Pressure.Front.Right..bar."       
[17] "Tire.Pressure.Rear.Left..bar."         
[18] "Tire.Pressure.Rear.Right..bar."        
[19] "Brake.Temperature.Front.Left....est.." 
[20] "Brake.Temperature.Front.Right....est.."
[21] "Brake.Temperature.Rear.Left....est.."  
[22] "Brake.Temperature.Rear.Right....est.." 
[23] "Front.Inverter.Temp...."               
[24] "Rear.Inverter.Temp...."                
[25] "Battery.Temp...."                      
[26] "Tire.Slip.Front.Left....est.."         
[27] "Tire.Slip.Front.Right....est.."        
[28] "Tire.Slip.Rear.Left....est.."          
[29] "Tire.Slip.Rear.Right....est.."  
```

Usage `> ptf("telemetry-date-time.csv")`
 
Results in a list of laps, with the structure shown above, and a summary data frame lapdf as shown below
```
> names(lapdf)
 [1] "num"              "seconds"          "minutes"          "maxMph"          
 [5] "maxKW"            "maxBhp"           "maxLateralG"      "maxAccelG"       
 [9] "maxBrakeG"        "maxBrakePedal"    "startChargePct"   "maxBrakeTempPct" 
[13] "maxFrontInverter" "maxRearInverter"  "maxBatteryTemp"  
 ```
 
 ptf drops lap 0, splits the rest of the data into laps, and calls plap on each to generate a row for each lap in the data frame
 
 To install it, first visit http://www.r-project.org and download and install the package.
 After starting R, if you know the vi editor:
 `> ptf <- vi()` and read in or cut and paste the code from ptf.R
 `> plap <- vi()` and read in or cut and paste the code from plap.R
 `> ls()` to see what data and scripts are in place, `> q()` to quit R.
 
 There's an example data file on github as well. It's truncated half way through lap 5.
 
 To plot lateral acceleration (column 6) vs. time (column 2) for lap 3 `plot(laps[[3]][c(2,6)], type="l")`
 
 To plot a map of the track (columns 5 and 4) for lap 2 `> plot(laps[[2]][c(5,4)], type="l")`
 
 To see png options and save plots as png files
 ```
> ? png
> png()
> plot(laps[[2]][c(5,4)], type="l")
> dev.off()
```
This results in files with names like like Rplot001.png being saved.
