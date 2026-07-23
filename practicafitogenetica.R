#Practica: Análisis Estadísticos Básicos para Fitogenética en R

# Librerías necesarias
library(tidyverse)
library(vegan)
library(FactoMineR)
library(factoextra)
library(ape)
library(corrplot)
library(agricolae)
library(pastecs)
library(Hmisc)

#Importar datos
setwd("~/Documents/Fitogenetica 2026/Clase 8")

ruta_datos_cebada <- "~/Documents/Fitogenetica 2026/Clase 8/updated_barley_dataset_275.csv"
# Cargar dataset
barley <- read.csv("updated_barley_dataset_275.csv")
# Revisar estructura
str(barley)
summary(barley)

#Estadistica descriptiva

stat.desc(barley$GY, basic = FALSE,
          norm = TRUE )

describe(barley$GY)


#1. ANOVA

#El análisis de varianza (ANOVA) permite determinar si existen diferencias significativas entre grupos.

#En este ejemplo se comparará el rendimiento de grano (GY) entre grupos de altura de planta (PH).

# Crear grupos de altura
barley$PH_group <- cut(barley$PH,
                       breaks = quantile(barley$PH,
                                         probs = c(0, 0.33, 0.66, 1),
                                         na.rm = TRUE),
                       labels = c("Baja", "Media", "Alta"),
                       include.lowest = TRUE)
# ANOVA
anova_model <- aov(GY ~ PH_group, data = barley)
summary(anova_model)

#Prueba de Tukey

TukeyHSD(anova_model)

#Visualización

ggplot(barley, aes(x = PH_group, y = GY, fill = PH_group)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "ANOVA de rendimiento según altura de planta",
       x = "Grupo de altura",
       y = "Grain Yield (GY)")

#Pregunta 1: ¿Existen diferencias significativas en el rendimiento de grano (GY) entre los grupos de altura de planta?

#Pregunta 2: ¿Cuál grupo de altura presenta el mayor promedio de rendimiento?

#Pregunta 3: ¿Qué indica la prueba de Tukey sobre las diferencias entre grupos?


#2. PERMANOVA

#La PERMANOVA permite evaluar diferencias multivariadas entre grupos utilizando matrices de distancia.

# Seleccionar variables necesarias incluyendo el grupo
datos_perm <- barley %>%
  
  select(PH_group, Area, B_glucan, Diameter, DTH,
         
         Fe, GY, HW, Length, Protein, TKW, Zn)

# Eliminar filas con NA en cualquier variable
datos_perm_clean <- na.omit(datos_perm)

# Variables cuantitativas
traits_clean <- datos_perm_clean %>%
  
  select(-PH_group)

# Distancia euclidiana
trait_dist <- dist(traits_clean, method = "euclidean")

# Factor de grupos
groups <- as.factor(datos_perm_clean$PH_group)

# PERMANOVA
permanova <- adonis2(trait_dist ~ groups)

# Ver resultados
print(permanova)

#Pregunta 1: ¿Existen diferencias multivariadas entre los grupos de altura de planta?

#Pregunta 2: ¿Qué representa el valor F en la PERMANOVA?

#Pregunta 3: ¿Por qué se utiliza una matriz de distancia euclidiana?


#3. Análisis de Coordenadas Principales (PCoA)

#El PCoA permite visualizar relaciones entre accesiones usando distancias multivariadas.

# PCoA
pcoa_res <- pcoa(trait_dist)
# Crear dataframe para graficar
pcoa_df <- data.frame(
  Axis1 = pcoa_res$vectors[,1],
  Axis2 = pcoa_res$vectors[,2],
  Group = groups
)
# Graficar
ggplot(pcoa_df, aes(x = Axis1, y = Axis2, color = Group)) +
  geom_point(size = 3, alpha = 0.8) +
  theme_minimal() +
  labs(title = "PCoA de accesiones de cebada",
       x = "PCoA 1",
       y = "PCoA 2")

#Pregunta 1: ¿Qué representan los ejes principales en el PCoA?

#Pregunta 2: ¿Qué significa que dos accesiones aparezcan cercanas en el gráfico?

