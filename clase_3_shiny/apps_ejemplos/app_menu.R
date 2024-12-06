library(shiny)
library(bslib)
library(htmltools)

ui <- page_navbar(
  
  nav_panel("Opción 1",
            div(
              h1("Título"),
              p("gato"),
              
            )
  ),
  
  nav_panel("Opción 2",
            div(
              h1("Título 2"),
              p("gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato"),
            )
  ),
  
  nav_panel("Opción 3",
            div(
              h1("Título 3"),
              p("gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato"),
              p("gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato")
            )
  )
)

server <- function(input, output, session) {
}

shinyApp(ui, server)
