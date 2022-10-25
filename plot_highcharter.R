# Cargar Librerías --------------------------------------------------------

library(tidyverse)
library(highcharter)
library(googlesheets4)

# Crear base de datos -----------------------------------------------------

data <- read_sheet(ss = "1hhMsy8nj9DAnsjeIpWmjAMy4zVWNxkGvouJyDWjz_8I", 
                   sheet = "Lanzamiento v.2", 
                   range = "A1:E14")
data$cantidad_ppto <- round(data$cantidad_ppto, digit = 2)

# Crear paleta de colores hex de rr.ss. ----------------------------------------

colores_rrss <- c("#4267B2", "#DB4437", "#C13584", "#0072B1", "#1ED760", "#FF0000")


# Plottear en highcharts ocupando el dataframe "data" --------------------------

data %>% 
hchart("column", hcaes(x = soporte, y = cantidad_ppto, group = formato)) %>% # dataframe y aes, agrupar por formato
  hc_colors(colores_rrss) %>% # Coloreado del agrupamiento, vector con hex codes creado anteriormente
  hc_chart( # Parámetros generales del plot
    backgroundColor = "#FAFAFA" ) %>% # Color del fondo
  hc_title(text = "Inversión Etapa de lanzamiento") %>%  # Título del gráfico
  hc_subtitle(text = "Composición del presupuesto") %>%  # Subtítulo del gráfico
  hc_xAxis( # Parámetros del eje X
    title = list(
      text  = "Soporte", # Nombre del eje X
      style = list(
        fontWeight = "bold", # Tipo de fuente, en este caso bold
        fontSize   = "1.4em"))) %>% # Tamaño de fuente
  hc_yAxis( # Parámetros eje Y
    title   = list(
      text  = "% Presupuesto", # Nombre del eje Y
      align = "high", # Alineamiento dentro del eje, en este casi arriba
      style = list(
        fontWeight = "bold", # Tipo de fuente
        fontSize   = "1.4em"))) %>% # Tamaño de fuente
  hc_plotOptions( # Parámetros específicos del plot que se genera
    column  = list(
      dataLabels = list(
        enabled  = TRUE)), # Para habilitar el número arriba de la barra
    series  = list(
      pointWidth = 35)) %>% # Ancho de los elementos de la serie, en este caso las columnas
  hc_tooltip(
    backgroundColor = "#FFFFFF", # Color del fondo que se despliega al pasar el tooltip por encima
    headerFormat = "<b>{point.key}</b><br><br>", # Título del tooltip se llama como la variable x (tipo de anuncio)
    pointFormat = "<b>{point.y} %<b/>"# Nombre del punto se llama como la variable y (% ppto)
  )
