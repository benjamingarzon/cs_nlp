# functions 

library(tm)
library(RWeka)

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

btm <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))