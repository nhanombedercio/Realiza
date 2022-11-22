clear all 
set more off
*---------------------------------------------------------------------------------------------------------------------------

*---------------------------------------------------------------------------------------------------------------------------
*** Projeto: Muva link
*** Analista: Dercio   
*** Data: 17/05/2021
*---------------------------------------------------------------------------------------------------------------------------
 
 
*****CRIANDO CAMINHO
*---------------------------------------------------------------------------------------------------------------------------
	if c(username) =="Dercio" {

			 global geral "C:\Users\Dercio\Dropbox (OPML)\MIS\Maputo\Data Management\08 Realiza"
		     global input "$geral\01 Data Raw"
		     global output "$geral\02 Data Clean"
  
	}
	else {
	
		global geral "C:\Users\Vania\Dropbox (OPML)\MIS\Maputo\Data Management\08 Realiza"
		*C:\Users\Vania\Dropbox (OPML)\MIS MAPUTO\Maputo\Data Management\04 RCT\03 Dofile
		global input "$geral\01 Data Raw"
		global output "$geral\02 Data Clean"
	}
	 
	*----------------------------------------------------------------------------------------------------------------------------		
			
	 ***Criando ficheiros temporarios 
	 *----------------------------------
	 tempfile Geral base1 base2 1 2 3 4 5 6 7 8
	 *----------------------------------

  *\01 Data Raw\01 Registo\Candidatos Report.xls"

	 import excel "C:\Users\Dercio\Dropbox (OPML)\MIS\Marambe\Maputo\Data Management\08 Realiza\01 Data Raw\01 Registo\Candidatos Report.xls", sheet("Candidatos_Report") firstrow clear 
	  

	 ****---------------------------- Limpeza dos dados -----------------------
	 *apagar variaveis desnecessarias 
	 *-------------------------------------------------------------------------
    
	       
	 *alterar nome das variaveis  
	 *-------------------------------------------------------------------------	
 
 
	 rename DatadeNascimento data_nasc
	 ren Vocêconcordaemrealizarainsc consetimento
	 *ren ContactoTelefónico Telefone
	 *ren ContactoTelefónicoAlternativo Telefone_2
	 ren ComoficousabendodoprogramaR referencia
	 ren Escreveonomedeumfamiliarou familiar_proximo
	 *ren Contactotelefónicodessefamili Telefone_familiar
	 ren Vocêéproprietáriaegestorade Dona_negocio
	 ren Qualéonomedonegócio Nome_negocio
	 ren Emqueanoseunegóciocomeçou inicio_negocio
	 ren Qualéaprincipalactividadedo Actividade_negocio
	 ren Quantaspessoasajudantesoutr numero_trabalhador
	 ren Oseunegóciotemajudantesout tem_trabalhador
	 ren Quaisforamoslucrosdoseuneg Lucros 
	 ren Oseunegóciopossuiumendereço Negocio_tem_Endereco
	 ren Indiqueoendereçodonegocior endereco_negocio
	 ren Seunegóciopossuialgumdosseg Comunicacao_negocio
	 ren Qualéonomedeusuáriodonego facebook_negocio
	 ren Qualéoseuendereçodeemail email_negocio
	* ren QualénumerodoWhatsAppdose whatssap_negocio
	 ren Qualasualocalidade cidade
	 ren  Qualéseubairroderesidência bairro
	 ren Contactotelefónicoalternativo telefone_alterrnativo_familiar
	 ren Escreveoseuendereçoporescri seu_endereco_escrito
	 ren Especifiquecomoteveainformaç especifique_referencia
	 ren Quantostrabalhadoresajudantes numero_trab_com_salario
	 ren Qualéoinstagramdaempresaou instagram_negocio
	 ren Qualéowebsitedasuaempresa website_negocio
	 ren Vocênosautorizaacontatálac autorzacao_contacto
	 ren Especifiqueaoutraactividaded outra_actividade
	 ren Ondeestalocalizadaoseunegoc Cidade_negocio
	 ren Bairroondeestalocalizadoose Bairro_negocio
	 ren NomeCompleto Nome
	 drop cidade
  
     
	 ***Organizar variaveis
	tostring especifique_referencia, replace
    foreach i in Nome consetimento referencia  Dona_negocio ///
	Nome_negocio Actividade_negocio Oteunegocioestáregistado ///
	tem_trabalhador Lucros Negocio_tem_Endereco endereco_negocio seu_endereco_escrito ///
	Comunicacao_negocio facebook_negocio email_negocio Cidade bairro ///
	 instagram_negocio especifique_referencia  ///
	autorzacao_contacto Bairro_negocio Cidade_negocio outra_actividade {
	replace `i' = itrim(`i')
	replace `i' = trim(`i')
	replace `i' = rtrim(`i')
	replace `i' = subinstr(`i', "ç", "c", .) 
	replace `i' = subinstr(`i', "Ç", "c", .)
	replace `i' = subinstr(`i', "ã", "a", .)
	replace `i' = subinstr(`i', "Ã", "a", .)
	replace `i' = subinstr(`i', "á", "a", .)
	replace `i' = subinstr(`i', "Á", "a", .)
	replace `i' = subinstr(`i', "à", "a", .)
	replace `i' = subinstr(`i', "À", "a", .)
	replace `i' = subinstr(`i', "é", "e", .)
	replace `i' = subinstr(`i', "É", "e", .)
	replace `i' = subinstr(`i', "È", "e", .)
	replace `i' = subinstr(`i', "è", "e", .)
	replace `i' = subinstr(`i', "â", "a", .)
	replace `i' = subinstr(`i', "Â", "e", .)
	replace `i' = subinstr(`i', "ê", "e", .)
	replace `i' = subinstr(`i', "Ê", "e", .)
	replace `i' = subinstr(`i', "ô", "o", .)
	replace `i' = subinstr(`i', "Ô", "o", .)
	replace `i' = subinstr(`i', "ó", "o", .)
	replace `i' = subinstr(`i', "Ó", "o", .)
	replace `i' = subinstr(`i', "õ", "o", .)
	replace `i' = subinstr(`i', "Õ", "o", .)
	replace `i' = subinstr(`i', "ú", "u", .)
	replace `i' = subinstr(`i', "Ú", "u", .)
	replace `i' = subinstr(`i', "í", "i", .)
	replace `i' = subinstr(`i', "Í", "i", .)
	replace `i' = subinstr(`i', "ì", "i", .)
	replace `i' = subinstr(`i', "Ì", "i", .)
	replace `i' = upper(`i')
	}	 
	 ren Oteunegocioestáregistado registo_negocio
	 
 
	 *bysort Nome: gen dup_name=_n
 
	 *drop if dup_name>1
	 *drop dup_name
	 
		 *bysort Telefone: gen dup_Telefone=_n
 
	 *drop if dup_Telefone>1
	 *drop dup_Telefone 
	 
	 
	  gen ano_nasc=year(data_nasc) 
     gen Idade=.
	 replace Idade=2022-ano_nasc
	 
	 
	 *tostring Idade, replace
    save `1', replace 
  
  import excel "C:\Users\Dercio\Dropbox (OPML)\MIS\Marambe\Maputo\Data Management\08 Realiza\02 Data Clean\01 Registo\Realiza pre-selected candidates - 1st list.xls", sheet("Sheet1") firstrow clear 
  destring Idade, replace
 merge m:m Nome using `1'
  
   gen lista=2
   replace lista=1 if Perfil!=""
  
	  gen local=""
	 replace local="BEIRA" if  Cidade=="BEIRA"
	 replace local="MAPUTO" if Cidade=="CIDADE DE MAPUTO" | Cidade=="MATOLA" | /// 
							   Cidade=="BOANE" | Cidade=="MARRACUENE" | Cidade=="MOAMBA" | ///
							   Cidade=="NAMAACHA" | Cidade=="MANHICA"
	 replace local="NAMPULA" if Cidade=="NAMPULA" 

	 
 
	/******************************************************************************************
	                     SELECAO RCT
	******************************************************************************************/
	
	/*********************************************************************
	
	CRITERIOS DE SELECAO 
	
	----------------------
	1 * NEGOCIO REGISTADO OU
	----SE NAO ENTAO REGISTADO, ENTAO
	2 * COM TRABALHADORES E PELO MENOS 2 ANOS DE FUNCIONALIDADE
	3 * COM LUCRO DE PELO MENOS 10 MIL E COM TRABALHADORES 
	4 * COM LUCRO DE PELO MENOS 10 mIEL E PELO MENOS 2 ANOS DE FUNCIONALIDADE
	5 * COM PELO MENOS 10 MIL DE LUCRO, COM TRABALHADORES E 2 ANOS DE FUNCIONALIADE
	*************************************************************************************************/
	
	
	gen Tempo_Negocio=.
	replace Tempo_Negocio=2022-inicio_negocio
	
	
	gen Status="NAO SELECIONADA"
	gen perfil="SEM PERFIL DESEJADO"
	
	*--------------------------------------------------------------------------------
	**** 1 *SELECIONAR NEGOCIOS REGISTADOS 
	*--------------------------------------------------------------------------------
	
	replace Status="SELECIONADA" if registo_negocio=="SIM"
	replace perfil="COM NEGOCIO REGISTADO" if registo_negocio=="SIM"
	
	  
	*********-------------------------------------------------------------------------------------------
	****2* SELECIONAR NEGOCIO NAO REGISTADOS, COM TRABALHADORES E COM PELO MENOS 2 ANOS DE FUNCIONALIDADE
	********----------------------------------------------------------------------------------------------
	
	replace Status="SELECIONADA" if tem_trabalhador=="SIM" & Tempo_Negocio>=2
	replace perfil="COM MAIS DE 2 ANOS E COM TRABALHADORES" if tem_trabalhador=="SIM" & Tempo_Negocio>=2 & perfil=="SEM PERFIL DESEJADO"
	
	*-------------------------------------------------------------------------------------------------------
	***** 3 *SELECIONAR NEGOCIO NAO REGISTADO, SEM TRABALHADOR, COM PELO MENOS 2 ANOS DE FUNCIONALIDADE E ///
	     * COM  PELO MENOS 10000 METICAIS 
	*-------------------------------------------------------------------------------------------------------*
	
	replace Status="SELECIONADA" if Tempo_Negocio>=2 & Lucros =="MAIS DE 15000 METICAIS" 
    replace Status="SELECIONADA" if Tempo_Negocio>=2 & Lucros =="MAIS DE 10000 METICAIS E MENOS DE 15000 METICAIS" 
									
									
    replace perfil="COM MAIS DE 2 ANOS E COM RENDIMENTO" if Tempo_Negocio>=2 & Lucros =="MAIS DE 15000 METICAIS"  & perfil=="SEM PERFIL DESEJADO" 
	replace perfil="COM MAIS DE 2 ANOS E COM RENDIMENTO" if Tempo_Negocio>=2 & Lucros =="MAIS DE 10000 METICAIS E MENOS DE 15000 METICAIS"  & perfil=="SEM PERFIL DESEJADO"  
									
	*------------------------------------------------------------------------------------------------------
	***** 4 *SELECIONAR NEGOCIO NAO REGISTADO, COM TRABALHADOR E COM LUCRO DE PELO MENOS 10000 METICAIS 
    *----------------------------------------------------------------------------------------------------
	
		 	replace Status="SELECIONADA" if tem_trabalhador=="SIM" & Lucros =="MAIS DE 15000 METICAIS"   									
		    replace Status="SELECIONADA" if tem_trabalhador=="SIM" & Lucros =="MAIS DE 10000 METICAIS E MENOS DE 15000 METICAIS"
			
			replace perfil="COM TRABALHADORES E COM RENDIMENTO" if tem_trabalhador=="SIM" & Lucros =="MAIS DE 15000 METICAIS" & perfil=="SEM PERFIL DESEJADO"   									
		    replace perfil="COM TRABALHADORES E COM RENDIMENTO" if tem_trabalhador=="SIM" & Lucros =="MAIS DE 10000 METICAIS E MENOS DE 15000 METICAIS" & perfil=="SEM PERFIL DESEJADO" 
  
									
	/*----------------------------------------------------------------------------------------------------------*/							
     ***** 5 *SELECIONAR NEGOCIO NAO REGISTADO, COM TRABALHADOR, COM  PELO MENOS 2 ANOS DE FUNCIONALIDADE E ///
	     * COM lucro DE PELO MENOS 10000 METICAIS 
	***----------------------------------------------------------------------------------------------------------
		 
			replace Status="SELECIONADA" if tem_trabalhador=="SIM" & Tempo_Negocio>=2 & Lucros =="MAIS DE 15000 METICAIS" 					
			replace Status="SELECIONADA" if tem_trabalhador=="SIM" & Tempo_Negocio>=2 & Lucros =="MAIS DE 10000 METICAIS E MENOS DE 15000 METICAIS"   

			replace perfil="COM TRABALHADORES, COM MAIS DE 2 ANOS E COM RENDIMENTO"  if tem_trabalhador=="SIM" & Tempo_Negocio>=2 & Lucros =="MAIS DE 15000 METICAIS" & perfil=="COM NEGOCIO REGISTADO"  					
			replace perfil="COM TRABALHADORES, COM MAIS DE 2 ANOS E COM RENDIMENTO"  if tem_trabalhador=="SIM" & Tempo_Negocio>=2 & Lucros =="MAIS DE 10000 METICAIS E MENOS DE 15000 METICAIS" & perfil=="COM NEGOCIO REGISTADO"  
			replace Status="NAO SELECIONADA" if Dona_negocio=="NAO"
	        replace perfil="SEM PERFIL DESEJADO" if Dona_negocio=="NAO"		
			replace Status="SELECIONADA" if lista==1
		/******************************************PERFIL*******************************************************/
 



 
  destring Idade, replace
