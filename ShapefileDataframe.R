### Tree shape file to lat  lon


## load libraries
library(rgdal)
library(raster)

shape <- readOGR(dsn = "data/GI.data/TorontoTreeShp", "TMMS_Open_Data_WGS84")

tree.df <- data.frame(shape)

write.csv(tree.df, "data/GI.data/Treedata.csv", row.names = FALSE)
