library(tibble)
library(ggplot2)
library(dplyr)
library(ggimage)
###############
#data
pol1 <- tibble(x = c(0, 0, 5.04, 5.04, 0), 
       y = c(0, 11.44, 11.44, 0, 0))
pol2 <- tibble(x = c(3.27, 3.27, 5.04, 5.04, 3.27), 
               y = c(0, 2, 2, 0, 0))
pol2 <- tibble(x = c(3.27, 3.27, 5.04, 5.04, 3.27), 
               y = c(0, 2, 2, 0, 0))
pol3 <- tibble(x = c(5.04, 8.54, 8.54, 5.04, 5.04), 
               y = c(11.44, 11.44, 0, 0, 11.44))
pol4 <- tibble(x = c(3.4, 3.4, 4.3, 4.3, 3.4), 
               y = c(2, 11.44, 11.44, 2, 2))
ln1 <- tibble(x = c(4.16, 4.16), y = c(0, 2))
pt <- tibble(x = rep(seq(0,5.04, by = 1.5), 8), 
             y = rep(seq(from = 0, to = 11.44, by = 1.5), each = 4), 
             image = "chair-1.1s-47px.svg") %>%
  filter(!c(x > 3 & y < 2))
pt2 <- tibble(x = 2.5, y = 12, image = "church-pulpit.png")
arrow1 <- tibble(x1 = rep(1.5, 4), 
                 x2 = c(3, 1.5, 0, 1.5), 
                 y1 = rep(4.5, 4), 
                 y2 = c(4.5, 6, 4.5, 3))
arrow2 <- tibble(x1 = c(4.6, 3.8), 
                 x2 = c(4.6, 3.8), 
                 y1 = c(0, 2), 
                 y2 = c(2, 0))
#################
#plot
ggplot(pol1, aes(x = x, y = y)) + 
  geom_polygon(fill = "blue", alpha = 0.5) +
  geom_polygon(data = pol2, aes(x = x, y = y), fill = "red", alpha = 0.5) +
  geom_polygon(data = pol3, aes(x = x, y = y), fill = "black", alpha = 0.5) +
  geom_polygon(data = pol4, aes(x = x, y = y), fill = "yellow", alpha = 0.8) +
  geom_line(data = ln1, aes(x = x, y = y))  +
  geom_image(data = pt, aes(x = x, y = y, image = image), size = .05) +
  geom_image(data = pt2, aes(x = x, y = y, image = image), size = .1) +
  ggtitle("Distribución de Asientos") +
  theme(plot.title = element_text(hjust = 0.5)) + 

  geom_text(data = tibble(x = 4.2, y = -.5, label = "S/E"), 
            aes( x=x, y=y, label=label),              
            color="black", 
            size=4 , angle=0, fontface="bold" ) +
  geom_text(data = tibble(x = 7, y = 6, label = "Salas"), 
            aes( x=x, y=y, label=label),              
            color="yellow", 
            size=10 , angle=45, fontface="bold" ) +
  geom_text(data = tibble(x = 2, y = 8, label = "Templo"), 
            aes( x=x, y=y, label=label),              
            color="#66ff99", 
            size=10 , angle=45, fontface="bold" ) +
  geom_text(data = tibble(x = 3.8, y = 7, label = "Circulación"), 
            aes( x=x, y=y, label=label),              
            color="black", 
            size=6 , angle = 90, fontface="bold" ) +
  geom_segment(data = arrow1, aes(x = x1, y = y1, xend = x2, yend = y2), 
               size = 0.4, 
               color = "#e60000", 
               arrow = arrow(length = unit(0.3, "cm"))) +
  geom_text(data = tibble(x = c(2, 1.5, 1, 1.5), y = c(4.5, 5.2, 4.5, 3.5), label = "1.5"), 
            aes( x=x, y=y, label=label),              
            color="white", 
            size = 3 , angle=0, fontface="bold" ) +
  geom_segment(data = arrow2, aes(x = x1, y = y1, xend = x2, yend = y2), 
               size = 0.8, 
               color = "white", 
               arrow = arrow(length = unit(0.3, "cm"))) +
  annotate("text", x = 7, y = 1, label = paste0("Total =", nrow(pt) + 1)) +
  ggsave(filename = "output/plano.jpg", device = "jpeg", dpi = "retina")

rm(list = ls())