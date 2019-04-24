getpbf_uflist <- function() {
  
  #'Returns a tibble which contains the IBGE identification code of each one of all 23 UFs (Units of the Federation) in Brazil.
  #'Note: In alphabetical order.
  #'Source: IBGE (Brazilian Institute of Geography and Statistics)
  EST <-
    c(
      'Acre',
      'Alagoas',
      'Amapá',
      'Amazonas',
      'Bahia',
      'Ceará',
      'Espirito Santo',
      'Goiás',
      'Maranhão',
      'Mato Grosso',
      'Mato Grosso do Sul',
      'Minas Gerais',
      'Pará',
      'Paraíba',
      'Paraná',
      'Pernambuco',
      'Piauí',
      'Rio de Janeiro',
      'Rio Grande do Norte',
      'Rio Grande do Sul',
      'Rondônia',
      'Roraima',
      'Santa Catarina',
      'São Paulo',
      'Sergipe',
      'Tocantins'
    )
  UF<-
    c(
      'AC',
      'AL',
      'AP',
      'AM',
      'BA',
      'CE',
      'ES',
      'GO',
      'MA',
      'MT',
      'MS',
      'MG',
      'PA',
      'PB',
      'PR',
      'PE',
      'PI',
      'RJ',
      'RN',
      'RS',
      'RO',
      'RR',
      'SC',
      'SP',
      'SE',
      'TO'
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
    17
  )
  df <- data.frame(num, UF, EST) %>% dplyr::tibble()
  return(df)
}


df <-getpbf_uf()
