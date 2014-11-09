rm(list=ls())
source("functions.R")

twitter <- "../data/en_US/en_US.twitter.txt"
news <- "../data/en_US/en_US.news.txt"
blogs <- "../data/en_US/en_US.blogs.txt"

# read data
text.twitter <- read_data(twitter)
text.blogs <- read_data(blogs)
text.news <- read_data(news)


# Sample some lines
sample.twitter <- sample_lines(text.twitter, .3)

# ------------------
# Quizz 1

# Question 2
print(length(text.twitter))

# Question 3
print(max(unlist(lapply(text.twitter, nchar))))
print(max(unlist(lapply(text.blogs, nchar))))
print(max(unlist(lapply(text.news, nchar))))

# Question 4
print(length(grep("love", text.twitter))/length(grep("hate", text.twitter)))

# Question 5
text <- "biostats"
tweet.biostats <- grep(text, text.twitter)
print(text.twitter[tweet.biostats])

# Question 6
text <- "A computer once beat me at chess, but it was no match for me at kickboxing"
tweets <- grep(text, text.twitter)
print(text.twitter[tweets])

