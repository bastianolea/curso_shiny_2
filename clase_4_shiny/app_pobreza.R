library(shiny)
library(bslib)
library(dplyr)
library(gt)
library(ggplot2)
library(htmltools)
library(shinyWidgets)
library(shinyjs)
library(purrr)
library(thematic)

# reactlog::reactlog_enable() # control + F3 para abrir ventana de reactividad

# cargamos el dato
dato <- readr::read_rds("datos/dato_pobreza.rds")

# crear un vector para usarlo en el ui
lista_regiones <- dato |> 
  select(region) |> 
  distinct(region) |> 
  pull()


margen_superior <- "30px"



color_fondo = "#E2D2BA"
color_texto = "#6B6154"
color_primario = "#A48E72"
color_secundario = "#A48E72"

color_negativo = "#D14C59"

# color_fondo = "#D14C59"
# color_texto = "#5A2131"
# color_primario = "#88425C"
# color_secundario = "#88425C"


thematic_shiny()

# tipografías ----
library(sysfonts)

# desacrgar tipografías para ggplot2
sysfonts::font_add_google("Fira Code", "Fira Code")

# detectar tipografías
showtext::showtext_auto()
showtext::showtext_opts(dpi = 140)



# ui ----
ui <- page_sidebar(
  
  # tema ----
  theme = bs_theme(bg = color_fondo, 
                   fg = color_texto,
                   primary = color_primario,
                   secondary = color_secundario,
                   # aplicar una tipografía desde Google Fonts
                   base_font = font_google("Fira Code"),
                   heading_font = font_google("Fira Sans")
  ),
  
  
  # css ----
  # usar css desde un archivo css
  includeCSS("styles.css"),
  
  # cambiar css directamente
  tags$style(
    HTML("h3 {text-decoration: underline; margin-top: 10px; }")
  ),
  
  
  
  # activar shinyjs
  useShinyjs(),
  
  
  
  # sidebar ----
  sidebar = div(
    
    div(style = css(margin_top = margen_superior, 
                    margin_bottom = "26px"),
        # h2("Pobreza"),
        
        selectInput("region",
                    label = "Elegir región",
                    choices = lista_regiones
        ) |> tooltip("Elija la región de su interés")
        
        
    ),
    
    # ui texto ----
    actionButton("ocultar_texto", label = "Mostrar información") |> tooltip("Presione para ver estadísticos detallados"),
    
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
    
    div(style = css(margin_top = "18px"),
        actionButton("ventana", 
                     label = "Ventana")
    )
    
  ),
  
  
  
  # ui titulo ----
  h2(textOutput("texto_region")) |> tooltip("Bienvenido/a"),
  
  ## pestañas ----
  navset_card_tab(
    
    ### pestaña 1 ---- 
    nav_panel(title = "Pestaña 1",
              
              
              layout_columns(
                col_widths = c(5, 7),
                
                #### ui tabla ----
                div(style = css(padding = "18px"),
                    
                    h3("Tabla"),
                    
                    gt_output("tabla_region"),
                    # actionButton("opcion_tabla", label = "Mostrar/ocultar")
                    
                    radioGroupButtons(
                      inputId = "opcion_tabla",
                      label = "Opciones",
                      choices = c("Con color", 
                                  "Color alerta",
                                  "Sin color"),
                      justified = TRUE
                    ),
                    
                    sliderInput("opcion_decimales",
                                label = "Decimales", 
                                min = 0, max = 8, value = 1)
                ),
                
                #### ui gráfico ----
                div(style = css(padding = "18px"),
                    h3("Gráfico"),
                    plotOutput("grafico")
                )
              )
              
    ),
    
    ### pestaña 2 ---- 
    nav_panel(title = "Pestaña 2",
              
              #### iteración ----
              h3("Información"),
              
              div(style = css(height = "400px", overflow_y = "scroll"),
                  uiOutput("textos_comunas")
              )
    )
    
  )
)


# —----


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
    paste("Datos de pobreza:", input$region)
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
    
    
    # browser()
    
    tabla2 <- tabla1 |>
    # tabla1 |> 
      tab_options(table.font.color = color_texto,
                  table.background.color = color_fondo,
                  # líneas horizontales y verticales
                  table_body.hlines.color = color_secundario,
                  table_body.vlines.color = color_secundario,
                  # línea debajo de los nombres de columnas
                  column_labels.border.bottom.color = color_secundario,
                  # lineas de arriba y abajo de la tabla
                  column_labels.border.top.color = color_fondo, 
                  table_body.border.bottom.color = color_fondo
      )
    
    # agregar color depende de la elección
    if (input$opcion_tabla == "Con color") {
      tabla2 <- tabla2 |> 
        data_color(pobreza_p, method = "numeric",
                   # palette = "viridis",
                   palette = c(color_fondo, color_negativo)
                   
        )
      
    } else if (input$opcion_tabla == "Color alerta") {
      
      tabla2 <- tabla2 |> 
        tab_style(style = list(
          cell_fill(color = color_negativo),
          cell_text(color = color_fondo)
        ),
        locations = cells_body(columns = pobreza_p,
                               rows = pobreza_p > 0.3))
    }
    
    return(tabla2)
  })
  
  # renderizar la tabla
  output$tabla_region <- render_gt(tabla())
  
  
  
  # grafico ----
  output$grafico <- renderPlot({
    
    
    dato_region() |> 
      mutate(alerta = ifelse(pobreza_p > 0.3, "alerta", "normal")) |> 
      ggplot() +
      aes(x = pobreza_p, y = nombre_comuna) +
      geom_col(aes(fill = alerta),
               width = 0.5) +
      geom_text(aes(label = scales::percent(pobreza_p)),
                hjust = 0, nudge_x = 0.01, family = "Fira Code") +
      # theme_classic() +
      scale_x_continuous(labels = scales::label_percent(),
                         expand = expansion(c(0, 0.15))) +
      scale_fill_manual(values = c("alerta" = color_negativo, 
                                   "normal" = color_primario)) +
      labs(y = "", x = "Porcentaje de pobreza") +
      theme(legend.position = "none") +
      theme(text = element_text(family = "Fira Code")) +
      theme(axis.text.y = element_text(colour = color_texto, size = 12)) +
      theme(axis.text.x = element_text(colour = color_texto, size = 12))
    
    # dev.new()
    # browser()
  })
  
  
  
  # generar ui ----
  textos_comunas <- reactive({
    # browser()
    
    dato_region_filtrado <- dato_region() |> 
      filter(pobreza_p > 0.3)
    
    if (nrow(dato_region_filtrado) == 0) {
      return(
        div(style = css(background_color = color_secundario, 
                        color = color_fondo,
                        border_radius = "5px",
                        padding = "4px", 
                        margin_bottom = "4px"),
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
      
      elemento <- div(style = css(background_color = color_secundario, 
                                  color = color_fondo,
                                  border_radius = "5px",
                                  padding = "4px", margin_bottom = "4px"),
                      p(texto)
      )
      
      return(elemento)
    })
    
    return(resultado_textos)
  })
  
  
  output$textos_comunas <- renderUI(textos_comunas())
  
  
  
  # notificaciones ----
  observeEvent(input$region, {
    showNotification(ui = paste("Región seleccionada:", input$region),
                     type = "message")
  })
  
  
  
  
  # ventana ----
  observeEvent(input$ventana, {
    
    
    showModal(session = session,
              ui = modalDialog(title = h1("Detalles"),
                               
                               div(
                                 p("gato gato gato gato gato gato gato gato gato")
                                 
                               )
              )
              
              
    )
    
  })
  
  
  
  
}

shinyApp(ui, server)