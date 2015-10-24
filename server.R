library(shiny)
library(ggplot2)

# Define the server logic to generate the sample data, fit the regr line and show plot and estimates
shinyServer(function(input, output) {
        
        
        # Generation of the plot with the sample data and the regression line
        # It is reactive and as such put in a renderPlot wrapper
        
        data <- function(nobs, xmax, intercept, slope, stdev){
                #generate the x values as uniform random variables over the given range
                x <- runif(n = nobs , min = 0 , max = xmax ) 
                #generate the error terms according to input stdev
                e <- rnorm(n = nobs , mean = 0 , sd = stdev )
                #calculate the y values according to slope and intercept
                y <- intercept + (slope * x) +  e 
                return(data.frame(x,y))
        }
        
        currentData <- reactive({ data(input$nobs, input$xmax, input$intercept,input$slope, input$stdev)})
        
        # draw plot
        output$regrPlot <- renderPlot({                 
                  
                  g <- ggplot(data = currentData(), aes(x=x, y=y ))
                  g <- g + geom_point(colour = "blue", size = 3) 
                  g <- g + geom_smooth(aes(colour="Fitted regression line"), size = 1, method='lm')
                  g <- g + geom_abline(aes(colour="True line"), size = 1, intercept = input$intercept, 
                                       slope = input$slope )
                  g <- g + theme(legend.position = c(0.8,0.8), legend.title=element_blank(),
                                 legend.text=element_text(size=14))
                  print(g)                           
        })           
        
        output$estimates <- renderPrint({                
                #fit regression line again to obtain coefficients
                fit <- lm( y ~ x, data = currentData())
                summary(fit)
        })
})


