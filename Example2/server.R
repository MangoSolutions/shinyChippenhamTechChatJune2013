library(shiny)
require(mangoTraining)
require(ggplot2)

# Define server logic 
shinyServer(function(input, output) {
			
			data <- reactive({	
						if(input$subsetCheck)
							demoData[demoData$Age <= input$subset, ] 
						else 
							demoData				
					})
			
			xaxis <-  reactive({
						input$xaxis			
					})
			yaxis <-  reactive({
						input$yaxis			
					})
			colouring <- reactive({
						switch(input$colouring,
							"NA"= NA,
							"sex" = "Sex",
							"smokes" = "Smokes")
					})
			panel <- reactive({
						switch(input$panel,
								"NA"= NA,
								"sex" = "Sex",
								"smokes" = "Smokes")
					})
		
			smoother <- reactive({
						input$smoothMethod
					})
			
			output$demoData <- renderTable({
						data()
					})
			
			output$myPlot <- renderPlot({
						xaxis <- xaxis()
						yaxis <- yaxis()
						title <- paste("Plot of", xaxis, "against", yaxis, sep = " ")
						colour <- colouring
						p <-qplot(data = data(), x = eval(parse(text=xaxis)), y = eval(parse(text=yaxis)), 
								xlab = xaxis, ylab = yaxis, main = title, size = I(3))
						if(!is.na(colouring())) {
							colour <- colouring()
							p <- p + geom_point(aes(col = eval(parse(text = colour ) ) ) )  + 
									scale_colour_discrete(colour)
						}
						if(!is.na(panel())) {
							panelBy <- panel()
							p <- p + facet_grid(eval(parse(text = paste(".~", panelBy))))
						}
						if(input$smooth){
							p <- p + stat_smooth(method = smoother())
						}
							
						print(p)
					})
})

