library(shiny)

shinyUI(fluidPage(
        
        # Application title
        titlePanel("Simple Linear Regression"),
        tags$h3("Instructions"),
        tags$p("This app allows you to generate a random sample of (x,y) points according to the formula: y = intercept + slope * x + error. You can define the intercept and slope and the standard deviation of the error term yourself. The errors are i.i.n.d. with mean zero. 
               You can also define the sample size and the range for the x values."),
        tags$p("As results you see a plot with the sample points, together with the fitted regression line with 95% confidence band. The original line with given intercept and slope is also shown. You also see the regression results printed. So you can compare the estimates for slope, intercept and standard deviation with the input values numerically."),
        tags$br(),
        
        fluidRow(
                
                column(2,
                       titlePanel("Inputs"),
                       
                       sliderInput("intercept", "Intercept", 0, min = -5, max = 5),
                       sliderInput("slope", "Slope", 0, min = -5, max = 5),
                       sliderInput("stdev", "Standard deviation of error term", 5, min = 0, max = 10),
                       
                       sliderInput("xmax","Maximum x value:",
                                   min = 1, max = 100, value = 20),
                       sliderInput("nobs", "Number of observations to generate:",
                                   min = 2, max = 30, value = 10)                                  
                ),
                
                column(6,
                       titlePanel("Graph"), 
                       plotOutput(outputId= "regrPlot")
                ),
                
                column(4,
                       titlePanel("Regression results"), 
                       verbatimTextOutput(outputId="estimates")
                )
        )
))

