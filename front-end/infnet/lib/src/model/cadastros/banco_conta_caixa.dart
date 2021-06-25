/*
Title: ERP INFNET                                                                
Description: Model relacionado à tabela [BANCO_CONTA_CAIXA] 
                                                                                
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

import 'package:infnet/src/model/model.dart';

class BancoContaCaixa {
	int id;
	int idBancoAgencia;
	String numero;
	String digito;
	String nome;
	String tipo;
	String descricao;
	BancoAgencia bancoAgencia;

	BancoContaCaixa({
			this.id,
			this.idBancoAgencia,
			this.numero,
			this.digito,
			this.nome,
			this.tipo,
			this.descricao,
			this.bancoAgencia,
		});

	static List<String> campos = <String>[
		'ID', 
		'NUMERO', 
		'DIGITO', 
		'NOME', 
		'TIPO', 
		'DESCRICAO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Número', 
		'Dígito', 
		'Nome', 
		'Tipo', 
		'Descrição', 
	];

	BancoContaCaixa.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idBancoAgencia = jsonDados['idBancoAgencia'];
		numero = jsonDados['numero'];
		digito = jsonDados['digito'];
		nome = jsonDados['nome'];
		tipo = getTipo(jsonDados['tipo']);
		descricao = jsonDados['descricao'];
		bancoAgencia = jsonDados['bancoAgencia'] == null ? null : new BancoAgencia.fromJson(jsonDados['bancoAgencia']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idBancoAgencia'] = this.idBancoAgencia ?? 0;
		jsonDados['numero'] = this.numero;
		jsonDados['digito'] = this.digito;
		jsonDados['nome'] = this.nome;
		jsonDados['tipo'] = setTipo(this.tipo);
		jsonDados['descricao'] = this.descricao;
		jsonDados['bancoAgencia'] = this.bancoAgencia == null ? null : this.bancoAgencia.toJson;
	
		return jsonDados;
	}
	
    getTipo(String tipo) {
    	switch (tipo) {
    		case '0':
    			return 'Corrente';
    			break;
    		case '1':
    			return 'Poupança';
    			break;
    		case '2':
    			return 'Investimento';
    			break;
    		case '3':
    			return 'Caixa Interno';
    			break;
    		default:
    			return null;
    		}
    	}

    setTipo(String tipo) {
    	switch (tipo) {
    		case 'Corrente':
    			return '0';
    			break;
    		case 'Poupança':
    			return '1';
    			break;
    		case 'Investimento':
    			return '2';
    			break;
    		case 'Caixa Interno':
    			return '3';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(BancoContaCaixa objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}