* keep if _merge==2
 *drop if Idade<18
 *drop if Idade>100
 
 replace local=Local if Local!=""
 replace local=Provincia
 replace local="MAPUTO" if Provincia=="Maputo Cidade"
 replace local="MAPUTO" if Provincia=="Maputo Provincia" 
 replace local="NAMPULA" if Provincia=="Nampula" 
 replace local="BEIRA" if Provincia=="Sofala" 
 replace local=Local if local==""
 
  
 replace perfil=Perfil if perfil==""
 replace Perfil=perfil if Perfil==""
drop perfil
   save "C:\Users\Dercio\Dropbox (OPML)\MIS\Marambe\Maputo\Data Management\08 Realiza\02 Data Clean\01 Registo\Resultados__Realiza.dta" , replace
 
     *drop AL AM
	order ModifiedTime consetimento Nome Idade local bairro seu_endereco_escrito     familiar_proximo ///
	    Dona_negocio Nome_negocio inicio_negocio Tempo_Negocio ///
	Actividade_negocio outra_actividade registo_negocio numero_trabalhador tem_trabalhador numero_trab_com_salario ///
	Lucros Negocio_tem_Endereco endereco_negocio Comunicacao_negocio facebook_negocio email_negocio   ///
	instagram_negocio website_negocio Cidade_negocio Bairro_negocio referencia especifique_referencia Status Perfil

	
	/*replace  Lucros="1. MENOS DE 500 METICAIS" if Lucros=="MENOS DE 500 METICAIS"
	replace  Lucros="2. MAIS DE 500 METICAIS E MENOS DE 1000 METICAIS" if Lucros=="MAIS DE 500 METICAIS E MENOS DE 1000 METICAIS"
	replace  Lucros="3. MAIS DE 1000 METICAIS E MENOS DE 2500 METICAIS" if Lucros=="MAIS DE 1000 METICAIS E MENOS DE 2500 METICAIS"
	replace  Lucros="4. MAIS DE 2500 METICAIS E MENOS DE 5000 METICAIS" if Lucros=="MAIS DE 2500 METICAIS E MENOS DE 5000 METICAIS"
	replace  Lucros="5. MAIS DE 5000 METICAIS E MENOS DE 10000 METICAIS" if Lucros=="MAIS DE 5000 METICAIS E MENOS DE 10000 METICAIS"	
	replace  Lucros="6. MAIS DE 10000 METICAIS E MENOS DE 15000 METICAIS" if Lucros=="MAIS DE 10000 METICAIS E MENOS DE 15000 METICAIS"
	replace  Lucros="7. MAIS DE 15000 METICAIS" if Lucros=="MAIS DE 15000 METICAIS"
	*/
	gen Lucro=""
	replace Lucro="1. Abaixo de 5000" if Lucros=="MENOS DE 500 METICAIS" | Lucros=="MAIS DE 500 METICAIS E MENOS DE 1000 METICAIS" | ///
										 Lucros=="MAIS DE 1000 METICAIS E MENOS DE 2500 METICAIS" | Lucros=="MAIS DE 2500 METICAIS E MENOS DE 5000 METICAIS"
	replace Lucro="2. MAIS DE 5000 E MENOS DE 10000" if Lucros=="MAIS DE 5000 METICAIS E MENOS DE 10000 METICAIS"	
	replace Lucro="3. MAIS 10000" if Lucros=="MAIS DE 15000 METICAIS" | Lucros=="MAIS DE 10000 METICAIS E MENOS DE 15000 METICAIS"
	
	drop Lucros
	 gen trabalhadores = numero_trabalhador+numero_trab_com_salario
	 replace Tempo_Negocio=2022-Tempo_Negocio if Tempo_Negocio>1000
	 replace Tempo_Negocio=10 if Tempo_Negocio>10
	 replace Tempo_Negocio=1 if Tempo_Negocio<1
	 
	 
 gen rede_social="SIM"
  replace rede_social="NAO" if Comunicacao_negocio=="NENHUM"
  replace rede_social="NAO" if Comunicacao_negocio=="WHATSAAP,NENHUM"
 
 
 drop Ramosdeactividade
 
 ren Actividade_negocio Ramosdeactividade

