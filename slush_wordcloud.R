library("tm")
library("wordcloud")
library("SnowballC")
library("XML")

#### SOURCE FROM SLUSH HOME PAGE ####
doc.html = htmlTreeParse('http://www.slush.org/why-attend/startups/',useInternal = TRUE)
rule <- "//div[@class='block startups-listing']//text()"
companydescriptions <- xpathSApply(doc.html, rule, xmlValue)
descs <- VCorpus(VectorSource(companydescriptions))



#### CLEANSING ####

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


  
#### PLOT ####
wordcloud(descs, max.words=60, scale=c(3,1), 
          random.order=FALSE, random.color=TRUE, rot.per=0.0, 
            use.r.layout=FALSE, colors=brewer.pal(5, "Set1"), fixed.asp=FALSE)
