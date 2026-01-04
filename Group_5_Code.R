
library(dplyr)
library(ggplot2)
library(sampling)

# Load the dataset
data <- read.csv("/Users/juliangriffin/Desktop/Semester 2/Survey - 3430/Group Project/Group_5_Data.csv")

# Ensure column names are correctly formatted
colnames(data) <- make.names(colnames(data))

numeric_cols <- c("GPA", "Study_hours_week", "Exercise_hours_week", 
                  "Stress_1_to_10", "Sleep_hours_day", 
                  "Lecture_attendance_percent", "Screen_time_hours_day")

cor_results <- cor(data[, numeric_cols], use="complete.obs")

print("Correlation Matrix:")
print(cor_results)

cor_values <- cor_results["GPA", -1]

# Find strongest negative correlation
strongest_negative <- names(sort(cor_values, decreasing = FALSE))[1]  

# Find strongest positive correlation
strongest_positive <- names(sort(cor_values, decreasing = TRUE))[1]  

# Print strongest correlation results
print(paste("Strongest Negative Factor Affecting GPA:", strongest_negative, "with correlation", cor_values[strongest_negative]))
print(paste("Strongest Positive Factor Affecting GPA:", strongest_positive, "with correlation", cor_values[strongest_positive]))

# Plot: Study Hours vs GPA
ggplot(data, aes(x = Study_hours_week, y = GPA)) +
  geom_point(color = "blue", alpha = 0.5) +  # Scatter points
  geom_smooth(method = "lm", color = "red") +  # Regression line
  theme_minimal() +
  labs(title = "Study Hours vs. GPA", x = "Study Hours per Week", y = "GPA")

# Plot: Sleep Hours vs GPA
ggplot(data, aes(x = Sleep_hours_day, y = GPA)) +
  geom_point(color = "purple", alpha = 0.5) +
  geom_smooth(method = "lm", color = "darkgreen") + 
  theme_minimal() +
  labs(title = "Sleep Hours vs. GPA", x = "Sleep Hours per Day", y = "GPA")

# Plot: Screen Time vs GPA
ggplot(data, aes(x = Screen_time_hours_day, y = GPA)) +
  geom_point(color = "darkorange", alpha = 0.5) +
  geom_smooth(method = "lm", color = "black") +
  theme_minimal() +
  labs(title = "Screen Time vs. GPA", x = "Screen Time per Day", y = "GPA")

data$Study_Bins <- cut(data$Study_hours_week, breaks = c(-Inf, 5, 10, 15, 20, Inf),
                       labels = c("0-5", "6-10", "11-15", "16-20", "21+"))

data$Sleep_Bins <- cut(data$Sleep_hours_day, breaks = c(-Inf, 4, 6, 8, Inf),
                       labels = c("0-4", "5-6", "7-8", "9+"))

data$Screen_Bins <- cut(data$Screen_time_hours_day, breaks = c(-Inf, 2, 5, 8, Inf),
                        labels = c("0-2", "3-5", "6-8", "9+"))

# Combine stratification factors into one column
data$Strata <- paste("Study:", data$Study_Bins, ", Sleep:", data$Sleep_Bins, ", Screen:", data$Screen_Bins)
data$Strata <- as.factor(data$Strata)

set.seed(123)
srs_sample <- data %>% sample_n(30)
srs_mean_gpa <- mean(srs_sample$GPA, na.rm = TRUE)

print(paste("SRS Mean GPA:", srs_mean_gpa))

# Count number of students in each stratum
strata_counts <- table(data$Strata)

# Proportional Allocation: Sample size proportional to each stratum’s size
total_sample_size <- 30  
strata_sizes <- round((strata_counts / sum(strata_counts)) * total_sample_size)

# Ensure we don't sample more than what's available
for (stratum in names(strata_sizes)) {
  if (strata_sizes[stratum] > strata_counts[stratum]) {
    strata_sizes[stratum] <- strata_counts[stratum]
  }
}

# Ensure only strata with at least 2 students are kept
valid_strata <- strata_sizes[strata_sizes > 1] 
valid_strata_names <- names(valid_strata)

# Subset data to only include valid strata
data <- data[data$Strata %in% valid_strata_names, ]

# Perform stratified sampling
strata_sample <- strata(data, stratanames = c("Strata"), size = as.vector(valid_strata), method = "srswor")
stratified_sample <- data[strata_sample$ID_unit, ]

# Estimate Mean GPA using Stratified Sampling
stratified_mean_gpa <- mean(stratified_sample$GPA, na.rm = TRUE)
print(paste("Stratified Mean GPA:", stratified_mean_gpa))

srs_se <- sd(srs_sample$GPA, na.rm = TRUE) / sqrt(nrow(srs_sample))
stratified_se <- sd(stratified_sample$GPA, na.rm = TRUE) / sqrt(nrow(stratified_sample))

print(paste("SRS Standard Error:", srs_se))
print(paste("Stratified Standard Error:", stratified_se))

# Find the group with the highest and lowest mean GPA
strata_gpa <- aggregate(GPA ~ Strata, data = stratified_sample, mean)
best_stratum <- strata_gpa[which.max(strata_gpa$GPA), ]
worst_stratum <- strata_gpa[which.min(strata_gpa$GPA), ]

print(paste("The group with the highest GPA:", best_stratum$Strata, "with a mean GPA of", best_stratum$GPA))
print(paste("The group with the lowest GPA:", worst_stratum$Strata, "with a mean GPA of", worst_stratum$GPA))

# Combine into a new data frame
best_worst_gpa <- rbind(best_stratum, worst_stratum)

# Bar Plot for Best vs. Worst Strata
ggplot(best_worst_gpa, aes(x = reorder(Strata, GPA), y = GPA, fill = GPA)) +
  geom_bar(stat = "identity", width = 0.6) +
  theme_minimal() +
  labs(title = "Comparison of Best vs. Worst Performing Strata",
       x = "Student Strata (Study, Sleep, Screen Time)",
       y = "Mean GPA") +
  scale_fill_gradient(low = "red", high = "green") +
  theme(axis.text.x = element_text(angle = 25, hjust = 1, size = 15))

## High GPA Students:
# - Sleep: 7-9 hours per night
# - Study: 6-10 hours per week
# - Screen Time: 3-5 hours per day
# - Likely GPA Range: 8.5 - 9.0
# -> Therefore, students who balance sleep, moderate study, and controlled screen time tend to achieve the highest GPAs.

## Low GPA Students:
# - Sleep: 5-6 hours per night
# - Study: 6-10 hours per week
# - Screen Time: 6-8+ hours per day
# - Likely GPA Range: 5.5 - 6.0
# -> Therefore, students with similar study habits but **insufficient sleep and excessive screen time** tend to perform the worst.
