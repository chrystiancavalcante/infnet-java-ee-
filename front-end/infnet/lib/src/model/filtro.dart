/*
Title: ERP INFNET                                                                
Description: Classe transiente para enviar os dados do filtro para o servidor
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 TRABALHO DE BLOCO INFNET                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           ERP INFNET@gmail.com                                                   
                                                                                
@author Chrystian Cavalcante (chrystiancavalcante@gmail.com)                    
@version 1.0.0
*******************************************************************************/
import 'dart:convert';

class Filtro {
  String campo;
  String valor;
  String dataInicial;
  String dataFinal;
  String condicao;
  String where; // ser?? utilizado quando o filtro for m??ltiplo, ou seja, quando mais de um filtro for enviado para o servidor

  Filtro({this.campo, this.valor, this.dataInicial, this.dataFinal});

  Filtro.fromJson(Map<String, dynamic> jsonDados) {
    campo = jsonDados['campo'];
    valor = jsonDados['valor'];
    dataInicial = jsonDados['dataInicial'];
    dataFinal = jsonDados['dataFinal'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = new Map<String, dynamic>();
    jsonDados['campo'] = this.campo;
    jsonDados['valor'] = this.valor;
    jsonDados['dataInicial'] = this.dataInicial;
    jsonDados['dataFinal'] = this.dataFinal;
    return jsonDados;
  }
}

String filtroEncodeJson(Filtro filtro) {
  final jsonDados = filtro.toJson;
  return json.encode(jsonDados);
}