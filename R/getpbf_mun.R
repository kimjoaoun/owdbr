library(dplyr)
library(httr)
library(jsonlite)

getpbf_mun <- function(IBGECODE, AAAA, MM, PAGE){
  if(is.na(IBGECODE)== TRUE){
    stop("Missing Argument: IBGECODE")
  }
  if(AAAA < 2003){
    stop("Invalid Input: Program Bolsa Familia was created in 2003, so AAAA cannot be < 2003")
  }
  if(MM > 12){
    stop("Invalid Input: The MM (Months) argument cannot be > 12!")
  }

  AAAAMM <- paste(AAAA, MM, sep="") %>%  as.numeric()
  IBGECODEN <- IBGECODE %>% as.numeric()
  PAGEN <- PAGE %>% as.numeric()

  path <- 'http://www.transparencia.gov.br/api-de-dados/bolsa-familia-por-municipio?'
  request <- GET(url= path,
                 query= list(
                   mesAno= AAAAMM,
                   codigoIbge= IBGECODEN,
                   pagina= PAGEN
                 )
             )

  resp <- content(request, as = "text", encoding = "UTF-8")

  table <- jsonlite::fromJSON(resp, flatten = TRUE) %>%
    data.frame()

  return(table)
}

#Work
works <- getpbf_mun(3304557, AAAA= 2015, MM=10, PAGE=1)

#Don't Work
lista <- c('3304557', '3303906')
dontwork <- getpbf_mun(lista, AAAA= 2015, MM=10, PAGE=1)
