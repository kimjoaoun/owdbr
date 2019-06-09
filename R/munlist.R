#' Get a tibble with a all municipalities from a State.
#'
#' Download a tibble with all the IBGECODE from municipality of the desired State.
#'
#' @param UF_Num A number given by the IBGE (Brazilian Institute for Geography and Statistics) for each state, a list of them might be requested with the owdbr::uflist() function.
#'
#' @return a tibble with the requested data divided in 11 columns, if there are more than one IBGECODE, returns all of them in the same tibble.
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
#'
#' @examples
#' \dontrun{
#' munlist(11)
#' }
#' @import tibble
#'
#' @author Joao Pedro Oliveira dos Santos, International Relations Institute, Pontifical Catholic University of Rio de Janeiro
#'
#' @export

munlist <- function(UF_Num) {
  ufnumenv <- UF_Num

  if (is.na(ufnumenv) == TRUE) {
    stop("UF_Num must not be equal to NA. You must specify a UF, use owdbr::owdbr_uflist() to see the list of the availible States and its UFs.")
  }

  resp <- data.table::fread("https://raw.githubusercontent.com/kimjoaoun/mateRial/master/IBGE_Mun/munibge.csv")
  table <- c()

  for (i in UF_Num) {
    newRow <- dplyr::filter(resp, resp$UF == i)
    table <- rbind(table, newRow)
  }

  return(tibble::as_tibble(table))
}
