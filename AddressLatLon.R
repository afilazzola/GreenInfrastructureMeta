## convert address to lat lon

# Read in the CSV data and store it in a variable 
data <- read.csv("data//GI.data//GreenRoofToronto.csv", stringsAsFactors = FALSE)
data[,"origAddress"] <- paste(data$STREET_NUM," ",data$STREET_NAME," ",data$STREET_TYPE,", ","Toronto,"," ON", sep="")


#load ggmap
library(ggmap)

# Initialize the data frame
geocoded <- data.frame(stringsAsFactors = FALSE)

# Loop through the addresses to get the latitude and longitude of each address and add it to the
# origAddress data frame in new columns lat and lon
for(i in 1:nrow(data))
{
  # Print("Working...")
  result <- geocode(data$origAddress[i], output = "latlona", source = "google")
  data$lon[i] <- as.numeric(result[1])
  data$lat[i] <- as.numeric(result[2])
}

## Reiterate loop to get all missing NAs as a result of not using Google API (i.e. Over query limit)
missing <- which(is.na(data$lat))
for(i in missing)
{
  # Print("Working...")
  result <- geocode(data$origAddress[i], output = "latlona", source = "google")
  data$lon[i] <- as.numeric(result[1])
  data$lat[i] <- as.numeric(result[2])
}


# Write a CSV file containing origAddress to the working directory
write.csv(data, "data//GI.data//GreenRoofGeocoded.csv", row.names=FALSE)




## Convert lat/lon for allotment and community gardens in Toronto

data2 <- read.csv("data//GI.data//GardenData.csv", stringsAsFactors = FALSE)


# Loop through the addresses to get the latitude and longitude of each address and add it to the
# origAddress data frame in new columns lat and lon
for(i in 1:nrow(data2))
{
  # Print("Working...")
  result <- geocode(data2$Address[i], output = "latlona", source = "google")
  data2$lon[i] <- as.numeric(result[1])
  data2$lat[i] <- as.numeric(result[2])
}

## Reiterate loop to get all missing NAs as a result of not using Google API (i.e. Over query limit)
missing <- which(is.na(data2$lat))
for(i in missing)
{
  # Print("Working...")
  result <- geocode(data2$Address[i], output = "latlona", source = "google")
  data2$lon[i] <- as.numeric(result[1])
  data2$lat[i] <- as.numeric(result[2])
}

# Write a CSV file containing origAddress to the working directory
write.csv(data2, "data//GI.data//GardenGeocoded.csv", row.names=FALSE)




## Convert lat/lon for allotment and community gardens in Peel Region

data3 <- read.csv("data//GI.data//PeelGardenData.csv", stringsAsFactors = FALSE)


# Loop through the addresses to get the latitude and longitude of each address and add it to the
# origAddress data frame in new columns lat and lon
for(i in 1:nrow(data3))
{
  # Print("Working...")
  result <- geocode(data3$Address[i], output = "latlona", source = "google")
  data3$lon[i] <- as.numeric(result[1])
  data3$lat[i] <- as.numeric(result[2])
}

## Reiterate loop to get all missing NAs as a result of not using Google API (i.e. Over query limit)
missing <- which(is.na(data3$lat))
for(i in missing)
{
  # Print("Working...")
  result <- geocode(data2$Address[i], output = "latlona", source = "google")
  data3$lon[i] <- as.numeric(result[1])
  data3$lat[i] <- as.numeric(result[2])
}

# Write a CSV file containing origAddress to the working directory
write.csv(data3, "data//GI.data//PeelGardenGeocoded.csv", row.names=FALSE)


### combine garden datasets

peel <- read.csv("data//GI.data//PeelGardenGeocoded.csv")
durham <- read.csv("data//GI.data//DurhamGardenGeocoded.csv")
toronto <- read.csv("data//GI.data//TorontoGardenGeocoded.csv")

peel <- peel[,c("Name","lon","lat")]
durham <- durham[,c("Name","Lon","Lat")]
toronto <- toronto[,c("Title","lon","lat")]

colnames(peel) <- c("name","lon","lat")
colnames(durham) <- c("name","lon","lat")
colnames(toronto) <- c("name","lon","lat")

gardens <- rbind(peel,durham,toronto)
gardens[,"region"] <- c(rep("Peel",nrow(peel)),rep("Durham",nrow(durham)),rep("Toronto",nrow(toronto)))

# Write a CSV file containing all community gardens
write.csv(gardens, "data//GI.data//ComGardensdata.csv", row.names=FALSE)




## Convert lat/lon for green roofs gardens in GTA

data4 <- read.csv("data//GI.data//GTA.Greenroof.csv", stringsAsFactors = FALSE)


# Loop through the addresses to get the latitude and longitude of each address and add it to the
# origAddress data frame in new columns lat and lon
for(i in 1:nrow(data4))
{
  # Print("Working...")
  result <- geocode(data4$Address[i], output = "latlona", source = "google")
  data4$lon[i] <- as.numeric(result[1])
  data4$lat[i] <- as.numeric(result[2])
}

## Reiterate loop to get all missing NAs as a result of not using Google API (i.e. Over query limit)
missing <- which(is.na(data4$lat))
for(i in missing)
{
  # Print("Working...")
  result <- geocode(data4$Address[i], output = "latlona", source = "google")
  data4$lon[i] <- as.numeric(result[1])
  data4$lat[i] <- as.numeric(result[2])
}

# Write a CSV file containing origAddress to the working directory
write.csv(data3, "data//GI.data//PeelGardenGeocoded.csv", row.names=FALSE)


### combine garden datasets

peel <- read.csv("data//GI.data//PeelGardenGeocoded.csv")
durham <- read.csv("data//GI.data//DurhamGardenGeocoded.csv")
toronto <- read.csv("data//GI.data//TorontoGardenGeocoded.csv")

peel <- peel[,c("Name","lon","lat")]
durham <- durham[,c("Name","Lon","Lat")]
toronto <- toronto[,c("Title","lon","lat")]

colnames(peel) <- c("name","lon","lat")
colnames(durham) <- c("name","lon","lat")
colnames(toronto) <- c("name","lon","lat")

gardens <- rbind(peel,durham,toronto)
gardens[,"region"] <- c(rep("Peel",nrow(peel)),rep("Durham",nrow(durham)),rep("Toronto",nrow(toronto)))

# Write a CSV file containing all community gardens
write.csv(gardens, "data//GI.data//ComGardensdata.csv", row.names=FALSE)