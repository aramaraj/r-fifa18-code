#shiny
library(shiny)
shinyUI(fluidPage(
  headerPanel("FIFA 18 Probability",htmlOutput("fifaLogo")),
  sidebarPanel(
                sliderInput("slider1", label = h3("Number of Players to Sample"), min = 10, 
                max = 17000, value = 100),
                selectInput("Country", "Nationality",
                            list("Argentina"="Argentina",
                                 "Portugal"="Portugal",
                                 "Germany"="Germany",
                                 "Brazil"="Brazil",
                                 "Croatia"="Croatia",
                                 "Spain"="Spain",
                                 "France"="France",
                                 "Netherlands"="Netherlands",
                                 "Italy"="Italy",
                                 "England"="England",
                                 "Colombia"="Colombia",
                                 "Uruguay"="Uruguay")),
                htmlOutput("Textinfo"),
                selectInput("X_axis", "X axis:",
                            list("Ball.control"="Ball.control","Preferred Positions"="Preferred.Positions","Reactions"="Reactions","Overall"="Overall","Sprint.speed"="Sprint.speed","Salary"="ValueK")),            
                selectInput("Y_axis", "Y axis:",
                            list("Overall"="Overall","Sprint.speed"="Sprint.speed","Salary"="ValueK"))),
                            htmlOutput("picture"),
                            plotOutput("airPlot")
))
