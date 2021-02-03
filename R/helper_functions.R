library(tidyverse)
library(magick)

create_cover_image <- function () {
  
  # 책 표지: https://commons.wikimedia.org/wiki/File:Unknown,_Egypt,_14th_Century_-_Book_Binding_-_Google_Art_Project.jpg
  base_img_loc <- here::here("assets/cover.jpg")
  
  base_image <- magick::image_read(base_img_loc) %>% 
    image_resize("1524x2000")
  
  # Annotate base image
  text <- glue::glue("Tidyverse Korea + 한글")
  
  final <- magick::image_annotate(base_image, text, size = 60, color = "white",
                                  degrees = 0,  location = "+150+330", font = "AppleGothic")

  # final <- magick::image_annotate(base_image, text, size = 60, color = "white", location = "+150+330", font = "NanumGothic")
  
  return(final)
}

# create_cover_image()

# Windows is not working !!!
# https://github.com/ropensci/magick/issues/96
# library(extrafont)
# loadfonts()
# image_annotate(smpl_img, "청명한 봄하늘", size = 70, location = "+50+200", color = "green", font = "Courier")
# library(sysfonts)
# font_add("NanumGothic","C:/windows/fonts/NanumFont/NanumGothic.ttf")
# 
# sysfonts::font.families()
# 
# image_annotate(smpl_img, "청명한 봄하늘", size = 70, location = "+50+200", color = "green", font = "NanumGothic")
