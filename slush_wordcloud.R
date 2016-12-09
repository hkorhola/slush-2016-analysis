library("tm")
library("wordcloud")
library("SnowballC")
library("XML")

#### SOURCE FROM SLUSH HOME PAGE ####
doc.html = htmlTreeParse('http://www.slush.org/why-attend/startups/',useInternal = TRUE)
rule <- "//div[@class='block startups-listing']//text()"
companydescriptions <- xpathSApply(doc.html, rule, xmlValue)
tweets <- VCorpus(VectorSource(companydescriptions))



#### CLEANSING ####

#remove whitespace
tweets <- tm_map(tweets, stripWhitespace)

#to lower case
tweets <- tm_map(tweets, content_transformer(tolower))

#remove stopwords (a, the, an...)
tweets <- tm_map(tweets, removeWords, stopwords("english"))

#remove manually some irrelevant words
tweets <- tm_map(tweets, removeWords, c("ltd", "inc"))

#remove numbers
tweets <- tm_map(tweets, removeNumbers)

#remove punctuation
tweets <- tm_map(tweets, removePunctuation)


  
#### PLOT ####
wordcloud(tweets, max.words=60, scale=c(3,1), 
          random.order=FALSE, random.color=TRUE, rot.per=0.0, 
            use.r.layout=FALSE, colors=brewer.pal(5, "Set1"), fixed.asp=FALSE)
