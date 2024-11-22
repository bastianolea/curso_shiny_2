
# Desarrollo de aplicaciones interactivas con R y Shiny
## Clase 1

Docente: _Bastián Olea Herrera._ 
baolea@uc.cl
https://bastianolea.github.io/

----

En la clase 1 vimos tres ejemplos de aplicaciones Shiny:

### Ejemplo de app 1: app vacía
- La app `app_vacia.R` corresponde a una aplicación básica Shiny, que solo tiene textos en la UI, y sirve de plantilla para otras aplicaciones.

### Ejemplo de app 2: completada
- El script `script_completos.R` hace el ejercicio manual de sacar una cuenta o presupuesto
- La app `app_completos.R` traduce el script anterior en una aplicación interactiva

### Ejemplo de app 3: tabla de datos
- El script `script_pobreza.R` hace una tabla con `{gt}` a partir de los datos `dato_pobreza.rds`
- La app `app_pobreza.R` crea una app donde el input es el vector de _regiones_ en la base de datos, y el output es la misma tabla del script anterior. La interactividad en la app corresponde a un selector `selectInput` que, en base al vector de las regiones sacado de la base, filtra la base de datos, y genera una tabla con los datos filtrados.

## Recursos:
- mis Shiny apps: https://bastianolea.github.io/shiny_apps/ 
- tutorial Shiny app básica: https://bastianolea.rbind.io/blog/r_introduccion/tutorial_shiny_1/ 
- tutorial tablas {gt}: https://bastianolea.rbind.io/blog/tutorial_gt/
- documentación {bslib} para crear interfaces en Shiny: https://rstudio.github.io/bslib/
- documentación de Shiny: https://shiny.posit.co/r/getstarted/shiny-basics/lesson1/
- Mastering Shiny, libro avanzado de Shiny: https://mastering-shiny.org