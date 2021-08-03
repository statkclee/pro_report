library(tidyverse)
library(magick)
library(extrafont)
loadfonts()

create_cover_image <- function (gender) {
  
  # 책 표지: https://commons.wikimedia.org/wiki/File:Unknown,_Egypt,_14th_Century_-_Book_Binding_-_Google_Art_Project.jpg
  base_img_loc <- here::here("assets/cover.jpg")
  logo_img_loc <- here::here("assets/logo.png")
  
  base_image <- image_read(base_img_loc) %>% 
    image_resize("1524x2000")
  logo_image <- image_read(logo_img_loc) %>% 
    image_resize("200%")
  
  # Annotate base image
  title_text  <- glue::glue("체질량지수(BMI) - R마크다운")
  subtitle_text <- glue::glue("데이터베이스 + {gender}")
  author_text <- glue::glue("R 사용자회")  
  
  final <- base_image %>% 
    image_annotate(title_text, size = 90, color = "white",
                   degrees = 0,  location = "+100+330", font = "NanumGothic") %>% 
    image_annotate(subtitle_text, size = 50, color = "green",
                   degrees = 0,  location = "+300+530", font = "NanumGothic") %>% 
    image_annotate(author_text, size = 80, color = "blue",
                   degrees = 0,  location = "+500+1300", font = "NanumBarunpen") %>% 
    image_composite(logo_image, offset = "+350+1600") %>% 
    image_resize("40%")

  return(final)
}

# create_cover_image(gender = "Male")

