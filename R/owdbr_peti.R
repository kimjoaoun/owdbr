owdbr_peti <- function(IBGECODE, AAAA, MM, PAGE=1){
  if (AAAA < 1996) {
    stop("Invalid Input: PETI was created in 1996, so AAAA cannot be < 1996")
  }
  if (MM > 12) {
    stop("Invalid Input: The MM (Months) argument cannot be > 12!")
  }

  AAAAMM <- paste(AAAA, MM, sep = "") %>% as.numeric()
  IBGECODEN <- IBGECODE %>% as.numeric()
  PAGEN <- PAGE %>% as.numeric()
  path <- "http://www.transparencia.gov.br/api-de-dados/peti-por-municipio?"

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

