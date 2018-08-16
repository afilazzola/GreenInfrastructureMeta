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


