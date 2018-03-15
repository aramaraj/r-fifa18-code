library(shiny)
library(ggplot2)
library(datasets)
library(stringr)
shinyServer(function(input, output) {
  # mydataset <- reactive({
  #   infile <- input$datafile
  #   if (is.null(infile)) {
  #     # User has not uploaded a file yet
  #     return(NULL)
  #   }
  #   read.csv(infile$datapath)
  # })
  output$airPlot <- reactivePlot(function() {
    mydatasetFifa18 <- read.csv("/Users/aramar1/Downloads/CompleteDatasetCleaned.csv")
    myDatasetSample <- head(mydatasetFifa18,input$slider1)
    myDataset <- filter(myDatasetSample, Nationality == input$Country)
    maxSal <- which.max(myDataset$Wage)
    sum(myDataset$Overall)
    sum(myDatasetSample$Overall)
    proportions <- sum(myDataset$Overall)/sum(myDatasetSample$Overall)
    srcImage <- myDataset[maxSal,]$Photo
    srcFlag <- myDataset[maxSal,]$Flag
    titleNumberOfPlayers<- paste("<h4>Number of Playersfrom",input$Country,
                                 "in TOP ",input$slider1," :",
                                 nrow(myDataset) ,"<br>Best Player",
                                 myDataset[maxSal,]$Name,"<br>Net Value:",
                                 myDataset[maxSal,]$Wage,"<br>Preferred Position:",
                                 myDataset[maxSal,]$Preferred.Positions,
                                 "<br>Potential of Winning FIFA 2018:",
                                 proportions*100,"</h4>")
    output$picture <-
      renderText({
        c(paste("<img src='",srcImage,"' width = '50px', height = '50px'/>","<img src='",srcFlag,"' width = '50px', height = '50px'/>",titleNumberOfPlayers))
      })
    output$Textinfo <-
      renderText({
        c("<h4>Compare Attributes</h4>")
      })
    output$fifaLogo <-
      renderText({
        c("<img src='http://www.profilerussia.com/images/FIFARussia2018logo.jpg' width = '50px', height = '50px'/>")
      })
    # body of the function
    ggplot(myDataset,aes_string(input$X_axis,input$Y_axis))+
      geom_point(size=1,color="purple")
    },width = 600, height = 500)
}

)