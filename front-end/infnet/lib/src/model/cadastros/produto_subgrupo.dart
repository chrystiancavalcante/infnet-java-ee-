/*
Title: ERP INFNET                                                                
Description: Model relacionado à tabela [PRODUTO_SUBGRUPO] 
                                                                                
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

class ProdutoSubgrupo {
	int id;
	int idProdutoGrupo;
	String nome;
	String descricao;
	ProdutoGrupo produtoGrupo;

	ProdutoSubgrupo({
			this.id,
			this.idProdutoGrupo,
			this.nome,
			this.descricao,
			this.produtoGrupo,
		});

	static List<String> campos = <String>[
		'ID', 
		'NOME', 
		'DESCRICAO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Nome', 
		'Descrição', 
	];

	ProdutoSubgrupo.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idProdutoGrupo = jsonDados['idProdutoGrupo'];
		nome = jsonDados['nome'];
		descricao = jsonDados['descricao'];
		produtoGrupo = jsonDados['produtoGrupo'] == null ? null : new ProdutoGrupo.fromJson(jsonDados['produtoGrupo']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idProdutoGrupo'] = this.idProdutoGrupo ?? 0;
		jsonDados['nome'] = this.nome;
		jsonDados['descricao'] = this.descricao;
		jsonDados['produtoGrupo'] = this.produtoGrupo == null ? null : this.produtoGrupo.toJson;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(ProdutoSubgrupo objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}