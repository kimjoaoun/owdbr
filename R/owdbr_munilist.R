#' Get a tibble with a all municipalities from a UF.
#'
#' Download a tibble with all the IBGECODE from municipality of the desired State (UF).
#'
#' @param UF_Num Brazilian Federative Unit Code, a list of them might be requested with the owdbr::owdbr_uflist() function
#'
#' @return Returns a tibble with the list of municipalities in the desired State (UF).
#'
#' @examples
#' owdbr_munilist(11) #For the list of municipalities in the state of Rondonia
#' owdbr_munilist(17) #For the list of municipalities in the state of Tocantins
#' owdbr_munilist(25) #For the list of municipalities in the state of Paraíba
#'
#'
owdbr_munilist <- function(UF_Num) {
  if(UF_Num== is.na(1)){
    stop('UF_Num must not be equal to NA. You must specify a UF, use owdbr::owdbr_uflist() to see the list of the availible States and its UFs.')
  }
  dados <- data.table::fread("https://raw.githubusercontent.com/kimjoaoun/mateRial/master/IBGE_Mun/munibge.csv") %>%
    dplyr::filter(UF == UF_Num)
  return(tibble::tibble(dados))
}

