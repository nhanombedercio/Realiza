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
  aes(x = Dona_negocio, y = n, fill = Dona_negocio  ) +
  geom_col()+ 
  geom_text(aes(label=n), size = 3, position = position_stack(vjust = 0.5))+
  scale_fill_hue(direction = 1) + ylab("Nr Empreendedoras") + xlab("")  + theme_bw() + 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.position="bottom",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+   guides(fill=guide_legend("Are you a business owner?"))
  
   
 
localdate %>%
 filter(Dona_negocio %in% "SIM") %>%
 ggplot() +
 aes(x = local, y = n, fill = local ) +
 geom_col(stat='identity', position = 'dodge') +
  geom_text(aes(label=n), size = 4, position = position_stack(vjust = 0.5))+
  scale_fill_hue(direction = 1) + ylab("Nr Empreendedoras")   + theme_bw() + 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.position="bottom",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+scale_y_continuous(limits=c(0,6000))+ggtitle("business owners by city")+guides(fill=guide_legend("Cidade de residencia"))
  
 


#Formalizacao vs local  e lucro vs local 
formal <- Resultados_Realiza %>%
  filter(Dona_negocio %in% "SIM"  ) %>%
  group_by(local,  registo_negocio) %>%
  summarise(n = n()) %>%   mutate(perc=n/sum(n)) %>% 
  mutate(percentagem=round(perc, digits = 3)*100 )    
   

#Formalizacao vs local  e lucro vs local 
lucro <- Resultados_Realiza %>%
  filter(Dona_negocio %in% "SIM"  ) %>%
  group_by(local,  Lucro) %>%
  summarise(n = n()) %>%  
  mutate(perc=(n/sum(n))*100) %>% 
  mutate(percentagem=round(perc, digits = 1) )%>% 
  mutate(percentagem1= as.character(percentagem)) %>%
  mutate(simb= "%" ) %>% 
  bind_rows(percentagem1,simb)  
 

ggplot(formal) +
 aes(x = local, y =percentagem , fill = registo_negocio,group =registo_negocio)+
  geom_col() + xlab("")+ 
  geom_text(aes(label=percentagem), size = 4, position = position_stack(vjust = 0.5))+
  scale_fill_hue(direction = 1) + ylab("Percentagem") 
+ theme_bw() + 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.position="bottom",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+
  ggtitle("Business is formal")
+guides(fill=guide_legend("sdfsdf"))



  
  
  
  

##lucro



ggplot(lucro) +
 aes(x = local, y = round(perc, digits = 1), fill = Lucro) +
 geom_col() + 
  geom_text(aes(label=round(perc, digits = 1)), size = 3, position = position_dodge(0.9))+
  scale_fill_hue(direction = 1) + ylab("Percentagem") + 
  xlab("Lucro das empreendedoras") + theme_bw()+guides(fill=guide_legend("")) + 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.position="bottom",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+ggtitle("Profit from mobilized women entrepreneurs")




##ucro,tem_trabalhador 
Resultados_Realiza %>%
  filter(Dona_negocio %in% "SIM") %>%  group_by(Lucro,tem_trabalhador ) %>%
  summarise(n = n()) %>%   mutate(perc=(n/sum(n))*100) %>% 
  mutate(percentagem=round(perc, digits = 3) ) %>% 
  mutate(Gpercentagem="percentagem"+"%" ) %>% 
  ggplot() +
  aes(x = Lucro, y=percentagem,  fill =tem_trabalhador ) +
  geom_col(position = "dodge", stat="identity") +
  scale_fill_hue(direction = 1) +
  theme_minimal()+scale_y_continuous(limits=c(0,100))+
  geom_text(aes(label=Gpercentagem), size = 4,position = position_dodge(0.9), vjust=-0.25)+
  scale_fill_hue(direction = 1) + ylab("Percentagem") + 
  xlab("Lucro das empreendedoras") + theme_bw()+guides(fill=guide_legend("")) + 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.position="bottom",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    #axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 20))+guides(fill=guide_legend("Tem Trabalhador?"))
 

