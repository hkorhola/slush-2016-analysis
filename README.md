# slush-2016-analysis
Text analysis of the startup companies participating in Slush.

## Source data
Source data is taken from Slush home page, on which the startup companies' descriptions are.

```R
doc.html = htmlTreeParse('http://www.slush.org/why-attend/startups/',useInternal = TRUE)
rule <- "//div[@class='block startups-listing']//text()"
companydescriptions <- xpathSApply(doc.html, rule, xmlValue)
tweets <- VCorpus(VectorSource(companydescriptions))
```

## Processing
Processing and some cleansing is executed with an R script

```R
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
Actual word cloud is plotted with another R function. Max 60 words are plotted to keep the readability good.
```R
wordcloud(tweets, max.words=60, scale=c(3,1), 
          random.order=FALSE, random.color=TRUE, rot.per=0.0, 
            use.r.layout=FALSE, colors=brewer.pal(5, "Set1"), fixed.asp=FALSE)
```

### Remarks
* Most common words 'mobile', 'data', 'analytics' are of course no big surprises. Mobile will continue increasing as a channel.
+ IoT is quite small, probably due to the hype and overuse of the term, making people want to avoid it as its own
- 'Health' and 'wellbeing' have risen up in the third category and are slightly bigger than 'gaming', which has been in the headlines for the past 5 years
* 'Virtual' is not dominating the cloud, contrary to what one could have imagined this year
* 'Education' is going up from the past years
* Security is surprisingly small in this cloud. Still, the winner of the pitching competition represented security category with their advanced scanning solutions.


![Alt text](/slush_wordcloud.png?raw=true "Word cloud Slush 2016")
