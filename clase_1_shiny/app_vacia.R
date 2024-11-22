# cargar los paquetes necesarios
library(shiny)
library(bslib) # bootstrap # install.packages("bslib")


ui <- page_fluid(
  
  h1("Aplicación vacía"),
  h2("Subtítulo"),
  p("Esta es mi primera aplicación Shiny"),
  br(), # salto de línea
  em("Itálicas"), # itálicas
  p("hola"),
  HTML("<p> shdsdhj </p>")
  
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)