	/*----- Sección de Declaraciones --------------*/

%{
#include <iostream>
#include <vector>
#include <stack> 
#include <string>         

 std::stack<std::string>etiquetas;
std::stack<std::string>etiquetas2;

std::stack<std::string>abre;
std::stack<std::string>cierra;

 std::vector<std::string>enlaces;
 std::vector<std::string>descarga_imagenes;
 std::vector<std::string>descarga_webs;         

int abre_html;
int cierra_html;
int contador=0;
void escribir_datos (int dato1, int dato2);
void cumple_estandar (std::stack<std::string> &pila);
bool cierre(std::stack<std::string> &pila, std::string tag);
bool cierre_v2(std::stack<std::string> &pila_abiertas, std::stack<std::string> &pila_cerradas);
void muestraEnlacesImagenes(std::vector<std::string> &vec,std::vector<std::string> &salida);
void muestraEnlacesGenerico(std::vector<std::string> &vec);
void descarga(std::vector<std::string> &entrada); 

%}

/*marcas principales*/
html_open	"<html>"
html_close	"</html>"

body_open	"<body>"
body_close	"</body>"

parrafo_open 	"<p>"
parrafo_close	"</p>"

enlace_open	("<a href=\"".*"\">")?("<a>")?
enlace_close	"</a>"

head_open 	"<head>"
head_close	"</head>"

titulo_open 	"<title>"
titulo_close	"</title>"

lista_open	"<ul>"
lista_close	"</ul>"

elemento_open	"<li>"
elemento_close	"</li>"

div_open	("<div id=\"".*"\">")?("<div class=\"".*"\">")?
div_close	"</div>"

span_open	("<span id=\"".*"\">")?("<span class=\"".*"\">")
span_close	"<span>"


/*encabezados*/
h1_open		"<h1>"
h1_close	"</h1>"

h2_open		"<h2>"
h2_close	"</h2>"

h3_open		"<h3>"
h3_close	"</h3>"

h4_open		"<h4>"
h4_close	"</h4>"

h5_open		"<h5>"
h5_close	"</h5>"

h6_open		"<h6>"
h6_close	"</h6>"


/*Estilos de letra*/
negrita_open	"<b>"
negrita_close	"</b">

italica_open	"<i>"
italica_close	"</i>"

fuerte_open	"<strong>"
fuerte_close	"</strong>"

peque_open	"<small>"
peque_close	"</small>"

/*Enlaces e imagenes*/

