/*
Title: ERP INFNET                                                                
Description: Model relacionado à tabela [VIEW_FIN_LANCAMENTO_PAGAR] 
                                                                                
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

import '../model.dart';

class ViewFinLancamentoPagar {
	int id;
	int idFinLancamentoPagar;
	int quantidadeParcela;
	double valorLancamento;
	DateTime dataLancamento;
	String numeroDocumento;
	int idFinParcelaPagar;
	int numeroParcela;
	DateTime dataVencimento;
	DateTime dataPagamento;
	double valorParcela;
	double taxaJuro;
	double valorJuro;
	double taxaMulta;
	double valorMulta;
	double taxaDesconto;
	double valorDesconto;
	String siglaDocumento;
	String nomeFornecedor;
	int idFinStatusParcela;
	String situacaoParcela;
	String descricaoSituacaoParcela;
	int idBancoContaCaixa;
	String nomeContaCaixa;

	ViewFinLancamentoPagar({
			this.id,
			this.idFinLancamentoPagar,
			this.quantidadeParcela,
			this.valorLancamento,
			this.dataLancamento,
			this.numeroDocumento,
			this.idFinParcelaPagar,
			this.numeroParcela,
			this.dataVencimento,
			this.dataPagamento,
			this.valorParcela,
			this.taxaJuro,
			this.valorJuro,
			this.taxaMulta,
			this.valorMulta,
			this.taxaDesconto,
			this.valorDesconto,
			this.siglaDocumento,
			this.nomeFornecedor,
			this.idFinStatusParcela,
			this.situacaoParcela,
			this.descricaoSituacaoParcela,
			this.idBancoContaCaixa,
			this.nomeContaCaixa,
		});

	static List<String> campos = <String>[
		'ID', 
		'QUANTIDADE_PARCELA', 
		'VALOR_LANCAMENTO', 
		'DATA_LANCAMENTO', 
		'NUMERO_DOCUMENTO', 
		'NUMERO_PARCELA', 
		'DATA_VENCIMENTO', 
		'DATA_PAGAMENTO', 
		'VALOR_PARCELA', 
		'TAXA_JURO', 
		'VALOR_JURO', 
		'TAXA_MULTA', 
		'VALOR_MULTA', 
		'TAXA_DESCONTO', 
		'VALOR_DESCONTO', 
		'SIGLA_DOCUMENTO', 
		'NOME_FORNECEDOR', 
		'SITUACAO_PARCELA', 
		'DESCRICAO_SITUACAO_PARCELA', 
		'NOME_CONTA_CAIXA', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Quantidade de Parcelas', 
		'Valor a Pagar', 
		'Data de Lançamento', 
		'Número do Documento', 
		'Número da Parcela', 
		'Data de Vencimento', 
		'Data de Pagamento', 
		'Valor', 
		'Taxa Juros', 
		'Valor Juros', 
		'Taxa Multa', 
		'Valor Multa', 
		'Taxa Desconto', 
		'Valor Desconto', 
		'Sigla', 
		'Nome', 
		'Situação', 
		'Descrição', 
		'Nome', 
	];

	ViewFinLancamentoPagar.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idFinLancamentoPagar = jsonDados['idFinLancamentoPagar'];
		quantidadeParcela = jsonDados['quantidadeParcela'];
		valorLancamento = jsonDados['valorLancamento'] != null ? jsonDados['valorLancamento'].toDouble() : null;
		dataLancamento = jsonDados['dataLancamento'] != null ? DateTime.tryParse(jsonDados['dataLancamento']) : null;
		numeroDocumento = jsonDados['numeroDocumento'];
		idFinParcelaPagar = jsonDados['idFinParcelaPagar'];
		numeroParcela = jsonDados['numeroParcela'];
		dataVencimento = jsonDados['dataVencimento'] != null ? DateTime.tryParse(jsonDados['dataVencimento']) : null;
		dataPagamento = jsonDados['dataPagamento'] != null ? DateTime.tryParse(jsonDados['dataPagamento']) : null;
		valorParcela = jsonDados['valorParcela'] != null ? jsonDados['valorParcela'].toDouble() : null;
		taxaJuro = jsonDados['taxaJuro'] != null ? jsonDados['taxaJuro'].toDouble() : null;
		valorJuro = jsonDados['valorJuro'] != null ? jsonDados['valorJuro'].toDouble() : null;
		taxaMulta = jsonDados['taxaMulta'] != null ? jsonDados['taxaMulta'].toDouble() : null;
		valorMulta = jsonDados['valorMulta'] != null ? jsonDados['valorMulta'].toDouble() : null;
		taxaDesconto = jsonDados['taxaDesconto'] != null ? jsonDados['taxaDesconto'].toDouble() : null;
		valorDesconto = jsonDados['valorDesconto'] != null ? jsonDados['valorDesconto'].toDouble() : null;
		siglaDocumento = jsonDados['siglaDocumento'];
		nomeFornecedor = jsonDados['nomeFornecedor'];
		idFinStatusParcela = jsonDados['idFinStatusParcela'];
		situacaoParcela = jsonDados['situacaoParcela'];
		descricaoSituacaoParcela = jsonDados['descricaoSituacaoParcela'];
		idBancoContaCaixa = jsonDados['idBancoContaCaixa'];
		nomeContaCaixa = jsonDados['nomeContaCaixa'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idFinLancamentoPagar'] = this.idFinLancamentoPagar ?? 0;
		jsonDados['quantidadeParcela'] = this.quantidadeParcela ?? 0;
		jsonDados['valorLancamento'] = this.valorLancamento;
		jsonDados['dataLancamento'] = this.dataLancamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataLancamento) : null;
		jsonDados['numeroDocumento'] = this.numeroDocumento;
		jsonDados['idFinParcelaPagar'] = this.idFinParcelaPagar ?? 0;
		jsonDados['numeroParcela'] = this.numeroParcela ?? 0;
		jsonDados['dataVencimento'] = this.dataVencimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataVencimento) : null;
		jsonDados['dataPagamento'] = this.dataPagamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataPagamento) : null;
    jsonDados['valorParcela'] = this.valorParcela;
		jsonDados['taxaJuro'] = this.taxaJuro;
		jsonDados['valorJuro'] = this.valorJuro;
		jsonDados['taxaMulta'] = this.taxaMulta;
		jsonDados['valorMulta'] = this.valorMulta;
		jsonDados['taxaDesconto'] = this.taxaDesconto;
		jsonDados['valorDesconto'] = this.valorDesconto;
		jsonDados['siglaDocumento'] = this.siglaDocumento;
		jsonDados['nomeFornecedor'] = this.nomeFornecedor;
		jsonDados['idFinStatusParcela'] = this.idFinStatusParcela ?? 0;
		jsonDados['situacaoParcela'] = this.situacaoParcela;
		jsonDados['descricaoSituacaoParcela'] = this.descricaoSituacaoParcela;
		jsonDados['idBancoContaCaixa'] = this.idBancoContaCaixa ?? 0;
		jsonDados['nomeContaCaixa'] = this.nomeContaCaixa;
	
		return jsonDados;
	}

	String objetoEncodeJson(ViewFinLancamentoPagar objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}