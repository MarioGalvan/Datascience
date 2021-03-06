"------------------------------------------------------------------------------------------------------------------------------
                                                         PUNTO 1
------------------------------------------------------------------------------------------------------------------------------"
#IMPORTAMOS LOS DATOS
"en este apartado colocas la ruta donde tienes guardado el BASEFUGA_GENERAL.csv
header=T quiere decir que se incluir�n los nombres de las columnas.
na=NA hace referencia a los valores faltantes que tiene el dataset. Como en la hoja de excel hay campos que d�cen NA, 
este ser� el identificador para cada uno de ellos.

NA= Valores faltantes

a la variable general le asignamos el dataset"

general<-read.csv("BASEFUGA.csv", header = T, na="NA", sep=";")

"Esta funci�n cuenta los valores NA que hay en cada columna"
sapply(general, function(x) sum(is.na(x)))


#T�CNICAS DE IMPUTACI�N PARA SUSTITUIR LOS NA

"Para la variable GENERO, NIV_EDUC, E_CIVIL, CIUDAD se utiliz� la moda

este comando nos permite obtener la frecuencia de los posibles valores que se encuentran en la variable especificada"
table(general$GENERO)
table(general$NIV_EDUC)
table(general$E_CIVIL)
table(general$CIUDAD)

"Para la variable EDAD Y COD_COM se utiliz� la media hallada obviando los valores faltantes

na.rm hace referencia a la existencia de valores faltantes, por lo que es necesario colocarle TRUE para que los omita
"
mean(general$EDAD,na.rm = TRUE)
mean(general$COD_COM,na.rm = TRUE)

#REEMPLAZAMOS LOS VALORES HALLADOS

"Primero las variables cualitativas o categ�ricas"
general$GENERO[is.na(general$GENERO)] <- "M"
general$NIV_EDUC[is.na(general$NIV_EDUC)] <- "UNV"
general$E_CIVIL[is.na(general$E_CIVIL)] <- "CAS"
general$CIUDAD[is.na(general$CIUDAD)] <- "SANTIAGO"

"Segundo las variables cuantitativas o num�ricas"
general$EDAD[is.na(general$EDAD)] <- 44
general$COD_COM[is.na(general$COD_COM)] <- 108

#VERIFICAMOS SI LOS VALORES NA FUERON MODIFICADOS CON LA FUNCI�N SAPPLY
sapply(general, function(x) sum(is.na(x)))

#POR OTRA PARTE, SE ENCONTRARON CARACTERES ESPECIALES EN LA VARIABLE EDAD, YA QUE EL VALOR M�NIMO EST� DADO POR UN VALOR NEGATIVO
#Summary: muestra un resumen estadistico de la varible EDAD
summary(general$EDAD)

#POR LO TANTO SE UTILIZ� LA FUNCI�N gsub PARA ELIMINAR EL CARACTER "-"
general$EDAD<-gsub("-","", general$EDAD)

#PERO COMO ESTA FUNCI�N SE TRABAJA PARA CADENAS O VARIABLES CUALITATIVAS, SE REALIZ� UNA CONVERSI�N DE CADENA A INTEGER
general$EDAD<-as.integer(general$EDAD)

#MIRAMOS SI LA CONVERSI�N SE REALIZ� CON �XITO
class(general$EDAD)

"------------------------------------------------------------------------------------------------------------------------------
                                                             PUNTO 2
------------------------------------------------------------------------------------------------------------------------------"
"an�lisis descriptivo de los datos: 

1.tipos de variables estadisticas
2.medidas de posici�n central
3.medidas de posici�n no central
4.Medidas de dispersi�n
5.Tabla de frecuencias
6.Gr�ficos"

"1.variables estadisticas"

#N�MERO DE VARIABLES CON EL COMANDO NCOL
ncol(general)

"2.medida de posici�n central"

#PARA ESTO, NECESITAMOS INSTALAR Y LLAMAR LA LIBRER�A PARA UTILIZAR LA FUNCI�N SKIMR 
#ESTA NOS ARROJA LAS MEDIDAS DE POSICI�N CENTRAL, NO CENTRAL Y MEDIDAS DE DISPERSI�N
install.packages("skimr")
library(skimr)

skim(general)

"Este comando divide las medidas por tipo de variable (Variable type), en nuestro caso tenemos 2 tipos de variables:

                                      factor=cualitativa o categ�rica
                                      numeric=cuantitativa o num�rica

-PARA Variable type: factor

skim_variable: variables cualitativas
n_missing: valores faltantes
ordered: si el conjunto est� ordenado
n_unique: los posibles casos que tiene una variable
top_count: es igual a la moda para cada variable

-PARA Variable type: numeric

n_missing: valores faltantes
skim_variable: variables cuantitativas
mean: media
sd: desviaci�n t�pica o est�ndar
p0: valor m�nimo
p25: primer cuartil
p50: segundo cuartil
p75: tercer cuartil
p100: valor m�ximo
hist: es un histograma con respecto a la distribuci�n de los datos
"
#RANGO INTERCUATILICO POR CADA VARIABLE
IQR(general$ID)
IQR(general$RENTA)
IQR(general$EDAD)
IQR(general$COD_OFI)
IQR(general$COD_COM)
IQR(general$D_Marzo)
IQR(general$D_Abril)
IQR(general$D_Mayo)
IQR(general$D_Junio)
IQR(general$D_Julio)
IQR(general$D_Agosto)
IQR(general$D_Septiembre)
IQR(general$M_MOROSO)
IQR(general$MONTO)


#VARIANZA PARA CADA VARIABLE
var(general$ID)
var(general$RENTA)
var(general$EDAD)
var(general$COD_OFI)
var(general$COD_COM)
var(general$D_Marzo)
var(general$D_Abril)
var(general$D_Mayo)
var(general$D_Junio)
var(general$D_Julio)
var(general$D_Agosto)
var(general$D_Septiembre)
var(general$M_MOROSO)
var(general$MONTO)

"5.Tabla de frecuencias para las variables RENTA y MONTO"

