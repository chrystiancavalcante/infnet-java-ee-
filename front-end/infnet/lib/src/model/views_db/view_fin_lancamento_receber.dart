/*
Title: ERP INFNET                                                                
Description: Model relacionado à tabela [VIEW_FIN_LANCAMENTO_RECEBER] 
                                                                                
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

class ViewFinLancamentoReceber {
	int id;
	int idFinLancamentoReceber;
	int quantidadeParcela;
	double valorLancamento;
	DateTime dataLancamento;
	String numeroDocumento;
	int idFinParcelaReceber;
	int numeroParcela;
	DateTime dataVencimento;
	DateTime dataRecebimento;
	double valorParcela;
	double taxaJuro;
	double valorJuro;
	double taxaMulta;
	double valorMulta;
	double taxaDesconto;
	double valorDesconto;
	String siglaDocumento;
	String nomeCliente;
	int idFinStatusParcela;
	String situacaoParcela;
	String descricaoSituacaoParcela;
	int idBancoContaCaixa;
	String nomeContaCaixa;

	ViewFinLancamentoReceber({
			this.id,
			this.idFinLancamentoReceber,
			this.quantidadeParcela,
			this.valorLancamento = 0.0,
			this.dataLancamento,
			this.numeroDocumento,
			this.idFinParcelaReceber,
			this.numeroParcela,
			this.dataVencimento,
			this.dataRecebimento,
			this.valorParcela = 0.0,
			this.taxaJuro = 0.0,
			this.valorJuro = 0.0,
			this.taxaMulta = 0.0,
			this.valorMulta = 0.0,
			this.taxaDesconto = 0.0,
			this.valorDesconto = 0.0,
			this.siglaDocumento,
			this.nomeCliente,
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
		'DATA_RECEBIMENTO', 
		'VALOR_PARCELA', 
		'TAXA_JURO', 
		'VALOR_JURO', 
		'TAXA_MULTA', 
		'VALOR_MULTA', 
		'TAXA_DESCONTO', 
		'VALOR_DESCONTO', 
		'SIGLA_DOCUMENTO', 
		'NOME_CLIENTE', 
		'SITUACAO_PARCELA', 
		'DESCRICAO_SITUACAO_PARCELA', 
		'NOME_CONTA_CAIXA', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Quantidade de Parcelas', 
		'Valor a Receber', 
		'Data de Lançamento', 
		'Número do Documento', 
		'Número da Parcela', 
		'Data de Vencimento', 
		'Data de Recebimento', 
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

	ViewFinLancamentoReceber.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idFinLancamentoReceber = jsonDados['idFinLancamentoReceber'];
		quantidadeParcela = jsonDados['quantidadeParcela'];
		valorLancamento = jsonDados['valorLancamento'] != null ? jsonDados['valorLancamento'].toDouble() : null;
		dataLancamento = jsonDados['dataLancamento'] != null ? DateTime.tryParse(jsonDados['dataLancamento']) : null;
		numeroDocumento = jsonDados['numeroDocumento'];
		idFinParcelaReceber = jsonDados['idFinParcelaReceber'];
		numeroParcela = jsonDados['numeroParcela'];
		dataVencimento = jsonDados['dataVencimento'] != null ? DateTime.tryParse(jsonDados['dataVencimento']) : null;
		dataRecebimento = jsonDados['dataRecebimento'] != null ? DateTime.tryParse(jsonDados['dataRecebimento']) : null;
		valorParcela = jsonDados['valorParcela'] != null ? jsonDados['valorParcela'].toDouble() : null;
		taxaJuro = jsonDados['taxaJuro'] != null ? jsonDados['taxaJuro'].toDouble() : null;
		valorJuro = jsonDados['valorJuro'] != null ? jsonDados['valorJuro'].toDouble() : null;
		taxaMulta = jsonDados['taxaMulta'] != null ? jsonDados['taxaMulta'].toDouble() : null;
		valorMulta = jsonDados['valorMulta'] != null ? jsonDados['valorMulta'].toDouble() : null;
		taxaDesconto = jsonDados['taxaDesconto'] != null ? jsonDados['taxaDesconto'].toDouble() : null;
		valorDesconto = jsonDados['valorDesconto'] != null ? jsonDados['valorDesconto'].toDouble() : null;
		siglaDocumento = jsonDados['siglaDocumento'];
		nomeCliente = jsonDados['nomeCliente'];
		idFinStatusParcela = jsonDados['idFinStatusParcela'];
		situacaoParcela = jsonDados['situacaoParcela'];
		descricaoSituacaoParcela = jsonDados['descricaoSituacaoParcela'];
		idBancoContaCaixa = jsonDados['idBancoContaCaixa'];
		nomeContaCaixa = jsonDados['nomeContaCaixa'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idFinLancamentoReceber'] = this.idFinLancamentoReceber ?? 0;
		jsonDados['quantidadeParcela'] = this.quantidadeParcela ?? 0;
		jsonDados['valorLancamento'] = this.valorLancamento;
		jsonDados['dataLancamento'] = this.dataLancamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataLancamento) : null;
		jsonDados['numeroDocumento'] = this.numeroDocumento;
		jsonDados['idFinParcelaReceber'] = this.idFinParcelaReceber ?? 0;
		jsonDados['numeroParcela'] = this.numeroParcela ?? 0;
		jsonDados['dataVencimento'] = this.dataVencimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataVencimento) : null;
		jsonDados['dataRecebimento'] = this.dataRecebimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataRecebimento) : null;
		jsonDados['valorParcela'] = this.valorParcela;
		jsonDados['taxaJuro'] = this.taxaJuro;
		jsonDados['valorJuro'] = this.valorJuro;
		jsonDados['taxaMulta'] = this.taxaMulta;
		jsonDados['valorMulta'] = this.valorMulta;
		jsonDados['taxaDesconto'] = this.taxaDesconto;
		jsonDados['valorDesconto'] = this.valorDesconto;
		jsonDados['siglaDocumento'] = this.siglaDocumento;
		jsonDados['nomeCliente'] = this.nomeCliente;
		jsonDados['idFinStatusParcela'] = this.idFinStatusParcela ?? 0;
		jsonDados['situacaoParcela'] = this.situacaoParcela;
		jsonDados['descricaoSituacaoParcela'] = this.descricaoSituacaoParcela;
		jsonDados['idBancoContaCaixa'] = this.idBancoContaCaixa ?? 0;
		jsonDados['nomeContaCaixa'] = this.nomeContaCaixa;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(ViewFinLancamentoReceber objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}