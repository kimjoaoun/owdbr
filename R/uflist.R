#'All the State's UF Codes.
#'
#'Returns a tibble which contains the IBGE identification code of each one of all 23 UFs (Units of the Federation) in Brazil.
#'
#'
#'
#'@return a tibble with 3 columns.
#' \describe{
#'    \item{EST}{The full name of the state}
#'    \item{UF}{The abbreviation of the state's name}
#'    \item{num}{The identification number of the state.}
#' }
#'
#'@examples uflist()
#'
#'@author Joao Pedro Oliveira dos Santos, International Relations Institute, Pontifical Catholic University of Rio de Janeiro
#'
#'@export
#'
#'@references Source: \href{https://cidades.ibge.gov.br}{IBGE (Brazilian Institute of Geography and Statistics)}

uflist <- function() {
  
  EST <-
    c(
      "Acre",
      "Alagoas",
      "Amapa",
      "Amazonas",
      "Bahia",
      "Ceara",
      "Espirito Santo",
      "Goias",
      "Maranhao",
      "Mato Grosso",
      "Mato Grosso do Sul",
      "Minas Gerais",
      "Para",
      "Paraiba",
      "Parana",
      "Pernambuco",
      "Piaui",
      "Rio de Janeiro",
      "Rio Grande do Norte",
      "Rio Grande do Sul",
      "Rondonia",
      "Roraima",
      "Santa Catarina",
      "Sao Paulo",
      "Sergipe",
      "Tocantins",
      "Distrito Federal"
    )
  UF <-
    c(
      "AC",
      "AL",
      "AP",
      "AM",
      "BA",
      "CE",
      "ES",
      "GO",
      "MA",
      "MT",
      "MS",
      "MG",
      "PA",
      "PB",
      "PR",
      "PE",
      "PI",
      "RJ",
      "RN",
      "RS",
      "RO",
      "RR",
      "SC",
      "SP",
      "SE",
      "TO",
      "DF"
    )
  num <- c(
    12,
    27,
    16,
    13,
    29,
    23,
    32,
    52,
    21,
    51,
    50,
    31,
    15,
    25,
    41,
    26,
    22,
    33,
    24,
    43,
    11,
    14,
    42,
    35,
    28,
    17,
    53
  )
  Regiao <- c("Norte",
              "Nordeste",
              "Nordeste",
              "Norte",
              "Nordeste",
              "Nordeste",
              "Sudeste",
              "Centro-Oeste",
              "Nordeste",
              "Centro-Oeste",
              "Centro-Oeste",
              "Sudeste",
              "Norte",
              "Nordeste",
              "Sul",
              "Nordeste",
              "Nordeste",
              "Sudeste",
              "Nordeste",
              "Sul",
              "Norte",
              "Norte",
              "Sul",
              "Sudeste",
              "Nordeste",
              "Norte",
              "Centro-Oeste")
  df <- tibble::as_tibble(data.frame(num, UF, EST, Regiao))
  return(df)
}
