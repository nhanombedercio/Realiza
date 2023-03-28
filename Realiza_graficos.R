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
library(esquisse)

 

#Importar base de dado de realiza
Resultados_Realiza <- read_excel("Resultados__Realiza.xls")
Selecionadas_Realiza <- read_excel("Selecionadas__Realiza.xls")
## Grafico de Geografia, formalização e 
## lucro (áreas para próxima mobilização com o perfil necessário)
  
###Formal VS tempo de negicio

  formal_tempo<-Selecionadas_Realiza %>% filter(Negóciocomregisto=="SIM")%>% 
    group_by(Tempo_Negocio)%>% summarise(n=n()) %>% mutate(perc=n/sum(n)*100,Negóciocomregisto="SIM",percentagem=round(perc, digits = 0))

  informal_tempo<-Selecionadas_Realiza %>% filter(Negóciocomregisto=="NAO")%>% 
    group_by(Tempo_Negocio)%>% summarise(n=n()) %>% mutate(perc=n/sum(n)*100,Negóciocomregisto="NAO",percentagem=round(perc, digits = 0))

  formal_tempo1<-rbind(formal_tempo, informal_tempo)
   
   negocio_tempo<-Resultados_Realiza %>% group_by(registo_negocio,Tempo_Negocio)%>% summarise(n=n()) %>% mutate(perc=n/sum(n)*100,percentagem=round(perc, digits = 0))
   negocio_tempoS<-Selecionadas_Realiza %>% group_by(Negóciocomregisto,Tempo_Negocio)%>% summarise(n=n()) %>% mutate(perc=n/sum(n)*100,percentagem=round(perc, digits = 0))
   
   negocio_lucro<-Resultados_Realiza %>% group_by(Lucro,Tempo_Negocio)%>% summarise(n=n()) %>% mutate(perc=n/sum(n)*100,percentagem=round(perc, digits = 0))
   negocio_lucroS<-Selecionadas_Realiza %>% group_by(Lucro,Tempo_Negocio)%>% summarise(n=n()) %>% mutate(perc=n/sum(n)*100,percentagem=round(perc, digits = 0))
   
   
library(ggplot2)

ggplot(negocio_tempoS) +
 aes(x = Tempo_Negocio, y = n, colour = Negóciocomregisto) +
 geom_point(shape = "circle", 
 size = 4L) +
 scale_color_hue(direction = 1) +
 labs(x = "Tempo negocio (Ano)", y = "Empreendedoras", 
 title = "Selecionadas", subtitle = "Formalização vs Tempo de negocio", color = "Formalização") +
 theme_light()  +  scale_y_continuous(limits = c(0, 400), breaks = seq(0, 450, by = 100))

   
   negocio_tempo %>%
     filter(!is.na(negocio_lucro)) %>%
     ggplot() +
     aes(x = Tempo_Negocio, y = n, colour = registo_negocio) +
     geom_point(shape = "circle", size = 4L) +
     scale_color_manual(
       values = c(NAO = "#8121A6",
                  SIM = "#FF7B61")
     ) +
     labs(
       x = "Tempo do Negocio (anos)",
       y = "Nr Empreendedoras ",
       color = "Negocio Formal?"
     ) +
     theme_light() +
     xlim(1, 10) +
     ylim(0, 600)
 


ggplot(negocio_tempo) +
 aes(x = Tempo_Negocio, y = n, colour = registo_negocio) +
  geom_point(shape = "circle", 
             size = 4L) +
  scale_color_hue(direction = 1) +
  labs(x = "Tempo de negocio (ano)", y = "Nr Empreendedoras", 
       title = "Inscritas", subtitle = "Formalização vs tempo do negocio", color = "Negocio formal?") +
  theme_light() +
  ylim(0, 1500)

library(ggplot2)

ggplot(negocio_lucroS) +
 aes(x = Tempo_Negocio, y = percentagem, colour = Lucro) +
 geom_point(shape = "circle", 
 size = 4L) +
 scale_color_hue(direction = 1) +
 labs(x = "Tempo de negocio (ano)", y = "Percentagem", 
 title = "Selecionadas", subtitle = "Tempo de negocio vs Lucro", color = "Lucro") +
  theme_light() +
 ylim(0, 50)
 



esquisser(formal_tempo)