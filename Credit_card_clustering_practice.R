# Carregando os pacotes
pacotes <- c("plotly", 
             "tidyverse", 
             "ggrepel", 
             "knitr", 
             "kableExtra",
             "reshape2",
             "misc3d",
             "plot3D", 
             "cluster", 
             "factoextra")

sapply(pacotes, require, character = T)

# Importando dataset

df <- read.csv('CC GENERAL_tratado.csv')
rownames(df) <- df[,2]

# Removendo Colunas que não usaremos no agrupamento
df <- df[,-2:-1]
View(df)

# Como temos variáveis com grandez diferentes, precisamos fazer a padronização por z-score
df_padronizado <- as.data.frame(scale(df[,1:17]))
View(df_padronizado)

# Checando se a padronização foi correta
round(mean(df_padronizado$BALANCE),3)
round(sd(df_padronizado$BALANCE),3)
# Média 0 e desvio padrão 1

### Método Hierárquico Aglomerativo ### 

## Matriz de Dissimilaridade
matriz_D <- df_padronizado[,] %>%
  dist(method = 'euclidean')
matriz_D

## Clusterização com complete linkage

cluster_hier <- agnes(matriz_D, method = 'complete')

## Visualização do dendograma formado
dev.off()
fviz_dend(x = cluster_hier, show_labels = F)




