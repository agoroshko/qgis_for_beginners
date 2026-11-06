# Получение координат центров фотографий и названий фото

library(dplyr)
library(sf)
library(exiftoolr)

photo_path = c("/Users/Andrey_Goroshko/Desktop/Бирюса/ФОТО/")

photos = list.files(path = photo_path, full.names = T)

data = exif_read(photo_path, recursive = T, 
                 tags = c("FileName", "GPSLatitude", "GPSLongitude")) %>%
  st_as_sf(coords = c("GPSLongitude", "GPSLatitude"))

st_write(data, "../temp_photos.gpkg")

# Копирование фотографий в отдельную папку
data = st_read("../temp_photos.gpkg") %>% 
  filter(pick == 1)

dest_folder = "C:/Users/Andrey_Goroshko/Desktop/ortophoto_data/"

fs::file_copy(path = data$SourceFile, new_path = dest_folder)






