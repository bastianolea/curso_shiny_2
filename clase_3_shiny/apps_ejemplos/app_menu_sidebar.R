library(shiny)
library(bslib)
library(htmltools)

ui <- page_navbar(
  sidebar = div(
    h3("Opciones"),
    p("gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato")
  ),
    
  
  nav_panel("Opción 1",
            div(
              h1("Título"),
              p("gato"),
              
            )
  ),
  
  nav_panel("Opción 2",
            card(
              card_header(
                h2("Tarjeta 1")
              ),
              card_body(
                div(style = css(height = "200px"),
                    p("texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto")
                )
              )
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