## 
##Tempo vs Lucro
ggplot(Resultados_Realiza) +
  aes(x = Tempo_Negocio, y = registo_negocio,fill = registo_negocio) +
  geom_boxplot() +scale_x_discrete(limits=c(0 ,2 ,4 ,6 ,8 ,10))+  
  scale_fill_hue(direction = 1) + ylab("Seu negocio esta registado?") + 
  xlab("Tempo no negocio (Anos)") + theme_bw()+
  guides(fill=guide_legend("")) + 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.position="bottom",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    #axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+guides(fill=guide_legend("Seu negocio esta registado?"))
 

##Rede socil vs lucro

Resultados_Realiza %>%
  filter(Dona_negocio %in% "SIM")%>%  group_by(Lucro, rede_social) %>%
  summarise(n = n()) %>% mutate(perc=(n/sum(n))*100) %>% mutate(percentagem=as.character(perc)) %>% 
  ggplot() +aes(x = Lucro, y=perc,fill = rede_social) +
  geom_col()+scale_fill_hue(direction = 1) + ylab("Percentagem") + 
  xlab("Lucro (meticais)") +guides(fill=guide_legend("Seu negócio usa rede social, \n email ou website para vender \n ou comunicar com clientes?"))+ 
  geom_text(aes(label=round(perc, digits = 0)), size = 4,position = position_stack(vjust = 0.5))+theme_bw()+ 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.position="bottom",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    #axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+scale_x_discrete(labels = function(x) str_wrap(x, width = 20))

 
##Ano de negocio lucro
 
Resultados_Realiza %>%
 filter(Dona_negocio %in% "SIM") %>%
 ggplot() +
 aes(x = Tempo_Negocio, y = Lucro,fill=Lucro ) +
 geom_boxplot() +scale_fill_hue(direction = 1) +
  xlab("Tempo de negocio (ano)")+scale_x_discrete(limits=c(0 ,2 ,4 ,6 ,8 ,10))+theme_bw()+
   theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.position="bottom",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    #axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+scale_y_discrete(labels = function(y) str_wrap(y, width = 20))


###Selecionadas

 
Selecionadas_Realiza %>%  group_by(Local) %>%
  summarise(n = n()) %>% mutate(perc=(n/sum(n))*100) %>%
ggplot() +  aes(x = Local, y=n, fill=Local) +
  geom_col() +
  geom_text(aes(label=n), size = 4,position = position_stack(vjust = 0.5))+ 
  scale_y_continuous(limits=c(0 ,1500))+
  scale_fill_hue(direction = 1) + ylab("Nr Empreendedoras") + xlab("")  + theme_bw() + 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.position="none",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+guides(fill=guide_legend("Local"))+
  ggtitle("Selected Entrepreneurs")

##PERFIL 
Selecionadas_Realiza %>% group_by(Local, Perfil) %>%
  summarise(n = n()) %>% mutate(perc=(n/sum(n))*100)%>%
  ggplot() +
  aes(x = Local, y=perc, fill = Perfil) +
  geom_col() +
  geom_text(aes(label=round(perc,digits = 0)), size = 4,position = position_stack(vjust = 0.5))+ 
  scale_y_continuous(limits=c(0 ,100))+
  scale_fill_hue(direction = 1) + ylab("Percentagem") + xlab("")  + theme_bw() + 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.position="none",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+guides(fill=guide_legend("Perfil"))+
  ggtitle("Business profile of the selected companies")

 
###Lucro das selecionadas por Cidade
Selecionadas_Realiza %>%
  group_by(local, Lucro) %>%
  summarise(n = n()) %>% mutate(perc=(n/sum(n))*100) %>% 
  mutate(percentagem=round(perc, digits = 0) ) %>% 
  ggplot() +
  aes(x = local, y=percentagem, fill =Lucro) +
  geom_col() +
  scale_fill_hue(direction = 1) +
  theme_minimal()+scale_y_continuous(limits=c(0,100))+  
  geom_text(aes(label=percentagem), size = 4,position = position_stack(0.5), vjust=-0.5)+
  scale_fill_hue(direction = 1) + ylab("Percentagem") + 
  xlab("Cidade de Residencia") + theme_bw()+guides(fill=guide_legend("")) + 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.position="bottom",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    #axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+
  ggtitle("Profit of the selected entrepreneurs ")
