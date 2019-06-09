#' Collects municipal level data from the program BOLSA FAMILIA database.
#'
#' The program BOLSA FAMILIA is a brazilian social welfare program that provides financial aid for poor families.
#' This function collects municipal level data from the program, some data like the number of citizens in a municipality which are enrolled in the program, and the total amount of money invested by the program in that city.
#'
#' @param IBGECODE IBGE unique identifier of the municipality which you want the data. The list of municipalities and its codes might be requested with the function owdbr::munlist()
#' @param AAAA Year of the data (AAAA format)
#' @param MM Month of the data (MM format)
#' @param PAGE Request's page. In normal situations: page=1.
#' @param YEARLY If True, it is not needed to fill the MM param, the package will request the data for the entire year (AAAA). Default= TRUE.
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
#'   }
#' @examples
#' \dontrun{
#' getpbf_mun("3304557", AAAA = "2015", MM = "05", PAGE = 1, YEARLY = FALSE)
#' }
#' @author Joao Pedro Oliveira dos Santos, International Relations Institute, Pontifical Catholic University of Rio de Janeiro
#'
#' @export

getpbf_mun <- function(IBGECODE, AAAA, MM = NULL, PAGE = 1, YEARLY = TRUE) {

  # Mensagens de erro para evitar que o usuário insira valores que não podem ser requisitados.
  if (AAAA < 2003) {
    stop("Invalid Input: Program Bolsa Familia was created in 2003, so AAAA cannot be < 2003")
  }
  if (AAAA < 2012) {
    warning("The requested time period data might not be availible!")
  }
  if (is.null(MM) != TRUE) {
    if (MM > 12) {
      stop("Invalid Input: The MM (Months) argument cannot be > 12!")
    }
  }

  # if (YEARLY == TRUE) {
  #    if (is.null(MM) == FALSE) {
  #     stop("Yearly requests do not accept the MM argument")
  #  }
  # }

  # Convertendo os valores em string para numéricos.
  AAAAMM <- paste(AAAA, MM, sep = "")
  IBGECODEN <- as.numeric(IBGECODE)
  PAGEN <- as.numeric(PAGE)

  # URL da API
  path <- "http://www.transparencia.gov.br/api-de-dados/bolsa-familia-por-municipio?"

  # Cria um vetor vazio, este alocará uma tabela.
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
      data <- getpbf_mun(IBGECODEN, anos, i, PAGEN, FALSE) # Recursion to avoid !DRY
      table <- dplyr::bind_rows(table, data)
    }
  }
  return(tibble::as_tibble(table))
}
