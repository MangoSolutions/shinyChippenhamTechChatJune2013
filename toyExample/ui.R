shinyUI(
	pageWithSidebar(
	  headerPanel("Normal distribution data"),
		sidebarPanel(sliderInput("n", "Number of points",min = 0, max = 100, value = 50)),
		mainPanel(plotOutput("normalPlot"))
	)
)

