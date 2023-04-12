
library(ggplot2)
require(ggimage)


get_data_points <- function(green, amber, green_icon = 'img/green.png', amber_icon = 'img/amber.png') {
  # greens + ambers must be 100
  stopifnot(green + amber == 100)
  
  # get identifiers from 1 to 100
  df <- data.frame(pid = seq(1, 100))
  df$cc <- floor((df$pid - 1) / 10)  # get the row number
  df$rr <- -((df$pid - 1) %% 10)  # get the column number
  # I swapped cc and rr to make it similar to the webpage
  
  # set the figure for the numbers
  df$iicon <- ifelse(df$pid <= green, green_icon, amber_icon)

  # generate figure
  p <- ggplot(df, aes(x = cc, y = rr, image = iicon)) +
    ggimage::geom_image(aes(image = iicon), size=0.12) +  # add the image
    theme_minimal() + # remove elements from theme
    theme(panel.grid.major = element_blank(),
          axis.title.x=element_blank(),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank(),
          axis.title.y=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank(),
          legend.position="none")
  
  return(p)
}

