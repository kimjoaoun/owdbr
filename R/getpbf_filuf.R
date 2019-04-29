#' Download a tibble with all the IBGECODE from municipality of the desired State (UF).
#'
#' @param UF_Num Brazilian Federative Unit Code, a list of them might be requested with the owdbr::getpbf_uflist() function
#'
#' @return Returns a tibble with the list of municipalities.
#'
#' @examples
#' getpbf_filuf('BA')
#' getpbf_filuf('RJ')
#' getpbf_filuf('MS')
#'
#'
gepbf_filuf <- function(UF_Num) {
  if(UF_Num== is.na()){
    stop('UF_Num must not be equal to NA. You must specify a UF, use owdbr::getpbf_uflist() to see the list of the availible States and its UFs.')
  }
  data <- download.file("") %>%
    dplyr::tibble() %>%
    dplyr::filter(UF == UF_Num)
  return(res)
}



help(package= owdbr)
help("owdbr_fies")
help("getpbf_mun")
