library(shiny)
library(ggplot2)

d <- data(package = "datasets", envir = parent.env())

shinyServer(function(input, output) {

  #ensure that the user has chosen a dataset before loading
  getDataset <- reactive({
    
    req(input$dataset)
    get(input$dataset, "package:datasets", inherits = TRUE)
    
  })
  
  #show the first five records 
  output$resultset <- renderTable({
    head(getDataset(),5)
  })
  
  #display the name of the dataset
  output$dataset_label <- renderText({
    input$dataset
  })
  
  #display the description of the dataset
  output$dataset_description <- renderText({
    d$results[d$results[,3]==input$dataset,4]
  })
  
  
  #create a select input with all of the variables in the dataset
  output$outcome_var <- renderUI({
    selectInput(inputId = "outcome_var", label = "Choose an Outcome Variable:", 
                choices = names(getDataset()))
  })
  
  #send a selectInput with the variable names from the dataset chosen
  output$select_names <- renderUI({
    selectizeInput(inputId = "select_names", label = "Choose Predictor Variables:", 
                   choices = names(getDataset()), multiple = TRUE)
  })
  
  
  #allow select of only two variables for plotting
  output$select_vars <- renderUI({
    selectizeInput(inputId = "select_vars", label = "Choose 2 Variables (x,y) for plotting:", 
                   choices = names(getDataset()), multiple = TRUE, options = list(maxItems = 2))
  })
  
  #get the variables that were selected for plotting
  ntext <- eventReactive(input$plotButton, {
    input$select_vars
  })
  
  #create the plot
  plot <- eventReactive(input$plotButton, {
    req(length(input$select_vars)==2)
    
    ggplot(getDataset(),aes_string( x = input$select_vars[1] ,y = input$select_vars[2] )) + geom_point()
  })
  
  #output the variables that were selected
  output$nText <- renderText({
    ntext()
  })
  
  #output the plot
  output$varplot <- renderPlot({
    plot()
  })
  
  #create regression string from the input variables
  getRegressionString <- eventReactive(input$regButton, {
    x <- input$outcome_var
    y <- ""
    for(arg in input$select_names) {y <- paste(y,arg," + ")}
    strR <- paste(x," ~ ",y)
    strR <- substr(strR,1,nchar(strR)-3)
    strR
    
  })
  
  #display the regression that will be run 
  output$regression_text <- renderText({
    getRegressionString()
  })
  
  #run regression and create the coefficient table
  getCoefTable <- eventReactive(input$regButton, {
    req(input$select_names)
    fit <- lm(getRegressionString(), getDataset())
    summary(fit)$coef
  })
  
  #output the regression coefficient table
  output$coef_table <- renderTable({
    getCoefTable()
  })
  
})