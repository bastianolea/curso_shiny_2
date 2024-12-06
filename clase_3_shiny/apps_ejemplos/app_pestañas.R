library(shiny)
library(bslib)
library(htmltools)

ui <- page_fluid(
  
  br(),
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
  
  navset_card_tab(
    nav_panel("Pestaña 1",
              p("texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto")
    ),
    nav_panel("Pestaña 2",
              p("gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato")
    ),
    nav_panel("Pestaña 3",
              div(
                h1("Título 3"),
                p("gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato"),
                p("gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato gato")
              )
    )
  ),
  
  card(
    card_header(
      h2("Tarjeta 2")
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