*****
la de yesno 100 "Sim" 0 "Nao"
gen ind_alimentacao = 0 if Ramosdeactividade !=""
replace ind_alimentacao= 100 if strpos(Ramosdeactividade, "ALIMENTICIO")
la var ind_alimentacao "Categoria de alimentacao"
la values ind_alimentacao  yesno
 
*****

gen ind_Estetica = 0 if Ramosdeactividade !=""
replace  ind_Estetica= 100 if strpos(Ramosdeactividade, "ESTETICA") 
replace  ind_Estetica= 100 if strpos(Ramosdeactividade, "SAUDE")
la var ind_Estetica "Categoria de ESTETICA"
la values ind_Estetica  yesno

*****

gen ind_Entretenimento = 0 if Ramosdeactividade !=""
replace ind_Entretenimento= 100 if strpos(Ramosdeactividade, "EDUCACAO") 
replace ind_Entretenimento= 100 if strpos(Ramosdeactividade, "ENTRETENIMENTO")
la var ind_Entretenimento "Categoria de Entretenimento"
la values ind_Entretenimento  yesno


*****

gen ind_DESPORTO = 0 if Ramosdeactividade !=""
replace ind_DESPORTO= 100 if strpos(Ramosdeactividade, "DESPORTO")  
la var ind_DESPORTO "Categoria de DESPORTO"
la values ind_DESPORTO  yesno

