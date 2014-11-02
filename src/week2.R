rm(list=ls())
source("functions.R")

news <- "../data/en_US/en_US.news.txt"

# read data
text.news <- read_data(news)
sample.news <- sample_lines(text.news, .1)

myCorpus <- Corpus(VectorSource(text.news))
myStopwords <- stopwords('english')
myCorpus <- tm_map(myCorpus, removeWords, myStopwords)

#building the TDM


myTdm <- TermDocumentMatrix(myCorpus, control = list(tokenize = btm))

frq1 <- findFreqTerms(myTdm, lowfreq=50)