library(rgdal)

data <- read.csv("data//GI.data//RetentionPondsUTM.csv")

coordinates(data) <- ~XCoordinate+YCoordinate
proj4string(data) <- CRS("+proj=utm +zone=17 +datum=WGS84") 

gps <- spTransform(data, CRS("+proj=longlat +datum=WGS84"))


write.csv(gps, "data//GI.data//RetentionPondsGPS.csv")