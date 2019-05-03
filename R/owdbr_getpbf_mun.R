#' Collects municipal level data from the Program Bolsa Familia Database.
#'
#' @param IBGECODE IBGE Unique Identifier of the municipality which you want the data. The list of municipalities and its codes might be requested with the function (INSERT FUNCTION THAT COLLECTS MUN-LIST)
#' @param AAAA Year of the Data (AAAA format)
#' @param MM Month of the Data (MM format)
#' @param PAGE Request's page. Default= 1.
#'
#' @return  Returns a tibble with the requested data, if there are more than one IBGECODE, returns all of them in the same tibble.
#'
#' @example getpbf_mun('3304557', AAAA='2010', MM='05')

owdbr_getpbf_mun <- function(IBGECODE, AAAA, MM, PAGE) {

  if (AAAA < 2003) {
    stop("Invalid Input: Program Bolsa Familia was created in 2003, so AAAA cannot be < 2003")
  }

  if(AAAA < 2012) {
  warning('The requested time period data might not be availible!')
  }

  if (MM > 12) {
    stop("Invalid Input: The MM (Months) argument cannot be > 12!")
  }

  AAAAMM <- paste(AAAA, MM, sep = "") %>% as.numeric()
  IBGECODEN <- IBGECODE %>% as.numeric()
  PAGEN <- PAGE %>% as.numeric()
  path <- "http://www.transparencia.gov.br/api-de-dados/bolsa-familia-por-municipio?"

  table <- c()

  for (i in IBGECODE) {
    request <- httr::GET(url = path,
      query = list(
        mesAno = AAAAMM,
        codigoIbge = i,
        pagina = PAGEN
      )
    )

    if(request$status_code != 200){
      stop(print('Request Failed: Status Code '), request$status_code)
    }

    resp <- content(request, as = "text", encoding = "UTF-8")
    newRow <- jsonlite::fromJSON(resp, flatten = TRUE) %>%
      data.frame()

    table <- rbind(table, newRow)
  }

  return(tibble(table))
}
