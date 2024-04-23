library(shiny)
library(ggplot2)
library(plotly)
library(countrycode)
library(readr)
library(dplyr)
data <- read.csv('../data/processed/airports-extended-data.csv')

# Define UI for application
ui <- fluidPage(
  titlePanel("World Airports Tracker"),
  sidebarLayout(
    sidebarPanel(
      selectInput("countryInput", "Select a Country:",
                  choices = sort(unique(data$country_name)),
                  selected = c("Canada"),
                ),
      selectInput("provinceInput", "Select Province:",
                  choices = NULL,
            # Initially empty, will be updated reactively
                  multiple = TRUE),
      selectInput("typeInput", "Select Type of Airport:",
                  choice = unique(data$type),
                  selected = unique(data$type)[1])

    ),
    mainPanel(
      plotlyOutput("mapPlot")
    )
  )
)

# Define server logic to plot the map
server <- function(input, output, session) {
  observe({
    # Filter data based on selected countries
    availableProvinces <- if (is.null(input$countryInput) || length(input$countryInput) == 0) {
      character(0)
    } else {
      sort(unique(data[data$country_name %in% input$countryInput, "province"]))
    }

    # Update cities dropdown
    updateSelectInput(session, "provinceInput", choices = availableProvinces)
  })

  # Observe country input and update types
  observe({
    availableTypes <- if (is.null(input$countryInput) || length(input$countryInput) == 0) {
      character(0)
    } else {
      sort(unique(data[data$country_name %in% input$countryInput, "type"]))
    }

    # Update types dropdown
    updateSelectInput(session, "typeInput", choices = availableTypes)
  })

  # Generate the plotly map plot based on selected inputs
  output$mapPlot <- renderPlotly({
    # If no countries are selected, return a blank plot
    req(input$countryInput)

    # Subset data based on selected countries, cities, and airport type
    dataSubset <- subset(data, country_name %in% input$countryInput)

    if (!is.null(input$provinceInput) && length(input$provinceInput) > 0) {
      dataSubset <- subset(dataSubset, province %in% input$provinceInput)
    }

    if (!is.null(input$typeInput) && length(input$typeInput) > 0) {
      dataSubset <- subset(dataSubset, type %in% input$typeInput)
    }

    # Create the ggplot object with tooltips
    p <- ggplot(data = dataSubset, aes(x = longitude_deg, y = latitude_deg, text = paste("Airport:", name, "<br>Province:", province, "<br>Country:", country_name))) +
      borders("world", colour = "gray50", fill = "gray50") +
      geom_point(color = "red", size = 1) +
      theme_minimal() +
      ggtitle(paste("Points in", paste(input$countryInput, collapse = ", "), "-", paste(input$typeInput, collapse = ", "))) +
      theme(legend.position = "none") # Hide legend to avoid unnecessary information

    # Convert to plotly object
    ggplotly(p, tooltip = "text")
  })

}


# Run the application
shinyApp(ui = ui, server = server)