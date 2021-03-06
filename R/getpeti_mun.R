#' Collects municipal level data from the PETI (Child Labour Erradication Program) database.
#'
#' PETI (Child Labour Erradication Program) is a brazilian social welfare program that provides financial support for poor families. Its objective is to protect these families children from any type of work before the age of 16 years old, with that, the Federal Government expect them to keep going to school.
#' This function collects municipal level data from the program, some data like the number of citizens in a municipality which are enrolled in the program, and the total amount of money invested by the program in that city.
#'
#'
#' @param IBGECODE IBGE Unique Identifier of the municipality which you want the data. The list of municipalities and its codes might be requested with the function owdbr::munlist()
#' @param AAAA Year of the Data (AAAA format)
#' @param MM Month of the Data (MM format)
#' @param PAGE Request's page. Default= 1.
#' @param YEARLY If True, it is not needed to fill the MM param, the package will request the data for the entire year (AAAA). Default= TRUE.
#'
#'
#' @return a tibble with the requested data, if there are more than one IBGECODE, returns all of them in the same tibble.
#' \describe{
#'   \item{dataReferencia}{Reference date}
#'   \item{valor}{Amount of money invested in the municipality.}
#'   \item{quantidadeBeneficiados}{Number of citizens wich are enrolled in the program in that moment}
#'   \item{municipio.codigoIBGE}{IBGE code of the municipality.}
#'   \item{municipio.nomeIBGE}{Name of the municipality.}
#'   \item{municipio.pais}{Country of the municipality.}
#'   \item{municipio.uf.sigla}{Abbreviation of name of the state in which the municipality is.}
#'   \item{municipio.uf.nome}{Full name of the state in wich the municipality is.}
#'   \item{tipo.id}{Type}
#'   \item{tipo.descricao}{Abbreviation of the program's name.}
#'   \item{tipo.descricaoDetalhada}{Full name of the program.}
#' }
#' @examples
#' \dontrun{
#' getpeti_mun("3304557", AAAA = "2015", MM = "05", PAGE = 1, YEARLY=FALSE)
#' }
#' @author Joao Pedro Oliveira dos Santos, International Relations Institute, Pontifical Catholic University of Rio de Janeiro
#'
#' @export


getpeti_mun <- function(IBGECODE, AAAA, MM, PAGE = 1, YEARLY=TRUE) {
  if (AAAA < 1996) {
    stop("Invalid Input: PETI was created in 1996, so AAAA cannot be < 1996")
  }
  if (MM > 12) {
    stop("Invalid Input: The MM (Months) argument cannot be > 12!")
  }

  AAAAMM <- as.numeric(paste(AAAA, MM, sep = ""))
  IBGECODEN <- as.numeric(IBGECODE)
  PAGEN <- as.numeric(PAGE)
  path <- "http://www.transparencia.gov.br/api-de-dados/peti-por-municipio?"

  table <- c()


  # loop para requerer os dados de cada municipio inserido; Requisição de um Mês específico.
  if (YEARLY == FALSE) {
    for (i in IBGECODE) { # API Request Code
      request <- httr::GET(
        url = path,
        query = list(
          mesAno = AAAAMM,
          codigoIbge = i,
          pagina = PAGEN
        )
      )

      if (request$status_code != 200) {
        stop(warning("Request Failed: Status Code "), request$status_code) # In case of error, what to show?
      }

      # Transforma a resposta da API em texto, e então coloca-a em um DF, que depois é transformado em tibble.
      resp <- httr::content(request, as = "text", encoding = "UTF-8")
      newRow <- data.frame(jsonlite::fromJSON(resp, flatten = TRUE))

      table <- dplyr::bind_rows(table, newRow)
      table <- tibble::as_tibble(table)
    }
  } else
    # Caso sejam feitas requisições de todos os meses de um ano, loop MM= 1 (janeiro) até 12 (dezembro).
    if (YEARLY == TRUE) {
      MX <- as.character(c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")) # Quantity of Months
      anos <- AAAA
      for (i in MX) {
        data <- getpeti_mun(IBGECODEN, anos, i, PAGEN, FALSE) # Recursion to avoid !DRY
        table <- dplyr::bind_rows(table, data)
      }
    }
  return(tibble::as_tibble(table))
}
