## app.R ##
library(shinydashboard)

ui <- dashboardPage(skin = "red",
  dashboardHeader(title = "Example Dashboard"),
  dashboardSidebar(
    sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Widgets", icon = icon("th"), tabName = "widgets",
             badgeLabel = "new", badgeColor = "green")
  )),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
      tags$script(src = "myscript.js")
      ),
      
    fluidRow(
      box(title = "Distribution",
        status = "warning", 
          solidHeader = TRUE, 
          plotOutput("plot1", height = 250)),
      
      box(status = "primary",
          solidHeader = TRUE,
        title = "Controls",
        sliderInput("slider", "Number of observations:", 1, 100, 50)
      )
    )
  )
)

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)