*****

gen ind_OUTRO = 0 if Ramosdeactividade !=""
replace ind_OUTRO= 100 if strpos(Ramosdeactividade, "OUTRO") 
la var ind_OUTRO "Categoria de OUTRO"
la values ind_OUTRO  yesno

***********
mean ind_alimentacao
est store a1
local a1 = e(N)








*****
gen tiPo_negocio=""
replace tiPo_negocio="OUTRO" if ind_OUTRO==100
  
replace tiPo_negocio="ENTRETENIMENTO" if ind_Entretenimento==100 | ind_DESPORTO==100 
replace tiPo_negocio="ESTETICA" if ind_Estetica==100
replace tiPo_negocio="ALIMENTACAO" if ind_alimentacao==100

gen varia_idade=""
 replace varia_idade="[18 - 25]" if Idade<=25
 replace varia_idade="[25 - 35]" if Idade<=35 & Idade>25
 replace varia_idade="[35 - 45]" if Idade<=45 & Idade>35
 replace varia_idade="[45 - 55]" if Idade<=55 & Idade>45
 replace varia_idade="[55 - 65]" if Idade<=65 & Idade>55
 replace varia_idade=">65" if Idade>=65
 
 replace Idade=. if Idade<17
 replace Idade=80 if Idade>80 & Idade!=.
  

	 export excel using "C:\Users\Dercio\Dropbox (OPML)\MIS\Marambe\Maputo\Data Management\08 Realiza\02 Data Clean\01 Registo\Resultados__Realiza.xls", firstrow(variables) replace
	 export excel using "C:\Users\Dercio\Dropbox (OPML)\MIS\Marambe\Maputo\Data Management\08 Realiza\Realiza\Resultados__Realiza.xls", firstrow(variables) replace
	 
	 ex
	 
	 
	 import excel "C:\Users\Dercio\Dropbox (OPML)\MIS\Marambe\Maputo\Data Management\08 Realiza\02 Data Clean\01 Registo\Realiza pre-selected candidates - 1st list.xls" , sheet("Sheet1") firstrow clear 
 
	 destring NodeTrabalhadores, replace
	 tostring NodeTrabalhadores, replace
	 save `1', replace 
	 
	 import excel "C:\Users\Dercio\Dropbox (OPML)\MIS\Marambe\Maputo\Data Management\08 Realiza\02 Data Clean\01 Registo\Realiza pre-selected candidates - 2 list.xlsx" , sheet("Sheet1") firstrow clear 
	 tostring Idade, replace
	 tostring Temtrabalhador, replace
	  
 
	 append using `1'
	 ren Informaçõessobreoslucros Lucros
	 gen Lucro=""
	replace Lucro="1. Abaixo de 5000" if Lucros=="MENOS DE 500 METICAIS" | Lucros=="MAIS DE 500 METICAIS E MENOS DE 1000 METICAIS" | ///
										 Lucros=="MAIS DE 1000 METICAIS E MENOS DE 2500 METICAIS" | Lucros=="MAIS DE 2500 METICAIS E MENOS DE 5000 METICAIS"
	replace Lucro="2. MAIS DE 5000 E MENOS DE 10000" if Lucros=="MAIS DE 5000 METICAIS E MENOS DE 10000 METICAIS"	
	replace Lucro="3. MAIS 10000" if Lucros=="MAIS DE 15000 METICAIS" | Lucros=="MAIS DE 10000 METICAIS E MENOS DE 15000 METICAIS"
	
	drop Lucros
	 gen trabalhadores = NodeTrabalhadores
	 ren Tempodevida Tempo_Negocio
	 replace Tempo_Negocio=2022-Tempo_Negocio if Tempo_Negocio>1000
	 replace Tempo_Negocio=10 if Tempo_Negocio>10
	 replace Tempo_Negocio=1 if Tempo_Negocio<1
	   
	   
	   
	 replace Temtrabalhador="NAO" if Temtrabalhador=="0"  
	 replace Temtrabalhador="NAO" if Temtrabalhador=="."   
	 replace Temtrabalhador="SIM" if Temtrabalhador=="1"
	 replace Temtrabalhador="SIM" if Temtrabalhador=="2"
	 replace Temtrabalhador="SIM" if Temtrabalhador=="3"
	 replace Temtrabalhador="SIM" if Temtrabalhador=="4"
	 replace Temtrabalhador="SIM" if Temtrabalhador=="5"
	 replace Temtrabalhador="SIM" if Temtrabalhador=="6"
	 replace Temtrabalhador="SIM" if Temtrabalhador=="7"
	 replace Temtrabalhador="SIM" if Temtrabalhador=="8"
	 replace Temtrabalhador="SIM" if Temtrabalhador=="9"
	 replace Temtrabalhador="SIM" if Temtrabalhador=="10"
	 replace Temtrabalhador="SIM" if Temtrabalhador=="12"
	 replace Temtrabalhador="SIM" if Temtrabalhador=="14"
	 replace Temtrabalhador="SIM" if Temtrabalhador=="17"
	 replace Temtrabalhador="SIM" if Temtrabalhador=="18"
	 //replace Temtrabalhador="SIM" if Temtrabalhador=="1"
	  
	  gen trabalhadorAsalariado="NAO"
	  replace trabalhadorAsalariado="SIM" if NodeTrabalhadorescsalário>0
	  replace trabalhadorAsalariado="NAO" if Temtrabalhador=="NAO"
	 ren Meiosdecomunicaçãodonegócio Comunicacao_negocio
	 ren Local local
         gen rede_social="SIM"
         replace rede_social="NAO" if Comunicacao_negocio=="NENHUM"
         replace rede_social="NAO" if Comunicacao_negocio=="WHATSAAP,NENHUM"
		 destring Idade, replace
		 replace Idade=. if Idade>100
		 
