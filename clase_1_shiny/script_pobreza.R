library(dplyr)
library(gt)

# cargamos el dato
dato <- readr::read_rds("dato_pobreza.rds")

dato |> 
  select(region) |> 
  distinct(region) |> 
  pull()

# filtrar la tabla
dato_region <- dato |> 
  filter(region == "Tarapacá") |> 
  select(region, nombre_comuna, pobreza_p)

tabla <- dato_region |>
  arrange(desc(pobreza_p)) |> 
  gt() |> 
  fmt_percent(pobreza_p, decimals = 1, dec_mark = ",") |> 
  data_color(pobreza_p, method = "numeric",
             palette = "viridis")

tabla
