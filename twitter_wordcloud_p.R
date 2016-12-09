#necessary packages
library("twitteR")
library("wordcloud")
library("SnowballC")
library("tm")
  
 
#Twitter keys
consumer_key <- '<your key>'
consumer_secret <- '<your key>'
access_token <- '<your key>'
access_secret <- '<your key>'
setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret)
 

slush_tweets <- searchTwitter("#slush16", n=5000)
 
#save text
slush_tweets_text <- sapply(slush_tweets, function(x) x$getText())
 
#create a corpus
slush_tweets_corpus <- VCorpus(VectorSource(slush_tweets_text))

slush_tweets_corpus <- tm_map(slush_tweets_corpus,content_transformer(function(x) iconv(x, to='UTF-8-MAC', sub='byte')),mc.cores=1)
 
#cleansing
slush_tweets_corpus <- tm_map(slush_tweets_corpus, stripWhitespace, lazy=TRUE)
slush_tweets_corpus <- tm_map(slush_tweets_corpus, content_transformer(tolower), lazy=TRUE) 

slush_tweets_corpus <- tm_map(slush_tweets_corpus, removeWords, stopwords("english"), lazy=TRUE)
slush_tweets_corpus <- tm_map(slush_tweets_corpus, removeWords, stopwords("finnish"), lazy=TRUE)

slush_tweets_corpus <- tm_map(slush_tweets_corpus, removeWords, c("http", "https", "co", "slush16", "slush", "slushhq"))
#remove numbers
slush_tweets_corpus <- tm_map(slush_tweets_corpus, removeNumbers)
slush_tweets_corpus <- tm_map(slush_tweets_corpus, removePunctuation, lazy=TRUE)


#### PLOT ####
wordcloud(slush_tweets_corpus, max.words=80, scale=c(3,1), 
          random.order=FALSE, random.color=TRUE, rot.per=0.0, 
            use.r.layout=FALSE, colors=brewer.pal(5, "Dark2"), fixed.asp=FALSE)
 
