/*
Title: ERP INFNET                                                                
Description: Model relacionado à tabela [CLIENTE] 
                                                                                
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

import 'package:intl/intl.dart';
import 'package:infnet/src/model/model.dart';

class Cliente {
	int id;
	int idPessoa;
	int idTabelaPreco;
	DateTime desde;
	DateTime dataCadastro;
	double taxaDesconto;
	double limiteCredito;
	String observacao;
	TabelaPreco tabelaPreco;
	Pessoa pessoa;
	ViewPessoaCliente viewPessoaCliente;

	Cliente({
		this.id,
		this.idPessoa,
		this.idTabelaPreco,
		this.desde,
		this.dataCadastro,
		this.taxaDesconto = 0.0,
		this.limiteCredito = 0.0,
		this.observacao,
		this.tabelaPreco,
    this.pessoa,
    this.viewPessoaCliente,
	});

	static List<String> campos = <String>[
		'ID', 
		'DESDE', 
		'DATA_CADASTRO', 
		'TAXA_DESCONTO', 
		'LIMITE_CREDITO', 
		'OBSERVACAO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'É Cliente Desde', 
		'Data de Cadastro', 
		'Taxa de Desconto', 
		'Limite de Crédito', 
		'Observação', 
	];

	Cliente.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idPessoa = jsonDados['idPessoa'];
		idTabelaPreco = jsonDados['idTabelaPreco'];
		desde = jsonDados['desde'] != null ? DateTime.tryParse(jsonDados['desde']) : null;
		dataCadastro = jsonDados['dataCadastro'] != null ? DateTime.tryParse(jsonDados['dataCadastro']) : null;
		taxaDesconto = jsonDados['taxaDesconto'] != null ? jsonDados['taxaDesconto'].toDouble() : null;
		limiteCredito = jsonDados['limiteCredito'] != null ? jsonDados['limiteCredito'].toDouble() : null;
		observacao = jsonDados['observacao'];
		tabelaPreco = jsonDados['tabelaPreco'] == null ? null : new TabelaPreco.fromJson(jsonDados['tabelaPreco']);
		pessoa = jsonDados['pessoa'] == null ? null : new Pessoa.fromJson(jsonDados['pessoa']);
		viewPessoaCliente = jsonDados['viewPessoaCliente'] == null ? null : new ViewPessoaCliente.fromJson(jsonDados['viewPessoaCliente']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idPessoa'] = this.idPessoa ?? 0;
		jsonDados['idTabelaPreco'] = this.idTabelaPreco ?? 0;
		jsonDados['desde'] = this.desde != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.desde) : null;
		jsonDados['dataCadastro'] = this.dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataCadastro) : null;
		jsonDados['taxaDesconto'] = this.taxaDesconto;
		jsonDados['limiteCredito'] = this.limiteCredito;
		jsonDados['observacao'] = this.observacao;
		jsonDados['tabelaPreco'] = this.tabelaPreco == null ? null : this.tabelaPreco.toJson;
		jsonDados['pessoa'] = this.pessoa == null ? null : this.pessoa.toJson;
		jsonDados['viewPessoaCliente'] = this.viewPessoaCliente == null ? null : this.viewPessoaCliente.toJson;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(Cliente objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}