owdbr_fies <-function(path){
  #' Collects data related to the Brazilian Federal Government's Educational Program FIES (Financiamento Estudantil).
  ckanr_setup(url = "http://www.fnde.gov.br/dadosabertos")
  print('This function might take some time to run since government data related to FIES might come in enourmous archives')
  resfies <-resource_search('name:Financiamentos Concedidos')
  resfies2 <- resfies$results

  table= c()

  for(i in resfies2){
    lista <- resfies2[[i]][["url"]]

    dataset <- fetch(lista, store= 'session', as= "table")

    fin.data <- rbind(table, dataset)
  }
  return(fin.data)
}

#fies_pkg <- package_show('fundo-de-financiamento-estudantil-fies')
#fiesid <- fies_pkg$id['resources']
#resfies <-resource_search('name:Financiamentos Concedidos')
#resfies2 <- resfies$results
#idf <- resfies2[[1]][["url"]] # <- ID
#d <- head(fetch(idf, store= 'session'))