*	 drop Ramosdeactividade
 
* ren Actividade_negocio Ramosdeactividade

*****
la de yesno 100 "Sim" 0 "Nao"
gen ind_alimentacao = 0 if Ramosdeactividade !=""
replace ind_alimentacao= 100 if strpos(Ramosdeactividade, "ALIMENTICIO")
la var ind_alimentacao "Categoria de alimentacao"
la values ind_alimentacao  yesno
 
*****

gen ind_Estetica = 0 if Ramosdeactividade !=""
replace  ind_Estetica= 100 if strpos(Ramosdeactividade, "ESTETICA") 
replace  ind_Estetica= 100 if strpos(Ramosdeactividade, "SAUDE")
la var ind_Estetica "Categoria de ESTETICA"
la values ind_Estetica  yesno

*****

gen ind_Entretenimento = 0 if Ramosdeactividade !=""
replace ind_Entretenimento= 100 if strpos(Ramosdeactividade, "EDUCACAO") 
replace ind_Entretenimento= 100 if strpos(Ramosdeactividade, "ENTRETENIMENTO")
la var ind_Entretenimento "Categoria de Entretenimento"
la values ind_Entretenimento  yesno


*****

gen ind_DESPORTO = 0 if Ramosdeactividade !=""
replace ind_DESPORTO= 100 if strpos(Ramosdeactividade, "DESPORTO")  
la var ind_DESPORTO "Categoria de DESPORTO"
la values ind_DESPORTO  yesno

