library(raster)
library(rgdal)

### convert fauna shape file to spreadsheet and convert to lat lon
fauna <- readOGR(dsn = "E:/ToAndrewAlex", "fauna_TRCA")

fauna <- spTransform(fauna, CRS("+proj=longlat +datum=WGS84"))

fauna.df <- data.frame(fauna)

## rename columns for lat lon
colnames(fauna.df)[21:22] <- c("lon","lat")
fauna.df[,23] <- NULL ## drop final column

write.csv(fauna.df, "data/SurveyData/FaunaData.csv", row.names = FALSE)


### convert flora shape file to spreadsheet and convert to lat lon
flora <- readOGR(dsn = "E:/ToAndrewAlex", "Flora_trca")

## Remove erroneous UTM value
flora.df <- data.frame(flora)
flora.df <- flora.df[!flora.df$coords.x1==min(flora.df$coords.x1),] ## lon
flora.df <- flora.df[!flora.df$coords.x2==min(flora.df$coords.x2),]  ## lat

## redefine as spatial points
coordinates(flora.df) <- ~coords.x1+coords.x2
proj4string(flora.df) <- CRS("+proj=utm +zone=17 +datum=WGS84") 

## Convert to lat lon
flora2 <- spTransform(flora.df, CRS("+proj=longlat +datum=WGS84"))

flora2.df <- data.frame(flora2)

## rename columns for lat lon
colnames(flora2.df)[25:26] <- c("lon","lat")
flora2.df[,27] <- NULL ## drop final column

write.csv(flora2.df, "data/SurveyData/FloraData.csv", row.names = FALSE)
