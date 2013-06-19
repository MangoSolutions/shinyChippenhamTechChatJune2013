library(shiny)
require(mangoTraining)
require(ggplot2)

# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
				
				# Application title
				headerPanel("Analysis of survey data"),
				
				# Sidebar with a slider input for number of observations
				sidebarPanel(
						
						wellPanel(
						h4("Plot options"),
						
						selectInput("xaxis", 
								"Choose x axis variable:", choices = c("Height", "Weight","BMI", "Age"), selected = "Height"),
						selectInput("yaxis", 
								"Choose y axis variable:", choices = c("Height", "Weight","BMI", "Age"), selected = "Weight"),
						
						radioButtons("colouring", "Colour by:", c("No colouring" = "NA","Sex" = "sex","Smoking status" = "smokes")),
						radioButtons("panel", "Panel by:", c("No panels" = "NA","Sex" = "sex","Smoking status" = "smokes"))
				),
						wellPanel(
						h4("Data options"),
						checkboxInput("subsetCheck", "Subset data by Age"),
						conditionalPanel(
								condition = "input.subsetCheck == true",
								sliderInput("subset", 
										"Maximum age:", 
										min = min(demoData$Age), 
										max = max(demoData$Age)+1, 
										value = max(demoData$Age))
						),
						
						checkboxInput("smooth", "Smooth"),
						conditionalPanel(
							condition = "input.smooth == true",
							selectInput("smoothMethod", "Method",
							list("lm", "glm", "loess"))
						)
				)
				),
				
				# Show a plot of the generated distribution
				mainPanel(
					tabsetPanel(
							tabPanel("Plot", plotOutput("myPlot")),
							tabPanel("Data", tableOutput("demoData")),
							tabPanel("Save options", 
									wellPanel(
										
											textInput("plotName", "Plot file name:", "summaryPlot"),
											downloadButton('downloadPlot', 'Save Plot'),
											textInput("dataName", "Data file name:", "summaryData"),
											downloadButton('downloadData', 'Save Data')
									)

									)
							)
						
						
					
				)
		))