imagen2 	("<img src=\"http"s?"://"[^\"]*\")(" alt=\""[^\"]*\")?(" height=\""[0-9][0-9]?[0-9]?\")?(" width=\""[0-9][0-9]?[0-9]?\")?>
imagen 		("<img src=\"http://"[^\"]*\")(" alt=\""[^\"]*\")?(" height=\""[0-9][0-9]?[0-9]?\")?(" width=\""[0-9][0-9]?[0-9]?\")?>
webs	 	("http"s?"://".*)(\.es|\.com)
%%
	/*----- Sección de Reglas //.			{} ----------------*/
{}

{html_open}		{ 	/*marcas principales*/
				etiquetas.push("<html>");
			  	etiquetas2.push("<html>");
				
			}

{html_close}		{	
				//etiquetas.pop();
				if(!cierre(etiquetas2,"<html>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
				
					
			}

{head_open}		{
				etiquetas2.push("<head>");
			}
{head_close}		{	
				if(!cierre(etiquetas2,"<head>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
			}
{body_open}		{	etiquetas.push("<body>");
			 	etiquetas2.push("<body>");
						
			}

		
{body_close}		{	
				if(!cierre(etiquetas2,"<body>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
			}

{div_open}		{	etiquetas2.push("<div>");	}

{div_close}		{
				if(!cierre(etiquetas2,"<div>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
			}

{titulo_open}		{	etiquetas2.push("<title>");	}

{titulo_close}		{	if(!cierre(etiquetas2,"<title>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
			}

{lista_open}		{	etiquetas2.push("<ul>");	}
{lista_close}		{	if(!cierre(etiquetas2,"<ul>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
			}

{elemento_open}		{	etiquetas2.push("<li>");	}
{elemento_close}	{	if(!cierre(etiquetas2,"<li>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
			}
				

{parrafo_open}		{	etiquetas2.push("<p>");		}

{parrafo_close}		{
				if(!cierre(etiquetas2,"<p>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;	
			}

{enlace_open}		{	etiquetas2.push("<a>");		}

{enlace_close}		{
				if(!cierre(etiquetas2,"<a>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;	
			}





{h1_open}		{	/*  Encabezados */
				etiquetas2.push("<h1>");
			}

{h1_close}		{	//etiquetas.pop();
				if(!cierre(etiquetas2,"<h1>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
			}
{h2_open}		{	etiquetas2.push("<h2>");	}

{h2_close}		{	
				if(!cierre(etiquetas2,"<h2>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
			}
{h3_open}		{	etiquetas2.push("<h3>");	}

{h3_close}		{	
				if(!cierre(etiquetas2,"<h3>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
			}
{h4_open}		{	etiquetas2.push("<h4>");	}

{h4_close}		{	
				if(!cierre(etiquetas2,"<h4>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
			}
{h5_open}		{	etiquetas2.push("<h5>");	}

{h5_close}		{	
				if(!cierre(etiquetas2,"<h5>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
			}
{h6_open}		{	etiquetas2.push("<h6>");	}

{h6_close}		{	
				if(!cierre(etiquetas2,"<h6>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
			}



{fuerte_open}		{	etiquetas2.push("<strong>");	}
{fuerte_close}		{	if(!cierre(etiquetas2,"<strong>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
			}
{peque_open}		{	etiquetas2.push("<small>");	}
{peque_close}		{	if(!cierre(etiquetas2,"<small>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
			}

{negrita_open}		{	etiquetas2.push("<b>");	}
{negrita_close}		{	if(!cierre(etiquetas2,"<b>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
			}
{italica_open}		{	etiquetas2.push("<i>");	}
{italica_close}		{	if(!cierre(etiquetas2,"<i>"))
					std::cout<<"Error: "<<etiquetas2.top()<<" --- "<<yytext<<std::endl;
			}

{imagen2}		{ /* Descarga de enlaces */
			 enlaces.push_back(std::string(yytext));
			}

{webs}			{
			 descarga_webs.push_back(std::string(yytext));
			}



%%
	/*----- Sección de Procedimientos --------*/
	
int main(int argc,char *argv[]){
	if(argc==2){
		yyin=fopen(argv[1],"rt");
		if(yyin==NULL){
			printf("El fichero %s no se puede abrir\n",argv[1]);
			exit(-1);
		}
	}
	if (argc==3){

		std::string command;
		std::string argumento=argv[2];;
		command = "wget " + argumento + " -O archivo.html";
		system((const char*)command.c_str());
		yyin=fopen("archivo.html","rt");
		if(yyin==NULL){
			printf("El fichero no se puede abrir\n");
			exit(-1);
		}
	}
		
	//else yyin =stdin;
	

	//abre_html=0;
	//cierra_html=0;
	etiquetas2.push("inicializacion");


	yylex ();
	//cierre_v2(abre,cierra);
	//escribir_datos(abre_html,cierra_html);
	//cumple_estandar(etiquetas);
	muestraEnlacesImagenes(enlaces,descarga_imagenes);
	descarga(descarga_imagenes);
	muestraEnlacesGenerico(descarga_webs);
	//descarga(descarga_webs);
	return 0;
}
void escribir_datos (int dato1, int dato2) {
	printf ("abre=%d\t\n",dato1);
	printf ("cierra=%d\t\n",dato2);
}
/*
void cumple_estandar (std::stack<std::string> &pila){
	if(pila.size()==0)
		std::cout<<"Cumple el estandar"<<std::endl;
	else
		std::cout<<"no cumple el estandar"<<std::endl;
}*/

bool cierre(std::stack<std::string> &pila, std::string tag){
	/*std::stack<std::string>aux(pila);
	while(aux.size()!=0){
		std::cout<<"Pila: "<<aux.top()<<std::endl;
		aux.pop();
	}*/
	std::string aux;
	if(pila.top().compare(tag)==0){
		aux=tag.insert(1,"/");
		std::cout<<"\tCorrecto: "<<pila.top()<<" --- "<<aux<<std::endl;
		pila.pop();
		return true;
	}
	else{
		//std::cout<<"Pila top: "<<pila.top()<<" != tag: "<<tag<<std::endl;
		//std::cout<<tag<<" no cumple estandar!"<<std::endl;
		return false;
	}
}
/*
bool cierre_v2(std::stack<std::string> &pila_abiertas, std::stack<std::string> &pila_cerradas){
	std::stack<std::string>aux;
	
	while(pila_cerradas.size()!=0){
		aux.push(pila_cerradas.top());
		pila_cerradas.pop();
	}
	if(aux.size()!=pila_abiertas.size()){
		std::cout<<"No cumple el estandar"<<std::endl;
		return false;
	}
	while(pila_abiertas.size()!=0&&aux.size()!=0){
		if(pila_abiertas.top()==aux.top()){
			std::cout<<pila_abiertas.top()<<"--- "<<aux.top()<<" Correcto!"<<std::endl;
			pila_abiertas.pop();
			aux.pop();
		}
		else{
			std::cout<<pila_abiertas.top()<<"--- "<<aux.top()<<" Incorrecto!"<<std::endl;
			//return false;
		}
	}
	std::cout<<"Cumple el estandar"<<std::endl;
	return true;
}*/

void muestraEnlacesImagenes(std::vector<std::string> &vec,std::vector<std::string> &salida ){
	std::size_t pos;
	std::size_t pos2;
	std::cout<<"Enlaces imagen encontrados:"<<vec.size()<<std::endl;
	for(int i=0;i<vec.size();i++){
		pos = vec[i].find("\"");
		//std::cout<<"PRimeras comillas:"<<pos<<std::endl;
		pos2=vec[i].find("\"",pos+1);
		//std::cout<<"Segundas comillas:"<<pos2<<std::endl; 
		pos++;
		std::cout<<"Enlace: "<<vec[i].substr(pos,pos2-pos)<<std::endl;
		salida.push_back(vec[i].substr(pos,pos2-pos));
	}
}

void muestraEnlacesGenerico(std::vector<std::string> &vec){
	std::cout<<"Enlaces genericos encontrados:"<<vec.size()<<std::endl;
	for(int i=0;i<vec.size();i++)
		std::cout<<"Enlace generico: "<<vec[i]<<std::endl;
}

void descarga(std::vector<std::string> &entrada){

	std::string command;
	system((const char*)command.c_str());
	std::cout<<"tramaño entradas a descargar: "<<entrada.size()<<std::endl;
	for(int i=0;i<entrada.size();i++){
		command = "wget " +entrada[i];
		//std::cout<<"Descarga: "<<command<<std::endl;
		system((const char*)command.c_str());
		//command.clear();
	}

} 















