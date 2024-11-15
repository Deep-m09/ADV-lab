library(ggplot2)
library(dplyr)
library(wordcloud)
library(scatterplot3d)

housing_data <- read.csv('Housing.csv')

word_freq <- as.data.frame(table(housing_data$furnishingstatus))
wordcloud(words = word_freq$Var1, freq = word_freq$Freq, min.freq = 1, scale=c(4,0.5),
          colors=brewer.pal(8, "Paired"), random.order=FALSE)

box_plot <- ggplot(housing_data, aes(x = furnishingstatus, y = price, fill = furnishingstatus)) +
  geom_boxplot(outlier.shape = NA) +
  stat_boxplot(geom ='errorbar') +
  labs(title = 'Box and Whisker Plot of House Prices by Furnishing Status', y = 'Price', x = 'Furnishing Status') +
  theme_minimal()

print(box_plot)

violin_plot <- ggplot(housing_data, aes(x = furnishingstatus, y = area, fill = furnishingstatus)) +
  geom_violin() +
  labs(title = 'Violin Plot of House Area by Furnishing Status', y = 'Area (sq. ft.)', x = 'Furnishing Status') +
  theme_minimal()

print(violin_plot)

scatter_plot <- ggplot(housing_data, aes(x = area, y = price)) +
  geom_point(color = 'blue') +
  geom_smooth(method = 'lm', color = 'red') +
  labs(title = 'Scatter Plot of Price vs Area with Linear Regression', x = 'Area (sq. ft.)', y = 'Price') +
  theme_minimal()

print(scatter_plot)

s3d <- scatterplot3d(housing_data$area, housing_data$bedrooms, housing_data$price,
                     color='blue', pch=16, angle=55, main='3D Plot of Price, Area, and Bedrooms',
                     xlab='Area (sq. ft.)', ylab='Bedrooms', zlab='Price')
