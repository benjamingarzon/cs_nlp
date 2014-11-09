# functions 

library(tm)
library(RWeka)
library(SnowballC)
library(tm.plugin.dc)

getSample <- function(filePath, sampleSize)
{
  content <- readLines(filePath, encoding="UTF-8")
  n <- length(content)
  sampleIndexes <- sample(1:n, size = sampleSize, replace = T)
  result <- content[sampleIndexes]
  
  return(tolower(result))
}

read_data <- function(filename){
  con <- file(filename, "r")
  text <- readLines(con) 
  close(con)
  return(text)
}

sample_lines <- function(lines, prob){
  s <- rbinom(length(lines), 1, prob)
  lines[s==1]
}

check_word <- function(word, word_list) {
  if (word %in% word_list) return(TRUE)
  else return(FALSE)
  
}


get_freqs <- function(myTdm){

FreqMat <- data.frame(apply(as.matrix(myTdm), 1, sum))
FreqMat <- data.frame(ST = row.names(FreqMat), Freq = FreqMat[, 1])
FreqMat <- FreqMat[order(FreqMat$Freq, decreasing = T), ]
}

btm2 <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
btm3 <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))