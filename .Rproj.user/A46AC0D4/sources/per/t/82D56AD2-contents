#library(esquisse)
library(readxl)
library(ggplot2)
library(plotly)
library(dplyr)
library(readr)
library(tidyverse)
library(readxl)
library(knitr)
library(ggvis)


#Importar base de dado de realiza
Resultados_Realiza <- read_excel("Resultados__Realiza.xls")
#esquisser(localdate)
## Grafico de Geografia, formalização e 
## lucro (áreas para próxima mobilização com o perfil necessário)

#Dona de Negocio
donaNegocio <- Resultados_Realiza %>%
    group_by(Dona_negocio) %>%
  summarise(n = n()) %>% 
   ungroup() 

localdate <- Resultados_Realiza %>%
  group_by(local, Dona_negocio) %>%
  summarise(n = n()) %>% 
  ungroup() 

 
ggplot(donaNegocio) +
  aes(x = Dona_negocio, y = n, fill = Dona_negocio, label=n  ) +
  geom_col()+geom_text()  + ylab("Nr Empreendedoras")  + theme_bw() + 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
     
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+ggtitle("Are you a business owner?")

 
localdate %>%
 filter(Dona_negocio %in% "SIM") %>%
 ggplot() +
 aes(x = local, y = n, fill = local, label=n ) +
 geom_col(stat='identity', position = 'dodge') +geom_text()+
 scale_fill_hue(direction = 1)+ ylab("Nr Empreendedoras") + xlab("Cidade")  + theme_bw() + 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+ggtitle("Businesswoman's Residence")


#Formalizacao vs local  e lucro vs local 
formal <- Resultados_Realiza %>%
  filter(Dona_negocio %in% "SIM"  ) %>%
  group_by(local,  registo_negocio) %>%
  summarise(n = n()) %>%   mutate(perc=n/sum(n))    
   

#Formalizacao vs local  e lucro vs local 
lucro <- Resultados_Realiza %>%
  filter(Dona_negocio %in% "SIM"  ) %>%
  group_by(local,  Lucro) %>%
  summarise(n = n()) %>%   mutate(perc=(n/sum(n))*100)    


 

ggplot(formal) +
 aes(x = local, y = round(perc, digits = 2), fill = registo_negocio,group =registo_negocio,label=round(perc*100, digits = 1))+
  geom_col() + 
  geom_text(size = 3, position = position_stack(vjust = 0.5))+
  +
 scale_fill_hue(direction = 1) + ylab("Percentagem") + xlab("Cidade")  + theme_bw() + 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.position="top",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+ggtitle("Business is formal ")

##lucro



ggplot(lucro) +
 aes(x = local, y = round(perc, digits = 1), fill = Lucro) +
 geom_col() + 
  geom_text(aes(label=round(perc, digits = 1)), size = 3, position = position_stack(vjust = 0.5))+
  scale_fill_hue(direction = 1) + ylab("Percentagem") + xlab("Cidade")  + theme_bw() + 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.position="top",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+ggtitle("The profits of female entrepreneurs during the last monthl")
 