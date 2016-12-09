# slush-2016-analysis
Text analysis of the startup companies participating in Slush accompanied with a Twitter analysis of Slush related tweets.

## Source data
Source data is taken from Slush home page, on which the startup companies' descriptions are.

```R
doc.html = htmlTreeParse('http://www.slush.org/why-attend/startups/',useInternal = TRUE)
rule <- "//div[@class='block startups-listing']//text()"
companydescriptions <- xpathSApply(doc.html, rule, xmlValue)
descs <- VCorpus(VectorSource(companydescriptions))
```

## Processing
Processing and some cleansing is executed with an R script

```R
#remove whitespace
descs <- tm_map(descs, stripWhitespace)

#to lower case
descs <- tm_map(descs, content_transformer(tolower))

#remove stopwords (a, the, an...)
descs <- tm_map(descs, removeWords, stopwords("english"))

#remove manually some irrelevant words
descs <- tm_map(descs, removeWords, c("ltd", "inc"))

#remove numbers
descs <- tm_map(descs, removeNumbers)

#remove punctuation
descs <- tm_map(descs, removePunctuation)
```

## Word cloud
Actual word cloud is plotted with another R function. Max 60 words are plotted to keep the readability good.
```R
wordcloud(descs, max.words=60, scale=c(3,1), 
          random.order=FALSE, random.color=TRUE, rot.per=0.0, 
            use.r.layout=FALSE, colors=brewer.pal(5, "Set1"), fixed.asp=FALSE)
```

### Remarks
* Most common words 'mobile', 'data', 'analytics' are of course no big surprises. Mobile will continue increasing as a channel.
+ IoT is rather small, probably due to the hype and overuse of the term, making people want to avoid it as its own
- 'Health' and 'wellbeing' have risen up in the third category and are slightly bigger than 'gaming', which has been in the headlines for the past 5 years
* 'Virtual' is not dominating the cloud, contrary to what one could have imagined this year
* 'Education' is going up from the past years
* Security is surprisingly small in this cloud. Still, the winner of the pitching competition represented security category with their advanced scanning solutions.


![Alt text](/slush_wordcloud.png?raw=true "Word cloud Slush 2016")


## Part 2, Twitter analysis for Slush '16
As next step a Twitter analysis is made by searching Twitter API for the latest 5000 tweets with the keyword #slush16. It is interesting to compare the company descriptions to what people are talking about.

The actual word analysis is following the same guidelines as above. You can check the source code in the repository, if interested.

## Results
The word cloud is shown below. Remarks:
* From companies, the winner of the pitching competition, [Cybelangel](https://www.cybelangel.com) is deservedly getting attention. That's good and the security topic will be hot during the next years. 
* Maybe slightly surprising the next companies popping up from the words are Finnair and Nokia. Where are the small companies, we only get these big ones? From the startups I only manage to spot the pitching winner, Cybelangel. It surprises me.
* Investment company [Atomico](https://www.atomico.com) is in the discussions. They are big, active company and they just published a nice report about the state of tech in Europe - definitely worth reading. 
* From people, Peter Vesterbacka stands out. And as we see from the company descriptions -analysis, education is well highlighted there, so I predict prosperous future for Peter and his industry colleagues in the expanding market. 
* Another person who is represented here in these top words is [Joel Willans](https://twitter.com/joelwillans?lang=fi), an author and editor. It seems he has been extremely active in Twitter and caught attention.
* Helsinki is well represented in the cloud, and visibility for Finland is always a nice thing.

![Alt text](/twitter_wordcloud.png?raw=true "Word cloud Slush 2016 from Twitter data")


