/*
Title: ERP INFNET                                                                
Description: Model relacionado à tabela [PRODUTO] 
                                                                                
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

class Produto {
	int id;
	int idProdutoSubgrupo;
	int idProdutoMarca;
	int idProdutoUnidade;
	int idTributIcmsCustomCab;
	int idTributGrupoTributario;
	String nome;
	String descricao;
	String gtin;
	String codigoInterno;
	double valorCompra;
	double valorVenda;
	String codigoNcm;
	double estoqueMinimo;
	double estoqueMaximo;
	double quantidadeEstoque;
	DateTime dataCadastro;
	ProdutoSubgrupo produtoSubgrupo;
	ProdutoMarca produtoMarca;
	ProdutoUnidade produtoUnidade;
	// TributIcmsCustomCab tributIcmsCustomCab;
	// TributGrupoTributario tributGrupoTributario;

	Produto({
			this.id,
			this.idProdutoSubgrupo,
			this.idProdutoMarca,
			this.idProdutoUnidade,
			this.idTributIcmsCustomCab,
			this.idTributGrupoTributario,
			this.nome,
			this.descricao,
			this.gtin,
			this.codigoInterno,
			this.valorCompra = 0.0,
			this.valorVenda = 0.0,
			this.codigoNcm,
			this.estoqueMinimo = 0.0,
			this.estoqueMaximo = 0.0,
			this.quantidadeEstoque = 0.0,
			this.dataCadastro,
			this.produtoSubgrupo,
			this.produtoMarca,
			this.produtoUnidade,
			// this.tributIcmsCustomCab,
			// this.tributGrupoTributario,
		});

	static List<String> campos = <String>[
		'ID', 
		'NOME', 
		'DESCRICAO', 
		'GTIN', 
		'CODIGO_INTERNO', 
		'VALOR_COMPRA', 
		'VALOR_VENDA', 
		'CODIGO_NCM', 
		'ESTOQUE_MINIMO', 
		'ESTOQUE_MAXIMO', 
		'QUANTIDADE_ESTOQUE', 
		'DATA_CADASTRO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Nome', 
		'Descrição', 
		'GTIN', 
		'Código Interno', 
		'Valor Compra', 
		'Valor Venda', 
		'Código NCM', 
		'Estoque Mínimo', 
		'Estoque Máximo', 
		'Quantidade em Estoque', 
		'Data de Cadastro', 
	];

	Produto.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idProdutoSubgrupo = jsonDados['idProdutoSubgrupo'];
		idProdutoMarca = jsonDados['idProdutoMarca'];
		idProdutoUnidade = jsonDados['idProdutoUnidade'];
		idTributIcmsCustomCab = jsonDados['idTributIcmsCustomCab'];
		idTributGrupoTributario = jsonDados['idTributGrupoTributario'];
		nome = jsonDados['nome'];
		descricao = jsonDados['descricao'];
		gtin = jsonDados['gtin'];
		codigoInterno = jsonDados['codigoInterno'];
		valorCompra = jsonDados['valorCompra'] != null ? jsonDados['valorCompra'].toDouble() : null;
		valorVenda = jsonDados['valorVenda'] != null ? jsonDados['valorVenda'].toDouble() : null;
		codigoNcm = jsonDados['codigoNcm'];
		estoqueMinimo = jsonDados['estoqueMinimo'] != null ? jsonDados['estoqueMinimo'].toDouble() : null;
		estoqueMaximo = jsonDados['estoqueMaximo'] != null ? jsonDados['estoqueMaximo'].toDouble() : null;
		quantidadeEstoque = jsonDados['quantidadeEstoque'] != null ? jsonDados['quantidadeEstoque'].toDouble() : null;
		dataCadastro = jsonDados['dataCadastro'] != null ? DateTime.tryParse(jsonDados['dataCadastro']) : null;
		produtoSubgrupo = jsonDados['produtoSubgrupo'] == null ? null : new ProdutoSubgrupo.fromJson(jsonDados['produtoSubgrupo']);
		produtoMarca = jsonDados['produtoMarca'] == null ? null : new ProdutoMarca.fromJson(jsonDados['produtoMarca']);
		produtoUnidade = jsonDados['produtoUnidade'] == null ? null : new ProdutoUnidade.fromJson(jsonDados['produtoUnidade']);
		// tributIcmsCustomCab = jsonDados['tributIcmsCustomCab'] == null ? null : new TributIcmsCustomCab.fromJson(jsonDados['tributIcmsCustomCab']);
		// tributGrupoTributario = jsonDados['tributGrupoTributario'] == null ? null : new TributGrupoTributario.fromJson(jsonDados['tributGrupoTributario']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idProdutoSubgrupo'] = this.idProdutoSubgrupo ?? 0;
		jsonDados['idProdutoMarca'] = this.idProdutoMarca ?? 0;
		jsonDados['idProdutoUnidade'] = this.idProdutoUnidade ?? 0;
		jsonDados['idTributIcmsCustomCab'] = this.idTributIcmsCustomCab ?? 0;
		jsonDados['idTributGrupoTributario'] = this.idTributGrupoTributario ?? 0;
		jsonDados['nome'] = this.nome;
		jsonDados['descricao'] = this.descricao;
		jsonDados['gtin'] = this.gtin;
		jsonDados['codigoInterno'] = this.codigoInterno;
		jsonDados['valorCompra'] = this.valorCompra;
		jsonDados['valorVenda'] = this.valorVenda;
		jsonDados['codigoNcm'] = this.codigoNcm;
		jsonDados['estoqueMinimo'] = this.estoqueMinimo;
		jsonDados['estoqueMaximo'] = this.estoqueMaximo;
		jsonDados['quantidadeEstoque'] = this.quantidadeEstoque;
		jsonDados['dataCadastro'] = this.dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataCadastro) : null;
		jsonDados['produtoSubgrupo'] = this.produtoSubgrupo == null ? null : this.produtoSubgrupo.toJson;
		jsonDados['produtoMarca'] = this.produtoMarca == null ? null : this.produtoMarca.toJson;
		jsonDados['produtoUnidade'] = this.produtoUnidade == null ? null : this.produtoUnidade.toJson;
		// jsonDados['tributIcmsCustomCab'] = this.tributIcmsCustomCab == null ? null : this.tributIcmsCustomCab.toJson;
		// jsonDados['tributGrupoTributario'] = this.tributGrupoTributario == null ? null : this.tributGrupoTributario.toJson;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(Produto objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}