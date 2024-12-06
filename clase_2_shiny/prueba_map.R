dato <- readr::read_rds("datos/dato_pobreza.rds")



input_region <- unique(dato$region)[4]

dato_filtrado <- dato |> 
  filter(region == input_region)


lista_comunas <- dato_filtrado$nombre_comuna



map(lista_comunas, ~{
  # .x = 4
  dato_comuna <- dato_filtrado |> 
    filter(nombre_comuna == .x)
  
  dato_comuna
  
  texto <- paste("La comuna",
        dato_comuna$nombre_comuna, 
        "tiene un porcentaje de pobreza de", 
        paste0(round(dato_comuna$pobreza_p*100, digits = 1), "%")
        )
  
  return(texto)
})
