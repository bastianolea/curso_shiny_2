# cargar los paquetes necesarios
library(shiny)
library(bslib) 


ui <- page_fluid(
  
  h1("Completada"),
  
  # crear un input
  sliderInput(inputId = "completo_precio",
              label = "Elegir precio",
              min = 1000, max = 10000,
              value = 3000),
  
  sliderInput(inputId = "personas_n",
              label = "Cantidad de personas",
              min = 1, max = 20,
              value = 2),
  
  sliderInput(inputId = "completos_por_persona",
              label = "Completos por persona",
              min = 1, max = 10,
              value = 2),
  
  hr(),
  
  # donde quiero que aparezca el output
  h3("Resultado:"),
  h1(textOutput("texto_total"))
  
)

server <- function(input, output, session) {
  
  # crear un objeto reactivo
  # a partir de un cálculo entre inputs
  completos_cantidad <- reactive(input$personas_n * input$completos_por_persona)
  
  # el otro reactivo
  total_completos_precio <- reactive(completos_cantidad() * input$completo_precio)
  
  # crear output
  output$texto_total <- renderText({
    
    paste0("$", format(total_completos_precio(), big.mark= "."))
    
    })
}

shinyApp(ui, server)