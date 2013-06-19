shinyServer( function(input, output){
	output$normalPlot <- renderPlot(
		hist(rnorm(input$n), xlab = "Random normal data", main = "Histogram of random normal data")
	)
})

