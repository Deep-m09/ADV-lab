library(ggplot2)
library(lubridate)
library(dplyr)

crime_data <- read.csv("crime_dataset_india.csv")

colnames(crime_data) <- make.names(colnames(crime_data), unique = TRUE)

print(colnames(crime_data))

crime_domain_count <- crime_data %>%
  group_by(Crime.Domain) %>%
  summarise(Count = n()) %>%
  ungroup()

ggplot(crime_domain_count, aes(x = "", y = Count, fill = Crime.Domain)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Distribution of Crime Domains") +
  theme_void() +
  theme(legend.position = "right")

ggplot(crime_data, aes(x = City)) +
  geom_bar(fill = "skyblue") +
  labs(title = "Count of Crimes by City", x = "City", y = "Number of Crimes") +
  theme_minimal()

ggplot(crime_data, aes(x = Victim.Age)) +
  geom_histogram(binwidth = 5, fill = "orange", color = "black") +
  labs(title = "Distribution of Victim Ages", x = "Victim Age", y = "Frequency") +
  theme_minimal()

crime_data$Date.Reported <- dmy(crime_data$Date.Reported)
ggplot(crime_data, aes(x = Date.Reported)) +
  geom_histogram(binwidth = 30, fill = "purple", color = "black") +
  labs(title = "Number of Crimes Reported Over Time", x = "Date Reported", y = "Number of Crimes") +
  theme_minimal()

weapon_summary <- crime_data %>%
  group_by(Weapon.Used) %>%
  summarise(Count = n())

ggplot(weapon_summary, aes(x = Weapon.Used, y = Count)) +
  geom_point(color = "darkred") +
  labs(title = "Crime Count by Weapon Used", x = "Weapon Used", y = "Number of Crimes") +
  theme_minimal()

city_summary <- crime_data %>%
  group_by(City) %>%
  summarise(Count = n(), Police.Deployed = sum(Police.Deployed))

ggplot(city_summary, aes(x = City, y = Count, size = Police.Deployed, fill = City)) +
  geom_point(alpha = 0.5, shape = 21) +
  labs(title = "Crimes by City and Police Deployed", x = "City", y = "Number of Crimes", size = "Police Deployed") +
  theme_minimal()

crime_data$Date.Reported <- dmy(crime_data$Date.Reported)

crime_data$YearMonth <- floor_date(crime_data$Date.Reported, "month")

monthly_crime_count <- crime_data %>%
  group_by(YearMonth) %>%
  summarise(Count = n()) %>%
  ungroup()

ggplot(monthly_crime_count, aes(x = YearMonth, y = Count)) +
  geom_line(color = "darkblue") +
  geom_point(color = "darkblue") +
  labs(title = "Number of Crimes Reported by Month", x = "Month", y = "Number of Crimes") +
  theme_minimal()
