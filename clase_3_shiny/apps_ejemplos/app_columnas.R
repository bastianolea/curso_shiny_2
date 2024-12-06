library(shiny)
library(bslib)
library(htmltools)

ui <- page_fluid(
  
  h1("Título"),
  
  div(
    p("texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto")
  ),
  
  layout_columns(
    
    div(
      h1("Columna 1"),
      p("texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto")
    ),
    
    div(
      h1("Columna 2"),
      p("texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto")
    ),
    
    div(
      h1("Columna 3"),
      p("texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto")
    )
  ),
  
  div(
    p("texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto")
  ),
  
  
  layout_columns(
    col_widths = c(4, 8),
    
    div(
      h1("Columna 1"),
      p("texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto")
    ),
    
    div(style = css(border = "1px solid red",
                    padding = "18px",
                    background_color = "lightgrey",
                    font_size = "80%"),
      div(
        h1("Columna 2"),
        p("texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto")
      ),
      
      div(
        layout_columns(
          col_widths = c(4, 8),
          div(
            h1("Columna 3a"),
            p("texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto")
          ),
          div(
            h1("Columna 3b"),
            p("texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto texto")
          )
        )
        )
      )
    ),
    
  )
  
  server <- function(input, output, session) {
  }
  
  shinyApp(ui, server)
  