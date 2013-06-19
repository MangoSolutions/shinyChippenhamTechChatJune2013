library(shiny)
require(mangoTraining)
require(ggplot2)

# Define UI 
shinyUI(pageWithSidebar(
				
				# Application title
				headerPanel("Analysis of survey data"),
				
				# Sidebar with a slider input for number of observations
				sidebarPanel(
						##create a sub panel within the side panel
						wellPanel(
						h4("Plot options"),
				#define dropdown for x axis		
						selectInput("xaxis", 
								"Choose x axis variable:", choices = c("Height", "Weight","BMI", "Age"), selected = "Height"),
				#define dropdown for y axis
						selectInput("yaxis", 
								"Choose y axis variable:", choices = c("Height", "Weight","BMI", "Age"), selected = "Weight"),
				#radio buttons for selecting how the points on the plot are coloured		
						radioButtons("colouring", "Colour by:", c("No colouring" = "NA","Sex" = "sex","Smoking status" = "smokes")),
				#radio buttons for selecting how the plot is panelled
						radioButtons("panel", "Panel by:", c("No panels" = "NA","Sex" = "sex","Smoking status" = "smokes"))
				),
						wellPanel(
						h4("Data options"),
						checkboxInput("subsetCheck", "Subset data by Age"),
						##conditional section - only see the slider if the checkbox is selected
						conditionalPanel(
								condition = "input.subsetCheck == true",
								sliderInput("subset", 
										"Maximum age:", 
										min = min(demoData$Age), 
										max = max(demoData$Age)+1, 
										value = max(demoData$Age))
						),
						
						checkboxInput("smooth", "Smooth"),
						##another conditional, only see the dropdown if the check box is selected
						conditionalPanel(
							condition = "input.smooth == true",
							selectInput("smoothMethod", "Method",
							list("lm", "glm", "loess"))
						)
				)
						
				),
				
				# Show a plot of the generated distribution
				mainPanel(

						plotOutput("myPlot"),
						tableOutput("demoData")
					
				)
		))
