library(shiny)
library(ggplot2)

d <- data(package = "datasets", envir = parent.env())

shinyUI(
  fluidPage(
    
    titlePanel("R Datasets Explorer"),
    tabsetPanel(
      tabPanel("1. Choose a Dataset",
               # STEP 1) Explore Datasets
               fluidRow(
                 column(width = 4, 
                        br(),     
                        selectInput(inputId = "dataset", label = "Choose a dataset to explore:"
                                    , choices = d$results[c(72,5,27,41,63,100,98,17,62),3])
                 ),
                 column(width = 8,
                        br(),     
                        h4("You are currently previewing: "),
                        verbatimTextOutput("dataset_label"),
                        verbatimTextOutput("dataset_description"),
                        tableOutput(outputId = "resultset")
                 )
               )
               
               
      ),
      tabPanel("2. Plot Variables",
               #Step 2) Plot variables
               fluidRow(  
                 
                 column(width = 4,
                        br(),   
                        uiOutput("select_vars"),
                        p("Click the button to plot the above selected variables."),
                        actionButton("plotButton", "Plot")
                 ),     
                 column(width = 8,
                        br(),   
                        p("The following variables are being plotted (x and y respectively): "),
                        verbatimTextOutput("nText"),
                        br(),
                        plotOutput("varplot")  
                        
                 )
                 
               )
      ),  
      tabPanel("3. Run Regression",  
               #Step 3) Run multivariable regressions
               fluidRow(
                 column(width = 4,
                        br(),     
                        uiOutput("outcome_var"),
                        br(),
                        uiOutput("select_names"),
                        br(),
                        p("Click the button below to run regression on selected variables."),
                        br(),
                        actionButton("regButton", "Regression")
                 ),
                 column(width = 8,
                        br(),
                        p("Regression expression:"),
                        verbatimTextOutput("regression_text"),
                        br(),
                        tableOutput(outputId = "coef_table")
                        
                 )
               )
      )  
    )
    
  )
  
)