[![](logo_spatialLab.png)](https://spatiallab.cl)

# Desarrollo de aplicaciones web interactivas con R y Shiny (versión 2)

_Desde el 21 de noviembre al 12 de diciembre, 2024._

Docente: _Bastián Olea Herrera._ baolea@uc.cl

![](curso_desarrollo_apps_linkedin_2.jpeg)

Repositorio con los materiales y las clases de la versión 2 del curso, impartida en [SpatialLab.](http://spatiallab.cl)

En [SpatialLab encontrarás muchos más cursos](https://spatiallab.cl/cursos-1) sobre R y análisis de datos impartidos por profesionales de diversas áreas.

Para más información sobre mis próximos cursos y clases particulares: [https://bastianolea.rbind.io/clases/](https://bastianolea.rbind.io/clases/)

----

# Clase 1

En la clase 1 vimos tres ejemplos de aplicaciones Shiny:

### Ejemplo de app 1: app vacía
- La app `app_vacia.R` corresponde a una aplicación básica Shiny, que solo tiene textos en la UI, y sirve de plantilla para otras aplicaciones.

### Ejemplo de app 2: completada
- El script `script_completos.R` hace el ejercicio manual de sacar una cuenta o presupuesto
- La app `app_completos.R` traduce el script anterior en una aplicación interactiva

### Ejemplo de app 3: tabla de datos
- El script `script_pobreza.R` hace una tabla con `{gt}` a partir de los datos `dato_pobreza.rds`
- La app `app_pobreza.R` crea una app donde el input es el vector de _regiones_ en la base de datos, y el output es la misma tabla del script anterior. La interactividad en la app corresponde a un selector `selectInput` que, en base al vector de las regiones sacado de la base, filtra la base de datos, y genera una tabla con los datos filtrados.

## Recursos clase 1:
- mis Shiny apps: https://bastianolea.github.io/shiny_apps/ 
- tutorial Shiny app básica: https://bastianolea.rbind.io/blog/r_introduccion/tutorial_shiny_1/ 
- tutorial tablas {gt}: https://bastianolea.rbind.io/blog/tutorial_gt/
- documentación {bslib} para crear interfaces en Shiny: https://rstudio.github.io/bslib/
- documentación de Shiny: https://shiny.posit.co/r/getstarted/shiny-basics/lesson1/
- Mastering Shiny, libro avanzado de Shiny: https://mastering-shiny.org


----

# Clase 2

En la clase 2 mejoramos la aplicación que creamos en la clase 1:

- Aprendimos a visualizar la reactividad de nuestras aplicaciones con `reactlog::reactlog_enable()`
- vimos ejemplos para crear párrafos de texto a partir de los datos de nuestra aplicación
- creamos un gráfico que depende del mismo input el cual depende la tabla
- aprendimos a crear nuevos inputs desde el paquete {shinyWidgets}, y revisar la galería de widgets con `shinyWidgets::shinyWidgetsGallery()`
- aprendimos a agregar estilos `css` con el argumento `style` en los divs, y además a hacerlo con el paruqete {htmltools}
- aprendimos a crear columnas con la función `layout_columns()`
- agregamos condicionalidad a los elementos de nuestra aplicación creando inputs que luego son usados en condicionales `if else` para modificar el flujo del código
- usamos el paquete {shinyjs} para ocultar y mostrar elementos de nuestra obligación a partir de inputs
- creamos elementos de la interfaz de nuestra aplicación usando {purrr}, para crear una cantidad indeterminada de elementos en base a los datos

## Recursos clase 2:
- visualizar reactividad con {reactlog} https://rstudio.github.io/reactlog/
- galería de shinyWidgets: https://dreamrs.github.io/shinyWidgets/index.html
- javascript en Shiny con {shinyjs} https://deanattali.com/shinyjs/

----
