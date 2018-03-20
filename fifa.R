library(caret)
library(ggplot2)

# import data
data <- read.csv("fifa.csv")

# remove goalkeepers from data
filtered.data <- data[data$Preferred.Positions != "GK ",]

# distribution of player ball control
ballcontrol.histogram <- ggplot(filtered.data, aes(Ball.control)) +
    geom_histogram() +
    ggtitle("Ball Control") +
    xlab("Ball Control") +
    ylab("Count") +
    theme_bw() +
    theme(text = element_text(size = 20), plot.title = element_text(hjust = 0.5))

ballcontrol.density <- ggplot(filtered.data, aes(Ball.control)) +
    geom_density() +
    ggtitle("Ball Control") +
    xlab("Ball Control") +
    ylab("Density") +
    theme_bw() +
    theme(text = element_text(size = 20), plot.title = element_text(hjust = 0.5))

# print(ballcontrol.histogram)
# print(ballcontrol.density)

# distribution of player finishing
finishing.histogram <- ggplot(filtered.data, aes(Finishing)) +
    geom_histogram() +
    ggtitle("Finishing") +
    xlab("Finishing") +
    ylab("Count") +
    theme_bw() +
    theme(text = element_text(size = 20), plot.title = element_text(hjust = 0.5))

finishing.density <- ggplot(filtered.data, aes(Finishing)) +
    geom_density() +
    ggtitle("Finishing") +
    xlab("Finishing") +
    ylab("Density") +
    theme_bw() +
    theme(text = element_text(size = 20), plot.title = element_text(hjust = 0.5))

# print(finishing.histogram)
# print(finishing.density)

# impact of ball control on overall player rating
ballcontrol.overall.point <- ggplot(filtered.data, aes(Ball.control, Overall)) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    ggtitle("Impact of Ball Control on Overall Player Rating") +
    theme_bw() +
    theme(text = element_text(size = 20), plot.title = element_text(hjust = 0.5))

# print(ballcontrol.overall.point)

# impact of finishing on overall player rating
finishing.overall.point <- ggplot(filtered.data, aes(Finishing, Overall)) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    ggtitle("Impact of Finishing on Overall Player Rating") +
    theme_bw() +
    theme(text = element_text(size = 20), plot.title = element_text(hjust = 0.5))

# print(finishing.overall.point)

# predict overall player rating based on ball control and finishing
selected.data <- filtered.data[, c("Overall", "Ball.control", "Finishing")]
selected.data <- selected.data[complete.cases(selected.data),]

train.control <- trainControl(method="repeatedcv", number=10, repeats=3) # repeated k-fold

m1 <- train(Overall ~., selected.data, trControl = train.control, method="lm")
m2 <- train(Overall ~., selected.data, trControl = train.control, method="rf")
all.models <- resamples(list(LinearModel = m1, RandomForest = m2))
all.models.plot <- bwplot(all.models, scales = list(relation = "free"))
# print(all.models.plot)
