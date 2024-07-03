library(shiny)
require(shinydashboard)
library(dplyr)
library(ggplot2)
library(png)

Electoral165 <- data.frame(read.csv("C://Users//shiva//OneDrive//Desktop//AppBihar//Electoral165.csv",stringsAsFactors=F,header=T))
Electoral166 <- data.frame(read.csv("C://Users//shiva//OneDrive//Desktop//AppBihar//Electoral_166.csv",stringsAsFactors=F,header=T))
Electoral168 <- data.frame(read.csv("C://Users//shiva//OneDrive//Desktop//AppBihar//Electoral_168.csv",stringsAsFactors=F,header=T))
Electoral178 <- data.frame(read.csv("C://Users//shiva//OneDrive//Desktop//AppBihar//Electoral_178.csv",stringsAsFactors=F,header=T))
Electoral179 <- data.frame(read.csv("C://Users//shiva//OneDrive//Desktop//AppBihar//Electoral179.csv",stringsAsFactors=F,header=T))
Electoral167 <- data.frame(read.csv("C://Users//shiva//OneDrive//Desktop//AppBihar//surjgrah.csv",stringsAsFactors=F,header=T))
Candidatedata <- (read.csv("C://Users//shiva//OneDrive//Desktop//AppBihar//Candidatedata.csv"))
Assemblywise <- as.data.frame(read.csv("C://Users//shiva//OneDrive//Desktop//AppBihar//PC28.csv"))
BoothWise165 <- as.data.frame(read.csv("C://Users//shiva//OneDrive//Desktop//AppBihar//pollingBoothwiseResult165.csv"))
BoothWiseResult165 =select(BoothWise165,1,3,4,24,26)
Expense <- as.data.frame(read.csv("C://Users//shiva//OneDrive//Desktop//AppBihar//Expenditure_Analysis.csv"))
constituencywise=select(Expense,1:4)

title <- tags$a(href = "https://en.wikipedia.org/wiki/2019_Indian_general_election_in_Bihar",tags$img(src = "",hieght=50,width = 50),"Bihar2019")

header <- dashboardHeader(title =title,
                          dropdownMenu(type = "message",
                                       messageItem(from ="Group D",message =" Welcome to our Dashboard" )
                          )
)

sidebar <- dashboardSidebar(
    sidebarSearchForm("searchText","buttonSearch","Search"),
    sidebarMenu(
        menuItem("Dashboard",tabName = "dashboard",icon = icon("dashboard")),
        menuItem("Demographics",tabName = "demographics"),
        menuSubItem("Polling-Booth wise",tabName = "PollingBooth"),
        menuSubItem("Assembly wise",tabName="assemblies"),
        menuItem("Constituency",tabName = "mpconstituency"),
        menuItem("Candidate",tabName = "Candidates"),
        menuItem("Election Expenditure",tabName ="Expenditure" ),
        menuItem("Visit-us",icon=icon("send",lib='glyphicon'),href="http://jantakamood.com/")
    ))


body <- dashboardBody(
    
    tags$head(includeScript("google_analytics.js")),
    fluidRow(
        
        infoBox("Over all Voter Turnout Percent", 57.33 ,width = 4),
        infoBox("Total Constituency",40,width = 4),
        infoBox("Total Assembly Seats",243,width = 4)
        
        
    ),
    
    tabItems(
        tabItem(tabName = "dashboard",
                fluidRow(
                    box(title="Munger Age distribution",solidHeader=TRUE,plotOutput("histogram1",height = 250)),
                    box(title="Jamalpur Age distribution",solidHeader=TRUE,plotOutput("histogram2",height = 250)),
                    box(title="Surajgarha Age distribution",solidHeader=TRUE,plotOutput("histogram3",height = 250)),
                    box(title="Lakhisarai Age distribution",solidHeader=TRUE,plotOutput("histogram4",height = 250)),
                    box(title="Mokama Age distribution",solidHeader=TRUE,plotOutput("histogram5",height = 250)),
                    box(title="Badh Age distribution",solidHeader=TRUE,plotOutput("histogram6",height = 250))
                    
                    
                    
                )),
        
        tabItem(tabName= "demographics",
                titlePanel("Bihar 2019 Lok Sabha "),
                valueBox("Rajiv Ranjan Singh (Lalan Singh)","Winner,JD(U)",width = 7,icon =icon("arrow-left"),color = "blue"),
                valueBox("Nilam Devi","RunnerUp INC",width = 5,icon = icon("hand-paper"),color = "green"),
                valueBox(167937,"winning marning",width =5),
                valueBox(335,"polling booths",icon=icon("person-booth"),width=2),
                valueBox(54.90,"Voter Turnout Munger",icon =icon("fa-circle-notch"),width = 5),
                box(img(src="munger.png", height='400px',width='400px')),
                box(img(src="mokama.png", height='400px',width='400px')),
                box(img(src="jamalpur.png", height='400px',width='400px')),
                box(img(src="lakhisarai.png", height='400px',width='400px')),
                box(img(src="badh.png", height='400px',width='400px')),
                
        ),
        
        
        tabItem(tabName = "mpconstituency",
                fluidPage(
                    titlePanel("Costituency Wise Voter Turnouts winner and their winning margins"),
                    
                    mainPanel(
                        textOutput("MPConstituencyEach"),
                        fluidRow(downloadButton('consd', 'Download')),
                        br(),
                        fluidRow(
                            DT::dataTableOutput('cons')
                        )
                        
                    )
                )
        ),
        
        tabItem(tabName = "Expenditure",
                fluidPage(
                    titlePanel("Constituency wise election Expenditure by the winner and runnerup"),
                    
                    mainPanel(
                        textOutput("ConstituencyWise Expenditure"),
                        fluidRow(downloadButton('expend', 'Download')),
                        br(),
                        fluidRow(
                            DT::dataTableOutput('expen')
                        )
                        
                    )
                )
        ),
        
        
        tabItem(tabName = "assemblies",
                fluidPage(
                    
                    
                    mainPanel(
                        textOutput("AssemblyWiseResultPC28"),
                        fluidRow(downloadButton('assemd', 'Download')),
                        
                        fluidRow(
                            DT::dataTableOutput('assem'),style = "height:500px; overflow-y: scroll;overflow-x: scroll;"
                        )
                        
                    )
                )
        ),
        
        tabItem(tabName = "PollingBooth",
                fluidPage(
                    titlePanel("Polling booth wise data"),
                    
                    mainPanel(
                        textOutput("BoothWiseResult165"),
                        fluidRow(downloadButton('poolingd', 'Download')),
                        br(),
                        fluidRow(
                            DT::dataTableOutput('pooling')
                        )
                        
                    )
                )
        ),
        
        tabItem(tabName="Candidates",
                
                fluidPage(
                    titlePanel("Cadidates data of the constituency"),
                    
                    mainPanel(
                        
                        fluidRow(downloadButton('candidatetabled', 'Download')),
                        br(),
                        fluidRow(
                            DT::dataTableOutput('candidatetable')
                        )
                        
                    )
                )
                
                
        )
    )
)

