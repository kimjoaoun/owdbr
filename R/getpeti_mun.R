#'Collects municipal level data from the PETI (Child Slave Labour Erradication Program) database.
#'
#'PETI (Child Slave Labour Erradication Program) is a brazilian social welfare program that provides financial support for poor families. Its objective is to protect these families children from any type of work before the age of 16 years old, with that, the Federal Government expect them to keep going to school.
#'This function collects municipal level data from the program, some data like the number of citizens in a municipality wich are enrolled in the program, and the total amound of money invested by the program in that city.
#'
#'
#'@param IBGECODE IBGE Unique Identifier of the municipality which you want the data. The list of municipalities and its codes might be requested with the function owdbr::munlist()
#'@param AAAA Year of the Data (AAAA format)
#'@param MM Month of the Data (MM format)
#'@param PAGE Request's page. Default= 1.
#'
#'
#'@return a tibble with the requested data divided in 11 columns, if there are more than one IBGECODE, returns all of them in the same tibble.
#'\describe{
#'   \item{table.dataReferencia}{Reference date}
#'   \item{table.valor}{Amount of money invested in the municipality.}
#'   \item{table.quantidadeBeneficiados}{Number of citizens wich are enrolled in the program in that moment}
#'   \item{table.municipio.codigoIBGE}{IBGE code of the municipality.}
#'   \item{table.municipio.nomeIBGE}{Name of the municipality.}
#'   \item{table.municipio.pais}{Country of the municipality.}
#'   \item{table.municipio.uf.sigla}{Abbreviation of name of the state in which the municipality is.}
#'   \item{table.municipio.uf.nome}{Full name of the state in wich the municipality is.}
#'   \item{table.tipo.id}{Type}
#'   \item{table.tipo.descricao}{Abbreviation of the program's name.}
#'   \item{table.tipo.descricaoDetalhada}{Full name of the program.}
#'   }
#'
#'@examples getpeti_mun('3304557', AAAA='2015', MM='05', PAGE=1)
#'
#'@author Joao Pedro Oliveira dos Santos, International Relations Institute, Pontifical Catholic University of Rio de Janeiro
#'
#'@export


getpeti_mun <- function(IBGECODE, AAAA, MM, PAGE=1){
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

  for (i in IBGECODE) {
    request <- httr::GET(url = path,
                         query = list(
                           mesAno = AAAAMM,
                           codigoIbge = i,
                           pagina = PAGEN
                         )
    )

    if(request$status_code != 200){
      stop(warning('Request Failed: Status Code '), request$status_code)
    }

    resp <- httr::content(request, as = "text", encoding = "UTF-8")
    newRow <- data.frame(jsonlite::fromJSON(resp, flatten = TRUE))

    table <- rbind(table, newRow)
    table <- tibble::as_tibble(table)
  }

  return(table)
}
