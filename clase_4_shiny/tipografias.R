# para ui ----
# en ui

# opción 1: directamente en el tema
theme <- bs_theme(
  base_font = font_google("Fira Code"),
  heading_font = font_google("Fredoka One") 
)

# opción 2: por separado
fresh::use_googlefont("Open Sans")
fresh::use_googlefont("Crimson Text")

theme = bslib::bs_theme(
  font_scale = 1.2,
  bg = color_fondo, fg = color_texto, primary = color_destacado, 
  # tipografías 
  base_font = "Crimson Text",
)



# tipografías para ragg/sysfonts ----
# se descargan en vivo, afuera

sysfonts::font_add_google("Fira Code", "Fira Code")

# después usar para que se detecten
showtext::showtext_auto()


# library(ragg)
# options(shiny.useragg = TRUE)
showtext::showtext_opts(dpi = 180)


# instalar localmente y usar ----
# se instalan afuera, y se declaran en UI

# instalar
gfonts::setup_font(id = "lato", output_dir = "www/")

# detectar
sysfonts::font_add("Lato",
                   regular = "www/fonts/lato-v24-latin-regular.ttf",
                   bold = "www/fonts/lato-v24-latin-900.ttf",
                   italic = "www/fonts/lato-v24-latin-italic.ttf",
                   bolditalic = "www/fonts/lato-v24-latin-900italic.ttf",
)

showtext_auto()
  
# en ui
gfonts::use_font("lato", "www/css/open-sans.css")

# o manualmnente con css
tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "css/libre-baskerville.css")),
tags$head(
  tags$link(rel = "stylesheet", type = "text/css", href = "css/libre-baskerville.css"),
  tags$style("* {font-family:'Libre Baskerville' !important;}")
)
tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "css/lato.css")),
tags$head(
  tags$link(rel = "stylesheet", type = "text/css", href = "css/lato.css"),
  tags$style("p, label, item {font-family:'Lato' !important;}")
)








