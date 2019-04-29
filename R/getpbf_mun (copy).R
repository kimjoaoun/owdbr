getpbf_mun <- function(IBGECODE, AAAA, MM, PAGE) {
  if (AAAA < 2003) {
    stop("Invalid Input: Program Bolsa Familia was created in 2003, so AAAA cannot be < 2003")
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
    request <- GET(
      url = path,
      query = list(
        mesAno = AAAAMM,
        codigoIbge = i,
        pagina = PAGEN
      )
    )

    resp <- content(request, as = "text", encoding = "UTF-8")
    newRow <- jsonlite::fromJSON(resp, flatten = TRUE) %>%
      data.frame()

    table <- rbind(table, newRow) %>%
      dplyr::rename(
        Municipio = municipio.nomeIBGE,
        UF.sigla = municipio.uf.sigla,
        municipio.uf.nome = UF.nome
      ) %>%
      dplyr::tibble()
  }

  return(table)
}
