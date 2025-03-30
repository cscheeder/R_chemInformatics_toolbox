# Preamble
##This is a small code snipped used to access the PubChem API to retrieve 
##annotations for chemicals. The PubChem API is queried using the InChiKey 
##representation and PubChem identifiers are retrieved.  
 


# Session Setup    
library(tidyr)
library(tidyverse)
library(stringr)
library(httr)
library(jsonlite)




# Query the PubChem API
inchikey_list = as.list(c("KTUFNOKKBVMGRW-UHFFFAOYSA-N"))
names(inchikey_list) <- c("Imatinib")

result_list <- list()

for(i in names(inchikey_list)){
  print(unlist(inchikey_list[i],use.names = F))
  signature <- GET(paste0("https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/inchikey/",
                          unlist(inchikey_list[i],use.names = F),
                          "/cids/JSON")
                   )
  results <- fromJSON(content(signature, "text"))
  cids <- results$IdentifierList$CID
  
  result_list[[i]] <- cids
  
}


# Save results in a table
cids <- tibble(
  name = names(sapply(result_list, "[[",1)),
  cid=paste0("cid",sapply(result_list, "[[",1)))
