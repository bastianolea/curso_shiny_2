library(shiny)
library(bslib)
library(htmltools)

ui <- page_fluid(
  
  h1("Título"),
  
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
  
  card(
    card_header(
      h2("Tarjeta 1")
    ),
    card_body(
      p("texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto")
    )
  ),
  
  layout_columns(
  card(
    card_header(
      h2("Tarjeta 1")
    ),
    card_body(
      p("texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto")
    )
  ),
  
  card(
    card_header(
      h2("Tarjeta 1")
    ),
    card_body(
      p("texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto")
    )
  )
  )
  
  
)

server <- function(input, output, session) {
}

shinyApp(ui, server)
