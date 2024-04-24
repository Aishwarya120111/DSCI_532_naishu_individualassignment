library(shiny)
library(ggplot2)
library(plotly)
library(countrycode)
library(readr)
library(dplyr)
data <- read.csv('../data/processed/airports-extended-data.csv')

# Define UI for application
ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom_style.css")
  ),
 
  titlePanel("Aviation Atlas: The Global Airport Dashboard"),

  # Define the sidebar layout with a row split into sidebar and main area
  sidebarLayout(
    # Sidebar panel for inputs
    sidebarPanel(
      img(src = "images.jpg", width = "75%",class = "centered-image"),
      selectInput("countryInput", "Select a Country:",
                  choices = sort(unique(data$country_name)),
                  selected = "Canada"),
      selectInput("provinceInput", "Select Province:",
                  choices = NULL,
                  multiple = TRUE),
      selectInput("typeInput", "Select Type of Airport:",
                  choices = unique(data$type),
                  selected = unique(data$type)[1])
      
    ),

    # Main panel for output
    mainPanel(class = "main-panel",
      div(class="info-box-container",
          div(class="info-box", 
              div(class="box-content", 
                  span(class="box-title"),
                  span(class="box-value", textOutput("totalCountry"))
              )
          ),
          div(class="info-box", 
              div(class="box-content", 
                  span(class="box-title"),
                  span(class="box-value", textOutput("totalProvince"))
              )
          )
      ),
      div(class = "custom-plotly-margin", 
          plotlyOutput("mapPlot", height = "600px")
      )
    )
  )
)

# Define server logic to plot the map
server <- function(input, output, session) {
  # Reactive expression to calculate total number of airports by country
  totalAirportsByCountry <- reactive({
    sum(data$country_name %in% input$countryInput & data$type == input$typeInput)
  })

  # Reactive expression to calculate total number of airports by province
  totalAirportsByProvince <- reactive({
    if (!is.null(input$provinceInput) && length(input$provinceInput) > 0) {
      sum(data$country_name %in% input$countryInput & data$province %in% input$provinceInput & data$type == input$typeInput)
    } else {
      0  # Return 0 if no province is selected
    }
  })

  # Render the total for country
  output$totalCountry <- renderText({
    paste("Number of", input$typeInput, "in", input$countryInput, ":", totalAirportsByCountry())
  })

  # Render the total for province
  output$totalProvince <- renderText({
    if (length(input$provinceInput) > 0) {
      paste("Number of", input$typeInput, "in", input$provinceInput, ":", totalAirportsByProvince())
    } else {
      "Please select a province to see the total number of airports."
    }
  })

  observe({
    # Filter data based on selected countries
    availableProvinces <- if (is.null(input$countryInput) || length(input$countryInput) == 0) {
      character(0)
    } else {
      sort(unique(data[data$country_name %in% input$countryInput, "province"]))
    }

    # Update provinces dropdown
    updateSelectInput(session, "provinceInput", choices = availableProvinces)
  })

  observe({
    # Filter types based on selected country
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

    # Subset data based on selected inputs
    dataSubset <- subset(data, country_name %in% input$countryInput)
    if (!is.null(input$provinceInput) && length(input$provinceInput) > 0) {
      dataSubset <- subset(dataSubset, province %in% input$provinceInput)
    }
    if (!is.null(input$typeInput) && length(input$typeInput) > 0) {
      dataSubset <- subset(dataSubset, type %in% input$typeInput)
    }

    # Create the ggplot object with tooltips
    p <- ggplot(data = dataSubset, aes(x = longitude_deg, y = latitude_deg, text = paste("Airport:", name, "<br>Province:", province, "<br>Country:", country_name))) +
      borders("world", colour = "#575656", fill = "#575656") +
      geom_point(color = "skyblue", size = 1) +
      theme_minimal() +
      ggtitle(paste("Distribution of", paste(input$typeInput, collapse = ", "),"Across", paste(input$countryInput, collapse = ", "))) +
      xlab("Longitude") +
      ylab("Latitude") +
      theme(legend.position = "none",plot.title = element_text(size=25, face="bold.italic"),
axis.title.x = element_text(size=14, face="bold"),
axis.title.y = element_text(size=14, face="bold"))

    # Convert to plotly object
    ggplotly(p, tooltip = "text")
  })

}

# Run the application
shinyApp(ui = ui, server = server)