#+
##  scale_x_discrete(labels = function(x) str_wrap(x, width = 20))+guides(fill=guide_legend("Tem Trabalhador?"))
#esquisser(Selecionadas_Realiza)

### NEGOCIO FORMAL DAS SELECIONADAS
Selecionadas_Realiza %>%
  group_by(local, Negóciocomregisto) %>%
  summarise(n = n()) %>% mutate(perc=(n/sum(n))*100) %>% 
  mutate(percentagem=round(perc, digits = 0) ) %>% 
  ggplot() +
  aes(x = local, y=percentagem, fill =Negóciocomregisto) +
  geom_col() +
  scale_fill_hue(direction = 1) +
  theme_minimal()+scale_y_continuous(limits=c(0,100))+  
  geom_text(aes(label=percentagem), size = 4,position = position_stack(0.5), vjust=-0.5)+
  scale_fill_hue(direction = 1) + ylab("Percentagem") + 
  xlab("Cidade de Residencia") + theme_bw()
+guides(fill=guide_legend("Teu negócio esta registado?")) + 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.position="bottom",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    #axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+
  ggtitle("Formalizing the business of women entrepreneurs")


### Trabalhador vs Lucro
Selecionadas_Realiza  %>%
  group_by(Lucro,Temtrabalhador) %>%
  summarise(n = n()) %>% mutate(perc=(n/sum(n))*100) %>% 
  mutate(percentagem=round(perc, digits = 0) ) %>% 
  ggplot() +
  aes(x =Lucro , y=percentagem, fill=Temtrabalhador) +
  geom_col() +
  scale_fill_hue(direction = 1) +
  theme_minimal()+scale_y_continuous(limits=c(0,100))+  
  geom_text(aes(label=percentagem), size = 4,position = position_stack(0.2), vjust=-0.5)+
  scale_fill_hue(direction = 1) + ylab("Percentagem") + 
  xlab("Lucro") + theme_bw()+guides(fill=guide_legend("Tem trabalhador?")) + 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.position="bottom",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    #axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+scale_x_discrete(labels = function(x) str_wrap(x, width = 20))+
  ggtitle("Profit of women entrepreneurs with \n and without workers")

### Tempo vs registo
ggplot(Selecionadas_Realiza) +
  aes(
    x = Tempo_Negocio,
    y = Negóciocomregisto,
    fill = Negóciocomregisto
  ) +
  geom_boxplot()+scale_fill_hue(direction = 1)+ylab("Teu negócio \n esta registado?")+xlab("Tempo de negocio (ano)")+scale_x_discrete(limits=c(0 ,2 ,4 ,6 ,8 ,10))+theme_bw()+guides(fill=guide_legend("Teu negócio \n esta registado?"))
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.position="bottom",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    #axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
   )+scale_y_discrete(labels = function(y) str_wrap(y, width = 20))
  
  ### 
  ##Ano de negocio lucro
  
  Selecionadas_Realiza %>%
    ggplot() +
    aes(x = Tempo_Negocio, y = Lucro,fill=Lucro ) +
    geom_boxplot() +scale_fill_hue(direction = 1) +
    xlab("Tempo de negocio (ano)")+scale_x_discrete(limits=c(0 ,2 ,4 ,6 ,8 ,10))+theme_bw()+
    theme(
      plot.title = element_text(face = "bold", size = 12),
      legend.background = element_rect(fill = "white", size = 4, colour = "white"),
      #legend.position="bottom",
      axis.ticks = element_line(colour = "grey70", size = 0.2),
      #axis.text.x = element_text(angle = 45, hjust = 1),
      panel.grid.major = element_line(colour = "grey70", size = 0.2),
      panel.grid.minor = element_blank()
    )+scale_y_discrete(labels = function(y) str_wrap(y, width = 20))

  
  ##Rede socil vs lucro
  
  Selecionadas_Realiza %>%
    group_by(Lucro, rede_social) %>%
    summarise(n = n()) %>% mutate(perc=(n/sum(n))*100) %>% mutate(percentagem=as.character(perc)) %>% 
    ggplot() +aes(x = Lucro, y=perc,fill = rede_social) +
    geom_col()+scale_fill_hue(direction = 1) + ylab("Percentagem") + 
    xlab("Lucro (meticais)") +guides(fill=guide_legend("Seu negócio usa rede social, \n email ou website para vender \n ou comunicar com clientes?"))+ 
    geom_text(aes(label=round(perc, digits = 0)), size = 4,position = position_stack(vjust = 0.5))+theme_bw()+ 
    theme(
      plot.title = element_text(face = "bold", size = 12),
      legend.background = element_rect(fill = "white", size = 4, colour = "white"),
      legend.position="bottom",
      axis.ticks = element_line(colour = "grey70", size = 0.2),
      #axis.text.x = element_text(angle = 45, hjust = 1),
      panel.grid.major = element_line(colour = "grey70", size = 0.2),
      panel.grid.minor = element_blank()
    )+scale_x_discrete(labels = function(x) str_wrap(x, width = 20))
  

  
  ###IDADE
  IDADE <- Resultados_Realiza %>%
    filter(Dona_negocio %in% "SIM" )

 
