myData <- read_excel(paste0('convert.xlsx'))
View(myData)


library(httr)
url <- "https://guacamole-priv.univ-avignon.fr/jpvir_test?corpus=lib&phrase=Tout%20bien%20est%20sujet%20une%20usure%20au%20fil%20du%20temps%20en%20raison&length=10"
response <- GET(url)


# Check if the request was successful
if (http_status(response)$status_code == 200) {
  # Parse JSON data
  json_data <- content(response, "text")
  
  # Convert JSON to a data frame or list, depending on the structure of the JSON
  parsed_data <- jsonlite::fromJSON(json_data)
  
  # Now you can work with the parsed_data object, which contains the JSON data
  print(parsed_data)
} else {
  cat("Error:", http_status(response)$reason, "\n")
}

x=system('wget -q -O - --no-check-certificate  "https://guacamole-priv.univ-avignon.fr/jpvir_test?corpus=lib&phrase=Tout%20bien%20est%20sujet%20une%20usure%20au%20fil%20du%20temps%20en%20raison&length=10"',intern = T)

library("jsonlite")

data <- fromJSON(x)


library(RPostgreSQL)
c=dbConnect(RPostgreSQL::PostgreSQL())

dbWriteTable(c,"json",data)
dbReadTable(c,"json",data)

library(httr)
url <- "http://localhost:56001/jpvir_test?corpus=lib&phrase=test&length=10"
response <- GET(url)

json_data <- content(response,"text")

#paramètre dbappend pour ajouter à la table 

x10 =system('wget -q -O - --no-check-certificate  "https://guacamole-priv.univ-avignon.fr/jpvir_test?corpus=lib&phrase=divorce&length=50"',intern = T)
XC10 <- as.data.frame(fromJSON(x10))
XC10$eval = rep(NA,50)
XC10$id_requete=rep(10,50)

XC10$id_passage=451:500


XC10$eval=as.integer(XC10$eval)


#table pour id les requêtes


divorce =system('wget -q -O - --no-check-certificate  "https://guacamole-priv.univ-avignon.fr/jpvir_test?corpus=lib&phrase=divorce&length=50"',intern = T)
mariage =system('wget -q -O - --no-check-certificate  "https://guacamole-priv.univ-avignon.fr/jpvir_test?corpus=lib&phrase=mariage&length=50"',intern = T)
pacs =system('wget -q -O - --no-check-certificate  "https://guacamole-priv.univ-avignon.fr/jpvir_test?corpus=lib&phrase=pacs&length=50"',intern = T)
cambriolage =system('wget -q -O - --no-check-certificate  "https://guacamole-priv.univ-avignon.fr/jpvir_test?corpus=lib&phrase=cambriolage&length=50"',intern = T)
vol =system('wget -q -O - --no-check-certificate  "https://guacamole-priv.univ-avignon.fr/jpvir_test?corpus=lib&phrase=vol&length=50"',intern = T)
viol =system('wget -q -O - --no-check-certificate  "https://guacamole-priv.univ-avignon.fr/jpvir_test?corpus=lib&phrase=viol&length=50"',intern = T)
aggression =system('wget -q -O - --no-check-certificate  "https://guacamole-priv.univ-avignon.fr/jpvir_test?corpus=lib&phrase=aggression&length=50"',intern = T)
harcèlement =system('wget -q -O - --no-check-certificate  "https://guacamole-priv.univ-avignon.fr/jpvir_test?corpus=lib&phrase=harcèlement&length=50"',intern = T)
enlèvement =system('wget -q -O - --no-check-certificate  "https://guacamole-priv.univ-avignon.fr/jpvir_test?corpus=lib&phrase=enlèvement&length=50"',intern = T)
adoption =system('wget -q -O - --no-check-certificate  "https://guacamole-priv.univ-avignon.fr/jpvir_test?corpus=lib&phrase=adoption&length=50"',intern = T)

df=data.frame("divorce", "mariage", "pacs","cambriolage", "vol", "viol","aggression", "harcèlement", "enlèvement", "adoption")

requete = data.frame("req_id"=seq(1,10,1),
                     "requete"=c("divorce", "mariage", "pacs",
                                 "cambriolage", "vol", "viol",
                                 "aggression", "harcèlement", "enlèvement", "adoption"))


library(RPostgreSQL) 
library(httr) 
library("jsonlite") 
cpg <- dbConnect(RPostgreSQL::PostgreSQL(), dbname = 'iut2203848')  
# Paramètres 
len <- 50 
phrases <- c("divorce", "mariage", "pacs","cambriolage", "vol", "viol","aggression", "harcèlement", "enlèvement", "adoption")  
# Initialisation de l'identifiant 
id <- 0  
# Création du data frame pour stocker les données 
df_list <- list()  
for (i in 1:length(phrases)) { 	
  phrase <- phrases[i] 	 	# Incrémentation de l'identifiant 	
  id <- id + 1 	 	
# Récupération des données 	
  url <- paste0("http://localhost:56001/jpvir_test?corpus=lib&phrase=", URLencode(phrase), "&length=", len) 	
  response <- GET(url) 	
  json_data <- content(response, "text") 	 	
# Création du data frame 	
  df <- data.frame(id = id, as.data.frame(fromJSON(json_data))) 	
  df_list[[i]] <- df }  # Combinaison de tous les data frames en un seul 
final_df <- do.call(rbind, df_list)  
# Création de la table sans contrainte de clé primaire 
dbWriteTable(cpg, "NOSQL", final_df, row.names = FALSE, append = TRUE)  
# Ajouter une clé primaire après la création de la table sql_
add_primary_key <- "ALTER TABLE public.NOSQL ADD PRIMARY KEY (id, id_dec, line);"
dbExecute(cpg, sql_add_primary_key)

write.csv("final_df","df.csv")
