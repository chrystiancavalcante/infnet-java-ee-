/*
Title: ERP INFNET                                                                
Description: Classe transiente para armazenar o retorno de erros que vem do servidor
                                                                                
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
class RetornoJsonErro {
  String status;
  String error;
  String message;
  String trace;
  String tipo;

  RetornoJsonErro({this.status, this.error, this.message, this.trace, this.tipo});

  RetornoJsonErro.fromJson(Map<String, dynamic> jsonDados) {
    status = jsonDados['status'];
    error = jsonDados['error'];
    message = jsonDados['message'];
    trace = jsonDados['trace'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = new Map<String, dynamic>();
    jsonDados['status'] = this.status;
    jsonDados['error'] = this.error;
    jsonDados['message'] = this.message;
    jsonDados['trace'] = this.trace;
    return jsonDados;
  }
}