ui <- dashboardPage(title = "Bihar 2019",header,sidebar,body)


server <- (function(input, output) {
    x1 <- Electoral165$Age
    
    output$histogram1 <- renderPlot({
        hist(x1,xlab = "Age", main = "Histogram of age distribution : Munger")
        
    })
    x2 <- Electoral166$Age
    output$histogram2 <- renderPlot({
        hist(x2,xlab = "Age", main = "Histogram of age distribution: Jamalpur")
    })
    x3 <- Electoral167$Age
    output$histogram3 <- renderPlot({
        hist(x3,xlab = "Age", main = "Histogram of age distribution: Surajgraha")
    })
    x4 <- Electoral168$Age
    output$histogram4 <- renderPlot({
        hist(x4,xlab = "Age", main = "Histogram of age distribution: Lakhisarai")
    })
    x5 <- Electoral178$Age
    output$histogram5 <- renderPlot({
        hist(x5,xlab = "Age", main = "Histogram of age distribution: Mokama ")
    })
    x6 <- Electoral179$Age
    output$histogram6 <- renderPlot({
        hist(x6,xlab = "Age", main = "Histogram of age distribution: Badh")
    })
    
    output$consd <- downloadHandler(
        filename = function() {
            paste('constituencywise', '.csv', sep = '')
        },
        content = function(file) {
            write.csv(idscan, file)
        }
    )
    
    output$cons = DT::renderDataTable(
        constituencywise,
        options = list(
            lengthMenu = list(c(25, 50, 100, 1000),
                              c('25', '50', '100', '1000')),
            pageLength = 25
        )
    )
    
    
    output$expend <- downloadHandler(
        filename = function() {
            paste('Expense', '.csv', sep = '')
        },
        content = function(file) {
            write.csv(idscan, file)
        }
    )
    
    output$expen = DT::renderDataTable(
        Expense,
        options = list(
            lengthMenu = list(c(25, 50, 100, 1000),
                              c('25', '50', '100', '1000')),
            pageLength = 25
        )
    )
    
    output$assemd <- downloadHandler(
        filename = function() {
            paste('Assemblywise', '.csv', sep = '')
        },
        content = function(file) {
            write.csv(idscan, file)
        }
    )
    
    output$assem = DT::renderDataTable(
        Assemblywise,
        options = list(
            lengthMenu = list(c(25, 50, 100, 1000),
                              c('25', '50', '100', '1000')),
            pageLength = 25
        )
    )
    
    output$poolingd <- downloadHandler(
        filename = function() {
            paste('BoothWiseResult165', '.csv', sep = '')
        },
        content = function(file) {
            write.csv(idscan, file)
        }
    )
    
    output$pooling = DT::renderDataTable(
        BoothWiseResult165,
        options = list(
            lengthMenu = list(c(25, 50, 100, 1000),
                              c('25', '50', '100', '1000')),
            pageLength = 25
        )
    )
    
    
    
    output$candidatetabled <- downloadHandler(
        filename = function() {
            paste('candidatedata', '.csv', sep = '')
        },
        content = function(file) {
            write.csv(idscan, file)
        }
    )
    
    output$candidatetable = DT::renderDataTable(
        Candidatedata,
        options = list(
            lengthMenu = list(c(25, 50, 100, 1000),
                              c('25', '50', '100', '1000')),
            pageLength = 25
        )
    )
})

# Run the application
shinyApp(ui = ui, server = server)
