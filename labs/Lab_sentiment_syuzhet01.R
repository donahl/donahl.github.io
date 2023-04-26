# Knowledge Mining: Text mining
# File: Lab_sentiment_syuzhet01.R
# Theme: Running sentiment anlaysis using syuzhet package
# Data: Twitter data via REST API

# Sample program for using rtweet, syuzhet for sentiment analysis
# Be sure you get Twitter developer account

install.packages(c("easypackages","rtweet","tidyverse","RColorBrewer","tidytext","syuzhet"))
library(easypackages)
libraries("rtweet","tidyverse","RColorBrewer","tidytext","syuzhet")
library(twitteR)

# Use rtweet to collect Twitter data via API
# Prerequisite: Twitter developer account

## Required package: rtweet
# Create token for direct authentication to access Twitter data

auth_setup_default()

setup_twitter_oauth("pVfxNI5eqFJHXrBtrXO0Zc5Cq", "9vS2w9E900SvxSZR0xcbEh8u7YJBj8eS498IuPRrYB2serocjt", 
                    "1060092103580098560-vk9vqB1N1Fm9fdEVxlffOFLhn5Gv0i", "oN1FszUIDG6cD0AP9m8ps0U19pSubpJMY1UjKr1D8Hjgw")

token <- rtweet::create_token(
  app = "drkarlhoassignment03",
  consumer_key <- "pVfxNI5eqFJHXrBtrXO0Zc5Cq",
  consumer_secret <- "9vS2w9E900SvxSZR0xcbEh8u7YJBj8eS498IuPRrYB2serocjt",
  access_token <- "1060092103580098560-vk9vqB1N1Fm9fdEVxlffOFLhn5Gv0i",
  access_secret <- "oN1FszUIDG6cD0AP9m8ps0U19pSubpJMY1UjKr1D8Hjgw")



## Check token
rtweet::auth_get()

# Collect data from Twitter using keyword "Taiwan"
tw <- search_tweets("Taiwan", n=1000)


# Sentiment analysis
twtweets <- iconv(tw$text) # convert text data encoding
tw_sent_nrc <- get_nrc_sentiment(twtweets) # Get sentiment scores using NRC lexicon
barplot(colSums(tw_sent_nrc),
        las = 2,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Sentiment Scores Tweets of "Taiwan"')

tw_sent <- get_sentiment(twtweets) # Get sentiment scores 
plot(tw_sent, pch=20, cex = .3, col = "blue")


