library(shiny)
library(bslib)
library(htmltools)

ui <- page_sidebar(
  title = "Aplicación",
  
  sidebar = div(
    h1("Título"),
    p("gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato"),
  ),
  
  div(
    h2("Contenido"),
    p("perro perro perro perro perro perro perro perro perro perro perro perro perro perro perro perro perro perro perro perro perro perro perro perro perro perro perro perro perro perro"),
  ),
  
  card(
    card_header(
      h2("Tarjeta 1")
    ),
    card_body(
      div(style = css(height = "200px"),
          p("texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto")
      )
    )
  ),
)

server <- function(input, output, session) {
}

shinyApp(ui, server)