*****

gen ind_OUTRO = 0 if Ramosdeactividade !=""
replace ind_OUTRO= 100 if strpos(Ramosdeactividade, "OUTRO") 
la var ind_OUTRO "Categoria de OUTRO"
la values ind_OUTRO  yesno

***********
mean ind_alimentacao
est store a1
local a1 = e(N)








*****
gen tiPo_negocio=""
replace tiPo_negocio="OUTRO" if ind_OUTRO==100
  
replace tiPo_negocio="ENTRETENIMENTO" if ind_Entretenimento==100 | ind_DESPORTO==100 
replace tiPo_negocio="ESTETICA" if ind_Estetica==100
replace tiPo_negocio="ALIMENTACAO" if ind_alimentacao==100


 
*graph export "$grafic/nivel_concluido.png", replace


 gen varia_idade=""
 replace varia_idade="[18 - 25]" if Idade<=25
 replace varia_idade="[25 - 35]" if Idade<=35 & Idade>25
 replace varia_idade="[35 - 45]" if Idade<=45 & Idade>35
 replace varia_idade="[45 - 55]" if Idade<=55 & Idade>45
 replace varia_idade="[55 - 65]" if Idade<=65 & Idade>55
 replace varia_idade=">65" if Idade>=65
 

    
	 	 export excel using "C:\Users\Dercio\Dropbox (OPML)\MIS\Marambe\Maputo\Data Management\08 Realiza\02 Data Clean\01 Registo\Selecionadas__Realiza.xls", firstrow(variables) replace
	 export excel using "C:\Users\Dercio\Dropbox (OPML)\MIS\Marambe\Maputo\Data Management\08 Realiza\Realiza\Selecionadas__Realiza.xls", firstrow(variables) replace
	 
	 ex
	  
	                                                                                                                                                                                                                                                                                                                                                                                                              
	  
	  
	   
	   
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	drop if Perfil=="SEM PERFIL DESEJADO"
    
	 export excel ModifiedTime consetimento Nome Idade local bairro seu_endereco_escrito Telefone Telefone_2 familiar_proximo ///
	Telefone_familiar telefone_alterrnativo_familiar Dona_negocio Nome_negocio inicio_negocio Tempo_Negocio ///
	Actividade_negocio outra_actividade registo_negocio numero_trabalhador tem_trabalhador numero_trab_com_salario ///
	Lucros Negocio_tem_Endereco endereco_negocio Comunicacao_negocio facebook_negocio email_negocio whatssap_negocio ///
	instagram_negocio website_negocio Cidade_negocio Bairro_negocio referencia especifique_referencia Status Perfil ///
	using "$output\01 Registo\Selecionadas_Lista Final.xls", firstrow(variables) replace
 
 keep if Lista==2
 
 	 export excel ModifiedTime consetimento Nome Idade local bairro seu_endereco_escrito Telefone Telefone_2 familiar_proximo ///
	Telefone_familiar telefone_alterrnativo_familiar Dona_negocio Nome_negocio inicio_negocio Tempo_Negocio ///
	Actividade_negocio outra_actividade registo_negocio numero_trabalhador tem_trabalhador numero_trab_com_salario ///
	Lucros Negocio_tem_Endereco endereco_negocio Comunicacao_negocio facebook_negocio email_negocio whatssap_negocio ///
	instagram_negocio website_negocio Cidade_negocio Bairro_negocio referencia especifique_referencia Status Perfil ///
	using "$output\01 Registo\Selecionadas_Lista_2.xls", firstrow(variables) replace
 tab Status 
  
 
 *save "$output\01 Registo\Selecionadas_piloto_RCT.dta", replace 


	/*v
	 ex
	 label define lucro 1 "MENOS DE 500 METICAIS" ///
	                  2 "MAIS DE 500 METICAIS E MENOS DE 1000 METICAIS" ///
					  3 "MAIS DE 1000 METICAIS E MENOS DE 2500 METICAIS" ///
					  4 "MAIS DE 2500 METICAIS E MENOS DE 5000 METICAIS" ///
					  5 "MAIS DE 5000 METICAIS E MENOS DE 10000 METICAIS" ///
					  6 "MAIS DE 10000 METICAIS E MENOS DE 15000 METICAIS" ///
					  7 "MAIS DE 15000 METICAIS"

	 ex  
 

********************************************************************************************************
/*-------------------------------------------------------------------------------------------------------*/
********************************************************************************************************
 
