library(shiny)
library(bslib)
library(dplyr)
library(gt)


# cargamos el dato
dato <- readr::read_rds("datos/dato_pobreza.rds")

# crear un vector para usarlo en el ui
lista_regiones <- dato |> 
  select(region) |> 
  distinct(region) |> 
  pull()

ui <- page_fluid(
  h2("Pobreza"),
  
  selectInput("region",
              label = "Elegir región",
              choices = lista_regiones
  ),
  
  h3("Tabla"),
  
  gt_output("tabla_region")
)



server <- function(input, output, session) {
  
  # filtrar la tabla
  dato_region <- reactive({
    dato |> 
      filter(region == input$region) |> # input
      select(region, nombre_comuna, pobreza_p)
  })
  
  # generar tabla
  tabla <- reactive({
    dato_region() |>
      arrange(desc(pobreza_p)) #|> # comando + shift + M
      # gt() |>
      # fmt_percent(pobreza_p, decimals = 1, dec_mark = ",") |>
      # data_color(pobreza_p, method = "numeric",
      #            palette = "viridis") |>
      # cols_label(pobreza_p = "Pobreza (%)",
      #            region = "Región",
      #            nombre_comuna = "Comuna")
  })
  
  # renderizar la tabla
  # output$tabla_region <- render_gt(tabla())
  output$tabla_region <- renderTable(tabla())
  
}

shinyApp(ui, server)