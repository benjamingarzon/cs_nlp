rm(list=ls())
source("functions.R")


#Some words are more frequent than others - what are the distributions of word frequencies? 
#What are the frequencies of 2-grams and 3-grams in the dataset? 
#How many unique words do you need in a frequency sorted dictionary to cover 50% of all word instances in the language? 90%? 
#How do you evaluate how many of the words come from foreign languages? 
#Can you think of a way to increase the coverage -- identifying words that may not be in the corpora or using a smaller number of words in the dictionary to cover the same number of phrases?


news <- "../data/en_US/en_US.news.txt"
# read data


text.news <- read_data(news)
sample.news <- sample_lines(text.news, .03)

myCorpus <- Corpus(VectorSource(sample.news))
myStopwords <- stopwords('english')
myCorpus <- tm_map(myCorpus, removeWords, myStopwords)

#building the TDM
# word freq
myTdm.1 <- TermDocumentMatrix(myCorpus, control = list(tokenize = MC_tokenizer, 
                                                       removePunctuation = TRUE, 
                                                       stopwords = TRUE) )
FreqMat.1 <- get_freqs(myTdm.1)

# 2-grams
myTdm.2 <- TermDocumentMatrix(myCorpus, control = list(tokenize = btm2, 
                                                       removePunctuation = TRUE, 
                                                       stopwords = TRUE) )
FreqMat.2 <- get_freqs(myTdm.2)

# 3-grams
myTdm.3 <- TermDocumentMatrix(myCorpus, control = list(tokenize = btm3, 
                                                       removePunctuation = TRUE, 
                                                       stopwords = TRUE) )
FreqMat.3 <- get_freqs(myTdm.3)

#How many unique words do you need in a frequency sorted dictionary to cover 50% of all word instances in the language? 90%? 
FreqMat.1$freq <- FreqMat.1$Freq/sum(FreqMat.1$Freq)
unique.50 <- max(which(cumsum(FreqMat.1$freq)<.5))
unique.90 <- max(which(cumsum(FreqMat.1$freq)<.9))


# blogs
blogs <- "../data/en_US/en_US.blogs.txt"
sampleVector <- getSample(blogs, sampleSize = 1000)

corpus <- VCorpus(VectorSource(sampleVector))

corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, stemDocument)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, content_transformer(tolower))

dtm <- DocumentTermMatrix(corpus)
dtm.r <- removeSparseTerms(dtm, 0.9)

tdm.1 <- TermDocumentMatrix(corpus, control = list(tokenize = MC_tokenizer))
FreqMat.1 <- get_freqs(tdm.1)
FreqMat.1$freq <- FreqMat.1$Freq/sum(FreqMat.1$Freq)
unique.50 <- max(which(cumsum(FreqMat.1$freq)<.5))
unique.90 <- max(which(cumsum(FreqMat.1$freq)<.9))

# check if word is foreign
english.dict <- "../data/wordsEn.txt"
word_list <- as.vector(read.table(english.dict)$V1)

words <- as.character(FreqMat.1$ST)
checks <- sapply(words, check_word, word_list) # = false for foreign words