ggplot(IDADE) +
 aes(x = Idade, y = registo_negocio, fill = registo_negocio) +
 geom_boxplot() +
 scale_fill_hue(direction = 1) +
 theme_minimal() +
 facet_wrap(vars(local))+ggtitle("Idade das mobilizadas")

ggplot(IDADE) +
 aes(x = Idade, y =local, fill=local) +
 geom_boxplot() +
 scale_fill_hue(direction = 1) +
 theme_minimal()+
  ggtitle("Idade das mobilizadas")
   
##Tipo de negocio
tab<- Selecionadas_Realiza  %>%
  group_by(tiPo_negocio,Lucro) %>%
  summarise(n = n()) %>% mutate(perc=(n/sum(n))*100) 


library(ggplot2)

ggplot(tab) +
 aes(x = tiPo_negocio, y = perc, fill =Lucro ) +
  geom_col()+scale_fill_hue(direction = 1) + ylab("Percentagem") + 
  xlab("Lucro") +guides(fill=guide_legend("Lucro do negocio"))+ 
  geom_text(aes(label=round(perc, digits = 0)), size = 4,position = position_stack(vjust = 0.5))+theme_bw()+ 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    #legend.position="bottom",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    #axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )+scale_x_discrete(labels = function(x) str_wrap(x, width = 20))


#### ASSALARIADOS 

mobi_assalariado<- Selecionadas_Realiza  %>%
  group_by(trabalhador_salario) %>%
  summarise(n = n()) %>% mutate(perc=(n/sum(n))*100)


library(ggplot2)

ggplot(mobi_assalariado) +
 aes(x = trabalhador_salario, y = perc, fill = trabalhador_salario) +
 geom_col() +
 scale_fill_hue(direction = 1) +
 theme_minimal()+scale_fill_hue(direction = 1) + ylab("percentage") + 
  xlab("Have salaried workers") +guides(fill=guide_legend("Have salaried workers"))+ 
  geom_text(aes(label=round(perc, digits = 0)), size = 4,position = position_stack(vjust = 0.5))+theme_bw()+ 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    #legend.position="bottom",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    #axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  ) +scale_y_continuous(limits=c(0,100))
 

#### ASSALARIADOS 

mobizadas_assalariado<- Resultados_Realiza  %>%
  group_by(trabalhador_salario) %>%
  summarise(n = n()) %>% mutate(perc=(n/sum(n))*100)


library(ggplot2)

ggplot(mobizadas_assalariado) +
  aes(x = trabalhador_salario, y = perc, fill = trabalhador_salario) +
  geom_col() +
  scale_fill_hue(direction = 1) +
  theme_minimal()+scale_fill_hue(direction = 1) + ylab("percentage") + 
  xlab("Have salaried workers") +guides(fill=guide_legend("Have salaried workers"))+ 
  geom_text(aes(label=round(perc, digits = 0)), size = 4,position = position_stack(vjust = 0.5))+theme_bw()+ 
  theme(
    plot.title = element_text(face = "bold", size = 12),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    #legend.position="bottom",
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    #axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  ) +scale_y_continuous(limits=c(0,100))

