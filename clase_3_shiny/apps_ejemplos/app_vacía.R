library(shiny)
library(bslib)
library(htmltools)

ui <- page_fluid(
  div(
    h1("Título"),
    p("gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato"),
    p("gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato")
  )
)

server <- function(input, output, session) {
}

shinyApp(ui, server)
