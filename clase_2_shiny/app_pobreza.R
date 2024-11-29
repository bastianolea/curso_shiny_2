library(shiny)
library(bslib)
library(dplyr)
library(gt)
library(ggplot2)
library(htmltools)
library(shinyWidgets)
library(shinyjs)
library(purrr)

# reactlog::reactlog_enable() # control + F3 para abrir ventana de reactividad

# cargamos el dato
dato <- readr::read_rds("datos/dato_pobreza.rds")

# crear un vector para usarlo en el ui
lista_regiones <- dato |> 
  select(region) |> 
  distinct(region) |> 
  pull()


margen_superior <- "30px"

ui <- page_fluid(
  
  # activar shinyjs
  useShinyjs(),
  
  # div(style = "margin-top: 16px; margin-bottom: 26px;",
  
  div(style = css(margin_top = margen_superior, 
                  margin_bottom = "26px"),
      h2("Pobreza"),
      
      selectInput("region",
                  label = "Elegir región",
                  choices = lista_regiones
      )
  ),
  
  
  # ui titulo ----
  h3(textOutput("texto_region")),
  
  # ui texto ----
  actionButton("ocultar_texto", label = "Mostrar información"),
  
  div(id = "panel_texto_mayor",
      style = "background-color: pink; padding: 8px; 
               max-width: 400px;
               margin: 8px; border-radius: 5px;",
      textOutput("texto_comuna_mayor")
  ) |> 
    hidden(),
  
  div(id = "panel_texto_menor",
      style = "background-color: lightblue; padding: 8px; 
               max-width: 400px;
               margin: 8px; border-radius: 5px;",
      textOutput("texto_comuna_menor")
  )|> 
    hidden(), 
  
  
  div(style = css(height = margen_superior)),
  
  layout_columns(
    col_widths = c(5, 7),
    
    # ui tabla ----
    div(
      h3("Tabla"),
      gt_output("tabla_region"),
      # actionButton("opcion_tabla", label = "Mostrar/ocultar")
      
      radioGroupButtons(
        inputId = "opcion_tabla",
        label = "Opciones",
        choices = c("Con color", 
                    "Sin color"),
        justified = TRUE
      ),
      
      sliderInput("opcion_decimales",
                  label = "Decimales", 
                  min = 0, max = 8, value = 1)
    ),
    
    # ui gráfico ----
    div(
      h3("Gráfico"),
      plotOutput("grafico")
    )
  ),
  
  hr(),
  
  h3("Información"),
  
  div(style = css(height = "400px", overflow_y = "scroll"),
      uiOutput("textos_comunas")
  )
  
)



server <- function(input, output, session) {
  
  # datos ----
  # filtrar la tabla
  dato_region <- reactive({
    dato |> 
      filter(region == input$region) |> # input
      select(region, nombre_comuna, pobreza_p)
  })
  
  # titulo región ----
  # texto que contiene el contenido de un input
  texto_region <- reactive({
    paste("Tabla regional:", input$region)
  })
  
  output$texto_region <- renderText(texto_region())
  
  
  # texto ----
  # texto de comuna con mayor porcentaje
  texto_comuna_mayor <- reactive({
    # browser()
    
    comuna_mayor <- dato_region() |> 
      arrange(desc(pobreza_p)) |> 
      slice(1)
    
    if (nrow(dato_region()) == 0) {
      texto <- "Ninguna región seleccionada. Por favor elija otra región" 
      
    } else {
      texto <- paste("En la región de", 
                     comuna_mayor$region,
                     "la comuna con mayor porcentaje de pobreza es", 
                     paste0(comuna_mayor$nombre_comuna, ","), 
                     "con un", 
                     paste0(round(comuna_mayor$pobreza_p*100, digits = 1), "%")
      )
    }
    
    # browser()
    
    return(texto)
  })
  
  output$texto_comuna_mayor <- renderText({
    texto_comuna_mayor()
  })
  
  
  ## ocultar texto ----
  observeEvent(input$ocultar_texto, {
    toggle("panel_texto_mayor")
    toggle("panel_texto_menor")
  })
  
  
  
  
  # texto de comuna con mayor porcentaje
  texto_comuna_menor <- reactive({
    # browser()
    
    comuna_menor <- dato_region() |> 
      arrange((pobreza_p)) |> 
      slice(1)
    
    if (nrow(dato_region()) == 0) {
      texto <- "Ninguna región seleccionada. Por favor elija otra región" 
      
    } else {
      texto <- paste("En la región de", 
                     comuna_menor$region,
                     "la comuna con menor porcentaje de pobreza es", 
                     paste0(comuna_menor$nombre_comuna, ","), 
                     "con un", 
                     paste0(round(comuna_menor$pobreza_p*100, digits = 1), "%")
      )
    }
    
    return(texto)
  })
  
  output$texto_comuna_menor <- renderText({
    texto_comuna_menor()
  })
  
  
  
  # tabla ----
  tabla <- reactive({
    req(nrow(dato_region()) > 0)
    
    tabla1 <- dato_region() |>
      arrange(desc(pobreza_p)) |> # comando + shift + M
      gt() |>
      fmt_percent(pobreza_p, 
                  decimals = input$opcion_decimales, 
                  dec_mark = ",") |>
      cols_label(pobreza_p = "Pobreza (%)",
                 region = "Región",
                 nombre_comuna = "Comuna")
    
    # agregar color depende de la elección
    if (input$opcion_tabla == "Con color") {
      tabla1 <- tabla1 |> 
        data_color(pobreza_p, method = "numeric",
                   palette = "viridis")
    }
    
    return(tabla1)
  })
  
  # renderizar la tabla
  output$tabla_region <- render_gt(tabla())
  
  
  
  # grafico ----
  output$grafico <- renderPlot({
    dato_region() |> 
      ggplot() +
      aes(x = pobreza_p, y = nombre_comuna) +
      geom_col() +
      theme_classic() +
      scale_x_continuous(labels = scales::label_percent())
  })
  
  
  
  # generar ui ----
  textos_comunas <- reactive({
    # browser()
    
    dato_region_filtrado <- dato_region() |> 
      filter(pobreza_p > 0.3)
    
    if (nrow(dato_region_filtrado) == 0) {
      return(
        div(style = css(background_color = "#E7E8EA", border_radius = "5px",
                        padding = "4px", margin_bottom = "4px"),
            p("no hay comunas mayores a 30%")
        )
      )
    }
    
    
    lista_comunas <- dato_region_filtrado$nombre_comuna
    
    # loop
    resultado_textos <- map(lista_comunas, ~{
      # .x = lista_comunas[4]
      dato_comuna <- dato_region_filtrado |> 
        filter(nombre_comuna == .x)
      
      dato_comuna
      
      texto <- paste("La comuna",
                     dato_comuna$nombre_comuna, 
                     "tiene un porcentaje de pobreza de", 
                     paste0(round(dato_comuna$pobreza_p*100, digits = 1), "%")
      )
      
      elemento <- div(style = css(background_color = "#E7E8EA", border_radius = "5px",
                                  padding = "4px", margin_bottom = "4px"),
                      p(texto)
      )
      
      return(elemento)
    })
    
    return(resultado_textos)
  })
  
  
  output$textos_comunas <- renderUI(textos_comunas())
  
  
  
}

shinyApp(ui, server)