#Pregunta 3: ¿Qué interpretación puede darse a grupos separados en el PCoA?


#4. Prueba Chi-cuadrado

#La prueba Chi-cuadrado permite evaluar asociaciones entre variables categóricas.

#En este ejemplo se clasificará el contenido de proteína y el peso de mil granos (TKW).

# Crear categorías
barley$Protein_group <- ifelse(barley$Protein > median(barley$Protein, na.rm = TRUE),
                               "Alta", "Baja")
barley$TKW_group <- ifelse(barley$TKW > median(barley$TKW, na.rm = TRUE),
                           "Alto", "Bajo")
# Tabla de contingencia
tabla <- table(barley$Protein_group, barley$TKW_group)
tabla
# Chi-cuadrado
chisq.test(tabla)

#Visualización

mosaicplot(tabla,
           color = TRUE,
           main = "Chi-cuadrado entre proteína y TKW")

#Pregunta 1: ¿Existe asociación entre el contenido de proteína y el TKW?

#Pregunta 2: ¿Qué indica una alta frecuencia en una categoría específica?

#Pregunta 3: ¿Por qué convertir variables continuas en categorías?


#5. Correlación entre Caracteres Cuantitativos

#La correlación es ampliamente utilizada en genética cuantitativa para evaluar relaciones entre rasgos agronómicos.

# Variables cuantitativas
corr_data <- barley %>%
  select(Area, B_glucan, Diameter, DTH, Fe,
         GY, HW, Length, Protein, TKW, Zn)
# Matriz de correlación
corr_matrix <- cor(corr_data,
                   use = "pairwise.complete.obs")
# Visualización
corrplot(corr_matrix,
         method = "color",
         type = "upper",
         tl.cex = 0.8,
         number.cex = 0.7)

#Pregunta 1: ¿Qué significa una correlación positiva entre TKW y GY?

#Pregunta 2: ¿Qué representa una correlación negativa?

#Pregunta 3: ¿Cuál es el rango posible de un coeficiente de correlación?



#6. PCA (Análisis de Componentes Principales)

#El PCA es una de las herramientas más utilizadas en fitogenética para explorar diversidad fenotípica.

# Eliminar NA
pca_data <- na.omit(corr_data)
# PCA
pca_res <- PCA(pca_data, graph = FALSE)
# Eigenvalues
fviz_eig(pca_res)

#Biplot PCA

fviz_pca_biplot(pca_res,
                repel = TRUE,
                col.var = "black",
                col.ind = "blue")


#Pregunta 1: ¿Cuál es el objetivo principal del PCA?

#Pregunta 2: ¿Qué indica un componente principal con alto porcentaje de varianza?

#Pregunta 3: ¿Qué significa que dos variables apunten en la misma dirección en el biplot?


#7. Regresión Lineal

#La regresión lineal permite modelar la relación entre variables cuantitativas.

#Ejemplo: efecto del peso de mil granos (TKW) sobre rendimiento (GY).

# Modelo lineal
lm_model <- lm(GY ~ TKW, data = barley)
summary(lm_model)

#Visualización

ggplot(barley, aes(x = TKW, y = GY)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  theme_minimal() +
  labs(title = "Relación entre TKW y rendimiento",
       x = "TKW",
       y = "Grain Yield")


#Pregunta 1: ¿Qué interpreta la pendiente de la regresión?

#Pregunta 2: ¿Qué significa un R² alto?

#Pregunta 3: ¿Qué indica un valor p significativo en la regresión?

#8. Clustering Jerárquico

#El análisis de agrupamiento permite identificar accesiones similares.

# Clustering
hc <- hclust(trait_dist, method = "ward.D2")
# Dendrograma
plot(hc,
     labels = FALSE,
     main = "Clustering jerárquico de accesiones",
     xlab = "Accesiones",
     sub = "")

#Pregunta 1: ¿Qué representa cada rama del dendrograma?

#Pregunta 2: ¿Qué significa una distancia pequeña entre accesiones?

#Pregunta 3: ¿Cómo puede utilizarse el clustering en mejoramiento genético?
