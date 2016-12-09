# slush-2016-analysis
Textual analysis of the startup companies participating in Slush.

## Source data
Source data is taken from Slush home page, on which the startup companies' descriptions are.

## Processing
Processing and some cleansing is executed with a R script

´´´
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
```

## Word cloud
Actual word cloud is plotted with another R function
´´´
wordcloud(tweets, max.words=60, scale=c(3,1), 
          random.order=FALSE, random.color=TRUE, rot.per=0.0, 
            use.r.layout=FALSE, colors=brewer.pal(5, "Set1"), fixed.asp=FALSE)
``` 
