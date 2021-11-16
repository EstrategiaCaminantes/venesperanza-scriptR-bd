
################ cargue librerias################
library(plyr)
library(dplyr)
library(httr)
library(jsonlite)
library(readr)
library(openxlsx) 
library(readxl)
library(ggplot2)
library(viridis)
library(wesanderson)
library(gridExtra)
library(gganimate)
library(readr)
library(dplyr)
library(assertive)
library(stringr)
library(ggplot2)
library(readxl)
library(lubridate)
library(eeptools)
library("gridExtra")
library(forecast)
library(nnfor)
library(gganimate)
library(hrbrthemes)
library(animation)
library("xlsx")
library(openxlsx)
library(caTools)
library(geojsonR)
library(geojsonio)
library(sp)
library(reshape2)



################ Mes y Día ################

Mes="Noviembre"
dia="Noviembre10"
mes_dia="11_10"


################ cargue  base encuestas################

webN <- read_csv(paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","caminantes_encuestas_llegadas_datosact_21_",mes_dia,".csv"))

###################número de documento###############################

webN$numero_documento=ifelse(is.na(webN$numero_documento),"NULL",
                             ifelse(webN$numero_documento=="null","NULL",webN$numero_documento))

###################tipo de documento###############################
webN$tipo_documento=ifelse(webN$tipo_documento=="otro",webN$cual_otro_tipo_documento,webN$tipo_documento)

webN$tipo_documento=ifelse(webN$tipo_documento=="Cédula de Identidad (venezonala)","cedula_identidad_venezolana",
                    ifelse(webN$tipo_documento=="Cédula de Identidad (venezolana)","cedula_identidad_venezolana",
                    ifelse(webN$tipo_documento=="Cédula de Identidad (Venezolana)","cedula_identidad_venezolana",
                    ifelse(webN$tipo_documento=="Cédula de ciudadania (colombiana)","cedula_ciudadania_colombiana",
                    ifelse(webN$tipo_documento=="Cédula de Ciudadanía (Colombiana)","cedula_ciudadania_colombiana",
                    ifelse(webN$tipo_documento=="null","NULL",
                    ifelse(webN$tipo_documento=="null","NULL",
                    ifelse(webN$tipo_documento=="Pasaporte","Pasaporte",
                    ifelse(webN$tipo_documento=="Constancia de Perdida de Documentos","Constancia_perdida_documentos",
                    ifelse(webN$tipo_documento=="Constancia de perdida de documentos","Constancia_perdida_documentos",
                    ifelse(webN$tipo_documento=="Constancia por perdida de documentos","Constancia_perdida_documentos",
                    ifelse(webN$tipo_documento=="No tengo ningún documento de identidad","Indocumentado",
                    ifelse(webN$tipo_documento=="PARTIDA DE NACIMIENTO","Acta de Nacimiento",
                    ifelse(webN$tipo_documento=="Partida de nacimiento","Acta de Nacimiento",
                    ifelse(webN$tipo_documento=="Perdida de documento","Indocumentado",
                    ifelse(webN$tipo_documento=="0","Otro",
                    ifelse(webN$tipo_documento=="Niup","Otro",webN$tipo_documento)))))))))))))))))

###################municipio destino final###############################

webN$nombre_municipio_destino_final=ifelse(webN$nombre_municipio_destino_final=="Bogotá","BOGOTA",
                                    ifelse(webN$nombre_municipio_destino_final=="Bucaramanga","BUCARAMANGA",
                                    ifelse(webN$nombre_municipio_destino_final=="Cali","CALI",
                                    ifelse(webN$nombre_municipio_destino_final=="Cúcuta","CUCUTA",
                                    ifelse(webN$nombre_municipio_destino_final=="Cucuta","CUCUTA",
                                    ifelse(webN$nombre_municipio_destino_final=="Barranquilla","BARRANQUILLA", 
                                    ifelse(webN$nombre_municipio_destino_final=="Medellín","MEDELLIN",
                                    ifelse(webN$nombre_municipio_destino_final=="Medellin","MEDELLIN",
                                    ifelse(webN$nombre_municipio_destino_final=="No estoy seguro/a","NoSeguro",
                                    ifelse(webN$nombre_municipio_destino_final=="null","NULL",
                                    ifelse(webN$nombre_municipio_destino_final=="Arauca","ARAUCA",
                                    ifelse(webN$nombre_municipio_destino_final=="Cartagena","CARTAGENA",
                                    ifelse(webN$nombre_municipio_destino_final=="Pasto","PASTO",
                                    ifelse(webN$nombre_municipio_destino_final=="Valledupar","VALLEDUPAR",
                                    ifelse(webN$nombre_municipio_destino_final=="Sucre Antioquía Olaya","SUCRE", 
                                    ifelse(webN$nombre_municipio_destino_final=="Riohacha","RIOHACHA",
                                    ifelse(webN$nombre_municipio_destino_final=="Otro","OTRO",
                                    webN$nombre_municipio_destino_final)))))))))))))))))

###################departamento Destino###############################

webN$departamentoDestino=ifelse(webN$nombre_municipio_destino_final=="Bogotá","BOGOTA",
                         ifelse(webN$nombre_municipio_destino_final=="Bucaramanga","SANTANDER",
                         ifelse(webN$nombre_municipio_destino_final=="Cali","VALLE DEL CAUCA",
                         ifelse(webN$nombre_municipio_destino_final=="Cúcuta","NORTE DE SANTANDER",
                         ifelse(webN$nombre_municipio_destino_final=="Cucuta","NORTE DE SANTANDER",
                         ifelse(webN$nombre_municipio_destino_final=="Medellín","ANTIOQUIA",
                         ifelse(webN$nombre_municipio_destino_final=="Medellin","ANTIOQUIA",
                         ifelse(webN$nombre_municipio_destino_final=="Arauca","ARAUCA",
                         ifelse(webN$nombre_municipio_destino_final=="Barranquilla","ATLANTICO",
                         ifelse(webN$nombre_municipio_destino_final=="Cartagena","BOLIVAR",
                         ifelse(webN$nombre_municipio_destino_final=="Pasto","NARINO",
                         ifelse(webN$nombre_municipio_destino_final=="Valledupar","CESAR",
                         ifelse(webN$nombre_municipio_destino_final=="null","NULL",
                         ifelse(webN$nombre_municipio_destino_final=="Riohacha","LA GUAJIRA",      
                         ifelse(webN$nombre_municipio_destino_final=="No estoy seguro/a","NoSeguro",
                         ifelse(webN$nombre_municipio_destino_final=="BARRANQUILLA","ATLANTICO",
                         ifelse(webN$nombre_municipio_destino_final=="BUCARAMANGA","SANTANDER",
                         ifelse(webN$nombre_municipio_destino_final=="CALI","VALLE DEL CAUCA",
                         ifelse(webN$nombre_municipio_destino_final=="CARTAGENA","BOLIVAR",
                         ifelse(webN$nombre_municipio_destino_final=="CUCUTA","NORTE DE SANTANDER",
                         ifelse(webN$nombre_municipio_destino_final=="MEDELLIN","ANTIOQUIA",
                         ifelse(webN$nombre_municipio_destino_final=="CUCUTA","NORTE DE SANTANDER",
                         ifelse(webN$nombre_municipio_destino_final=="PASTO","NARINO",
                         ifelse(webN$nombre_municipio_destino_final=="RIOHACHA","LA GUAJIRA",
                         ifelse(webN$nombre_municipio_destino_final=="VALLEDUPAR","CESAR",
                         ifelse(webN$nombre_municipio_destino_final=="Otro","OTRO",webN$nombre_municipio_destino_final))))))))))))))))))))))))))

webN$departamentoDestino=ifelse(is.na(webN$departamentoDestino),"NULL",webN$departamentoDestino)

###################llegada Ubicacion###############################


webN$llegada_ubicacion=ifelse(webN$llegada_ubicacion=="Otro",webN$llegada_otra_ubicacion,webN$llegada_ubicacion)

webN$llegada_ubicacion=ifelse(webN$llegada_ubicacion=="Bogotá","BOGOTA",
                       ifelse(webN$llegada_ubicacion=="Bucaramanga","BUCARAMANGA",
                       ifelse(webN$llegada_ubicacion=="Cali","CALI",
                       ifelse(webN$llegada_ubicacion=="Cúcuta","CUCUTA",
                       ifelse(webN$llegada_ubicacion=="No estoy seguro/a","No_Seguro",
                       ifelse(webN$llegada_ubicacion=="Medellín","MEDELLIN",
                       ifelse(webN$llegada_ubicacion=="En Boyaca San Jose D Pare","SAN JOSE DE PARE",
                       ifelse(webN$llegada_ubicacion=="Villa del rosario  norte de Santander","VILLA DEL ROSARIO",
                       ifelse(webN$llegada_ubicacion=="Guayabetal","GUAYABETAL", 
                       ifelse(webN$llegada_ubicacion=="Arauca","ARAUCA",
                       ifelse(webN$llegada_ubicacion=="El choco tado","TADO",
                       ifelse(webN$llegada_ubicacion=="la unión nariño","LA UNION",  
                       ifelse(webN$llegada_ubicacion=="Nariño Ipiales","IPIALES", 
                       ifelse(webN$llegada_ubicacion=="Pamplona","PAMPLONA", 
                       ifelse(webN$llegada_ubicacion=="Pereira","PEREIRA",
                       ifelse(webN$llegada_ubicacion=="Norte de Santander","CUCUTA",
                       ifelse(webN$llegada_ubicacion=="null","NULL", 
                       ifelse(webN$llegada_ubicacion=="Sucre Antioquía Olaya","SUCRE",
                       ifelse(webN$llegada_ubicacion=="San José de guaviares","SAN JOSE DE GUAVIARE",
                       ifelse(webN$llegada_ubicacion=="Monterrey Casanare","MONTERREY",
                       ifelse(webN$llegada_ubicacion=="Herrera tolima","HERRERA",
                       ifelse(webN$llegada_ubicacion=="Neiva Huila","NEIVA", 
                       ifelse(webN$llegada_ubicacion=="1","OTRO",
                       ifelse(webN$llegada_ubicacion=="2","OTRO",
                       ifelse(webN$llegada_ubicacion=="5","OTRO",      
                       ifelse(webN$llegada_ubicacion=="tame arauca","TAME",
                       ifelse(webN$llegada_ubicacion=="Cartagena","CARTAGENA",
                       ifelse(webN$llegada_ubicacion=="Quiimbio","OTRO",
                       ifelse(webN$llegada_ubicacion=="Barranquilla","BARRANQUILLA",
                       ifelse(webN$llegada_ubicacion=="Chinacota","CHINACOTA", 
                       ifelse(webN$llegada_ubicacion=="Chinacota norte de santander","CHINACOTA",
                       ifelse(webN$llegada_ubicacion=="Ipiales","IPIALES",
                       ifelse(webN$llegada_ubicacion=="Palmira Valle","PALMIRA",
                       ifelse(webN$llegada_ubicacion=="Pasto","PASTO",
                       ifelse(webN$llegada_ubicacion=="NULL","NULL",
                       ifelse(webN$llegada_ubicacion=="8","OTRO",
                       ifelse(webN$llegada_ubicacion=="Aguazul Casanare","AGUAZUL",
                       ifelse(webN$llegada_ubicacion=="Alcalá valle del cauca","ALCALA",
                       ifelse(webN$llegada_ubicacion=="Almenia calarca","ARMENIA",
                       ifelse(webN$llegada_ubicacion=="Boyaca","OTRO",
                       ifelse(webN$llegada_ubicacion=="Cerete cordoba","CERETE",
                       ifelse(webN$llegada_ubicacion=="Ciuda yopal","YOPAL",
                       ifelse(webN$llegada_ubicacion=="En San Antonio Del Táchira    En La Frontera","VILLA DEL ROSARIO",
                       ifelse(webN$llegada_ubicacion=="Ibague Tolima","IBAGUE",
                       ifelse(webN$llegada_ubicacion=="Ibagué.","IBAGUE",
                       ifelse(webN$llegada_ubicacion=="NULL","NULL",
                       ifelse(webN$llegada_ubicacion=="Ipiales nariños","IPIALES",
                       ifelse(webN$llegada_ubicacion=="La dorada","LA DORADA",
                       ifelse(webN$llegada_ubicacion=="La dorada caldas","LA DORADA",
                       ifelse(webN$llegada_ubicacion=="Melgar Tolima","MELGAR",webN$llegada_ubicacion))))))))))))))))))))))))))))))))))))))))))))))))))
                       
webN$llegada_ubicacion=ifelse(webN$llegada_ubicacion=="Pamplona norte de Santander","PAMPLONA",
                       ifelse(webN$llegada_ubicacion=="Riohacha","RIOHACHA",
                       ifelse(webN$llegada_ubicacion=="Sabana larga  Barranquilla","SABANALARGA",
                       ifelse(webN$llegada_ubicacion=="san gil","SAN GIL",
                       ifelse(webN$llegada_ubicacion=="Soacha cundinamarca","SOACHA",
                       ifelse(webN$llegada_ubicacion=="san gil","SAN GIL",
                       ifelse(webN$llegada_ubicacion=="Valledupar","VALLEDUPAR",
                       ifelse(webN$llegada_ubicacion=="Villa del rosario","VILLA DEL ROSARIO",
                       ifelse(webN$llegada_ubicacion=="Yopal","YOPAL",
                       ifelse(webN$llegada_ubicacion=="Armenia Quindío","ARMENIA",
                       ifelse(webN$llegada_ubicacion=="Canta gallo sur de Bolívar","CANTAGALLO",
                       ifelse(webN$llegada_ubicacion=="Chinchina","CHINCHINA",
                       ifelse(webN$llegada_ubicacion=="Ciudad Bolívar","OTRO",
                       ifelse(webN$llegada_ubicacion=="Espinal Tolima","ESPINAL",
                       ifelse(webN$llegada_ubicacion=="Pacora caldas correjimiento Castilla","PACORA",
                       ifelse(webN$llegada_ubicacion=="Putumayo villa garzon","VILLA GARZON",
                       ifelse(webN$llegada_ubicacion=="Santa Marta","SANTA MARTA",
                       ifelse(webN$llegada_ubicacion=="Venta Quemada Boyaca","VENTAQUEMADA", 
                       ifelse(webN$llegada_ubicacion=="11","OTRO",webN$llegada_ubicacion)))))))))))))))))))                                                                                  
                       



webN$llegada_ubicacion=ifelse(webN$llegada_ubicacion=="Acasia","ACACIAS",
                       ifelse(webN$llegada_ubicacion=="Aguachica cesar","AGUACHICA",
                       ifelse(webN$llegada_ubicacion=="APRTADO ANTIOQUIA","APARTADO",
                       ifelse(webN$llegada_ubicacion=="Armenia","ARMENIA",
                       ifelse(webN$llegada_ubicacion=="Armenia Quindio","ARMENIA",
                       ifelse(webN$llegada_ubicacion=="Barranca bermeja","BARRANCABERMEJA",
                       ifelse(webN$llegada_ubicacion=="Barranca Bermeja vereda la plazuela","BARRANCABERMEJA",
                       ifelse(webN$llegada_ubicacion=="Bochalema","BOCHALEMA",
                       ifelse(webN$llegada_ubicacion=="Bolivar Magangué","MAGANGUE",
                       ifelse(webN$llegada_ubicacion=="Bosconia cesar","BOSCONIA",
                       ifelse(webN$llegada_ubicacion=="Boyacá","BOYACA",
                       ifelse(webN$llegada_ubicacion=="Briceño","BRICENO",
                       ifelse(webN$llegada_ubicacion=="Briseño","BRICENO",
                       ifelse(webN$llegada_ubicacion=="Casanare","CASANARE",
                       ifelse(webN$llegada_ubicacion=="Chinchiná caldas","CHINCHINA",
                       ifelse(webN$llegada_ubicacion=="Cucuta","CUCUTA",
                       ifelse(webN$llegada_ubicacion=="Cúcuta Norte de Santander","CUCUTA",
                       ifelse(webN$llegada_ubicacion=="Duitamaboyaca","DUITAMA",
                       ifelse(webN$llegada_ubicacion=="Ecuador machala","OTRO",
                       ifelse(webN$llegada_ubicacion=="El Cauca Santander de quilichao","SANTANDER DE QUILICHAO",
                       ifelse(webN$llegada_ubicacion=="En barrancabermeja","BARRANCABERMEJA",
                       ifelse(webN$llegada_ubicacion=="En ecuador","OTRO",
                       ifelse(webN$llegada_ubicacion=="En guateque boyaca","GUATEQUE",
                       ifelse(webN$llegada_ubicacion=="En tolima planadas  gaitania","PLANADAS",
                       ifelse(webN$llegada_ubicacion=="Ibagué","IBAGUE",
                       ifelse(webN$llegada_ubicacion=="Ituango antioquia","ITUANGO",
                       ifelse(webN$llegada_ubicacion=="Manizales","MANIZALES",
                       ifelse(webN$llegada_ubicacion=="Moniquira boyaca","MONIQUIRA",
                       ifelse(webN$llegada_ubicacion=="En barrancabermeja","BARRANCABERMEJA",
                       ifelse(webN$llegada_ubicacion=="Paipa boyaca salitre","PAIPA",
                       ifelse(webN$llegada_ubicacion=="Palmira valle","PALMIRA",
                       ifelse(webN$llegada_ubicacion=="Palmira valle del cauca","PALMIRA",
                       ifelse(webN$llegada_ubicacion=="Peru","OTRO",
                       ifelse(webN$llegada_ubicacion=="Perú lima","OTRO",
                       ifelse(webN$llegada_ubicacion=="Puerto berrio Antioquia","PUERTO BERRIO",
                       ifelse(webN$llegada_ubicacion=="Sabana de torres santander","SABANA DE TORRES",
                       ifelse(webN$llegada_ubicacion=="San Marcos Sucre","SAN MARCOS",
                       ifelse(webN$llegada_ubicacion=="San Martin. Departamento El meta","SAN MARTIN",
                       ifelse(webN$llegada_ubicacion=="Santa marta","SANTA MARTA",
                       ifelse(webN$llegada_ubicacion=="Sevilla valles del Cauca","SEVILLA",
                       ifelse(webN$llegada_ubicacion=="Soacha","SOACHA",
                       ifelse(webN$llegada_ubicacion=="Socorro Santander","SOCORRO",
                       ifelse(webN$llegada_ubicacion=="Sogamoso nobsa","SOGAMOSO",
                       ifelse(webN$llegada_ubicacion=="Tunja boyaca","TUNJA",
                       ifelse(webN$llegada_ubicacion=="Villa del Rosario- norte de santander","VILLA DEL ROSARIO",
                       ifelse(webN$llegada_ubicacion=="Villagarzon putumayo","VILLAGARZON",
                       ifelse(webN$llegada_ubicacion=="Villavicencio","VILLAVICENCIO",
                       ifelse(webN$llegada_ubicacion=="Zarzal valle del cauca","ZARZAL",
                       ifelse(webN$llegada_ubicacion=="Risaralda sector el guamito","RISARALDA",webN$llegada_ubicacion)))))))))))))))))))))))))))))))))))))))))))))))))
                              
                      

webN$llegada_ubicacion=ifelse(webN$llegada_ubicacion=="Amaime valle del cauca","AMAIME",
                       ifelse(webN$llegada_ubicacion=="Ivague","IBAGUE",
                       ifelse(webN$llegada_ubicacion=="Magangue bolivar","MAGANGUE",
                       ifelse(webN$llegada_ubicacion=="Pereira Risaralda","PEREIRA",
                       ifelse(webN$llegada_ubicacion=="San Alberto cesar","SAN ALBERTO",
                       ifelse(webN$llegada_ubicacion=="Tolima","TOLIMA",
                       ifelse(webN$llegada_ubicacion=="Yopal Casanare","YOPAL",
                       ifelse(webN$llegada_ubicacion=="En chinacota","CHINACOTA",
                       ifelse(webN$llegada_ubicacion=="Duitama","DUITAMA",
                       ifelse(webN$llegada_ubicacion=="Maicao","MAICAO",
                       ifelse(webN$llegada_ubicacion=="EN BORDO CAUCA","PATIA",
                       ifelse(webN$llegada_ubicacion=="En Chinacota norte de santader","CHINACOTA",
                       ifelse(webN$llegada_ubicacion=="Antioquía","ANTIOQUIA",
                       ifelse(webN$llegada_ubicacion=="Bueno ya guarde tu numero a lo que llegue  mi destino te envió","OTRO",
                       ifelse(webN$llegada_ubicacion=="Dorada Caldas","LA DORADA",
                       ifelse(webN$llegada_ubicacion=="La don juana","OTRO",
                       ifelse(webN$llegada_ubicacion=="Pamplona Norte de Santander","PAMPLONA",
                       ifelse(webN$llegada_ubicacion=="Santiago de chile","OTRO",webN$llegada_ubicacion))))))))))))))))))
                              
webN$llegada_municipio=webN$llegada_ubicacion                       

table(webN$llegada_municipio, useNA = "ifany")
###################llegada departamento###############################

webN$llegada_departamento=ifelse(webN$llegada_municipio=="BOGOTA","BOGOTA",
                          ifelse(webN$llegada_municipio=="BUCARAMANGA","SANTANDER",
                          ifelse(webN$llegada_municipio=="CALI","VALLE DEL CAUCA",
                          ifelse(webN$llegada_municipio=="CUCUTA","NORTE DE SANTANDER",
                          ifelse(webN$llegada_municipio=="NULL","NULL",
                          ifelse(webN$llegada_municipio=="VILLA DEL ROSARIO","NORTE DE SANTANDER", 
                          ifelse(webN$llegada_municipio=="MEDELLIN","ANTIOQUIA",
                          ifelse(webN$llegada_municipio=="SAN JOSE DE PARE","BOYACA",
                          ifelse(webN$llegada_municipio=="GUAYABETAL","CUNDINAMARCA",
                          ifelse(webN$llegada_municipio=="IPIALES","NARINO",
                          ifelse(webN$llegada_municipio=="PASTO","NARINO",
                          ifelse(webN$llegada_municipio=="GUAYABETAL","CUNDINAMARCA", 
                          ifelse(webN$llegada_municipio=="null","NULL", 
                          ifelse(webN$llegada_municipio=="Medellín","ANTIOQUIA",
                          ifelse(webN$llegada_municipio=="PAMPLONA","SANTANDER",
                          ifelse(webN$llegada_municipio=="PEREIRA","RISARALDA",
                          ifelse(webN$llegada_municipio=="TADO","CHOCO",
                          ifelse(webN$llegada_municipio=="TAME","ARAUCA",
                          ifelse(webN$llegada_municipio=="LA UNION","NARINO",
                          ifelse(webN$llegada_municipio=="TAME","ARAUCA",
                          ifelse(webN$llegada_municipio=="SUCRE","ANTIOQUIA",
                          ifelse(webN$llegada_municipio=="HERRERA","TOLIMA",
                          ifelse(webN$llegada_municipio=="NEIVA","HUILA",
                          ifelse(webN$llegada_municipio=="MONTERREY","CASANARE",
                          ifelse(webN$llegada_municipio=="SAN JOSE DE GUAVIARE","GUAVIARE",
                          ifelse(webN$llegada_municipio=="CARTAGENA","BOLIVAR",
                          ifelse(webN$llegada_municipio=="CHINACOTA","NORTE DE SANTANDER",
                          ifelse(webN$llegada_municipio=="PALMIRA","VALLE DEL CAUCA",
                          ifelse(webN$llegada_municipio=="AGUAZUL","CASANARE",
                          ifelse(webN$llegada_municipio=="ALCALA","VALLE DEL CAUCA",
                          ifelse(webN$llegada_municipio=="ARMENIA","QUINDIO",
                          ifelse(webN$llegada_municipio=="BARRANQUILLA","ATLANTICO",
                          ifelse(webN$llegada_municipio=="CERETE","CORDOBA",
                          ifelse(webN$llegada_municipio=="IBAGUE","TOLIMA",
                          ifelse(webN$llegada_municipio=="LA DORADA","CALDAS",
                          ifelse(webN$llegada_municipio=="MELGAR","TOLIMA",
                          ifelse(webN$llegada_municipio=="RIOHACHA","LA GUAJIRA",
                          ifelse(webN$llegada_municipio=="SABANALARGA","ATLANTICO",
                          ifelse(webN$llegada_municipio=="SAN GIL","SANTANDER",
                          ifelse(webN$llegada_municipio=="SOACHA","CUNDINAMARCA",
                          ifelse(webN$llegada_municipio=="VALLEDUPAR","CESAR",
                          ifelse(webN$llegada_municipio=="YOPAL","CASANARE",
                          ifelse(webN$llegada_municipio=="VENTAQUEMADA","BOYACA",
                          ifelse(webN$llegada_municipio=="VILLA GARZON","PUTUMAYO",
                          ifelse(webN$llegada_municipio=="Casanare","CASANARE",
                          ifelse(webN$llegada_municipio=="CANTAGALLO","BOLIVAR",
                          ifelse(webN$llegada_municipio=="CHINCHINA","CALDAS",
                          ifelse(webN$llegada_municipio=="SANTA MARTA","MAGDALENA",
                          ifelse(webN$llegada_municipio=="ESPINAL","TOLIMA",
                          ifelse(webN$llegada_municipio=="PACORA","CALDAS",webN$llegada_municipio))))))))))))))))))))))))))))))))))))))))))))))))))                                                                                                         


webN$llegada_departamento=ifelse(webN$llegada_municipio=="Armenia","QUINDIO",
                          ifelse(webN$llegada_municipio=="ARMENIA","QUINDIO",
                          ifelse(webN$llegada_municipio=="ACACIAS","META",
                          ifelse(webN$llegada_municipio=="AGUACHICA","CESAR",
                          ifelse(webN$llegada_municipio=="APARTADO","ANTIOQUIA",
                          ifelse(webN$llegada_municipio=="BARRANCABERMEJA","SANTANDER",
                          ifelse(webN$llegada_municipio=="BOCHALEMA","NORTE DE SANTANDER",
                          ifelse(webN$llegada_municipio=="BOSCONIA","CESAR",
                          ifelse(webN$llegada_municipio=="BRICENO","CUNDINAMARCA",
                          ifelse(webN$llegada_municipio=="DUITAMA","BOYACA",
                          ifelse(webN$llegada_municipio=="GUATEQUE","BOYACA",
                          ifelse(webN$llegada_municipio=="ITUANGO","ANTIOQUIA",
                          ifelse(webN$llegada_municipio=="LOS PATIOS","NORTE DE SANTANDER",
                          ifelse(webN$llegada_municipio=="MAGANGUE","BOLIVAR",
                          ifelse(webN$llegada_municipio=="MANIZALES","CALDES",
                          ifelse(webN$llegada_municipio=="MONIQUIRA","BOYACA",
                          ifelse(webN$llegada_municipio=="PAIPA","BOYACA",
                          ifelse(webN$llegada_municipio=="PLANADAS","TOLIMA",
                          ifelse(webN$llegada_municipio=="PUERTO BERRIO","ANTIOQUIA",
                          ifelse(webN$llegada_municipio=="PLANADAS","TOLIMA",
                          ifelse(webN$llegada_municipio=="SABANA DE TORRES","SANTANDER",
                          ifelse(webN$llegada_municipio=="SAN MARCOS","SUCRE",
                          ifelse(webN$llegada_municipio=="SAN MARTIN","META",
                          ifelse(webN$llegada_municipio=="SANTANDER DE QUILICHAO","CAUCA",
                          ifelse(webN$llegada_municipio=="SEVILLA","VALLE DEL CAUCA",
                          ifelse(webN$llegada_municipio=="SOCORRO","SANTANDER",
                          ifelse(webN$llegada_municipio=="SOGAMOSO","BOYACA",
                          ifelse(webN$llegada_municipio=="TUNJA","BOYACA",
                          ifelse(webN$llegada_municipio=="VILLAGARZON","PUTUMAYO",
                          ifelse(webN$llegada_municipio=="VILLAVICENCIO","META",
                          ifelse(webN$llegada_municipio=="ZARZAL","VALLE DEL CAUCA",
                          ifelse(webN$llegada_municipio=="AMAIME","VALLE DEL CAUCA",
                          ifelse(webN$llegada_municipio=="SAN ALBERTO","CESAR",
                          ifelse(webN$llegada_municipio=="CALDES","CALDAS",
                          ifelse(webN$llegada_departamento=="PATIA","CAUCA",webN$llegada_departamento)))))))))))))))))))))))))))))))))))

webN$llegada_departamento=ifelse(webN$llegada_departamento=="CALDES","CALDAS", 
                          ifelse(webN$llegada_departamento=="CHINACOTA","NORTE DE SANTANDER",
                          ifelse(webN$llegada_departamento=="DUITAMA","BOYACA",
                          ifelse(webN$llegada_departamento=="MAICAO","LA GUAJIRA",
                          ifelse(webN$llegada_departamento=="PATIA","CAUCA",
                         ifelse(webN$llegada_departamento=="VALLE DE SAN JOSE","SANTANDER",webN$llegada_departamento))))))

table(webN$llegada_departamento, useNA = "ifany")
###################fecha_llegada###################

webN$llegada_fecha_reporte=substr(webN$llegada_fecha_reporte, 1, 10)

webN$llegada_fecha_reporte=parse_date_time(webN$llegada_fecha_reporte, orders = c("ymd", "dmy", "mdy"))
webN$llegada_fecha_reporte=as.Date(webN$llegada_fecha_reporte)


##########fecha_registro########################

webN$fecha_registro=substr(webN$fecha_registro, 1, 10)
webN$fecha_registro=as.Date(webN$fecha_registro)


############# diferencia entre fechas################

webN$diff_fechas = as.numeric(difftime(webN$llegada_fecha_reporte, webN$fecha_registro, units = "days")) 

webN$diff_fechas=as.numeric(webN$diff_fechas)

###################Creacion compartido a y Estado###################
webN$Compartido_a="NULL"
webN$Estado="NULL"



###################Correo electronico, actualizacion tel y y correo ###############################

webN$correo_electronico=webN$correo

webN$datosact_telefono=webN$datos_act_num_contacto

webN$datosact_correo= webN$datos_act_correo



###################Como llego al formulario###############################

webN$como_llego_al_formulario=ifelse(webN$como_llego_al_formulario=="Encontró el enlace en Facebook","Facebook",
                              ifelse(webN$como_llego_al_formulario=="Recibí el enlace por chat","Enlace_chat",
                              ifelse(webN$como_llego_al_formulario=="Recibí un volante en un albergue","Volante",
                              ifelse(webN$como_llego_al_formulario=="Recibí un volante en el albergue","Volante",
                              ifelse(webN$como_llego_al_formulario=="Recibí una manilla con el número","Volante",
                              ifelse(webN$como_llego_al_formulario=="Recibí una foto con la información","Foto",
                              ifelse(webN$como_llego_al_formulario=="Una persona conocida me lo envió para que lo llenara","persona_conocida",
                              ifelse(webN$como_llego_al_formulario=="Ví un pendón en un albergue","pendon",
                              ifelse(webN$como_llego_al_formulario=="Otro","Otro",
                              ifelse(webN$como_llego_al_formulario=="Una persona conocida me lo envió para que lo llenara","persona_conocida","NULL"))))))))))


###################telefono parentesco###############################

webN$parentesco_conocido_destino=ifelse(webN$parentesco_conocido_destino=="otro",webN$otro_parentesco_conocido_destino,webN$parentesco_conocido_destino)

###################creacion de indice ###################

webN$indice=paste0(webN$primer_nombre,webN$primer_apellido,webN$segundo_apellido,
                   webN$numero_documento)

webN$indice=toupper(webN$indice)

removeAccents<-function(x)
{
  a <- c('À', 'Á', 'Â', 'Ã', 'Ä', 'Å', 'Æ', 'Ç', 'È', 'É', 'Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï', 'Ð', 'Ñ', 'Ò', 'Ó', 'Ô', 'Õ', 'Ö', 'Ø', 'Ù', 'Ú', 'Û', 'Ü', 'Ý', 'ß', 'à', 'á', 'â', 'ã', 'ä', 'å', 'æ', 'ç', 'è', 'é', 'ê', 'ë', 'ì', 'í', 'î', 'ï', 'ñ', 'ò', 'ó', 'ô', 'õ', 'ö', 'ø', 'ù', 'ú', 'û', 'ü', 'ý', 'ÿ', 'Ā', 'ā', 'Ă', 'ă', 'Ą', 'ą', 'Ć', 'ć', 'Ĉ', 'ĉ', 'Ċ', 'ċ', 'Č', 'č', 'Ď', 'ď', 'Đ', 'đ', 'Ē', 'ē', 'Ĕ', 'ĕ', 'Ė', 'ė', 'Ę', 'ę', 'Ě', 'ě', 'Ĝ', 'ĝ', 'Ğ', 'ğ', 'Ġ', 'ġ', 'Ģ', 'ģ', 'Ĥ', 'ĥ', 'Ħ', 'ħ', 'Ĩ', 'ĩ', 'Ī', 'ī', 'Ĭ', 'ĭ', 'Į', 'į', 'İ', 'ı', 'Ĳ', 'ĳ', 'Ĵ', 'ĵ', 'Ķ', 'ķ', 'Ĺ', 'ĺ', 'Ļ', 'ļ', 'Ľ', 'ľ', 'Ŀ', 'ŀ', 'Ł', 'ł', 'ŀ','Ń', 'ń', 'Ņ', 'ņ', 'Ň', 'ň', 'ŉ', 'Ō', 'ō', 'Ŏ', 'ŏ', 'Ő', 'ő', 'Œ', 'œ', 'Ŕ', 'ŕ', 'Ŗ', 'ŗ', 'Ř', 'ř', 'Ś', 'ś', 'Ŝ', 'ŝ', 'Ş', 'ş', 'Š', 'š', 'Ţ', 'ţ', 'Ť', 'ť', 'Ŧ', 'ŧ', 'Ũ', 'ũ', 'Ū', 'ū', 'Ŭ', 'ŭ', 'Ů', 'ů', 'Ű', 'ű', 'Ų', 'ų', 'Ŵ', 'ŵ', 'Ŷ', 'ŷ', 'Ÿ', 'Ź', 'ź', 'Ż', 'ż', 'Ž', 'ž', 'ſ', 'ƒ', 'Ơ', 'ơ', 'Ư', 'ư', 'Ǎ', 'ǎ', 'Ǐ', 'ǐ', 'Ǒ', 'ǒ', 'Ǔ', 'ǔ', 'Ǖ', 'ǖ', 'Ǘ', 'ǘ', 'Ǚ', 'ǚ', 'Ǜ', 'ǜ', 'Ǻ', 'ǻ', 'Ǽ', 'ǽ', 'Ǿ', 'ǿ');
  b <- c('A', 'A', 'A', 'A', 'A', 'A', 'AE', 'C', 'E', 'E', 'E', 'E', 'I', 'I', 'I', 'I', 'D', 'N', 'O', 'O', 'O', 'O', 'O', 'O', 'U', 'U', 'U', 'U', 'Y', 's', 'a', 'a', 'a', 'a', 'a', 'a', 'ae', 'c', 'e', 'e', 'e', 'e', 'i', 'i', 'i', 'i', 'n', 'o', 'o', 'o', 'o', 'o', 'o', 'u', 'u', 'u', 'u', 'y', 'y', 'A', 'a', 'A', 'a', 'A', 'a', 'C', 'c', 'C', 'c', 'C', 'c', 'C', 'c', 'D', 'd', 'D', 'd', 'E', 'e', 'E', 'e', 'E', 'e', 'E', 'e', 'E', 'e', 'G', 'g', 'G', 'g', 'G', 'g', 'G', 'g', 'H', 'h', 'H', 'h', 'I', 'i', 'I', 'i', 'I', 'i', 'I', 'i', 'I', 'i', 'IJ', 'ij', 'J', 'j', 'K', 'k', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L','N', 'n', 'N', 'n', 'N', 'n', 'n', 'O', 'o', 'O', 'o', 'O', 'o', 'OE', 'oe', 'R', 'r', 'R', 'r', 'R', 'r', 'S', 's', 'S', 's', 'S', 's', 'S', 's', 'T', 't', 'T', 't', 'T', 't', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'W', 'w', 'Y', 'y', 'Y', 'Z', 'z', 'Z', 'z', 'Z', 'z', 's', 'f', 'O', 'o', 'U', 'u', 'A', 'a', 'I', 'i', 'O', 'o', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'A', 'a', 'AE', 'ae', 'O', 'o');
  for(i in 1:length(a))
  {
    x<-gsub(x = x,pattern = a[i],replacement = b[i])
  }
  return(x)
}

webN$indice=removeAccents(webN$indice)

webN$indice=gsub(" ", "", webN$indice, fixed = TRUE)
webN$indice=gsub("  ", "", webN$indice, fixed = TRUE)
webN$indice=gsub(".", "", webN$indice, fixed = TRUE)
webN$indice=gsub(",", "", webN$indice, fixed = TRUE)
webN$indice=gsub(" , ", "", webN$indice, fixed = TRUE)
webN$indice=gsub(" ", "", webN$indice, fixed = TRUE)


###################Editar sin datos nulos ###################

webN1= webN[!webN$indice=="NULLNULLNULLNULL" & !webN$indice=="NANANANA",]

webN1= webN1[!webN1$indice=="NULLNULLNULLNULL",]

nulos= dim(webN)[1]-dim(webN1)[1]

webN2= webN1[!duplicated(webN1$indice),]


#################################union antiguas bases#################################

#WVI

sheetNames <- excel_sheets(paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","20210710WVI.xlsx"))

for(i in 1:length(sheetNames))
{assign(sheetNames[i],read_excel(paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","20210710WVI.xlsx"),col_types = "text",sheet = i))

}

WVI=rbind.fill(ATLANTICO_WVI,`NORTE DE SANTANDER_WVI`,SANTANDER_WVI)


#IRC

sheetNames <- excel_sheets(paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","20210710IRC.xlsx"))

for(i in 1:length(sheetNames))
{assign(sheetNames[i],read_excel(paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","20210710IRC.xlsx"),col_types = "text",sheet = i))
}

IRC=rbind(ANTIOQUIA_IRC,`NORTE DE SANTANDER_IRC`,CUNDINAMARCA_IRC)



#SC

sheetNames <- excel_sheets(paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","20210710SC.xlsx"))

for(i in 1:length(sheetNames))
{assign(sheetNames[i],read_excel(paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","20210710SC.xlsx"),col_types = "text",sheet = i))
}



SC=rbind(ARAUCA_SC,BOGOTA_SC,GUAJIRA_SC)



#MC

sheetNames <- excel_sheets(paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","20210710MC.xlsx"))

for(i in 1:length(sheetNames))
{assign(sheetNames[i],read_excel(paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","20210710MC.xlsx"),col_types = "text",sheet = i))
}


MC=rbind(ANTIOQUIA_MC,BOLIVAR_MC,CESAR_MC)


#CUA


sheetNames <- excel_sheets(paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","20210710CUA.xlsx"))

for(i in 1:length(sheetNames))
{assign(sheetNames[i],read_excel(paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","20210710CUA.xlsx"),col_types = "text",sheet = i))
}


CUA=rbind(`VALLE DEL CAUCA_CUA`,NARINO_CUA,MAGDALENA_CUA)


#SIN COMPARTIR


sheetNames <- excel_sheets(paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","20210710SINCOMP.xlsx"))

for(i in 1:length(sheetNames))
{assign(sheetNames[i],read_excel(paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","20210710SINCOMP.xlsx"),col_types = "text",sheet = i))
}


#################################Total bases antiguas#################################
Total=dplyr::bind_rows(WVI,MC,IRC,SC,CUA,SinComp)


#################################conversion bases antiguas#################################

Total$fecha_registro=as.Date(as.numeric(Total$fecha_registro), origin = "1899-12-30")
Total$llegada_fecha_reporte=as.Date(as.numeric(Total$llegada_fecha_reporte), origin = "1899-12-30")

Total$indice=paste0(Total$primer_nombre,Total$primer_apellido,Total$segundo_apellido,
                      Total$numero_documento)

Total$indice=toupper(Total$indice)


Total$indice=removeAccents(Total$indice)

Total$indice=toupper(Total$indice)

Total$indice=gsub(" ", "", Total$indice, fixed = TRUE)
Total$indice=gsub("  ", "", Total$indice, fixed = TRUE)
Total$indice=gsub(".", "", Total$indice, fixed = TRUE)
Total$indice=gsub(",", "", Total$indice, fixed = TRUE)
Total$indice=gsub(" , ", "", Total$indice, fixed = TRUE)
Total$indice=gsub(" ", "", Total$indice, fixed = TRUE)



################################pegado bases################################


Total1=merge(Total,webN2, by =c("indice","numero_documento"), all.x = T)


Total1$indice=toupper(Total1$indice)

Total1$indice=removeAccents(Total1$indice)

Total1$indice=toupper(Total1$indice)

Total1$indice=gsub(" ", "", Total1$indice, fixed = TRUE)
Total1$indice=gsub("  ", "", Total1$indice, fixed = TRUE)
Total1$indice=gsub(".", "", Total1$indice, fixed = TRUE)
Total1$indice=gsub(",", "", Total1$indice, fixed = TRUE)
Total1$indice=gsub(" , ", "", Total1$indice, fixed = TRUE)
Total1$indice=gsub(" ", "", Total1$indice, fixed = TRUE)



###TIPO DOCUMENTO

Total1$tipo_documento= if_else(is.na(Total1$tipo_documento.y),Total1$tipo_documento.x,
                                    if_else(Total1$tipo_documento.y=="NULL",Total1$tipo_documento.x,Total1$tipo_documento.y))


Total1$tipo_documento=ifelse(Total1$tipo_documento=="Cédula de Identidad (venezonala)","cedula_identidad_venezolana",
                           ifelse(Total1$tipo_documento=="Cédula de Identidad (venezolana)","cedula_identidad_venezolana",
                                  ifelse(Total1$tipo_documento=="Cédula de Identidad (Venezolana)","cedula_identidad_venezolana",
                                         ifelse(Total1$tipo_documento=="Cédula de ciudadania (colombiana)","cedula_ciudadania_colombiana",
                                                ifelse(Total1$tipo_documento=="Cédula de Ciudadanía (Colombiana)","cedula_ciudadania_colombiana",
                                                       ifelse(Total1$tipo_documento=="null","NULL",
                                                              ifelse(Total1$tipo_documento=="null","NULL",
                                                                     ifelse(Total1$tipo_documento=="Pasaporte","Pasaporte",
                                                                            ifelse(Total1$tipo_documento=="Constancia de Perdida de Documentos","Constancia_perdida_documentos",
                                                                                   ifelse(Total1$tipo_documento=="Constancia de perdida de documentos","Constancia_perdida_documentos",
                                                                                          ifelse(Total1$tipo_documento=="Constancia por perdida de documentos","Constancia_perdida_documentos",
                                                                                                 ifelse(Total1$tipo_documento=="No tengo ningún documento de identidad","Indocumentado",
                                                                                                        ifelse(Total1$tipo_documento=="PARTIDA DE NACIMIENTO","Acta de Nacimiento",
                                                                                                               ifelse(Total1$tipo_documento=="Partida de nacimiento","Acta de Nacimiento",
                                                                                                                      ifelse(Total1$tipo_documento=="Perdida de documento","Indocumentado",
                                                                                                                             ifelse(Total1$tipo_documento=="0","Otro",
                                                                                                                                    ifelse(Total1$tipo_documento=="Niup","Otro",Total1$tipo_documento)))))))))))))))))



####fecha registro

Total1$fecha_registro.y=as.Date(Total1$fecha_registro.y)

Total1$fecha_registro.x=as.Date(Total1$fecha_registro.x)

Total1$fecha_registro= if_else(is.na(Total1$fecha_registro.x),Total1$fecha_registro.y,Total1$fecha_registro.x) 

Total1$fecha_registro= as.Date(Total1$fecha_registro)


####fecha llegada

Total1$llegada_fecha_reporte.x= as.Date(Total1$llegada_fecha_reporte.x)

Total1$llegada_fecha_reporte.y= as.Date(Total1$llegada_fecha_reporte.y)
# 
Total1$llegada_fecha_reporte= if_else(is.na(Total1$llegada_fecha_reporte.y),Total1$llegada_fecha_reporte.x,Total1$llegada_fecha_reporte.y) 
# 



##Diferencia llegada y registro

Total1$diff_fechas=as.numeric(difftime(Total1$llegada_fecha_reporte, Total1$fecha_registro, units = "days")) 



### departamento destino



Total1$departamentoDestino= if_else(is.na(Total1$departamentoDestino.y),Total1$departamentoDestino.x,
                                     if_else(Total1$departamentoDestino.y=="NULL",Total1$departamentoDestino.x,Total1$departamentoDestino.y))



### llegada Departamento


Total1$llegada_departamento= if_else(is.na(Total1$llegada_departamento.y),Total1$llegada_departamento.x,
                                     if_else(Total1$llegada_departamento.y=="NULL",Total1$llegada_departamento.x,Total1$llegada_departamento.y))



### llegada municipio
Total1$llegada_municipio= if_else(is.na(Total1$llegada_municipio.y),Total1$llegada_municipio.x,
                                  if_else(Total1$llegada_municipio.y=="NULL",Total1$llegada_municipio.x,Total1$llegada_municipio.y))

Total1$llegada_municipio= if_else(is.na(Total1$llegada_municipio),"NULL",Total1$llegada_municipio)



Total1$nombre_municipio_destino_final= if_else(is.na(Total1$nombre_municipio_destino_final.y),Total1$nombre_municipio_destino_final.x,
                                               if_else(Total1$nombre_municipio_destino_final.y=="NULL",Total1$nombre_municipio_destino_final.x,Total1$nombre_municipio_destino_final.y))

Total1$nombre_municipio_destino_final= if_else(is.na(Total1$nombre_municipio_destino_final),"NULL",Total1$nombre_municipio_destino_final)




Total1$llegada_num_contacto= if_else(is.na(Total1$llegada_num_contacto.y),Total1$llegada_num_contacto.x,
                                     if_else(Total1$llegada_num_contacto.y=="NULL",Total1$llegada_num_contacto.x,
                                             if_else(Total1$llegada_num_contacto.y=="null",Total1$llegada_num_contacto.x,
                                                     Total1$llegada_num_contacto.y)))

Total1$llegada_num_contacto= if_else(is.na(Total1$llegada_num_contacto),"NULL",Total1$llegada_num_contacto)


#########como_llego_al_formulario


Total1$como_llego_al_formulario=if_else(is.na(Total1$como_llego_al_formulario.y),Total1$como_llego_al_formulario.x,
                                 if_else(Total1$como_llego_al_formulario.y=="NULL",Total1$como_llego_al_formulario.x,Total1$como_llego_al_formulario.y))

# table(Total1$como_llego_al_formulario,useNA = "ifany")

Total1$como_llego_al_formulario= if_else(is.na(Total1$como_llego_al_formulario),"NULL",Total1$como_llego_al_formulario)

Total1$como_llego_al_formulario=ifelse(Total1$como_llego_al_formulario=="Encontró el enlace en Facebook","Facebook",
                                     ifelse(Total1$como_llego_al_formulario=="Recibí el enlace por chat","Enlace_chat",
                                            ifelse(Total1$como_llego_al_formulario=="Recibí un volante en un albergue","Volante",
                                                   ifelse(Total1$como_llego_al_formulario=="Recibí un volante en el albergue","Volante",
                                                          ifelse(Total1$como_llego_al_formulario=="Recibí una manilla con el número","Volante",
                                                          ifelse(Total1$como_llego_al_formulario=="Recibí una foto con la información","Foto",
                                                                 ifelse(Total1$como_llego_al_formulario=="Una persona conocida me lo envió para que lo llenara","persona_conocida",
                                                                        ifelse(Total1$como_llego_al_formulario=="Ví un pendón en un albergue","pendon",
                                                                               ifelse(Total1$como_llego_al_formulario=="Otro","Otro",
                                                                                      ifelse(Total1$como_llego_al_formulario=="Una persona conocida me lo envió para que lo llenara","persona_conocida","NULL"))))))))))


#########como_llego_al_formulario


Total1$como_llego_al_formulario=if_else(is.na(Total1$como_llego_al_formulario.y),Total1$como_llego_al_formulario.x,
                                        if_else(Total1$como_llego_al_formulario.y=="NULL",Total1$como_llego_al_formulario.x,Total1$como_llego_al_formulario.y))

# table(Total1$como_llego_al_formulario,useNA = "ifany")

Total1$como_llego_al_formulario= if_else(is.na(Total1$como_llego_al_formulario),"NULL",Total1$como_llego_al_formulario)

#########linea propia

Total1$linea_contacto_propia.x=as.numeric(Total1$linea_contacto_propia.x)
Total1$linea_contacto_propia.y=as.numeric(Total1$linea_contacto_propia.y)

Total1$linea_contacto_propia=if_else(is.na(Total1$linea_contacto_propia.y),Total1$linea_contacto_propia.x,
                                        if_else(Total1$linea_contacto_propia.y=="NULL",Total1$linea_contacto_propia.x,Total1$linea_contacto_propia.y))


#########linea_asociada_whatsapp

Total1$linea_asociada_whatsapp.x=as.numeric(Total1$linea_asociada_whatsapp.x)
Total1$linea_asociada_whatsapp.y=as.numeric(Total1$linea_asociada_whatsapp.y)
Total1$linea_asociada_whatsapp=if_else(is.na(Total1$linea_asociada_whatsapp.y),Total1$linea_asociada_whatsapp.x,
                                     if_else(Total1$linea_asociada_whatsapp.y=="NULL",Total1$linea_asociada_whatsapp.x,Total1$linea_asociada_whatsapp.y))

#########numero_entregado_venesperanza

Total1$numero_entregado_venesperanza.x=as.numeric(Total1$numero_entregado_venesperanza.x)
Total1$numero_entregado_venesperanza.y=as.numeric(Total1$numero_entregado_venesperanza.y)
Total1$numero_entregado_venesperanza=if_else(is.na(Total1$numero_entregado_venesperanza.y),Total1$numero_entregado_venesperanza.x,
                                       if_else(Total1$numero_entregado_venesperanza.y=="NULL",Total1$numero_entregado_venesperanza.x,Total1$numero_entregado_venesperanza.y))


#########correo_electronico

Total1$correo_electronico=if_else(is.na(Total1$correo_electronico.y),Total1$correo_electronico.x,
                                             if_else(Total1$correo_electronico.y=="NULL",Total1$correo_electronico.x,Total1$correo_electronico.y))


#########latitud


Total1$latitud=if_else(is.na(Total1$latitud.y),Total1$latitud.x,
                                  if_else(Total1$latitud.y=="NULL",Total1$latitud.x,Total1$latitud.y))



#########longitud

Total1$longitud=if_else(is.na(Total1$longitud.y),Total1$longitud.x,
                       if_else(Total1$longitud.y=="NULL",Total1$longitud.x,Total1$longitud.y))


#########numero_contacto

Total1$numero_contacto=if_else(is.na(Total1$numero_contacto.y),Total1$numero_contacto.x,
                        if_else(Total1$numero_contacto.y=="NULL",Total1$numero_contacto.x,Total1$numero_contacto.y))



#########numero_contacto

Total1$datos_act_num_contacto=if_else(is.na(Total1$datos_act_num_contacto.y),Total1$datos_act_num_contacto.x,
                               if_else(Total1$datos_act_num_contacto.y=="NULL",Total1$datos_act_num_contacto.x,Total1$datos_act_num_contacto.y))


#########ORG

Total1$ORG_REGISTRO=if_else(is.na(Total1$ORG_REGISTRO.y),Total1$ORG_REGISTRO.x,
                               if_else(Total1$ORG_REGISTRO.y=="NULL",Total1$ORG_REGISTRO.x,Total1$ORG_REGISTRO.y))

#########datos actu telefono

Total1$datosact_telefono.x=as.character(Total1$datosact_telefono.x)
Total1$datosact_telefono.y=as.character(Total1$datosact_telefono.y)
Total1$datosact_telefono.x= if_else(is.na(Total1$datosact_telefono.x),"NULL",Total1$datosact_telefono.x)
Total1$datosact_telefono.y= if_else(is.na(Total1$datosact_telefono.y),"NULL",Total1$datosact_telefono.y)

Total1$datosact_telefono= if_else(Total1$datosact_telefono.y=="NULL",Total1$datosact_telefono.x,
                                  if_else(Total1$datosact_telefono.y=="null",Total1$datosact_telefono.x,Total1$datosact_telefono.y))

Total1$datosact_telefono= if_else(is.na(Total1$datosact_telefono),"NULL",Total1$datosact_telefono)

### actualización correo

Total1$datos_act_correo.x= if_else(is.na(Total1$datos_act_correo.x),"NULL",Total1$datos_act_correo.x)
Total1$datos_act_correo.y= if_else(is.na(Total1$datos_act_correo.y),"NULL",Total1$datos_act_correo.y)


Total1$datos_act_correo= if_else(Total1$datos_act_correo.y=="NULL",Total1$datos_act_correo.x,
                                 if_else(Total1$datos_act_correo.y=="null",Total1$datos_act_correo.x,Total1$datos_act_correo.y))

Total1$datos_act_correo= if_else(is.na(Total1$datos_act_correo),"NULL",Total1$datos_act_correo)


#####Actualizacion

Total1$Act1=paste0(Total1$datosact_telefono,
                   Total1$datos_act_correo)


Total1$Actualizacion1= ifelse(Total1$Act1== "NULLNULL","SinActualizar","Actualizado")


Total1$Actualizacion2=ifelse(Total1$Actualizacion1=="Actualizado","Actualizado",
                                    ifelse(Total1$Actualizacion1=="SinActualizar" & !is.na(Total1$fecha_actualizacion),"Nuevo",Total1$Actualizacion1))

Total1$Actualizacion=Total1$Actualizacion2


#########Estado
Total1$Estado= Total1$Estado.x

#########Compartido_a
Total1$Compartido_a= Total1$Compartido_a.x

#########Fuente

Total1$fuente=ifelse(is.na(Total1$fuente.x) & Total1$fuente.y=="NULL",Total1$fuente.y,
                     ifelse(is.na(Total1$fuente.x) & is.na(Total1$fuente.y),Total1$fuente.y,
                            ifelse(Total1$fuente.x== "NULL" & Total1$fuente.y== "NULL",Total1$fuente.y,Total1$fuente.x)))

#########Fecha actualización

Total1$fecha_actualizacion=ifelse(is.na(Total1$fecha_actualizacion) & Total1$Actualizacion=="Actualizado","Nov10",
                                  ifelse(is.na(Total1$fecha_actualizacion) & Total1$Actualizacion=="Nuevo","Nov10",Total1$fecha_actualizacion))

######municipio

Total1$nombre_municipio_destino_final.x= if_else(is.na(Total1$nombre_municipio_destino_final.x),"NULL",Total1$nombre_municipio_destino_final.x)
Total1$nombre_municipio_destino_final.y= if_else(is.na(Total1$nombre_municipio_destino_final.y),"NULL",Total1$nombre_municipio_destino_final.y)


Total1$nombre_municipio_destino_final= if_else(Total1$nombre_municipio_destino_final.y=="NULL",Total1$nombre_municipio_destino_final.x,
                                               if_else(Total1$nombre_municipio_destino_final.y=="null",Total1$nombre_municipio_destino_final.x,Total1$nombre_municipio_destino_final.y))

Total1$nombre_municipio_destino_final= if_else(is.na(Total1$nombre_municipio_destino_final),"NULL",Total1$nombre_municipio_destino_final)



######municipio Departamento Destino

Total1$departamentoDestino= if_else(is.na(Total1$llegada_departamento),Total1$departamentoDestino,
                                     if_else(Total1$llegada_departamento=="NULL",Total1$departamentoDestino,Total1$llegada_departamento))

Total1$departamentoDestino= if_else(is.na(Total1$departamentoDestino),"NULL",Total1$departamentoDestino)


table(Total1$departamentoDestino,Total1$Compartido_a,useNA = "ifany")

###### nombre municipio destino final

Total1$nombre_municipio_destino_final.x= if_else(is.na(Total1$nombre_municipio_destino_final.x),"NULL",Total1$nombre_municipio_destino_final.x)
Total1$nombre_municipio_destino_final.y= if_else(is.na(Total1$nombre_municipio_destino_final.y),"NULL",Total1$nombre_municipio_destino_final.y)


Total1$nombre_municipio_destino_final= if_else(Total1$nombre_municipio_destino_final.y=="NULL",Total1$nombre_municipio_destino_final.x,
                                       if_else(Total1$nombre_municipio_destino_final.y=="null",Total1$nombre_municipio_destino_final.x,Total1$nombre_municipio_destino_final.y))

Total1$nombre_municipio_destino_final= if_else(is.na(Total1$nombre_municipio_destino_final),"NULL",Total1$nombre_municipio_destino_final)

Total1$nombre_municipio_destino_final= if_else(is.na(Total1$llegada_municipio),Total1$nombre_municipio_destino_final,
                                               if_else(Total1$llegada_municipio=="NULL",Total1$nombre_municipio_destino_final,Total1$llegada_municipio))

Total1$nombre_municipio_destino_final=ifelse(Total1$nombre_municipio_destino_final=="Bogotá","BOGOTA",
                                      ifelse(Total1$nombre_municipio_destino_final=="Bucaramanga","BUCARAMANGA",
                                      ifelse(Total1$nombre_municipio_destino_final=="Cali","CALI",
                                      ifelse(Total1$nombre_municipio_destino_final=="Cúcuta","CUCUTA",
                                      ifelse(Total1$nombre_municipio_destino_final=="Cucuta","CUCUTA",
                                      ifelse(Total1$nombre_municipio_destino_final=="Barranquilla","BARRANQUILLA", 
                                      ifelse(Total1$nombre_municipio_destino_final=="Medellín","MEDELLIN",
                                      ifelse(Total1$nombre_municipio_destino_final=="Medellin","MEDELLIN",
                                      ifelse(Total1$nombre_municipio_destino_final=="No estoy seguro/a","NoSeguro",
                                      ifelse(Total1$nombre_municipio_destino_final=="null","NULL",
                                      ifelse(Total1$nombre_municipio_destino_final=="Arauca","ARAUCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="Cartagena","CARTAGENA",
                                      ifelse(Total1$nombre_municipio_destino_final=="Pasto","PASTO",
                                      ifelse(Total1$nombre_municipio_destino_final=="Valledupar","VALLEDUPAR",
                                      ifelse(Total1$nombre_municipio_destino_final=="Sucre Antioquía Olaya","SUCRE", 
                                      ifelse(Total1$nombre_municipio_destino_final=="Riohacha","RIOHACHA",
                                      ifelse(Total1$nombre_municipio_destino_final=="AGUA CHICA","AGUACHICA",
                                      ifelse(Total1$nombre_municipio_destino_final=="AGUA CHICA. CESAR","AGUACHICA",
                                      ifelse(Total1$nombre_municipio_destino_final=="ALMENIA","ARMENIA",
                                      ifelse(Total1$nombre_municipio_destino_final=="ARMENIA, MONTENEGRO","ARMENIA",
                                      ifelse(Total1$nombre_municipio_destino_final=="CALARCA/ ARMENIA","CALARCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="CHIQUINQUIRA CUNDINAMARCA","CHIQUINQUIRA",
                                      ifelse(Total1$nombre_municipio_destino_final=="MANIZALEZ","MANIZALES", 
                                      ifelse(Total1$nombre_municipio_destino_final=="PANTE- CUNDINAMARCA","PANDI", 
                                      ifelse(Total1$nombre_municipio_destino_final=="PANTE. CUNDINAMARCA","PANDI",
                                      ifelse(Total1$nombre_municipio_destino_final=="SANTA ANA DE BOYACA","SANTANA",
                                      ifelse(Total1$nombre_municipio_destino_final=="SANTA MARTHA","SANTA MARTA",
                                      ifelse(Total1$nombre_municipio_destino_final=="YOPAL, CASANARE","YOPAL",
                                      ifelse(Total1$nombre_municipio_destino_final=="SAN ANTERO CORDOBA","SAN ANTERO",
                                      ifelse(Total1$nombre_municipio_destino_final=="SAN JOSE DE GUAVIARE","SAN JOSE DEL GUAVIARE",
                                      ifelse(Total1$nombre_municipio_destino_final=="Municipio Valle  de San José  verdad Cerro de Mango finca La Montaña","VALLE DE SAN JOSE",
                                      Total1$nombre_municipio_destino_final))))))))))))))))))))))))))))))) 


###### actualización departamento destino

Total1$departamentoDestino=ifelse(Total1$nombre_municipio_destino_final=="ACACIAS","META",
                                      ifelse(Total1$nombre_municipio_destino_final=="AGUACHICA","CESAR",
                                      ifelse(Total1$nombre_municipio_destino_final=="ALCALA","VALLE DEL CAUCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="APARTADO","ANTIOQUIA",
                                      ifelse(Total1$nombre_municipio_destino_final=="ARMENIA","QUINDIO",
                                      ifelse(Total1$nombre_municipio_destino_final=="ARAUCA","ARAUCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="BARRANCABERMEJA","SANTANDER", 
                                      ifelse(Total1$nombre_municipio_destino_final=="BARRANQUILLA","ATLANTICO",
                                      ifelse(Total1$nombre_municipio_destino_final=="BOCHALEMA","NORTE DE SANTANDER",
                                      ifelse(Total1$nombre_municipio_destino_final=="BOGOTA","BOGOTA",
                                      ifelse(Total1$nombre_municipio_destino_final=="BOSCONIA","CESAR",
                                      ifelse(Total1$nombre_municipio_destino_final=="BOYACA","BOYACA",
                                      ifelse(Total1$nombre_municipio_destino_final=="BRICENO","CUNDINAMARCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="BUCARAMANGA","SANTANDER",
                                      ifelse(Total1$nombre_municipio_destino_final=="CALARCA","QUINDIO",
                                      ifelse(Total1$nombre_municipio_destino_final=="CALI","VALLE DEL CAUCA", 
                                      ifelse(Total1$nombre_municipio_destino_final=="CALIMA","VALLE DEL CAUCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="CANTAGALLO","BOLIVAR",
                                      ifelse(Total1$nombre_municipio_destino_final=="CARTAGENA","BOLIVAR",
                                      ifelse(Total1$nombre_municipio_destino_final=="CASANARE","CASANARE",
                                      ifelse(Total1$nombre_municipio_destino_final=="CERETE","CORDOBA",
                                      ifelse(Total1$nombre_municipio_destino_final=="CHINACOTA","NORTE DE SANTANDER",
                                      ifelse(Total1$nombre_municipio_destino_final=="CHINCHINA","CALDAS",
                                      ifelse(Total1$nombre_municipio_destino_final=="CHIQUINQUIRA","BOYACA", 
                                      ifelse(Total1$nombre_municipio_destino_final=="CUCUTA","NORTE DE SANTANDER", 
                                      ifelse(Total1$nombre_municipio_destino_final=="DUITAMA","BOYACA",
                                      ifelse(Total1$nombre_municipio_destino_final=="ESPINAL","TOLIMA",
                                      ifelse(Total1$nombre_municipio_destino_final=="FLORIDABLANCA","SANTANDER",
                                      ifelse(Total1$nombre_municipio_destino_final=="GUATEQUE","BOYACA",
                                      ifelse(Total1$nombre_municipio_destino_final=="HERRERA","TOLIMA",
                                      ifelse(Total1$nombre_municipio_destino_final=="HUILA","HUILA",
                                      ifelse(Total1$nombre_municipio_destino_final=="IBAGUE","TOLIMA",
                                      ifelse(Total1$nombre_municipio_destino_final=="IPIALES","NARINO",
                                      ifelse(Total1$nombre_municipio_destino_final=="LA DORADA","CALDAS",
                                      ifelse(Total1$nombre_municipio_destino_final=="LA UNION","VALLE DEL CAUCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="LA VICTORIA","VALLE DEL CAUCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="LOS PATIOS","NORTE DE SANTANDER",
                                      ifelse(Total1$nombre_municipio_destino_final=="MAGANGUE","MAGDALENA",
                                      ifelse(Total1$nombre_municipio_destino_final=="MAICAO","LA GUAJIRA",
                                      ifelse(Total1$nombre_municipio_destino_final=="MALAGA","SANTANDER",
                                      ifelse(Total1$nombre_municipio_destino_final=="MANIZALES","CALDAS",
                                      ifelse(Total1$nombre_municipio_destino_final=="MEDELLIN","ANTIOQUIA",
                                      ifelse(Total1$nombre_municipio_destino_final=="MONIQUIRA","BOYACA",
                                      ifelse(Total1$nombre_municipio_destino_final=="NEIVA","HUILA",
                                      ifelse(Total1$nombre_municipio_destino_final=="PACORA","CALDAS",
                                      ifelse(Total1$nombre_municipio_destino_final=="PAIPA","BOYACA",
                                      ifelse(Total1$nombre_municipio_destino_final=="PALMIRA","VALLE DEL CAUCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="PAMPLONA","NORTE DE SANTANDER",
                                      ifelse(Total1$nombre_municipio_destino_final)))))))))))))))))))))))))))))))))))))))))))))))))
                                  
                                  
Total1$departamentoDestino=ifelse(Total1$nombre_municipio_destino_final=="PANDI","CUNDINAMARCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="PATIA","CAUCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="PASTO","NARINO",
                                      ifelse(Total1$nombre_municipio_destino_final=="PEREIRA","RISARALDA",
                                      ifelse(Total1$nombre_municipio_destino_final=="PLANADAS","TOLIMA",
                                      ifelse(Total1$nombre_municipio_destino_final=="POPAYAN","CAUCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="PUERTO","OTRO",
                                      ifelse(Total1$nombre_municipio_destino_final=="PUERTO BERRIO","ANTIOQUIA",
                                      ifelse(Total1$nombre_municipio_destino_final=="PUERTO WILCHES","SANTANDER",
                                      ifelse(Total1$nombre_municipio_destino_final=="PUTUMAYO","PUTUMAYO",
                                      ifelse(Total1$nombre_municipio_destino_final=="RIOHACHA","LA GUAJIRA",
                                      ifelse(Total1$nombre_municipio_destino_final=="RISARALDA","RISARALDA",
                                      ifelse(Total1$nombre_municipio_destino_final=="SABANA DE TORRES","SANTANDER",
                                      ifelse(Total1$nombre_municipio_destino_final=="SAN ALBERTO","CESAR",
                                      ifelse(Total1$nombre_municipio_destino_final=="SAN ANTERO","CORDOBA",
                                      ifelse(Total1$nombre_municipio_destino_final=="SAN GIL","SANTANDER",
                                      ifelse(Total1$nombre_municipio_destino_final=="RIOHACHA","LA GUAJIRA",
                                      ifelse(Total1$nombre_municipio_destino_final=="SAN JOSE DEL GUAVIARE","GUAVIARE",
                                      ifelse(Total1$nombre_municipio_destino_final=="SAN JOSE DE PARE","BOYACA",
                                      ifelse(Total1$nombre_municipio_destino_final=="SAN JUAN DE RIO SECO","CUNDINAMARCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="SAN MARTIN","META",
                                      ifelse(Total1$nombre_municipio_destino_final=="SANTA MARTA","MAGDALENA",
                                      ifelse(Total1$nombre_municipio_destino_final=="SANTANA","BOYACA",
                                      ifelse(Total1$nombre_municipio_destino_final=="SANTANDER DE QUILICHAO","CAUCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="SEVILLA","VALLE DEL CAUCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="SOACHA","CUNDINAMARCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="SOCORRO","SANTANDER",
                                      ifelse(Total1$nombre_municipio_destino_final=="SOGAMOSO","BOYACA",
                                      ifelse(Total1$nombre_municipio_destino_final=="SUCRE","SUCRE",
                                      ifelse(Total1$nombre_municipio_destino_final=="TADO","CHOCO",
                                      ifelse(Total1$nombre_municipio_destino_final=="TAME","ARAUCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="TUNJA","BOYACA",
                                      ifelse(Total1$nombre_municipio_destino_final=="VALLE DE SAN JOSE","SANTANDER",
                                      ifelse(Total1$nombre_municipio_destino_final=="VALLEDUPAR","CESAR",
                                      ifelse(Total1$nombre_municipio_destino_final=="VENTAQUEMADA","BOYACA",
                                      ifelse(Total1$nombre_municipio_destino_final=="VILLA DEL ROSARIO","NORTE DE SANTANDER",
                                      ifelse(Total1$nombre_municipio_destino_final=="VILLAGARZON","PUTUMAYO",
                                      ifelse(Total1$nombre_municipio_destino_final=="VILLAVICENCIO","META",
                                      ifelse(Total1$nombre_municipio_destino_final=="YOPAL","CASANARE",
                                      ifelse(Total1$nombre_municipio_destino_final=="ZARZAL","VALLE DEL CAUCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="GUAYABETAL","CUNDINAMARCA",
                                      ifelse(Total1$nombre_municipio_destino_final=="SAN JOSE DEL GUAVIARE","GUAVIARE",
                                      ifelse(Total1$nombre_municipio_destino_final=="TOLIMA","TOLIMA",
                                      ifelse(Total1$nombre_municipio_destino_final=="NULL","OTRO",Total1$departamentoDestino))))))))))))))))))))))))))))))))))))))))))))  

Total1$departamentoDestino= if_else(is.na(Total1$departamentoDestino),"OTRO",Total1$departamentoDestino)



Total1$Compartido_a= ifelse(Total1$departamentoDestino=="ARAUCA","SC",
                            ifelse(Total1$departamentoDestino=="ATLANTICO","WVI",
                                   ifelse(Total1$departamentoDestino=="BOGOTA","SC",
                                          ifelse(Total1$departamentoDestino=="LA GUAJIRA","SC",
                                                 ifelse(Total1$departamentoDestino=="NULL","SinComp",
                                                        ifelse(Total1$departamentoDestino=="SANTANDER","WVI",
                                                               ifelse(Total1$departamentoDestino=="CUNDINAMARCA","IRC",
                                                                      ifelse(Total1$departamentoDestino=="ANTIOQUIA" & Total1$Compartido_a=="IRC","IRC",
                                                                             ifelse(Total1$departamentoDestino=="ANTIOQUIA" & Total1$Compartido_a=="MC","MC",
                                                                                    ifelse(Total1$departamentoDestino=="NORTE DE SANTANDER" & Total1$Compartido_a=="WVI","WVI",  
                                                                                           ifelse(Total1$departamentoDestino=="NORTE DE SANTANDER" & Total1$Compartido_a=="IRC","IRC",
                                                                                                  ifelse(Total1$departamentoDestino=="NORTE DE SANTANDER" & Total1$Compartido_a=="MC","IRC",
                                                                                                         ifelse(Total1$departamentoDestino=="CUNDINAMARCA","IRC",      
                                                                                                                ifelse(Total1$departamentoDestino=="VALLE DEL CAUCA","CUA",
                                                                                                                       ifelse(Total1$departamentoDestino=="SANTANDER","WVI",
                                                                                                                              ifelse(Total1$departamentoDestino=="MAGDALENA","CUA",
                                                                                                                                     ifelse(Total1$departamentoDestino=="NARINO","CUA",
                                                                                                                                            ifelse(Total1$departamentoDestino=="NORTE DE SANTANDER"& Total1$Compartido_a=="CUA","IRC",
                                                                                                                                                   ifelse(Total1$departamentoDestino=="NORTE DE SANTANDER"& Total1$Compartido_a=="SC","IRC",
                                                                                                                                                          ifelse(Total1$departamentoDestino=="NORTE DE SANTANDER"& Total1$Compartido_a=="SinComp","IRC",
                                                                                                                                                                 ifelse(Total1$departamentoDestino=="NORTE DE SANTANDER"& is.na(Total1$Compartido_a),"IRC",
                                                                                                                                                                        ifelse(Total1$departamentoDestino=="BOLIVAR","MC",
                                                                                                                                                                               ifelse(Total1$departamentoDestino=="CESAR","MC",
                                                                                                                                                                                      ifelse(Total1$departamentoDestino=="ANTIOQUIA"& Total1$Compartido_a=="WVI","MC",
                                                                                                                                                                                             ifelse(Total1$departamentoDestino=="ANTIOQUIA"& Total1$Compartido_a=="SC","MC",
                                                                                                                                                                                                    ifelse(Total1$departamentoDestino=="ANTIOQUIA"& Total1$Compartido_a=="CUA","MC",
                                                                                                                                                                                                    ifelse(Total1$departamentoDestino=="ANTIOQUIA"& Total1$Compartido_a=="SinComp","MC",
                                                                                                                                                                                                           ifelse(Total1$departamentoDestino=="ANTIOQUIA"& is.na(Total1$Compartido_a),"MC",
                                                                                                                                                                                                                  ifelse(Total1$departamentoDestino=="CESAR","MC",
                                                                                                                                                                                                                         ifelse(Total1$departamentoDestino=="NULL","SinComp",
                                                                                                                                                                                                                                ifelse(Total1$departamentoDestino%in% c("BOYACA","CALDAS","CASANARE","TOLIMA","CHOCO","GUAVIARE","META","Otro","OTRO","QUINDIO","CAUCA","PUTUMAYO","RISARALDA","NoSeguro","NULL"),"SinComp",Total1$Compartido_a)))))))))))))))))))))))))))))))

Total1$Compartido_a= if_else(Total1$departamentoDestino=="ANTIOQUIA"& is.na(Total1$Compartido_a),"MC",
                             if_else(Total1$departamentoDestino=="NORTE DE SANTANDER"& is.na(Total1$Compartido_a),"IRC",Total1$Compartido_a)) 


Total1$Compartido_a= if_else(Total1$departamentoDestino=="NORTE DE SANTANDER" & Total1$nombre_municipio_destino_final=="CUCUTA","IRC",
                             if_else(Total1$departamentoDestino=="NORTE DE SANTANDER" & Total1$nombre_municipio_destino_final!="CUCUTA","WVI",Total1$Compartido_a))


table(Total1$nombre_municipio_destino_final, Total1$Compartido_a, useNA = "ifany")


table(Total1$departamentoDestino,Total1$Compartido_a,useNA = "ifany")



### telefono_conocido_destino

Total1$telefono_conocido_destino.x= if_else(is.na(Total1$telefono_conocido_destino.x),"NULL",Total1$telefono_conocido_destino.x)
Total1$telefono_conocido_destino.y= if_else(is.na(Total1$telefono_conocido_destino.y),"NULL",Total1$telefono_conocido_destino.y)


Total1$telefono_conocido_destino= if_else(Total1$telefono_conocido_destino.y=="NULL",Total1$telefono_conocido_destino.x,
                                 if_else(Total1$telefono_conocido_destino.y=="null",Total1$telefono_conocido_destino.x,Total1$telefono_conocido_destino.y))

Total1$telefono_conocido_destino= if_else(is.na(Total1$telefono_conocido_destino),"NULL",Total1$telefono_conocido_destino)

table(Total1$telefono_conocido_destino, useNA = "ifany")

### parentesco_conocido_destino

Total1$parentesco_conocido_destino.x= if_else(is.na(Total1$parentesco_conocido_destino.x),"NULL",Total1$parentesco_conocido_destino.x)
Total1$parentesco_conocido_destino.y= if_else(is.na(Total1$parentesco_conocido_destino.y),"NULL",Total1$parentesco_conocido_destino.y)


Total1$parentesco_conocido_destino= if_else(Total1$parentesco_conocido_destino.y=="NULL",Total1$parentesco_conocido_destino.x,
                                          if_else(Total1$parentesco_conocido_destino.y=="null",Total1$parentesco_conocido_destino.x,Total1$parentesco_conocido_destino.y))

Total1$parentesco_conocido_destino= if_else(is.na(Total1$parentesco_conocido_destino),"NULL",Total1$parentesco_conocido_destino)

table(Total1$parentesco_conocido_destino, useNA = "ifany")


Total1$parentesco_conocido_destino=if_else(Total1$parentesco_conocido_destino=="amigo","Amigo",
                                           if_else(Total1$parentesco_conocido_destino=="c_nyuge","Conyugue",
                                                   if_else(Total1$parentesco_conocido_destino=="Cónyuge","Conyugue",
                                                           if_else(Total1$parentesco_conocido_destino=="hijo_a","Hijo/a",
                                                                   if_else(Total1$parentesco_conocido_destino=="null","NULL",
                                                                           if_else(Total1$parentesco_conocido_destino=="otro","Otro",
                                                                                   if_else(Total1$parentesco_conocido_destino=="padre_madre","Padre/madre",
                                                                                           if_else(Total1$parentesco_conocido_destino=="conocido","Conocido",Total1$parentesco_conocido_destino))))))))


Total2= Total1[,c("departamentoDestino",'indice','primer_nombre.x','segundo_nombre.x','primer_apellido.x','segundo_apellido.x',
              'tipo_documento','numero_documento','como_llego_al_formulario',
              'numero_contacto','linea_contacto_propia','linea_asociada_whatsapp',
              'correo_electronico','fecha_llegada_pais.x',"fuente","tipo",'nombre_municipio_destino_final',
              'fecha_registro',"llegada_fecha_reporte","latitud","longitud","diff_fechas",
              "numero_entregado_venesperanza","llegada_departamento",'llegada_municipio',"llegada_num_contacto",'datos_act_num_contacto','datos_act_correo',
              "datosact_telefono","telefono_conocido_destino","parentesco_conocido_destino","ORG_REGISTRO",'Compartido_a','Estado',"Observaciones",'Actualizacion',"fecha_actualizacion")]

names(Total2)= c("departamentoDestino",'indice','primer_nombre','segundo_nombre','primer_apellido','segundo_apellido',
               'tipo_documento',"numero_documento",'como_llego_al_formulario',
               'numero_contacto','linea_contacto_propia','linea_asociada_whatsapp',
               'correo_electronico','fecha_llegada_pais','fuente',"tipo",'nombre_municipio_destino_final',
               'fecha_registro',"llegada_fecha_reporte","latitud","longitud","diff_fechas","numero_entregado_venesperanza",'llegada_departamento','llegada_municipio',"llegada_num_contacto",
               'datos_act_num_contacto','datos_act_correo',"datosact_telefono","telefono_conocido_destino","parentesco_conocido_destino","ORG_REGISTRO",
               'Compartido_a','Estado',"Observaciones",'Actualizacion',"fecha_actualizacion")


#################################### nuevos datos

sobra=webN2[!(webN2$indice %in% Total2$indice),]

sobra=sobra[!duplicated(sobra$indice),]

ANTIOQUIA=sobra[sobra$departamentoDestino=="ANTIOQUIA",] 

library(caTools)
set.seed(150)
split = sample.split(ANTIOQUIA$indice, SplitRatio = 0.50)
# Create training and testing sets
Antioquia_MC = subset(ANTIOQUIA, split == TRUE)
Antioquia_IRC = subset(ANTIOQUIA, split == FALSE)

NORTE=sobra[sobra$departamentoDestino=="NORTE DE SANTANDER",] 
split = sample.split(NORTE$indice, SplitRatio = 0.50)
# Create training and testing sets
NORTE_WVI = subset(NORTE, split == TRUE)
NORTE_IRC = subset(NORTE, split == FALSE)

NORTE_WVI$`Estado-WV` =" "
NORTE_WVI$Estado =" "
NORTE_WVI$Compartido_a ="WVI"
NORTE_WVI$Actualizacion ="Nuevo"

NORTE_IRC$Estado =" "
NORTE_IRC$Compartido_a ="IRC"
NORTE_IRC$Actualizacion ="Nuevo"

Antioquia_IRC$Estado =" "
Antioquia_IRC$Compartido_a ="IRC"
Antioquia_IRC$Actualizacion ="Nuevo"

Antioquia_MC$Estado =" "
Antioquia_MC$Compartido_a ="MC"
Antioquia_MC$Actualizacion ="Nuevo"


sob=dplyr::bind_rows(NORTE_WVI,NORTE_IRC,Antioquia_IRC,Antioquia_MC)
# sob=dplyr::bind_rows(Antioquia_IRC,Antioquia_MC)
names(sob)

sobra1=merge(sobra,sob[,c(8,41,36,37)], by=c("indice","numero_documento"), all.x=T)


sobra1$Compartido_a=ifelse(is.na(sobra1$Compartido_a.x),sobra1$Compartido_a.y,
                           ifelse(sobra1$Compartido_a.x=="NULL",sobra1$Compartido_a.y,sobra1$Compartido_a.x))
sobra1$Estado =" "
sobra1$Actualizacion ="Nuevo"

sobra1$Compartido_a= ifelse(sobra1$departamentoDestino=="ARAUCA","SC",
                            ifelse(sobra1$departamentoDestino=="ATLANTICO","WVI",
                                   ifelse(sobra1$departamentoDestino=="BOGOTA","SC",
                                          ifelse(sobra1$departamentoDestino=="BOGOTA","SC",
                                                 ifelse(sobra1$departamentoDestino=="LA GUAJIRA","SC",
                                                        ifelse(sobra1$departamentoDestino=="NULL","SinComp",
                                                               ifelse(sobra1$departamentoDestino=="SANTANDER","WVI",
                                                                      ifelse(sobra1$departamentoDestino=="CUNDINAMARCA","IRC",
                                                                             ifelse(sobra1$departamentoDestino=="ANTIOQUIA" & sobra1$Compartido_a=="IRC","IRC",
                                                                                    ifelse(sobra1$departamentoDestino=="ANTIOQUIA" & sobra1$Compartido_a=="MC","MC",
                                                                                           ifelse(sobra1$departamentoDestino=="NORTE DE SANTANDER" & sobra1$nombre_municipio_destino_final=="CUCUTA","IRC",  
                                                                                                  ifelse(sobra1$departamentoDestino=="NORTE DE SANTANDER" & sobra1$nombre_municipio_destino_final!="CUCUTA","WVI",
                                                                                                         ifelse(sobra1$departamentoDestino=="NORTE DE SANTANDER" & sobra1$Compartido_a=="MC","IRC",
                                                                                                                ifelse(sobra1$departamentoDestino=="CUNDINAMARCA","IRC",      
                                                                                                                       ifelse(sobra1$departamentoDestino=="VALLE DEL CAUCA","CUA",
                                                                                                                              ifelse(sobra1$departamentoDestino=="SANTANDER","WVI",
                                                                                                                                     ifelse(sobra1$departamentoDestino=="MAGDALENA","CUA",
                                                                                                                                            ifelse(sobra1$departamentoDestino=="NARINO","CUA",
                                                                                                                                                   ifelse(sobra1$departamentoDestino=="NORTE DE SANTANDER"& sobra1$Compartido_a=="CUA","IRC",
                                                                                                                                                          ifelse(sobra1$departamentoDestino=="NORTE DE SANTANDER"& sobra1$Compartido_a=="SC","IRC",
                                                                                                                                                                 ifelse(sobra1$departamentoDestino=="NORTE DE SANTANDER"& sobra1$Compartido_a=="SinComp","IRC",
                                                                                                                                                                        ifelse(sobra1$departamentoDestino=="BOLIVAR","MC",
                                                                                                                                                                               ifelse(sobra1$departamentoDestino=="CESAR","MC",
                                                                                                                                                                                      ifelse(sobra1$departamentoDestino=="ANTIOQUIA"& sobra1$Compartido_a=="WVI","MC",
                                                                                                                                                                                             ifelse(sobra1$departamentoDestino=="ANTIOQUIA"& sobra1$Compartido_a=="SC","MC",
                                                                                                                                                                                                    ifelse(sobra1$departamentoDestino=="ANTIOQUIA"& sobra1$Compartido_a=="SinComp","MC",
                                                                                                                                                                                                           ifelse(sobra1$departamentoDestino=="CESAR","MC",
                                                                                                                                                                                                                  ifelse(sobra1$departamentoDestino%in% c("BOYACA","CALDAS","CASANARE","CHOCO","META","GUAVIARE","TOLIMA","Otro","OTRO","QUINDIO","CAUCA","PUTUMAYO","RISARALDA","NoSeguro","NULL","OTRO"),"SinComp",sobra1$Compartido_a))))))))))))))))))))))))))))














####PEGADO CON DATOS NUEVOS


Total3=rbind.fill(Total2,sobra1)


Total3$fecha_actualizacion=ifelse(is.na(Total3$fecha_actualizacion) & Total3$Actualizacion=="Actualizado","Nov10",
                                  ifelse(is.na(Total3$fecha_actualizacion) & Total3$Actualizacion=="Nuevo","Nov10",Total3$fecha_actualizacion))

Total6= Total3[,c("departamentoDestino",'indice','primer_nombre','segundo_nombre','primer_apellido','segundo_apellido',
              'tipo_documento','numero_documento','como_llego_al_formulario',
              'numero_contacto','linea_contacto_propia','linea_asociada_whatsapp',
              'correo_electronico','fecha_llegada_pais',"fuente","tipo",'nombre_municipio_destino_final',
              'fecha_registro',"llegada_fecha_reporte","latitud","longitud","diff_fechas",
              "numero_entregado_venesperanza","llegada_departamento",'llegada_municipio',"llegada_num_contacto",'datos_act_num_contacto','datos_act_correo',
              "datosact_telefono","datosact_telefono","telefono_conocido_destino","parentesco_conocido_destino","ORG_REGISTRO",'Compartido_a','Estado',"Observaciones",'Actualizacion',"fecha_actualizacion")]


table(Total6$nombre_municipio_destino_final,useNA = "ifany")


##################### BASE DE  LLEGADAS

llegadasN <- read_csv(paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","caminantes_llegadas_21_",mes_dia,".csv"))


llegadasN[is.na(llegadasN)] <- "NULL"



### llegadas fuente

llegadasN$fuente_llegada=if_else(is.na(llegadasN$waId),"2",
                                 if_else(llegadasN$waId=="NULL","2","1"))


### telefono

llegadasN$waId <- substring(llegadasN$waId, 3)
llegadasN$waId <- ifelse(llegadasN$waId=="LL","NULL",llegadasN$waId)

### llegada municipio

llegadasN$donde_te_encuentras=ifelse(llegadasN$donde_te_encuentras=="Otro",llegadasN$otro_donde_te_encuentras,llegadasN$donde_te_encuentras)

llegadasN$llegada_municipio= llegadasN$donde_te_encuentras

llegadasN$llegada_municipio=toupper(llegadasN$llegada_municipio)

llegadasN$llegada_municipio=removeAccents(llegadasN$llegada_municipio)

llegadasN$llegada_municipio=ifelse(llegadasN$llegada_municipio=="AGUACHICA CESAR","AGUACHICA",
                            ifelse(llegadasN$llegada_municipio=="APRTADO ANTIOQUIA","APARTADO",
                            ifelse(llegadasN$llegada_municipio=="BARRANCA BERMEJA","BARRANCABERMEJA",
                            ifelse(llegadasN$llegada_municipio=="BOCHALEMA \nNORTE DE SANTNDER","BOCHALEMA",
                            ifelse(llegadasN$llegada_municipio=="BOLIVAR MAGANGUE","MAGANGUE",
                            ifelse(llegadasN$llegada_municipio=="BOSCONIA CESAR","BOSCONIA",
                            ifelse(llegadasN$llegada_municipio=="BOYACA","TUNJA",
                            ifelse(llegadasN$llegada_municipio=="CANCELAR","NULL",
                            ifelse(llegadasN$llegada_municipio=="CUCUTA NORTE DE SANTANDER","CUCUTA",
                            ifelse(llegadasN$llegada_municipio=="EL CHOCO TADO","TADO",
                            ifelse(llegadasN$llegada_municipio=="EN BOYACA SAN JOSE D PARE","SAN JOSE DE PARE",
                            ifelse(llegadasN$llegada_municipio=="EN EL REMOLINO","PASTO",
                            ifelse(llegadasN$llegada_municipio=="LA UNION NARINO","LA UNION",
                            ifelse(llegadasN$llegada_municipio=="MANIZALES","MANIZALES",
                            ifelse(llegadasN$llegada_municipio=="MONTERREY CASANARE","MONTERREY",
                            ifelse(llegadasN$llegada_municipio=="NARINO IPIALES","IPIALES",
                            ifelse(llegadasN$llegada_municipio=="NORTE DE SANTANDER","CUCUTA",
                            ifelse(llegadasN$llegada_municipio=="PAIPA BOYACA SALISTRE","PAIPA",
                            ifelse(llegadasN$llegada_municipio=="PAMPLONA NORTE DE SANTANDER","PAMPLONA", 
                            ifelse(llegadasN$llegada_municipio=="PERU","OTRO",    
                            ifelse(llegadasN$llegada_municipio=="SABANA DE TORRES SANTANDER","SABANA DE TORRES",
                            ifelse(llegadasN$llegada_municipio=="SOCORRO SANTANDER","SOCORRO",
                            ifelse(llegadasN$llegada_municipio=="TUNJA BOYACA","TUNJA",
                            ifelse(llegadasN$llegada_municipio=="VILLA DEL ROSARIO  NORTE DE SANTANDER","VILLA DEL ROSARIO",
                            ifelse(llegadasN$llegada_municipio=="NULL","NULL",
                            ifelse(llegadasN$llegada_municipio=="8","NULL",
                            ifelse(llegadasN$llegada_municipio=="PACORA CALDAS CORREGIMIENTO CASTILLA CALDAS","PACORA", 
                            ifelse(llegadasN$llegada_municipio=="PALMIRA VALLE DEL CAUCA","PALMIRA",
                            ifelse(llegadasN$llegada_municipio=="SOGAMOSO NOBSA","SOGAMOSO",
                            ifelse(llegadasN$llegada_municipio=="SAN MARTIN. DEPARTAMENTO EL META","SAN MARTIN",
                            ifelse(llegadasN$llegada_municipio=="HULILA","HUILA",
                            ifelse(llegadasN$llegada_municipio=="EN TOLIMA PLANADAS  GAITANIA","PLANADAS",
                            ifelse(llegadasN$llegada_municipio=="CHINACOTA NORTE DE SANTANDER","CHINACOTA",
                            ifelse(llegadasN$llegada_municipio=="CHINCHINA CALDAS","CHINCHINA",
                            ifelse(llegadasN$llegada_municipio=="AQUI EN CUCUTA XQ NOS REGRESAMOS","CUCUTA",
                            ifelse(llegadasN$llegada_municipio=="ARMENIA QUINDIO","ARMENIA",
                            ifelse(llegadasN$llegada_municipio=="BARRANCA BERMEJA VEREDA LA PLAZUELA","BARRANCABERMEJA",
                            ifelse(llegadasN$llegada_municipio=="ECUADOR","OTRO",
                            ifelse(llegadasN$llegada_municipio=="MELGAR TOLIMA","MELGAR",
                            ifelse(llegadasN$llegada_municipio=="MONIQUIRA BOYACA","MONIQUIRA",
                            ifelse(llegadasN$llegada_municipio=="PAIPA BOYACA SALITRE","PAIPA",
                            ifelse(llegadasN$llegada_municipio=="PALMIRA VALLE","PALMIRA",
                            ifelse(llegadasN$llegada_municipio=="PALMIRA VALLE DEL CAUCA","PALMIRA",
                            ifelse(llegadasN$llegada_municipio=="PERU LIMA","OTRO",
                            ifelse(llegadasN$llegada_municipio=="SOGAMOSO NOBSA","SOGAMOSO",
                            ifelse(llegadasN$llegada_municipio=="SUCRE ANTIOQUIA OLAYA","SUCRE",
                            ifelse(llegadasN$llegada_municipio=="VILLA DEL ROSARIO- NORTE DE SANTANDER","VILLA DEL ROSARIO",
                            ifelse(llegadasN$llegada_municipio=="EN GUATEQUE BOYACA","GUATEQUE",
                            ifelse(llegadasN$llegada_municipio=="ECUADOR MACHALA","OTRO",
                            ifelse(llegadasN$llegada_municipio=="PUERTO BERRIO ANTIOQUIA","PUERTO BERRIO",llegadasN$llegada_municipio))))))))))))))))))))))))))))))))))))))))))))))))))                                                                                                                                    


llegadasN$llegada_municipio=ifelse(llegadasN$llegada_municipio=="SAN JOSE DE GUAVIARES","SAN JOSE DEL GUAVIARE",
                                   ifelse(llegadasN$llegada_municipio=="1","OTRO",
                                   ifelse(llegadasN$llegada_municipio=="2","OTRO",
                                   ifelse(llegadasN$llegada_municipio=="5","OTRO",
                                   ifelse(llegadasN$llegada_municipio=="11","OTRO",
                                   ifelse(llegadasN$llegada_municipio=="ZARZAL VALLE DEL CAUCA","VALLE DEL CAUCA", 
                                   ifelse(llegadasN$llegada_municipio=="SIENEGA MAR DELENA","CIENAGA",
                                   ifelse(llegadasN$llegada_municipio=="MONTERIA CORDOBA","MONTERIA",
                                   ifelse(llegadasN$llegada_municipio=="EN BARRANCABERMEJA","BARRANCABERMEJA",
                                   ifelse(llegadasN$llegada_municipio=="CANTA GALLO SUR DE BOLIVAR","CANTAGALLO",
                                   ifelse(llegadasN$llegada_municipio=="CAPITANEJO SANTANDER","SANTANDER",
                                   ifelse(llegadasN$llegada_municipio=="CIUDAD BOLIVAR","OTRO",
                                   ifelse(llegadasN$llegada_municipio=="CUCUTA COLOMBIA","CUCUTA",
                                   ifelse(llegadasN$llegada_municipio=="CUCUTILLA","CUCUTA",
                                   ifelse(llegadasN$llegada_municipio=="ECUADOR GUAYAQUIL","OTRO",
                                   ifelse(llegadasN$llegada_municipio=="EL CAUCA SANTANDER DE QUILICHAO","SANTANDER DE QUILICHAO",
                                   ifelse(llegadasN$llegada_municipio=="EL SOCORRO","SOCORRO",
                                   ifelse(llegadasN$llegada_municipio=="ESPINAL TOLIMA","ESPINAL",
                                   ifelse(llegadasN$llegada_municipio=="LA PARADA","VILLA DEL ROSARIO", 
                                   ifelse(llegadasN$llegada_municipio=="MARINILLAS","MARINILLA",
                                   ifelse(llegadasN$llegada_municipio=="PUTUMAYO VILLA GARZON","VILLA GARZON",
                                   ifelse(llegadasN$llegada_municipio=="SAN MARCOS SUCRE","SAN MARCOS",
                                   ifelse(llegadasN$llegada_municipio=="SAN JIL","SAN GIL",      
                                   ifelse(llegadasN$llegada_municipio=="VILLA DEL ROSARIO LA PARADA","VILLA DEL ROSARIO",
                                   ifelse(llegadasN$llegada_municipio=="ACASIA","ACACIAS",
                                   ifelse(llegadasN$llegada_municipio=="AGUACHICA","AGUACHICA",
                                   ifelse(llegadasN$llegada_municipio=="AGUAZUL CASANARE","AGUAZUL",
                                   ifelse(llegadasN$llegada_municipio=="EN SAN ANTONIO DEL TACHIRA    EN LA FRONTERA","LA PARADA",
                                   ifelse(llegadasN$llegada_municipio=="EN LA FRONTERA","LA PARADA",
                                   ifelse(llegadasN$llegada_municipio=="HERRERA TOLIMA","HERRERA",
                                   ifelse(llegadasN$llegada_municipio=="NEIVA HUILA","NEIVA",
                                   ifelse(llegadasN$llegada_municipio=="PARAMO DE SANTANDER","PARAMO",
                                   ifelse(llegadasN$llegada_municipio=="SABANA LARGA  BARRANQUILLA","SABANALARGA",
                                   ifelse(llegadasN$llegada_municipio=="SOACHA CUNDINAMARCA","SOACHA",
                                   ifelse(llegadasN$llegada_municipio=="ALCALA VALLE DEL CAUCA","VALLE DEL CAUCA",
                                   ifelse(llegadasN$llegada_municipio=="ALMENIA CALARCA","ARMENIA",
                                   ifelse(llegadasN$llegada_municipio=="CERETE CORDOBA","CORDOBA",
                                   ifelse(llegadasN$llegada_municipio=="CIUDA YOPAL","YOPAL",
                                   ifelse(llegadasN$llegada_municipio=="EN LA CIUDAD DE BUGA","BUGA",
                                   ifelse(llegadasN$llegada_municipio=="EN LA PARADA","LA PARADA",
                                   ifelse(llegadasN$llegada_municipio=="IBAGUE TOLIMA","IBAGUE",
                                   ifelse(llegadasN$llegada_municipio=="IBAGUE.","IBAGUE",
                                   ifelse(llegadasN$llegada_municipio=="IPIALES NARINOS","IPIALES",
                                   ifelse(llegadasN$llegada_municipio=="LA DORADA CALDAS","LA DORADA",
                                   ifelse(llegadasN$llegada_municipio=="PEREIRA RISARALDA","PEREIRA",
                                   ifelse(llegadasN$llegada_municipio=="QUIIMBIO","OTRO",
                                   ifelse(llegadasN$llegada_municipio=="TAME ARAUCA","TAME",
                                   ifelse(llegadasN$llegada_municipio=="PACORA CALDAS CORREJIMIENTO CASTILLA","PACORA",
                                   ifelse(llegadasN$llegada_municipio=="PALMIRA  VALLE  DEL  CAUCA","PALMIRA",
                                   ifelse(llegadasN$llegada_municipio=="URIBIA LA GUAJIRA","URIBIA",llegadasN$llegada_municipio))))))))))))))))))))))))))))))))))))))))))))))))))
llegadasN$llegada_municipio=ifelse(llegadasN$llegada_municipio=="VENTA QUEMADA BOYACA","VENTAQUEMADA",
                                   ifelse(llegadasN$llegada_municipio=="LA PARADA","VILLA DEL ROSARIO",
                                   ifelse(llegadasN$llegada_municipio=="DUITAMABOYACA","DUITAMA",
                                   ifelse(llegadasN$llegada_municipio=="EN SOCORRO","EL SOCORRO",
                                   ifelse(llegadasN$llegada_municipio=="YOPAL CASANARE","YOPAL",
                                   ifelse(llegadasN$llegada_municipio=="SEVILLA VALLES DEL CAUCA","SEVILLA",
                                   ifelse(llegadasN$llegada_municipio=="RISARALDA SECTOR EL GUAMITO","RISARALDA",
                                   ifelse(llegadasN$llegada_municipio=="MUNICIPIO ARJONA CESAR","ARJONA",
                                   ifelse(llegadasN$llegada_municipio=="EL SOCORRO","SOCORRO",
                                   ifelse(llegadasN$llegada_municipio=="VILLA ROSARIO NORTE DE SANTANDER","SOCORRO",
                                   ifelse(llegadasN$llegada_municipio=="BRISENO","BRICENO",
                                   ifelse(llegadasN$llegada_municipio=="VILLAGARZON PUTUMAYO","VILLAGARZON",
                                   ifelse(llegadasN$llegada_municipio=="VILLA GARZON","VILLAGARZON",
                                   ifelse(llegadasN$llegada_municipio=="EN ECUADOR","OTRO",
                                   ifelse(llegadasN$llegada_municipio=="ITUANGO ANTIOQUIA","ITUANGO",
                                   ifelse(llegadasN$llegada_municipio=="IVAGUE","IBAGUE",
                                   ifelse(llegadasN$llegada_municipio=="MAGANGUE BOLIVAR","MAGANGUE",
                                   ifelse(llegadasN$llegada_municipio=="SAN ALBERTO CESAR","SAN ALBERTO",
                                   ifelse(llegadasN$llegada_municipio=="SANTANDER SOCORRO","SANTANDER",
                                   ifelse(llegadasN$llegada_municipio=="AMAIME VALLE DEL CAUCA","AMAIME",
                                   ifelse(llegadasN$llegada_municipio=="TULCAN CARCHI ECUADOR","OTRO",
                                   ifelse(llegadasN$llegada_municipio=="SOY DE VENEZUELA","OTRO",
                                   ifelse(llegadasN$llegada_municipio=="EN CHINACOTA","CHINACOTA",
                                   ifelse(llegadasN$llegada_municipio=="URUGUECA","ZONA BANANERA",llegadasN$llegada_municipio))))))))))))))))))))))))                                                                             


llegadasN$llegada_municipio=ifelse(llegadasN$llegada_municipio=="EN BORDO CAUCA","PATIA",
                            ifelse(llegadasN$llegada_municipio=="FACATATIVA CUNDINAMARCA","FACATATIVA",
                            ifelse(llegadasN$llegada_municipio=="CHIQUINQUIRA BOYACA","CHIQUINQUIRA",
                            ifelse(llegadasN$llegada_municipio=="CIENAGA MAGDALENA CORREGIMIENTO MAGDALENA","CIENAGA",
                            ifelse(llegadasN$llegada_municipio=="DEPARTAMENTO DE CASANARE MUNICIPIO PORE","PORE",
                            ifelse(llegadasN$llegada_municipio=="EN CHINACOTA NORTE DE SANTADER","CHINACOTA",
                            ifelse(llegadasN$llegada_municipio=="MALAGA SANTANDER","MALAGA",
                            ifelse(llegadasN$llegada_municipio=="MUNICIPIO VALLE  DE SAN JOSE  VERDAD CERRO DE MANGO FINCA LA MONTANA","VALLE DE SAN JOSE",
                            ifelse(llegadasN$llegada_municipio=="PUTUMAYO PUERTO ASI","PUERTO ASIS",
                            ifelse(llegadasN$llegada_municipio=="BARRANCAMERVEJA","BARRANCABERMEJA",
                            ifelse(llegadasN$llegada_municipio=="BUENO YA GUARDE TU NUMERO A LO QUE LLEGUE  MI DESTINO TE ENVIO","OTRO",
                            ifelse(llegadasN$llegada_municipio=="MALAGA SANTADER","MALAGA",  
                            ifelse(llegadasN$llegada_municipio=="PUERTO ARAUJO SANTANDER","PUERTO ARAUJO",
                            ifelse(llegadasN$llegada_municipio=="SANTANA DE BOYACA","MALAGA",
                            ifelse(llegadasN$llegada_municipio=="SANTIAGO DE CHILE","OTRO",
                            ifelse(llegadasN$llegada_municipio=="SEVILLA VAYE","SEVILLA", 
                            ifelse(llegadasN$llegada_municipio=="TUNJAN","TUNJA",
                            ifelse(llegadasN$llegada_municipio=="DORADA CALDAS","LA DORADA",
                            ifelse(llegadasN$llegada_municipio=="DUITAMA BOYACA","DUITAMA",
                            ifelse(llegadasN$llegada_municipio=="LA DON JUANA","OTRO",llegadasN$llegada_municipio))))))))))))))))))))
                                   




### llegada deparmento

llegadasN$llegada_departamento=ifelse(llegadasN$llegada_municipio=="AGUACHICA","CESAR",
                               ifelse(llegadasN$llegada_municipio=="APARTADO","ANTIOQUIA",
                               ifelse(llegadasN$llegada_municipio=="BARRANCABERMEJA","SANTANDER",
                               ifelse(llegadasN$llegada_municipio=="BOCHALEMA","NORTE DE SANTANDER",
                               ifelse(llegadasN$llegada_municipio=="MAGANGUE","BOLIVAR",
                               ifelse(llegadasN$llegada_municipio=="BOSCONIA","CESAR",
                               ifelse(llegadasN$llegada_municipio=="TUNJA","BOYACA",
                               ifelse(llegadasN$llegada_municipio=="NULL","NULL",
                               ifelse(llegadasN$llegada_municipio=="CUCUTA","NORTE DE SANTANDER",
                               ifelse(llegadasN$llegada_municipio=="TADO","CHOCO",
                               ifelse(llegadasN$llegada_municipio=="SAN JOSE DE PARE","BOYACA",
                               ifelse(llegadasN$llegada_municipio=="PASTO","NARINO",
                               ifelse(llegadasN$llegada_municipio=="LA UNION","NARINO",
                               ifelse(llegadasN$llegada_municipio=="MANIZALES","CALDAS",
                               ifelse(llegadasN$llegada_municipio=="MONTERREY","CASANARE",
                               ifelse(llegadasN$llegada_municipio=="IPIALES","NARINO",
                               ifelse(llegadasN$llegada_municipio=="CHINACOTA","NORTE DE SANTANDER",
                               ifelse(llegadasN$llegada_municipio=="PAIPA","BOYACA",
                               ifelse(llegadasN$llegada_municipio=="PAMPLONA","NORTE DE SANTANDER", 
                               ifelse(llegadasN$llegada_municipio=="Otro", "OTRO",   
                               ifelse(llegadasN$llegada_municipio=="SABANA DE TORRES","SANTANDER",
                               ifelse(llegadasN$llegada_municipio=="SOCORRO","SANTANDER",
                               ifelse(llegadasN$llegada_municipio=="TUNJA","BOYACA",
                               ifelse(llegadasN$llegada_municipio=="VILLA DEL ROSARIO","NORTE DE SANTANDER",
                               ifelse(llegadasN$llegada_municipio=="CARTAGENA","BOLIVAR",
                               ifelse(llegadasN$llegada_municipio=="GUAYABETAL","CUNDINAMARCA",
                               ifelse(llegadasN$llegada_municipio=="CALI","VALLE DEL CAUCA",
                               ifelse(llegadasN$llegada_municipio=="BARRANQUILLA","ATLANTICO",
                               ifelse(llegadasN$llegada_municipio=="IPIALES","NARINO",
                               ifelse(llegadasN$llegada_municipio=="MEDELLIN","ANTIOQUIA",
                               ifelse(llegadasN$llegada_municipio=="SUCRE","ANTIOQUIA",
                               ifelse(llegadasN$llegada_municipio=="ANTOQUIA","ANTIOQUIA",
                               ifelse(llegadasN$llegada_municipio=="BUCARAMANGA","SANTANDER",
                               ifelse(llegadasN$llegada_municipio=="PALMIRA","VALLE DEL CAUCA",
                               ifelse(llegadasN$llegada_municipio=="PEREIRA","RISARALDA",
                               ifelse(llegadasN$llegada_municipio=="SAN GIL","SANTANDER",
                               ifelse(llegadasN$llegada_municipio=="SANTA MARTA","MAGDALENA",
                               ifelse(llegadasN$llegada_municipio=="SOACHA","CUNDINAMARCA",
                               ifelse(llegadasN$llegada_municipio=="TAME","ARAUCA",
                               ifelse(llegadasN$llegada_municipio=="VALLEDUPAR","CESAR",
                               ifelse(llegadasN$llegada_municipio=="VILLAVICENCIO","META",
                               ifelse(llegadasN$llegada_municipio=="ZARZAL","VALLE DEL CAUCA",
                               ifelse(llegadasN$llegada_municipio=="MONIQUIRA","BOYACA",
                               ifelse(llegadasN$llegada_municipio=="SOGAMOSO","BOYACA",
                               ifelse(llegadasN$llegada_municipio=="APARTADO","ANTIOQUIA",
                               ifelse(llegadasN$llegada_municipio=="HERRERA TOLIMA","TOLIMA",
                               ifelse(llegadasN$llegada_municipio=="CHINCHINA","CALDAS",
                               ifelse(llegadasN$llegada_municipio=="QUIIMBIO","OTRO", 
                               ifelse(llegadasN$llegada_municipio=="PACORA","CALDAS",
                               llegadasN$llegada_municipio)))))))))))))))))))))))))))))))))))))))))))))))))


llegadasN$llegada_departamento= ifelse(llegadasN$llegada_municipio=="NEIVA HUILA","HUILA", 
                                ifelse(llegadasN$llegada_municipio=="GINEBRA","VALLE DEL CAUCA",
                                ifelse(llegadasN$llegada_municipio=="SABANA DE TORRES","SANTANDER", 
                                ifelse(llegadasN$llegada_municipio=="GUATEQUE","BOYACA",
                                ifelse(llegadasN$llegada_municipio=="APARTADO","ANTIOQUIA",
                                ifelse(llegadasN$llegada_municipio=="AGUACHICA","CESAR", 
                                ifelse(llegadasN$llegada_municipio=="ARMENIA","QUINDIO",
                                ifelse(llegadasN$llegada_municipio=="MELGAR","TOLIMA",
                                ifelse(llegadasN$llegada_municipio=="NEIVA HUILA","HUILA", 
                                ifelse(llegadasN$llegada_municipio=="BOCHALEMA","NORTE DE SANTANDER",
                                ifelse(llegadasN$llegada_municipio=="PLANADAS","TOLIMA", 
                                ifelse(llegadasN$llegada_municipio=="PUERTO BERRIO","ANTIOQUIA",
                                ifelse(llegadasN$llegada_municipio=="SAN JOSE DEL GUAVIARE","GUAVIARE",
                                ifelse(llegadasN$llegada_municipio=="SAN MARTIN","META", 
                                ifelse(llegadasN$llegada_municipio=="TAME ARAUCA","ARAUCA",
                                ifelse(llegadasN$llegada_municipio=="ARMENIA","QUINDIO",
                                ifelse(llegadasN$llegada_municipio=="NULL","NULL",
                                ifelse(llegadasN$llegada_municipio=="EN SAN ANTONIO DEL TACHIRA    EN LA FRONTERA","NORTE DE SANTANDER",
                                ifelse(llegadasN$llegada_municipio=="EN LA FRONTERA","NORTE DE SANTANDER",
                                ifelse(llegadasN$llegada_municipio=="ACACIAS","META",
                                ifelse(llegadasN$llegada_municipio=="AGUAZUL","CASANARE",
                                ifelse(llegadasN$llegada_municipio=="BUGA","VALLE DEL CAUCA",
                                ifelse(llegadasN$llegada_municipio=="HERRERA","TOLIMA",
                                ifelse(llegadasN$llegada_municipio=="IBAGUE","TOLIMA",
                                ifelse(llegadasN$llegada_municipio=="LA DORADA","CALDAS",
                                ifelse(llegadasN$llegada_municipio=="LA PARADA","NORTE DE SANTANDER",
                                ifelse(llegadasN$llegada_municipio=="MARINILLAS","CALDAS",
                                ifelse(llegadasN$llegada_municipio=="NEIVA","TOLIMA",
                                ifelse(llegadasN$llegada_municipio=="PARAMO","SANTANDER",
                                ifelse(llegadasN$llegada_municipio=="RIOHACHA","LA GUAJIRA",
                                ifelse(llegadasN$llegada_municipio=="SABANALARGA","ATLANTICO",
                                ifelse(llegadasN$llegada_municipio=="YOPAL","CASANARE",
                                ifelse(llegadasN$llegada_municipio=="PACORA CALDAS CORREJIMIENTO CASTILLA","CALDAS",
                                ifelse(llegadasN$llegada_municipio=="VENTA QUEMADA BOYACA","BOYACA",
                                ifelse(llegadasN$llegada_municipio=="URIBIA LA GUAJIRA","LA GUAJIRA",
                                ifelse(llegadasN$llegada_municipio=="DUITAMA","BOYACA",
                                ifelse(llegadasN$llegada_municipio=="CANTAGALLO","BOLIVAR",
                                ifelse(llegadasN$llegada_municipio=="CIENAGA","MAGDALENA",
                                ifelse(llegadasN$llegada_municipio=="ESPINAL","TOLIMA",
                                ifelse(llegadasN$llegada_municipio=="MARINILLA","CALDAS",
                                ifelse(llegadasN$llegada_municipio=="MONTERIA","CORDOBA",
                                ifelse(llegadasN$llegada_municipio=="SAN MARCOS","SUCRE",
                                ifelse(llegadasN$llegada_municipio=="SANTANDER DE QUILICHAO","CAUCA",
                                ifelse(llegadasN$llegada_municipio=="VILLA GARZON","PUTUMAYO",
                                ifelse(llegadasN$llegada_municipio=="EL SOCORRO","SANTANDER",
                                ifelse(llegadasN$llegada_municipio=="URIBIA","LA GUAJIRA",
                                ifelse(llegadasN$llegada_municipio=="SANTANDER SOCORRO","SANTANDER",
                                llegadasN$llegada_departamento)))))))))))))))))))))))))))))))))))))))))))))))

llegadasN$llegada_departamento=ifelse(llegadasN$llegada_municipio=="SEVILLA","VALLE DEL CAUCA",
                                ifelse(llegadasN$llegada_municipio=="ARJONA","BOLIVAR",
                                ifelse(llegadasN$llegada_municipio=="BRICENO","CUNDINAMARCA",
                                ifelse(llegadasN$llegada_municipio=="BRISENO","CUNDINAMARCA",  
                                ifelse(llegadasN$llegada_municipio=="LOS PATIOS","NORTE DE SANTANDER",
                                ifelse(llegadasN$llegada_municipio=="ITUANGO ANTIOQUIA","ANTIOQUIA",
                                ifelse(llegadasN$llegada_municipio=="EN ECUADOR","OTRO",
                                ifelse(llegadasN$llegada_municipio=="MAICAO","LA GUAJIRA",
                                ifelse(llegadasN$llegada_municipio=="AMAIME","VALLE DEL CAUCA",
                                ifelse(llegadasN$llegada_municipio=="ITUANGO","ANTIOQUIA",
                                ifelse(llegadasN$llegada_municipio=="VILLAGARZON","PUTUMAYO",
                                ifelse(llegadasN$llegada_municipio=="SANTANDER SOCORRO","SANTANDER",
                                ifelse(llegadasN$llegada_municipio=="ITUANGO ANTIOQUIA","ITUANGO",
                                ifelse(llegadasN$llegada_municipio=="SAN ALBERTO","CESAR",
                                ifelse(llegadasN$llegada_municipio=="VENTAQUEMADA","BOYACA",
                                ifelse(llegadasN$llegada_municipio=="CHINACOTA","NORTE DE SANTANDER",
                                ifelse(llegadasN$llegada_municipio=="SOY DE VENEZUELA","OTRO",
                                ifelse(llegadasN$llegada_municipio=="MALAMBO","ATLANTICO", 
                                ifelse(llegadasN$llegada_municipio=="URUGUECA","MAGDALENA", 
                                ifelse(llegadasN$llegada_municipio=="ZONA BANANERA","MAGDALENA",
                                ifelse(llegadasN$llegada_municipio=="FACATATIVA","CUNDINAMARCA", 
                                ifelse(llegadasN$llegada_municipio=="PATIA","CAUCA",
                                ifelse(llegadasN$llegada_municipio=="PORE","CASANARE",
                                ifelse(llegadasN$llegada_municipio=="CHIQUINQUIRA","BOYACA",
                                ifelse(llegadasN$llegada_municipio=="CIENAGA","MAGDALENA",
                                ifelse(llegadasN$llegada_municipio=="CHINACOTA","NORTE DE SANTANDER",
                                ifelse(llegadasN$llegada_municipio=="MALAGA","SANTANDER",
                                ifelse(llegadasN$llegada_municipio=="VALLE DE SAN JOSE","SANTANDER",
                                ifelse(llegadasN$llegada_municipio=="FLORENCIA","CAQUETA",
                                ifelse(llegadasN$llegada_municipio=="AGUCHICA","CESAR",
                                ifelse(llegadasN$llegada_municipio=="POPAYAN","CAUCA",
                                ifelse(llegadasN$llegada_municipio=="PUERTO ASIS","PUTUMAYO",
                                ifelse(llegadasN$llegada_municipio=="VILLA ROSARIO","NORTE DE SANTANDER",
                                ifelse(llegadasN$llegada_municipio=="PUERTO ARAUJO","SANTANDER",llegadasN$llegada_departamento))))))))))))))))))))))))))))))))))                                                                                  

table(llegadasN$llegada_departamento, useNA = "ifany")


######## fecha registro

llegadasN$fecha_registro=as.Date(substr(llegadasN$created_at, 1, 10))


######## linea asociada a whatsapp


llegadasN$linea_asociada_whatsapp=ifelse(llegadasN$numero_contacto_asociado_whatsapp== 44329, "NULL",llegadasN$numero_contacto_asociado_whatsapp)

llegadasN$linea_asociada_whatsapp=if_else(is.na(llegadasN$linea_asociada_whatsapp),"NULL",llegadasN$linea_asociada_whatsapp)

llegadasN$linea_asociada_whatsapp=if_else(llegadasN$numero_contacto_asociado_whatsapp=="2","0",llegadasN$numero_contacto_asociado_whatsapp)

####### columna de duplicados

llegadasN$duplicados= if_else(duplicated(llegadasN$numero_documento),"1","0")                        
                                    

llegadasN1=llegadasN[!duplicated(llegadasN$numero_documento),]


##################################################TOTAL + LLEGADAS

df=merge(Total6,llegadasN1, by=c("numero_documento","numero_contacto"),all = T)


#### llegada municipio

df$llegada_municipio= if_else(is.na(df$llegada_municipio.y),df$llegada_municipio.x,
                                  if_else(df$llegada_municipio.y=="NULL",df$llegada_municipio.x,df$llegada_municipio.y))

df$llegada_municipio= if_else(is.na(df$llegada_municipio),"NULL",df$llegada_municipio)


#### llegada departamento

df$llegada_departamento= if_else(is.na(df$llegada_departamento.y),df$llegada_departamento.x,
                                  if_else(df$llegada_departamento.y=="NULL",df$llegada_departamento.x,df$llegada_departamento.y))

df$llegada_departamento= if_else(is.na(df$llegada_departamento),"NULL",df$llegada_departamento)



df$nombre_municipio_destino_final= if_else(is.na(df$nombre_municipio_destino_final),df$llegada_municipio,df$nombre_municipio_destino_final)

#### departamento destino

df$departamentoDestino1= if_else(is.na(df$llegada_departamento),df$departamentoDestino,
                                     if_else(df$llegada_departamento=="NULL",df$departamentoDestino,df$llegada_departamento))




df$departamentoDestino=df$departamentoDestino1

df$departamentoDestino=ifelse(df$nombre_municipio_destino_final=="ACACIAS","META",
                                  ifelse(df$nombre_municipio_destino_final=="AGUACHICA","CESAR",
                                         ifelse(df$nombre_municipio_destino_final=="ALCALA","VALLE DEL CAUCA",
                                                ifelse(df$nombre_municipio_destino_final=="APARTADO","ANTIOQUIA",
                                                       ifelse(df$nombre_municipio_destino_final=="ARMENIA","QUINDIO",
                                                              ifelse(df$nombre_municipio_destino_final=="ARAUCA","ARAUCA",
                                                                     ifelse(df$nombre_municipio_destino_final=="BARRANCABERMEJA","SANTANDER", 
                                                                            ifelse(df$nombre_municipio_destino_final=="BARRANQUILLA","ATLANTICO",
                                                                                   ifelse(df$nombre_municipio_destino_final=="BOCHALEMA","NORTE DE SANTANDER",
                                                                                          ifelse(df$nombre_municipio_destino_final=="BOGOTA","BOGOTA",
                                                                                                 ifelse(df$nombre_municipio_destino_final=="BOSCONIA","CESAR",
                                                                                                        ifelse(df$nombre_municipio_destino_final=="BOYACA","BOYACA",
                                                                                                               ifelse(df$nombre_municipio_destino_final=="BRICENO","CUNDINAMARCA",
                                                                                                                      ifelse(df$nombre_municipio_destino_final=="BUCARAMANGA","SANTANDER",
                                                                                                                             ifelse(df$nombre_municipio_destino_final=="CALARCA","QUINDIO",
                                                                                                                                    ifelse(df$nombre_municipio_destino_final=="CALI","VALLE DEL CAUCA", 
                                                                                                                                           ifelse(df$nombre_municipio_destino_final=="CALIMA","VALLE DEL CAUCA",
                                                                                                                                                  ifelse(df$nombre_municipio_destino_final=="CANTAGALLO","BOLIVAR",
                                                                                                                                                         ifelse(df$nombre_municipio_destino_final=="CARTAGENA","BOLIVAR",
                                                                                                                                                                ifelse(df$nombre_municipio_destino_final=="CASANARE","CASANARE",
                                                                                                                                                                       ifelse(df$nombre_municipio_destino_final=="CERETE","CORDOBA",
                                                                                                                                                                              ifelse(df$nombre_municipio_destino_final=="CHINACOTA","NORTE DE SANTANDER",
                                                                                                                                                                                     ifelse(df$nombre_municipio_destino_final=="CHINCHINA","CALDAS",
                                                                                                                                                                                            ifelse(df$nombre_municipio_destino_final=="CHIQUINQUIRA","BOYACA", 
                                                                                                                                                                                                   ifelse(df$nombre_municipio_destino_final=="CUCUTA","NORTE DE SANTANDER", 
                                                                                                                                                                                                          ifelse(df$nombre_municipio_destino_final=="DUITAMA","BOYACA",
                                                                                                                                                                                                                 ifelse(df$nombre_municipio_destino_final=="ESPINAL","TOLIMA",
                                                                                                                                                                                                                        ifelse(df$nombre_municipio_destino_final=="FLORIDABLANCA","SANTANDER",
                                                                                                                                                                                                                               ifelse(df$nombre_municipio_destino_final=="GUATEQUE","BOYACA",
                                                                                                                                                                                                                                      ifelse(df$nombre_municipio_destino_final=="HERRERA","TOLIMA",
                                                                                                                                                                                                                                             ifelse(df$nombre_municipio_destino_final=="HUILA","HUILA",
                                                                                                                                                                                                                                                    ifelse(df$nombre_municipio_destino_final=="IBAGUE","TOLIMA",
                                                                                                                                                                                                                                                           ifelse(df$nombre_municipio_destino_final=="IPIALES","NARINO",
                                                                                                                                                                                                                                                                  ifelse(df$nombre_municipio_destino_final=="LA DORADA","CALDAS",
                                                                                                                                                                                                                                                                         ifelse(df$nombre_municipio_destino_final=="LA UNION","VALLE DEL CAUCA",
                                                                                                                                                                                                                                                                                ifelse(df$nombre_municipio_destino_final=="LA VICTORIA","VALLE DEL CAUCA",
                                                                                                                                                                                                                                                                                       ifelse(df$nombre_municipio_destino_final=="LOS PATIOS","NORTE DE SANTANDER",
                                                                                                                                                                                                                                                                                              ifelse(df$nombre_municipio_destino_final=="MAGANGUE","MAGDALENA",
                                                                                                                                                                                                                                                                                                     ifelse(df$nombre_municipio_destino_final=="MAICAO","LA GUAJIRA",
                                                                                                                                                                                                                                                                                                            ifelse(df$nombre_municipio_destino_final=="MALAGA","SANTANDER",
                                                                                                                                                                                                                                                                                                                   ifelse(df$nombre_municipio_destino_final=="MANIZALES","CALDAS",
                                                                                                                                                                                                                                                                                                                          ifelse(df$nombre_municipio_destino_final=="MEDELLIN","ANTIOQUIA",
                                                                                                                                                                                                                                                                                                                                 ifelse(df$nombre_municipio_destino_final=="MONIQUIRA","BOYACA",
                                                                                                                                                                                                                                                                                                                                        ifelse(df$nombre_municipio_destino_final=="NEIVA","HUILA",
                                                                                                                                                                                                                                                                                                                                               ifelse(df$nombre_municipio_destino_final=="PACORA","CALDAS",
                                                                                                                                                                                                                                                                                                                                                      ifelse(df$nombre_municipio_destino_final=="PAIPA","BOYACA",
                                                                                                                                                                                                                                                                                                                                                             ifelse(df$nombre_municipio_destino_final=="PALMIRA","VALLE DEL CAUCA",
                                                                                                                                                                                                                                                                                                                                                                    ifelse(df$nombre_municipio_destino_final=="PAMPLONA","NORTE DE SANTANDER",
                                                                                                                                                                                                                                                                                                                                                                           ifelse(df$nombre_municipio_destino_final)))))))))))))))))))))))))))))))))))))))))))))))))


df$departamentoDestino=ifelse(df$nombre_municipio_destino_final=="PANDI","CUNDINAMARCA",
                                  ifelse(df$nombre_municipio_destino_final=="PATIA","CAUCA",
                                         ifelse(df$nombre_municipio_destino_final=="PASTO","NARINO",
                                                ifelse(df$nombre_municipio_destino_final=="PEREIRA","RISARALDA",
                                                       ifelse(df$nombre_municipio_destino_final=="PLANADAS","TOLIMA",
                                                              ifelse(df$nombre_municipio_destino_final=="POPAYAN","CAUCA",
                                                                     ifelse(df$nombre_municipio_destino_final=="PUERTO","OTRO",
                                                                            ifelse(df$nombre_municipio_destino_final=="PUERTO BERRIO","ANTIOQUIA",
                                                                                   ifelse(df$nombre_municipio_destino_final=="PUERTO WILCHES","SANTANDER",
                                                                                          ifelse(df$nombre_municipio_destino_final=="PUTUMAYO","PUTUMAYO",
                                                                                                 ifelse(df$nombre_municipio_destino_final=="RIOHACHA","LA GUAJIRA",
                                                                                                        ifelse(df$nombre_municipio_destino_final=="RISARALDA","RISARALDA",
                                                                                                               ifelse(df$nombre_municipio_destino_final=="SABANA DE TORRES","SANTANDER",
                                                                                                                      ifelse(df$nombre_municipio_destino_final=="SAN ALBERTO","CESAR",
                                                                                                                             ifelse(df$nombre_municipio_destino_final=="SAN ANTERO","CORDOBA",
                                                                                                                                    ifelse(df$nombre_municipio_destino_final=="SAN GIL","SANTANDER",
                                                                                                                                           ifelse(df$nombre_municipio_destino_final=="RIOHACHA","LA GUAJIRA",
                                                                                                                                                  ifelse(df$nombre_municipio_destino_final=="SAN JOSE DEL GUAVIARE","GUAVIARE",
                                                                                                                                                         ifelse(df$nombre_municipio_destino_final=="SAN JOSE DE PARE","BOYACA",
                                                                                                                                                                ifelse(df$nombre_municipio_destino_final=="SAN JUAN DE RIO SECO","CUNDINAMARCA",
                                                                                                                                                                       ifelse(df$nombre_municipio_destino_final=="SAN MARTIN","META",
                                                                                                                                                                              ifelse(df$nombre_municipio_destino_final=="SANTA MARTA","MAGDALENA",
                                                                                                                                                                                     ifelse(df$nombre_municipio_destino_final=="SANTANA","BOYACA",
                                                                                                                                                                                            ifelse(df$nombre_municipio_destino_final=="SANTANDER DE QUILICHAO","CAUCA",
                                                                                                                                                                                                   ifelse(df$nombre_municipio_destino_final=="SEVILLA","VALLE DEL CAUCA",
                                                                                                                                                                                                          ifelse(df$nombre_municipio_destino_final=="SOACHA","CUNDINAMARCA",
                                                                                                                                                                                                                 ifelse(df$nombre_municipio_destino_final=="SOCORRO","SANTANDER",
                                                                                                                                                                                                                        ifelse(df$nombre_municipio_destino_final=="SOGAMOSO","BOYACA",
                                                                                                                                                                                                                               ifelse(df$nombre_municipio_destino_final=="SUCRE","SUCRE",
                                                                                                                                                                                                                                      ifelse(df$nombre_municipio_destino_final=="TADO","CHOCO",
                                                                                                                                                                                                                                             ifelse(df$nombre_municipio_destino_final=="TAME","ARAUCA",
                                                                                                                                                                                                                                                    ifelse(df$nombre_municipio_destino_final=="TUNJA","BOYACA",
                                                                                                                                                                                                                                                           ifelse(df$nombre_municipio_destino_final=="VALLE DE SAN JOSE","SANTANDER",
                                                                                                                                                                                                                                                                  ifelse(df$nombre_municipio_destino_final=="VALLEDUPAR","CESAR",
                                                                                                                                                                                                                                                                         ifelse(df$nombre_municipio_destino_final=="VENTAQUEMADA","BOYACA",
                                                                                                                                                                                                                                                                                ifelse(df$nombre_municipio_destino_final=="VILLA DEL ROSARIO","NORTE DE SANTANDER",
                                                                                                                                                                                                                                                                                       ifelse(df$nombre_municipio_destino_final=="VILLAGARZON","PUTUMAYO",
                                                                                                                                                                                                                                                                                              ifelse(df$nombre_municipio_destino_final=="VILLAVICENCIO","META",
                                                                                                                                                                                                                                                                                                     ifelse(df$nombre_municipio_destino_final=="YOPAL","CASANARE",
                                                                                                                                                                                                                                                                                                            ifelse(df$nombre_municipio_destino_final=="ZARZAL","VALLE DEL CAUCA",
                                                                                                                                                                                                                                                                                                                   ifelse(df$nombre_municipio_destino_final=="GUAYABETAL","CUNDINAMARCA",
                                                                                                                                                                                                                                                                                                                          ifelse(df$nombre_municipio_destino_final=="SAN JOSE DEL GUAVIARE","GUAVIARE",
                                                                                                                                                                                                                                                                                                                                 ifelse(df$nombre_municipio_destino_final=="TOLIMA","TOLIMA",
                                                                                                                                                                                                                                                                                                                                        ifelse(df$nombre_municipio_destino_final=="NULL","OTRO",
                                                                                                                                                                                                                                                                                                                                               ifelse(df$nombre_municipio_destino_final=="SUCRE","SUCRE",df$departamentoDestino)))))))))))))))))))))))))))))))))))))))))))))  

df$departamentoDestino= if_else(is.na(df$departamentoDestino),"OTRO",df$departamentoDestino)

table(df$nombre_municipio_destino_final, useNA = "ifany")


#####
df$Compartido_a= ifelse(df$departamentoDestino=="ARAUCA","SC",
                            ifelse(df$departamentoDestino=="ATLANTICO","WVI",
                                   ifelse(df$departamentoDestino=="BOGOTA","SC",
                                          ifelse(df$departamentoDestino=="BOGOTA","SC",
                                                 ifelse(df$departamentoDestino=="LA GUAJIRA","SC",
                                                        ifelse(df$departamentoDestino=="NULL","SinComp",
                                                               ifelse(df$departamentoDestino=="SANTANDER","WVI",
                                                                      ifelse(df$departamentoDestino=="CUNDINAMARCA","IRC",
                                                                             ifelse(df$departamentoDestino=="ANTIOQUIA" & df$Compartido_a=="IRC","IRC",
                                                                                    ifelse(df$departamentoDestino=="ANTIOQUIA" & df$Compartido_a=="MC","MC",
                                                                                           ifelse(df$departamentoDestino=="NORTE DE SANTANDER" & df$nombre_municipio_destino_final=="CUCUTA","IRC",  
                                                                                                  ifelse(df$departamentoDestino=="NORTE DE SANTANDER" & df$nombre_municipio_destino_final!="CUCUTA","WVI",
                                                                                                         ifelse(df$departamentoDestino=="NORTE DE SANTANDER" & df$Compartido_a=="MC","IRC",
                                                                                                                ifelse(df$departamentoDestino=="CUNDINAMARCA","IRC",      
                                                                                                                       ifelse(df$departamentoDestino=="VALLE DEL CAUCA","CUA",
                                                                                                                              ifelse(df$departamentoDestino=="SANTANDER","WVI",
                                                                                                                                     ifelse(df$departamentoDestino=="MAGDALENA","CUA",
                                                                                                                                            ifelse(df$departamentoDestino=="NARINO","CUA",
                                                                                                                                                   ifelse(df$departamentoDestino=="NORTE DE SANTANDER"& df$Compartido_a=="CUA","IRC",
                                                                                                                                                          ifelse(df$departamentoDestino=="NORTE DE SANTANDER"& df$Compartido_a=="SC","IRC",
                                                                                                                                                                 ifelse(df$departamentoDestino=="NORTE DE SANTANDER"& df$Compartido_a=="SinComp","IRC",
                                                                                                                                                                        ifelse(df$departamentoDestino=="BOLIVAR","MC",
                                                                                                                                                                               ifelse(df$departamentoDestino=="CESAR","MC",
                                                                                                                                                                                      ifelse(df$departamentoDestino=="ANTIOQUIA"& df$Compartido_a=="WVI","MC",
                                                                                                                                                                                             ifelse(df$departamentoDestino=="ANTIOQUIA"& df$Compartido_a=="SC","MC",
                                                                                                                                                                                                    ifelse(df$departamentoDestino=="ANTIOQUIA"& is.na(df$Compartido_a),"MC",
                                                                                                                                                                                                    ifelse(df$departamentoDestino=="ANTIOQUIA"& df$Compartido_a=="SinComp","MC",
                                                                                                                                                                                                           ifelse(df$departamentoDestino=="CESAR","MC",
                                                                                                                                                                                                                  ifelse(df$departamentoDestino%in% c("BOYACA","CALDAS","CASANARE","CHOCO","META","HUILA","GUAVIARE","TOLIMA","Otro","OTRO","QUINDIO","CAUCA","SUCRE","PUTUMAYO","RISARALDA","NoSeguro","NULL","OTRO"),"SinComp",df$Compartido_a)))))))))))))))))))))))))))))















##compartido a
df$Compartido_a= ifelse(df$departamentoDestino=="ANTIOQUIA"& is.na(df$Compartido_a),"MC",df$Compartido_a)
df$Compartido_a= ifelse(is.na(df$Compartido_a),"SinComp",df$Compartido_a)
df$Compartido_a= ifelse(df$departamentoDestino=="NoSeguro","SinComp",df$Compartido_a)
df$Compartido_a= ifelse(is.na(df$departamentoDestino),"SinComp",df$Compartido_a)
df$departamentoDestino= ifelse(df$departamentoDestino=="Otro","OTRO",df$departamentoDestino)
df$departamentoDestino= ifelse(is.na(df$departamentoDestino),"NULL",df$departamentoDestino)


table(df$nombre_municipio_destino_final, df$Compartido_a, useNA = "ifany")

#### tipo de documento


df$tipo_documento=if_else(is.na(df$tipo_documento.x),df$tipo_documento.y,df$tipo_documento.x)

df$tipo_documento=ifelse(df$tipo_documento=="Cédula de Identidad (venezonala)","cedula_identidad_venezolana",
                             ifelse(df$tipo_documento=="Cédula de Identidad (venezolana)","cedula_identidad_venezolana",
                                    ifelse(df$tipo_documento=="Cédula de Identidad (Venezolana)","cedula_identidad_venezolana",
                                           ifelse(df$tipo_documento=="Cédula de ciudadania (colombiana)","cedula_ciudadania_colombiana",
                                                  ifelse(df$tipo_documento=="Cédula de Ciudadanía (Colombiana)","cedula_ciudadania_colombiana",
                                                         ifelse(df$tipo_documento=="null","NULL",
                                                                ifelse(df$tipo_documento=="null","NULL",
                                                                       ifelse(df$tipo_documento=="Pasaporte","Pasaporte",
                                                                              ifelse(df$tipo_documento=="Constancia de Perdida de Documentos","Constancia_perdida_documentos",
                                                                                     ifelse(df$tipo_documento=="Constancia de perdida de documentos","Constancia_perdida_documentos",
                                                                                            ifelse(df$tipo_documento=="Constancia por perdida de documentos","Constancia_perdida_documentos",
                                                                                                   ifelse(df$tipo_documento=="No tengo ningún documento de identidad","Indocumentado",
                                                                                                          ifelse(df$tipo_documento=="PARTIDA DE NACIMIENTO","Acta de Nacimiento",
                                                                                                                 ifelse(df$tipo_documento=="Partida de nacimiento","Acta de Nacimiento",
                                                                                                                        ifelse(df$tipo_documento=="Perdida de documento","Indocumentado",
                                                                                                                               ifelse(df$tipo_documento=="0","Otro",
                                                                                                                                      ifelse(df$tipo_documento=="Niup","Otro",
                                                                                                                                             ifelse(df$tipo_documento=="SinActualizar","Otro",df$tipo_documento))))))))))))))))))




##LINEA WH
df$linea_asociada_whatsapp=ifelse(is.na(df$linea_asociada_whatsapp.x), df$linea_asociada_whatsapp.y,df$linea_asociada_whatsapp.x)

df$llegada_num_contacto=ifelse(is.na(df$llegada_num_contacto), df$waId,df$llegada_num_contacto)

###ACTUALIZACION


df$Actualizacion=ifelse(is.na(df$Actualizacion),"Nuevo",df$Actualizacion)

### FECHA ACTUALIZACION
df$fecha_actualizacion=ifelse(is.na(df$fecha_actualizacion) & df$Actualizacion=="Actualizado","Nov10",
                                  ifelse(is.na(df$fecha_actualizacion) & df$Actualizacion=="Nuevo","Nov10",df$fecha_actualizacion))



### fuentes

df$fuente= if_else(is.na(df$fuente),"NULL",df$fuente)
df$fuente_llegada=as.character(df$fuente_llegada)
df$fuente_llegada= if_else(is.na(df$fuente_llegada),"NULL",df$fuente_llegada)

df$fuente= if_else(df$fuente=="NULL",df$fuente_llegada,df$fuente)


### nombre jefe hogar

df$llegada_nombre_jefe_hogar=df$nombre_jefe_hogar
# 

################################## identificar duplicados

library(vctrs)
library(dplyr)

##lista duplicados incluyendo el dato original

df$duplicados1=vec_duplicate_id(df$numero_documento)

###grupo por el cual se va pegar

df$deptoSocio=paste0(df$departamentoDestino,df$Compartido_a)

###eliminar espacios

df$deptoSocio=gsub(" ", "", df$deptoSocio, fixed = TRUE)


### genarar columna con datos de filas pegado

df =df %>% group_by(df$duplicados1) %>%
  mutate(duplicados2 = toString(deptoSocio)) %>%
  as.data.frame()

### generar columna sin datos repetidos en fila

df$duplicados3 <- sapply(strsplit(df$duplicados2, ",", fixed = TRUE), function(x) 
  paste(unique(toupper(trimws(unlist(strsplit(x,split="(?!')[ [:punct:]]",fixed=F,perl=T))))),collapse = " "))

### generar columna eliminando los valores para datos sin duplicados

df$duplicados4=ifelse(duplicated(df$duplicados1)|duplicated(df$duplicados1,fromLast = T),df$duplicados3," ")

### diferenciar entre datos por numero

df$count=count.fields(textConnection(df$duplicados4), sep = " ")


df$duplicados2=ifelse(df$count>=3,"2",
                      ifelse(df$count==2 & df$duplicados4==" ","0","1"))

df$duplicados7=ifelse(duplicated(df$numero_documento),1,0)

df$duplicados=df$duplicados7

df$duplicados1=df$duplicados2
df$duplicados2=df$duplicados4

### mantener el indice

df$indice=paste0(df$primer_nombre,df$primer_apellido,df$segundo_apellido,
                 df$numero_documento)


df$indice=toupper(df$indice)

df$indice=removeAccents(df$indice)

df$indice=toupper(df$indice)

df$indice=gsub(" ", "", df$indice, fixed = TRUE)
df$indice=gsub("  ", "", df$indice, fixed = TRUE)
df$indice=gsub(".", "", df$indice, fixed = TRUE)
df$indice=gsub(",", "", df$indice, fixed = TRUE)
df$indice=gsub(" , ", "", df$indice, fixed = TRUE)
df$indice=gsub(" ", "", df$indice, fixed = TRUE)


### ORG

df$ORG_REGISTRO=if_else(is.na(df$ORG_REGISTRO),"NULL",df$ORG_REGISTRO)

df$ORG_REGISTRO=if_else(df$ORG_REGISTRO=="SCG","SC",df$ORG_REGISTRO)


### numero venesperanza

df$numero_entregado_venesperanza=if_else(is.na(df$numero_entregado_venesperanza),"NULL",df$numero_entregado_venesperanza)

table(df$numero_entregado_venesperanza,useNA = "ifany")

####fecha registro

df$fecha_registro.y=as.Date(df$fecha_registro.y)

df$fecha_registro.x=as.Date(df$fecha_registro.x)

df$fecha_registro= if_else(is.na(df$fecha_registro.x),df$fecha_registro.y,df$fecha_registro.x) 

df$fecha_registro= as.Date(df$fecha_registro)

####fecha llegada

df$llegada_fecha_reporte= as.Date(df$llegada_fecha_reporte)
##Diferencia llegada y registro

df$diff_fechas=as.numeric(difftime(df$llegada_fecha_reporte, df$fecha_registro, units = "days")) 


df$diff_fechas=ifelse(df$diff_fechas< 0, 0, df$diff_fechas)
table(df$diff_fechas, useNA = "ifany")



#########datos actu telefono

df$datosact_telefono= if_else(is.na(df$datosact_telefono),"NULL",df$datosact_telefono)

table(df$datosact_telefono, useNA = "ifany")

### actualización correo

df$datos_act_correo= if_else(is.na(df$datos_act_correo),"NULL",df$datos_act_correo)

table(df$datos_act_correo, useNA = "ifany")



#########latitud


df$latitud=if_else(is.na(df$latitud.y),df$latitud.x,
                       if_else(df$latitud.y=="NULL",df$latitud.x,df$latitud.y))



#########longitud

df$longitud=if_else(is.na(df$longitud.y),df$longitud.x,
                        if_else(df$longitud.y=="NULL",df$longitud.x,df$longitud.y))



###################Como llego al formulario###############################

df$como_llego_al_formulario=ifelse(df$como_llego_al_formulario=="Encontró el enlace en Facebook","Facebook",
                                     ifelse(df$como_llego_al_formulario=="Recibí el enlace por chat","Enlace_chat",
                                            ifelse(df$como_llego_al_formulario=="Recibí un volante en un albergue","Volante",
                                                   ifelse(df$como_llego_al_formulario=="Recibí un volante en el albergue","Volante",
                                                          ifelse(df$como_llego_al_formulario=="Recibí una manilla con el número","Volante",
                                                                 ifelse(df$como_llego_al_formulario=="Recibí una foto con la información","Foto",
                                                                        ifelse(df$como_llego_al_formulario=="Una persona conocida me lo envió para que lo llenara","persona_conocida",
                                                                               ifelse(df$como_llego_al_formulario=="Ví un pendón en un albergue","pendon",
                                                                                      ifelse(df$como_llego_al_formulario=="Otro","Otro",
                                                                                             ifelse(df$como_llego_al_formulario=="Una persona conocida me lo envió para que lo llenara","persona_conocida",df$como_llego_al_formulario))))))))))


###################parentesco ###############################

df$parentesco_conocido_destino=if_else(df$parentesco_conocido_destino=="amigo","Amigo/a",
                                   if_else(df$parentesco_conocido_destino=="Amigo","Amigo/a",
                                   if_else(df$parentesco_conocido_destino=="c_nyuge","Conyugue",
                                   if_else(df$parentesco_conocido_destino=="Cónyuge","Conyugue",
                                   if_else(df$parentesco_conocido_destino=="hijo_a","Hijo/a",
                                   if_else(df$parentesco_conocido_destino=="HIJA","Hijo/a",
                                   if_else(df$parentesco_conocido_destino=="null","NULL",
                                   if_else(df$parentesco_conocido_destino=="otro","Otro",
                                   if_else(df$parentesco_conocido_destino=="padre_madre","Padre/madre",
                                   if_else(df$parentesco_conocido_destino=="conocido","Conocido",
                                   if_else(df$parentesco_conocido_destino=="Amiga","Amigo/a",
                                   if_else(df$parentesco_conocido_destino=="Cuñada","Cunado/a",
                                   if_else(df$parentesco_conocido_destino=="CUÑADA","Cunado/a",
                                   if_else(df$parentesco_conocido_destino=="CUÑADO","Cunado/a",
                                   if_else(df$parentesco_conocido_destino=="Cuñado","Cunado/a",
                                   if_else(df$parentesco_conocido_destino=="Hermana","Hermano/a",
                                   if_else(df$parentesco_conocido_destino=="HERMANA","Hermano/a",
                                   if_else(df$parentesco_conocido_destino=="Hermano","Hermano/a",
                                   if_else(df$parentesco_conocido_destino=="HERMANO","Hermano/a",
                                   if_else(df$parentesco_conocido_destino=="Hernano","Hermano/a",
                                   if_else(df$parentesco_conocido_destino=="Heemana","Hermano/a",
                                   if_else(df$parentesco_conocido_destino=="Prima","Primo/a",
                                   if_else(df$parentesco_conocido_destino=="PRIMA","Primo/a",
                                   if_else(df$parentesco_conocido_destino=="Primo","Primo/a",
                                   if_else(df$parentesco_conocido_destino=="PRIMO","Primo/a",
                                   if_else(df$parentesco_conocido_destino=="Sobrina","Sobrino/a",
                                   if_else(df$parentesco_conocido_destino=="Sobrino","Sobrino/a",
                                   if_else(df$parentesco_conocido_destino=="SOBRINA","Sobrino/a",
                                   if_else(df$parentesco_conocido_destino=="SOBRINO","Sobrino/a",
                                   if_else(df$parentesco_conocido_destino=="Suegra","Suegro/a",
                                   if_else(df$parentesco_conocido_destino=="SUEGRO","Suegro/a",
                                   if_else(df$parentesco_conocido_destino=="TIA","Tio/a",
                                   if_else(df$parentesco_conocido_destino=="TIO","Tio/a",
                                   if_else(df$parentesco_conocido_destino=="Abuela","Abuelo/a",
                                   if_else(df$parentesco_conocido_destino=="Abuelo","Abuelo/a",
                                   if_else(df$parentesco_conocido_destino=="ABUELA","Abuelo/a",
                                   if_else(df$parentesco_conocido_destino=="ABUELO","Abuelo/a",
                                   if_else(df$parentesco_conocido_destino=="HIJASTRA","Hijastro/a",
                                   if_else(df$parentesco_conocido_destino=="Hijastro","Hijastro/a",
                                   if_else(df$parentesco_conocido_destino=="YERNA","Yerno/a",  
                                   if_else(df$parentesco_conocido_destino=="Yerno","Yerno/a", 
                                   if_else(is.na(df$parentesco_conocido_destino),"NULL", df$parentesco_conocido_destino))))))))))))))))))))))))))))))))))))))))))


df6= df[,c("departamentoDestino",'indice','primer_nombre','segundo_nombre','primer_apellido','segundo_apellido',
           'tipo_documento',"numero_documento",'como_llego_al_formulario',
           'numero_contacto','linea_contacto_propia','linea_asociada_whatsapp',
           'correo_electronico','fecha_llegada_pais','fuente',"tipo",'nombre_municipio_destino_final',
           'fecha_registro',"llegada_fecha_reporte","latitud","longitud","diff_fechas","numero_entregado_venesperanza",'llegada_departamento','llegada_municipio',"llegada_num_contacto","llegada_nombre_jefe_hogar",
           'datos_act_num_contacto','datos_act_correo',"datosact_telefono","datosact_telefono","telefono_conocido_destino","parentesco_conocido_destino","ORG_REGISTRO",
           'Compartido_a','Estado',"Observaciones",'Actualizacion',"fecha_actualizacion","duplicados","duplicados1", "duplicados2")]

table(df6$parentesco_conocido_destino,useNA = "ifany")

### Compilado total
openxlsx::write.xlsx(df6,paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","Actual/CompiladoTotal20211110.xlsx"),overwrite = T)

################################################### Compilado sin nulos


### indice

df6$nulos=paste0(df6$primer_nombre,df6$segundo_nombre,df6$primer_apellido,df6$segundo_apellido)


df6$nulos=toupper(df6$nulos)

df6$nulos=removeAccents(df6$nulos)

df6$nulos=toupper(df6$nulos)

df6$nulos=gsub(" ", "", df6$nulos, fixed = TRUE)
df6$nulos=gsub("  ", "", df6$nulos, fixed = TRUE)
df6$nulos=gsub(".", "", df6$nulos, fixed = TRUE)
df6$nulos=gsub(",", "", df6$nulos, fixed = TRUE)
df6$nulos=gsub(" , ", "", df6$nulos, fixed = TRUE)
df6$nulos=gsub(" ", "", df6$nulos, fixed = TRUE)


df7=df6[!df6$nulos %in% c("NULLNULLNULLNA","NANANANA","NANANANULL","DNULLFNULL",
                         "NANANANOLOSE"),]

df8=df7[!df7$departamentoDestino %in% c("NULL","NA","OTRO","NoSeguro"),]

df9=df8[!df8$numero_contacto %in% c("NULL","NA"),]

df9=df8

#### identificar duplicados

library(vctrs)
library(dplyr)

##lista duplicados incluyendo el dato original

df9$duplicados1=vec_duplicate_id(df9$numero_documento)

###grupo por el cual se va pegar

df9$deptoSocio=paste0(df9$departamentoDestino,df9$Compartido_a)

###eliminar espacios

df9$deptoSocio=gsub(" ", "", df9$deptoSocio, fixed = TRUE)



### genarar columna con datos de filas pegado

df9 =df9 %>% group_by(df9$duplicados1) %>%
  mutate(duplicados2 = toString(deptoSocio)) %>%
  as.data.frame()

### generar columna sin datos repetidos en fila

df9$duplicados3 <- sapply(strsplit(df9$duplicados2, ",", fixed = TRUE), function(x) 
  paste(unique(toupper(trimws(unlist(strsplit(x,split="(?!')[ [:punct:]]",fixed=F,perl=T))))),collapse = " "))

### generar columna eliminando los valores para datos sin duplicados

df9$duplicados4=ifelse(duplicated(df9$duplicados1)|duplicated(df9$duplicados1,fromLast = T),df9$duplicados3," ")

### diferenciar entre datos por numero

df9$count=count.fields(textConnection(df9$duplicados4), sep = " ")


df9$duplicados2=ifelse(df9$count>=3,"2",
                      ifelse(df9$count==2 & df9$duplicados4==" ","0","1"))

df9$duplicados7=ifelse(duplicated(df9$numero_documento),1,0)

df9$duplicados=df9$duplicados7

df9$duplicados1=df9$duplicados2
df9$duplicados2=df9$duplicados4

df10= df9[,c("departamentoDestino",'indice','primer_nombre','segundo_nombre','primer_apellido','segundo_apellido',
           'tipo_documento',"numero_documento",'como_llego_al_formulario',
           'numero_contacto','linea_contacto_propia','linea_asociada_whatsapp',
           'correo_electronico','fecha_llegada_pais','fuente',"tipo",'nombre_municipio_destino_final',
           'fecha_registro',"llegada_fecha_reporte","latitud","longitud","diff_fechas","numero_entregado_venesperanza",'llegada_departamento','llegada_municipio',"llegada_num_contacto","llegada_nombre_jefe_hogar",
           'datos_act_num_contacto','datos_act_correo',"datosact_telefono","datosact_telefono","telefono_conocido_destino","parentesco_conocido_destino","ORG_REGISTRO",
           'Compartido_a','Estado',"Observaciones",'Actualizacion',"fecha_actualizacion","duplicados","duplicados1","duplicados2")]

table(df10$llegada_fecha_reporte,useNA = "ifany")


openxlsx::write.xlsx(df10,paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","Actual/CompiladoSinNulos20211110.xlsx"),overwrite = T)


################################################### tabla resumen

df=df10
a=table(df$Actualizacion,df$Compartido_a, useNA = "ifany")
df$fuente=as.character(df$fuente)
df$fuente= if_else(df$fuente=="3.0","3",df$fuente)
b=table(df$fuente, df$Compartido_a, useNA = "ifany")
rownames(b)=c("Chatbot","Web","Kobo")

Totales=table(df$Compartido_a)

Duplicados_doc= table(duplicated(df$numero_documento), df$Compartido_a)
rownames(Duplicados_doc)=c("No Duplicados Documento","Duplicados Documento")

Duplicados_ind= table(duplicated(df$indice), df$Compartido_a)
rownames(Duplicados_ind)=c("No Duplicados indice","Duplicados indice")

wf=as.data.frame(rbind(Totales,Duplicados_doc,Duplicados_ind,a,b))

openxlsx::write.xlsx(wf,paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","resumenNoviembre10.xlsx"),
                     col.names = TRUE, row.names = TRUE, overwrite = T)



########################################################3 escribir fuera

##########wVI


xl_lst <- list('ATLANTICO_WVI' = df[df$departamentoDestino=="ATLANTICO" & df$Compartido_a== "WVI",], 'NORTE DE SANTANDER_WVI' =df[df$departamentoDestino=="NORTE DE SANTANDER" & df$Compartido_a== "WVI",],'SANTANDER_WVI' = df[df$departamentoDestino=="SANTANDER" & df$Compartido_a== "WVI",])

paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","20210710SINCOMP.xlsx")
openxlsx::write.xlsx(xl_lst,paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","Actual/","20210710WVI.xlsx"),overwrite = T)

##########IRC

borrar=c("Estado-WV","INFORMACION COMPLEMENTARIA-REGIONES1","INFORMACION COMPLEMENTARIA-REGIONES2","Observaciones complemntaria regiones", "Indicaciones para region")
df1 <- df[ , !(names(df) %in% borrar)]

xl_lst <- list('ANTIOQUIA_IRC' = df1[df1$departamentoDestino=="ANTIOQUIA" & df1$Compartido_a== "IRC",], 'NORTE DE SANTANDER_IRC' = df1[df1$departamentoDestino=="NORTE DE SANTANDER" & df1$Compartido_a== "IRC",],'CUNDINAMARCA_IRC' =df1[df1$departamentoDestino=="CUNDINAMARCA" & df1$Compartido_a== "IRC",])

openxlsx::write.xlsx(xl_lst,paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","Actual/","20210710IRC.xlsx"),overwrite = T)


##########MC

xl_lst <- list('ANTIOQUIA_MC' = df1[df1$departamentoDestino=="ANTIOQUIA" & df1$Compartido_a== "MC",], 'BOLIVAR_MC' = df1[df1$departamentoDestino=="BOLIVAR" & df1$Compartido_a== "MC",],'CESAR_MC' =df1[df1$departamentoDestino=="CESAR" & df1$Compartido_a== "MC",])

openxlsx::write.xlsx(xl_lst,paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","Actual/","20210710MC.xlsx"),overwrite = T)


##########CUA

xl_lst <- list('MAGDALENA_CUA' = df1[df1$departamentoDestino=="MAGDALENA" & df1$Compartido_a== "CUA",], 'NARINO_CUA' =  df1[df1$departamentoDestino=="NARINO" & df1$Compartido_a== "CUA",],'VALLE DEL CAUCA_CUA' = df1[df1$departamentoDestino=="VALLE DEL CAUCA" & df1$Compartido_a== "CUA",])

openxlsx::write.xlsx(xl_lst,paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","Actual/","20210710CUA.xlsx"),overwrite = T)


##########SC

xl_lst <- list('BOGOTA_SC' =  df1[df1$departamentoDestino=="BOGOTA" & df1$Compartido_a== "SC",], 'ARAUCA_SC' = df1[df1$departamentoDestino=="ARAUCA" & df1$Compartido_a== "SC",],'GUAJIRA_SC' =df1[df1$departamentoDestino=="LA GUAJIRA" & df1$Compartido_a== "SC",])

openxlsx::write.xlsx(xl_lst,paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","Actual/","20210710SC.xlsx"),overwrite = T)


##########SinComp

xl_lst <- list('SinComp' = df1[df1$Compartido_a== "SinComp",])

openxlsx::write.xlsx(xl_lst,paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","Actual/","20210710SinComp.xlsx"),overwrite = T)

#######################################################################################################################
######## bases para graficas de Dashboard########

######## Base llegadas

tot6=Total6[ !duplicated(Total6$numero_documento),]

lleg=merge(llegadasN,tot6[,c(2,8,10)], by=c("numero_documento","numero_contacto"),all.x = T)


lleg$Div_Depto=ifelse(lleg$llegada_departamento=="ANTIOQUIA","05",
               ifelse(lleg$llegada_departamento=="ATLANTICO","08",
               ifelse(lleg$llegada_departamento=="BOGOTA","11",
               ifelse(lleg$llegada_departamento=="BOLIVAR","13",
               ifelse(lleg$llegada_departamento=="BOYACA","15",
               ifelse(lleg$llegada_departamento=="CALDAS","17",
               ifelse(lleg$llegada_departamento=="CAQUETA","18",
               ifelse(lleg$llegada_departamento=="CAUCA","19",
               ifelse(lleg$llegada_departamento=="CESAR","20",
               ifelse(lleg$llegada_departamento=="CORDOBA","23",
               ifelse(lleg$llegada_departamento=="CUNDINAMARCA","25",
               ifelse(lleg$llegada_departamento=="CHOCO","27",
               ifelse(lleg$llegada_departamento=="HUILA","41",
               ifelse(lleg$llegada_departamento=="LA GUAJIRA","44",
               ifelse(lleg$llegada_departamento=="MAGDALENA","47",
               ifelse(lleg$llegada_departamento=="META","50",
               ifelse(lleg$llegada_departamento=="NARINO","52",
               ifelse(lleg$llegada_departamento=="NORTE DE SANTANDER","54",
               ifelse(lleg$llegada_departamento=="QUINDIO","63",
               ifelse(lleg$llegada_departamento=="RISARALDA","66",
               ifelse(lleg$llegada_departamento=="SANTANDER","68",
               ifelse(lleg$llegada_departamento=="SUCRE","70",
               ifelse(lleg$llegada_departamento=="TOLIMA","73",
               ifelse(lleg$llegada_departamento=="VALLE_CAUCA","76",
               ifelse(lleg$llegada_departamento=="ARAUCA","81",
               ifelse(lleg$llegada_departamento=="CASANARE","85",
               ifelse(lleg$llegada_departamento=="PUTUMAYO","86",
               ifelse(lleg$llegada_departamento=="SAN ANDRES","88",
               ifelse(lleg$llegada_departamento=="AMAZONAS","91",
               ifelse(lleg$llegada_departamento=="GUANIA","94",
               ifelse(lleg$llegada_departamento=="GUAVIARE","95",
               ifelse(lleg$llegada_departamento=="VAUPES","97",
               ifelse(lleg$llegada_departamento=="VICHADA","99"," ")))))))))))))))))))))))))))))))))



DIVIPOLA <- read_excel(paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","DIVIPOLA.xlsx"))
lleg11=merge(lleg,DIVIPOLA,by=c("llegada_municipio","llegada_departamento"), all.x=T)

lleg11$Div_Depto=lleg11$Div_Depto.x
openxlsx::write.xlsx(lleg11,paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","LlegadasNov10.xlsx"),overwrite = T)

######## Base sin nulos para graficas

df10$Div_Depto=ifelse(df10$departamentoDestino=="ANTIOQUIA","05",
               ifelse(df10$departamentoDestino=="ATLANTICO","08",
               ifelse(df10$departamentoDestino=="BOGOTA","11",
               ifelse(df10$departamentoDestino=="BOLIVAR","13",
               ifelse(df10$departamentoDestino=="BOYACA","15",
               ifelse(df10$departamentoDestino=="CALDAS","17",
               ifelse(df10$departamentoDestino=="CAQUETA","18",
               ifelse(df10$departamentoDestino=="CAUCA","19",
               ifelse(df10$departamentoDestino=="CESAR","20",
               ifelse(df10$departamentoDestino=="CORDOBA","23",
               ifelse(df10$departamentoDestino=="CUNDINAMARCA","25",
               ifelse(df10$departamentoDestino=="CHOCO","27",
               ifelse(df10$departamentoDestino=="HUILA","41",
               ifelse(df10$departamentoDestino=="LA GUAJIRA","44",
               ifelse(df10$departamentoDestino=="MAGDALENA","47",
               ifelse(df10$departamentoDestino=="META","50",
               ifelse(df10$departamentoDestino=="NARINO","52",
               ifelse(df10$departamentoDestino=="NORTE DE SANTANDER","54",
               ifelse(df10$departamentoDestino=="QUINDIO","63",
               ifelse(df10$departamentoDestino=="RISARALDA","66",
               ifelse(df10$departamentoDestino=="SANTANDER","68",
               ifelse(df10$departamentoDestino=="SUCRE","70",
               ifelse(df10$departamentoDestino=="TOLIMA","73",
               ifelse(df10$departamentoDestino=="VALLE_CAUCA","76",
               ifelse(df10$departamentoDestino=="ARAUCA","81",
               ifelse(df10$departamentoDestino=="CASANARE","85",
               ifelse(df10$departamentoDestino=="PUTUMAYO","86",
               ifelse(df10$departamentoDestino=="SAN ANDRES","88",
               ifelse(df10$departamentoDestino=="AMAZONAS","91",
               ifelse(df10$departamentoDestino=="GUANIA","94",
               ifelse(df10$departamentoDestino=="GUAVIARE","95",
               ifelse(df10$departamentoDestino=="VAUPES","97",
               ifelse(df10$departamentoDestino=="VICHADA","99","SinInfo")))))))))))))))))))))))))))))))))


DIVIPOLA <- read_excel(paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","DIVIPOLA.xlsx"))
df10=merge(df10,DIVIPOLA,by=c("llegada_municipio","llegada_departamento"), all.x=T)

df10$Div_Depto=df10$Div_Depto.x

df10$departamentoOrigen=if_else(df10$ORG_REGISTRO=="WV","NORTE DE SANTANDER",
                                if_else(df10$ORG_REGISTRO=="IRC","NORTE DE SANTANDER",
                                        if_else(df10$ORG_REGISTRO=="SC","ARAUCA",
                                                if_else(df10$ORG_REGISTRO=="SCG","LA GUAJIRA"," "))))

df10$ORG_REGISTRO=if_else(df10$ORG_REGISTRO=="SCG","SC",df10$ORG_REGISTRO)

df11= df10[,c("departamentoDestino","departamentoOrigen",'indice','primer_nombre','segundo_nombre','primer_apellido','segundo_apellido',
              'tipo_documento',"numero_documento",'como_llego_al_formulario',
              'numero_contacto','linea_contacto_propia','linea_asociada_whatsapp',
              'correo_electronico','fecha_llegada_pais','fuente',"tipo",'nombre_municipio_destino_final',
              'fecha_registro',"llegada_fecha_reporte","latitud","longitud","diff_fechas","numero_entregado_venesperanza",'llegada_departamento','llegada_municipio',"llegada_num_contacto","llegada_nombre_jefe_hogar",
              'datos_act_num_contacto','datos_act_correo',"datosact_telefono","datosact_telefono","telefono_conocido_destino","parentesco_conocido_destino","ORG_REGISTRO",
              'Compartido_a','Estado',"Observaciones",'Actualizacion',"fecha_actualizacion","duplicados","duplicados1","duplicados2","Div_Depto","div_mun")]


openxlsx::write.xlsx(df11,paste0("D:/IMMAP/VenEsperanza/Caminantes/",Mes,"/",dia,"/","Actual/","Graficas20211110.xlsx"),overwrite = T)

#######################################################################################################################


