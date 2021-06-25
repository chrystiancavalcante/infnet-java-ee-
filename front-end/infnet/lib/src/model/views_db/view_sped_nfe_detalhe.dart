/*
Title: ERP INFNET                                                                
Description: Model relacionado à tabela [VIEW_SPED_NFE_DETALHE] 
                                                                                
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

import 'package:infnet/src/infra/biblioteca.dart';
import 'package:infnet/src/model/model.dart';

class ViewSpedNfeDetalhe {
	int id;
	int idNfeCabecalho;
	int idProduto;
	int numeroItem;
	String codigoProduto;
	String gtin;
	String nomeProduto;
	String ncm;
	String nve;
	String cest;
	String indicadorEscalaRelevante;
	String cnpjFabricante;
	String codigoBeneficioFiscal;
	int exTipi;
	int cfop;
	String unidadeComercial;
	double quantidadeComercial;
	String numeroPedidoCompra;
	int itemPedidoCompra;
	String numeroFci;
	String numeroRecopi;
	double valorUnitarioComercial;
	double valorBrutoProduto;
	String gtinUnidadeTributavel;
	String unidadeTributavel;
	double quantidadeTributavel;
	double valorUnitarioTributavel;
	double valorFrete;
	double valorSeguro;
	double valorDesconto;
	double valorOutrasDespesas;
	String entraTotal;
	double valorTotalTributos;
	double percentualDevolvido;
	double valorIpiDevolvido;
	String informacoesAdicionais;
	double valorSubtotal;
	double valorTotal;
	int idTributOperacaoFiscal;
	int idProdutoUnidade;
	String cstCofins;
	double quantidadeVendidaCofins;
	double baseCalculoCofins;
	double aliquotaCofinsPercentual;
	double aliquotaCofinsReais;
	double valorCofins;
	String origemMercadoria;
	String cstIcms;
	String csosn;
	String modalidadeBcIcms;
	double percentualReducaoBcIcms;
	double valorBcIcms;
	double aliquotaIcms;
	double valorIcms;
	String motivoDesoneracaoIcms;
	String modalidadeBcIcmsSt;
	double percentualMvaIcmsSt;
	double percentualReducaoBcIcmsSt;
	double valorBaseCalculoIcmsSt;
	double aliquotaIcmsSt;
	double valorIcmsSt;
	double valorBcIcmsStRetido;
	double valorIcmsStRetido;
	double valorBcIcmsStDestino;
	double valorIcmsStDestino;
	double aliquotaCreditoIcmsSn;
	double valorCreditoIcmsSn;
	double percentualBcOperacaoPropria;
	String ufSt;
	double valorBcIi;
	double valorDespesasAduaneiras;
	double valorImpostoImportacao;
	double valorIof;
	String cnpjProdutor;
	String codigoSeloIpi;
	int quantidadeSeloIpi;
	String enquadramentoLegalIpi;
	String cstIpi;
	double valorBaseCalculoIpi;
	double aliquotaIpi;
	double quantidadeUnidadeTributavel;
	double valorUnidadeTributavel;
	double valorIpi;
	double baseCalculoIssqn;
	double aliquotaIssqn;
	double valorIssqn;
	int municipioIssqn;
	int itemListaServicos;
	String cstPis;
	double quantidadeVendidaPis;
	double valorBaseCalculoPis;
	double aliquotaPisPercentual;
	double aliquotaPisReais;
	double valorPis;
	Produto produto;
//	TributOperacaoFiscal tributOperacaoFiscal;
	ProdutoUnidade produtoUnidade;

	ViewSpedNfeDetalhe({
		this.id,
		this.idNfeCabecalho,
		this.idProduto,
		this.numeroItem,
		this.codigoProduto,
		this.gtin,
		this.nomeProduto,
		this.ncm,
		this.nve,
		this.cest,
		this.indicadorEscalaRelevante,
		this.cnpjFabricante,
		this.codigoBeneficioFiscal,
		this.exTipi,
		this.cfop,
		this.unidadeComercial,
		this.quantidadeComercial = 0.0,
		this.numeroPedidoCompra,
		this.itemPedidoCompra,
		this.numeroFci,
		this.numeroRecopi,
		this.valorUnitarioComercial = 0.0,
		this.valorBrutoProduto = 0.0,
		this.gtinUnidadeTributavel,
		this.unidadeTributavel,
		this.quantidadeTributavel = 0.0,
		this.valorUnitarioTributavel = 0.0,
		this.valorFrete = 0.0,
		this.valorSeguro = 0.0,
		this.valorDesconto = 0.0,
		this.valorOutrasDespesas = 0.0,
		this.entraTotal,
		this.valorTotalTributos = 0.0,
		this.percentualDevolvido = 0.0,
		this.valorIpiDevolvido = 0.0,
		this.informacoesAdicionais,
		this.valorSubtotal = 0.0,
		this.valorTotal = 0.0,
		this.idTributOperacaoFiscal,
		this.idProdutoUnidade,
		this.cstCofins,
		this.quantidadeVendidaCofins = 0.0,
		this.baseCalculoCofins = 0.0,
		this.aliquotaCofinsPercentual = 0.0,
		this.aliquotaCofinsReais = 0.0,
		this.valorCofins = 0.0,
		this.origemMercadoria,
		this.cstIcms,
		this.csosn,
		this.modalidadeBcIcms,
		this.percentualReducaoBcIcms = 0.0,
		this.valorBcIcms = 0.0,
		this.aliquotaIcms = 0.0,
		this.valorIcms = 0.0,
		this.motivoDesoneracaoIcms,
		this.modalidadeBcIcmsSt,
		this.percentualMvaIcmsSt = 0.0,
		this.percentualReducaoBcIcmsSt = 0.0,
		this.valorBaseCalculoIcmsSt = 0.0,
		this.aliquotaIcmsSt = 0.0,
		this.valorIcmsSt = 0.0,
		this.valorBcIcmsStRetido = 0.0,
		this.valorIcmsStRetido = 0.0,
		this.valorBcIcmsStDestino = 0.0,
		this.valorIcmsStDestino = 0.0,
		this.aliquotaCreditoIcmsSn = 0.0,
		this.valorCreditoIcmsSn = 0.0,
		this.percentualBcOperacaoPropria = 0.0,
		this.ufSt,
		this.valorBcIi = 0.0,
		this.valorDespesasAduaneiras = 0.0,
		this.valorImpostoImportacao = 0.0,
		this.valorIof = 0.0,
		this.cnpjProdutor,
		this.codigoSeloIpi,
		this.quantidadeSeloIpi,
		this.enquadramentoLegalIpi,
		this.cstIpi,
		this.valorBaseCalculoIpi = 0.0,
		this.aliquotaIpi = 0.0,
		this.quantidadeUnidadeTributavel = 0.0,
		this.valorUnidadeTributavel = 0.0,
		this.valorIpi = 0.0,
		this.baseCalculoIssqn = 0.0,
		this.aliquotaIssqn = 0.0,
		this.valorIssqn = 0.0,
		this.municipioIssqn,
		this.itemListaServicos,
		this.cstPis,
		this.quantidadeVendidaPis = 0.0,
		this.valorBaseCalculoPis = 0.0,
		this.aliquotaPisPercentual = 0.0,
		this.aliquotaPisReais = 0.0,
		this.valorPis = 0.0,
		this.produto,
		//this.tributOperacaoFiscal,
		this.produtoUnidade,
	});

	static List<String> campos = <String>[
		'ID', 
		'NUMERO_ITEM', 
		'CODIGO_PRODUTO', 
		'GTIN', 
		'NOME_PRODUTO', 
		'NCM', 
		'NVE', 
		'CEST', 
		'INDICADOR_ESCALA_RELEVANTE', 
		'CNPJ_FABRICANTE', 
		'CODIGO_BENEFICIO_FISCAL', 
		'EX_TIPI', 
		'CFOP', 
		'UNIDADE_COMERCIAL', 
		'QUANTIDADE_COMERCIAL', 
		'NUMERO_PEDIDO_COMPRA', 
		'ITEM_PEDIDO_COMPRA', 
		'NUMERO_FCI', 
		'NUMERO_RECOPI', 
		'VALOR_UNITARIO_COMERCIAL', 
		'VALOR_BRUTO_PRODUTO', 
		'GTIN_UNIDADE_TRIBUTAVEL', 
		'UNIDADE_TRIBUTAVEL', 
		'QUANTIDADE_TRIBUTAVEL', 
		'VALOR_UNITARIO_TRIBUTAVEL', 
		'VALOR_FRETE', 
		'VALOR_SEGURO', 
		'VALOR_DESCONTO', 
		'VALOR_OUTRAS_DESPESAS', 
		'ENTRA_TOTAL', 
		'VALOR_TOTAL_TRIBUTOS', 
		'PERCENTUAL_DEVOLVIDO', 
		'VALOR_IPI_DEVOLVIDO', 
		'INFORMACOES_ADICIONAIS', 
		'VALOR_SUBTOTAL', 
		'VALOR_TOTAL', 
		'CST_COFINS', 
		'QUANTIDADE_VENDIDA_COFINS', 
		'BASE_CALCULO_COFINS', 
		'ALIQUOTA_COFINS_PERCENTUAL', 
		'ALIQUOTA_COFINS_REAIS', 
		'VALOR_COFINS', 
		'ORIGEM_MERCADORIA', 
		'CST_ICMS', 
		'CSOSN', 
		'MODALIDADE_BC_ICMS', 
		'PERCENTUAL_REDUCAO_BC_ICMS', 
		'VALOR_BC_ICMS', 
		'ALIQUOTA_ICMS', 
		'VALOR_ICMS', 
		'MOTIVO_DESONERACAO_ICMS', 
		'MODALIDADE_BC_ICMS_ST', 
		'PERCENTUAL_MVA_ICMS_ST', 
		'PERCENTUAL_REDUCAO_BC_ICMS_ST', 
		'VALOR_BASE_CALCULO_ICMS_ST', 
		'ALIQUOTA_ICMS_ST', 
		'VALOR_ICMS_ST', 
		'VALOR_BC_ICMS_ST_RETIDO', 
		'VALOR_ICMS_ST_RETIDO', 
		'VALOR_BC_ICMS_ST_DESTINO', 
		'VALOR_ICMS_ST_DESTINO', 
		'ALIQUOTA_CREDITO_ICMS_SN', 
		'VALOR_CREDITO_ICMS_SN', 
		'PERCENTUAL_BC_OPERACAO_PROPRIA', 
		'UF_ST', 
		'VALOR_BC_II', 
		'VALOR_DESPESAS_ADUANEIRAS', 
		'VALOR_IMPOSTO_IMPORTACAO', 
		'VALOR_IOF', 
		'CNPJ_PRODUTOR', 
		'CODIGO_SELO_IPI', 
		'QUANTIDADE_SELO_IPI', 
		'ENQUADRAMENTO_LEGAL_IPI', 
		'CST_IPI', 
		'VALOR_BASE_CALCULO_IPI', 
		'ALIQUOTA_IPI', 
		'QUANTIDADE_UNIDADE_TRIBUTAVEL', 
		'VALOR_UNIDADE_TRIBUTAVEL', 
		'VALOR_IPI', 
		'BASE_CALCULO_ISSQN', 
		'ALIQUOTA_ISSQN', 
		'VALOR_ISSQN', 
		'MUNICIPIO_ISSQN', 
		'ITEM_LISTA_SERVICOS', 
		'CST_PIS', 
		'QUANTIDADE_VENDIDA_PIS', 
		'VALOR_BASE_CALCULO_PIS', 
		'ALIQUOTA_PIS_PERCENTUAL', 
		'ALIQUOTA_PIS_REAIS', 
		'VALOR_PIS', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Número do Item', 
		'Código do Produto', 
		'GTIN', 
		'Nome', 
		'NCM', 
		'NVE', 
		'CEST', 
		'Indicador Escala Relevante', 
		'CNPJ do Fabricante', 
		'Código Benefício Fiscal', 
		'EX TIPI', 
		'CFOP', 
		'Unidade Comercial', 
		'Quantidade Comercial', 
		'Número Pedido Compra', 
		'Item Pedido Compra', 
		'Número FCI', 
		'Número RECOPI', 
		'Valor Unitário Comercial', 
		'Valor Bruto Produto', 
		'GTIN Unidade Tributável', 
		'Unidade Tributável', 
		'Quantidade Tributável', 
		'Valor Unitário Tributável', 
		'Valor Frete', 
		'Valor Seguro', 
		'Valor Desconto', 
		'Valor Outras Despesas', 
		'Indicador Exibilidade', 
		'Valor Total Tributos', 
		'Percentual Devolvido', 
		'Valor IPI Devolvido', 
		'Informações Adicionais', 
		'Valor Subtotal', 
		'Valor Total', 
		'CST COFINS', 
		'Quantidade Vendida', 
		'Valor BC COFINS', 
		'Alíquota COFINS Percentual', 
		'Alíquota COFINS Reais', 
		'Valor COFINS', 
		'Origem da Mercadoria', 
		'CST', 
		'CSOSN', 
		'Modalidade Base Cálculo', 
		'Percentual Redução BC ICMS', 
		'Valor BC ICMS', 
		'Alíquota ICMS', 
		'Valor ICMS', 
		'UF', 
		'Indicador Exibilidade', 
		'Percentual MVA ICMS ST', 
		'Percentual Redução BC ICMS ST', 
		'Valor BC ICMS ST', 
		'Alíquota ICMS ST', 
		'Valor ICMS ST', 
		'Valor BC ICMS ST Retido', 
		'Valor ICMS ST Retido', 
		'Valor BC ICMS ST Destino', 
		'Valor ICMS ST Destino', 
		'Alíquota Crédito ICMS SN', 
		'Valor Crédito ICMS SN', 
		'Percentual BC Operação Própria', 
		'UF', 
		'Valor BC II', 
		'Valor Despesas Aduaneiras', 
		'Valor Imposto Importação', 
		'Valor IOF', 
		'CNPJ Produtor', 
		'Código Selo IPI', 
		'Quantidade Selos', 
		'Código de Enquadramento Legal', 
		'CST IPI', 
		'Valor BC IPI', 
		'Alíquota IPI', 
		'Quantidade Unidade Tributável', 
		'Valor Unidade Tributável', 
		'Valor IPI', 
		'Valor BC ISSQN', 
		'Alíquota ISSQN', 
		'Valor ISSQN', 
		'Município IBGE', 
		'Item Lista Serviços', 
		'CST PIS', 
		'Quantidade Vendida', 
		'Valor BC PIS', 
		'Alíquota PIS Percentual', 
		'Alíquota PIS Reais', 
		'Valor PIS', 
	];

	ViewSpedNfeDetalhe.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idNfeCabecalho = jsonDados['idNfeCabecalho'];
		idProduto = jsonDados['idProduto'];
		numeroItem = jsonDados['numeroItem'];
		codigoProduto = jsonDados['codigoProduto'];
		gtin = jsonDados['gtin'];
		nomeProduto = jsonDados['nomeProduto'];
		ncm = jsonDados['ncm'];
		nve = jsonDados['nve'];
		cest = jsonDados['cest'];
		indicadorEscalaRelevante = getIndicadorEscalaRelevante(jsonDados['indicadorEscalaRelevante']);
		cnpjFabricante = jsonDados['cnpjFabricante'];
		codigoBeneficioFiscal = jsonDados['codigoBeneficioFiscal'];
		exTipi = jsonDados['exTipi'];
		cfop = jsonDados['cfop'];
		unidadeComercial = jsonDados['unidadeComercial'];
		quantidadeComercial = jsonDados['quantidadeComercial'] != null ? jsonDados['quantidadeComercial'].toDouble() : null;
		numeroPedidoCompra = jsonDados['numeroPedidoCompra'];
		itemPedidoCompra = jsonDados['itemPedidoCompra'];
		numeroFci = jsonDados['numeroFci'];
		numeroRecopi = jsonDados['numeroRecopi'];
		valorUnitarioComercial = jsonDados['valorUnitarioComercial'] != null ? jsonDados['valorUnitarioComercial'].toDouble() : null;
		valorBrutoProduto = jsonDados['valorBrutoProduto'] != null ? jsonDados['valorBrutoProduto'].toDouble() : null;
		gtinUnidadeTributavel = jsonDados['gtinUnidadeTributavel'];
		unidadeTributavel = jsonDados['unidadeTributavel'];
		quantidadeTributavel = jsonDados['quantidadeTributavel'] != null ? jsonDados['quantidadeTributavel'].toDouble() : null;
		valorUnitarioTributavel = jsonDados['valorUnitarioTributavel'] != null ? jsonDados['valorUnitarioTributavel'].toDouble() : null;
		valorFrete = jsonDados['valorFrete'] != null ? jsonDados['valorFrete'].toDouble() : null;
		valorSeguro = jsonDados['valorSeguro'] != null ? jsonDados['valorSeguro'].toDouble() : null;
		valorDesconto = jsonDados['valorDesconto'] != null ? jsonDados['valorDesconto'].toDouble() : null;
		valorOutrasDespesas = jsonDados['valorOutrasDespesas'] != null ? jsonDados['valorOutrasDespesas'].toDouble() : null;
		entraTotal = getEntraTotal(jsonDados['entraTotal']);
		valorTotalTributos = jsonDados['valorTotalTributos'] != null ? jsonDados['valorTotalTributos'].toDouble() : null;
		percentualDevolvido = jsonDados['percentualDevolvido'] != null ? jsonDados['percentualDevolvido'].toDouble() : null;
		valorIpiDevolvido = jsonDados['valorIpiDevolvido'] != null ? jsonDados['valorIpiDevolvido'].toDouble() : null;
		informacoesAdicionais = jsonDados['informacoesAdicionais'];
		valorSubtotal = jsonDados['valorSubtotal'] != null ? jsonDados['valorSubtotal'].toDouble() : null;
		valorTotal = jsonDados['valorTotal'] != null ? jsonDados['valorTotal'].toDouble() : null;
		idTributOperacaoFiscal = jsonDados['idTributOperacaoFiscal'];
		idProdutoUnidade = jsonDados['idProdutoUnidade'];
		cstCofins = jsonDados['cstCofins'];
		quantidadeVendidaCofins = jsonDados['quantidadeVendidaCofins'] != null ? jsonDados['quantidadeVendidaCofins'].toDouble() : null;
		baseCalculoCofins = jsonDados['baseCalculoCofins'] != null ? jsonDados['baseCalculoCofins'].toDouble() : null;
		aliquotaCofinsPercentual = jsonDados['aliquotaCofinsPercentual'] != null ? jsonDados['aliquotaCofinsPercentual'].toDouble() : null;
		aliquotaCofinsReais = jsonDados['aliquotaCofinsReais'] != null ? jsonDados['aliquotaCofinsReais'].toDouble() : null;
		valorCofins = jsonDados['valorCofins'] != null ? jsonDados['valorCofins'].toDouble() : null;
		origemMercadoria = jsonDados['origemMercadoria'] == '' ? null : jsonDados['origemMercadoria'];
		cstIcms = jsonDados['cstIcms'];
		csosn = jsonDados['csosn'];
		modalidadeBcIcms = getModalidadeBcIcms(jsonDados['modalidadeBcIcms']);
		percentualReducaoBcIcms = jsonDados['percentualReducaoBcIcms'] != null ? jsonDados['percentualReducaoBcIcms'].toDouble() : null;
		valorBcIcms = jsonDados['valorBcIcms'] != null ? jsonDados['valorBcIcms'].toDouble() : null;
		aliquotaIcms = jsonDados['aliquotaIcms'] != null ? jsonDados['aliquotaIcms'].toDouble() : null;
		valorIcms = jsonDados['valorIcms'] != null ? jsonDados['valorIcms'].toDouble() : null;
		motivoDesoneracaoIcms = jsonDados['motivoDesoneracaoIcms'] == '' ? null : jsonDados['motivoDesoneracaoIcms'];
		modalidadeBcIcmsSt = getModalidadeBcIcmsSt(jsonDados['modalidadeBcIcmsSt']);
		percentualMvaIcmsSt = jsonDados['percentualMvaIcmsSt'] != null ? jsonDados['percentualMvaIcmsSt'].toDouble() : null;
		percentualReducaoBcIcmsSt = jsonDados['percentualReducaoBcIcmsSt'] != null ? jsonDados['percentualReducaoBcIcmsSt'].toDouble() : null;
		valorBaseCalculoIcmsSt = jsonDados['valorBaseCalculoIcmsSt'] != null ? jsonDados['valorBaseCalculoIcmsSt'].toDouble() : null;
		aliquotaIcmsSt = jsonDados['aliquotaIcmsSt'] != null ? jsonDados['aliquotaIcmsSt'].toDouble() : null;
		valorIcmsSt = jsonDados['valorIcmsSt'] != null ? jsonDados['valorIcmsSt'].toDouble() : null;
		valorBcIcmsStRetido = jsonDados['valorBcIcmsStRetido'] != null ? jsonDados['valorBcIcmsStRetido'].toDouble() : null;
		valorIcmsStRetido = jsonDados['valorIcmsStRetido'] != null ? jsonDados['valorIcmsStRetido'].toDouble() : null;
		valorBcIcmsStDestino = jsonDados['valorBcIcmsStDestino'] != null ? jsonDados['valorBcIcmsStDestino'].toDouble() : null;
		valorIcmsStDestino = jsonDados['valorIcmsStDestino'] != null ? jsonDados['valorIcmsStDestino'].toDouble() : null;
		aliquotaCreditoIcmsSn = jsonDados['aliquotaCreditoIcmsSn'] != null ? jsonDados['aliquotaCreditoIcmsSn'].toDouble() : null;
		valorCreditoIcmsSn = jsonDados['valorCreditoIcmsSn'] != null ? jsonDados['valorCreditoIcmsSn'].toDouble() : null;
		percentualBcOperacaoPropria = jsonDados['percentualBcOperacaoPropria'] != null ? jsonDados['percentualBcOperacaoPropria'].toDouble() : null;
		ufSt = jsonDados['ufSt'] == '' ? null : jsonDados['ufSt'];
		valorBcIi = jsonDados['valorBcIi'] != null ? jsonDados['valorBcIi'].toDouble() : null;
		valorDespesasAduaneiras = jsonDados['valorDespesasAduaneiras'] != null ? jsonDados['valorDespesasAduaneiras'].toDouble() : null;
		valorImpostoImportacao = jsonDados['valorImpostoImportacao'] != null ? jsonDados['valorImpostoImportacao'].toDouble() : null;
		valorIof = jsonDados['valorIof'] != null ? jsonDados['valorIof'].toDouble() : null;
		cnpjProdutor = jsonDados['cnpjProdutor'];
		codigoSeloIpi = jsonDados['codigoSeloIpi'];
		quantidadeSeloIpi = jsonDados['quantidadeSeloIpi'];
		enquadramentoLegalIpi = jsonDados['enquadramentoLegalIpi'];
		cstIpi = jsonDados['cstIpi'];
		valorBaseCalculoIpi = jsonDados['valorBaseCalculoIpi'] != null ? jsonDados['valorBaseCalculoIpi'].toDouble() : null;
		aliquotaIpi = jsonDados['aliquotaIpi'] != null ? jsonDados['aliquotaIpi'].toDouble() : null;
		quantidadeUnidadeTributavel = jsonDados['quantidadeUnidadeTributavel'] != null ? jsonDados['quantidadeUnidadeTributavel'].toDouble() : null;
		valorUnidadeTributavel = jsonDados['valorUnidadeTributavel'] != null ? jsonDados['valorUnidadeTributavel'].toDouble() : null;
		valorIpi = jsonDados['valorIpi'] != null ? jsonDados['valorIpi'].toDouble() : null;
		baseCalculoIssqn = jsonDados['baseCalculoIssqn'] != null ? jsonDados['baseCalculoIssqn'].toDouble() : null;
		aliquotaIssqn = jsonDados['aliquotaIssqn'] != null ? jsonDados['aliquotaIssqn'].toDouble() : null;
		valorIssqn = jsonDados['valorIssqn'] != null ? jsonDados['valorIssqn'].toDouble() : null;
		municipioIssqn = jsonDados['municipioIssqn'];
		itemListaServicos = jsonDados['itemListaServicos'];
		cstPis = jsonDados['cstPis'];
		quantidadeVendidaPis = jsonDados['quantidadeVendidaPis'] != null ? jsonDados['quantidadeVendidaPis'].toDouble() : null;
		valorBaseCalculoPis = jsonDados['valorBaseCalculoPis'] != null ? jsonDados['valorBaseCalculoPis'].toDouble() : null;
		aliquotaPisPercentual = jsonDados['aliquotaPisPercentual'] != null ? jsonDados['aliquotaPisPercentual'].toDouble() : null;
		aliquotaPisReais = jsonDados['aliquotaPisReais'] != null ? jsonDados['aliquotaPisReais'].toDouble() : null;
		valorPis = jsonDados['valorPis'] != null ? jsonDados['valorPis'].toDouble() : null;
		produto = jsonDados['produto'] == null ? null : Produto.fromJson(jsonDados['produto']);
		//tributOperacaoFiscal = jsonDados['tributOperacaoFiscal'] == null ? null : TributOperacaoFiscal.fromJson(jsonDados['tributOperacaoFiscal']);
		produtoUnidade = jsonDados['produtoUnidade'] == null ? null : ProdutoUnidade.fromJson(jsonDados['produtoUnidade']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idNfeCabecalho'] = this.idNfeCabecalho ?? 0;
		jsonDados['idProduto'] = this.idProduto ?? 0;
		jsonDados['numeroItem'] = this.numeroItem ?? 0;
		jsonDados['codigoProduto'] = this.codigoProduto;
		jsonDados['gtin'] = this.gtin;
		jsonDados['nomeProduto'] = this.nomeProduto;
		jsonDados['ncm'] = this.ncm;
		jsonDados['nve'] = this.nve;
		jsonDados['cest'] = this.cest;
		jsonDados['indicadorEscalaRelevante'] = setIndicadorEscalaRelevante(this.indicadorEscalaRelevante);
		jsonDados['cnpjFabricante'] = Biblioteca.removerMascara(this.cnpjFabricante);
		jsonDados['codigoBeneficioFiscal'] = this.codigoBeneficioFiscal;
		jsonDados['exTipi'] = this.exTipi ?? 0;
		jsonDados['cfop'] = this.cfop ?? 0;
		jsonDados['unidadeComercial'] = this.unidadeComercial;
		jsonDados['quantidadeComercial'] = this.quantidadeComercial;
		jsonDados['numeroPedidoCompra'] = this.numeroPedidoCompra;
		jsonDados['itemPedidoCompra'] = this.itemPedidoCompra ?? 0;
		jsonDados['numeroFci'] = this.numeroFci;
		jsonDados['numeroRecopi'] = this.numeroRecopi;
		jsonDados['valorUnitarioComercial'] = this.valorUnitarioComercial;
		jsonDados['valorBrutoProduto'] = this.valorBrutoProduto;
		jsonDados['gtinUnidadeTributavel'] = this.gtinUnidadeTributavel;
		jsonDados['unidadeTributavel'] = this.unidadeTributavel;
		jsonDados['quantidadeTributavel'] = this.quantidadeTributavel;
		jsonDados['valorUnitarioTributavel'] = this.valorUnitarioTributavel;
		jsonDados['valorFrete'] = this.valorFrete;
		jsonDados['valorSeguro'] = this.valorSeguro;
		jsonDados['valorDesconto'] = this.valorDesconto;
		jsonDados['valorOutrasDespesas'] = this.valorOutrasDespesas;
		jsonDados['entraTotal'] = setEntraTotal(this.entraTotal);
		jsonDados['valorTotalTributos'] = this.valorTotalTributos;
		jsonDados['percentualDevolvido'] = this.percentualDevolvido;
		jsonDados['valorIpiDevolvido'] = this.valorIpiDevolvido;
		jsonDados['informacoesAdicionais'] = this.informacoesAdicionais;
		jsonDados['valorSubtotal'] = this.valorSubtotal;
		jsonDados['valorTotal'] = this.valorTotal;
		jsonDados['idTributOperacaoFiscal'] = this.idTributOperacaoFiscal ?? 0;
		jsonDados['idProdutoUnidade'] = this.idProdutoUnidade ?? 0;
		jsonDados['cstCofins'] = this.cstCofins;
		jsonDados['quantidadeVendidaCofins'] = this.quantidadeVendidaCofins;
		jsonDados['baseCalculoCofins'] = this.baseCalculoCofins;
		jsonDados['aliquotaCofinsPercentual'] = this.aliquotaCofinsPercentual;
		jsonDados['aliquotaCofinsReais'] = this.aliquotaCofinsReais;
		jsonDados['valorCofins'] = this.valorCofins;
		jsonDados['origemMercadoria'] = this.origemMercadoria;
		jsonDados['cstIcms'] = this.cstIcms;
		jsonDados['csosn'] = this.csosn;
		jsonDados['modalidadeBcIcms'] = setModalidadeBcIcms(this.modalidadeBcIcms);
		jsonDados['percentualReducaoBcIcms'] = this.percentualReducaoBcIcms;
		jsonDados['valorBcIcms'] = this.valorBcIcms;
		jsonDados['aliquotaIcms'] = this.aliquotaIcms;
		jsonDados['valorIcms'] = this.valorIcms;
		jsonDados['motivoDesoneracaoIcms'] = this.motivoDesoneracaoIcms;
		jsonDados['modalidadeBcIcmsSt'] = setModalidadeBcIcmsSt(this.modalidadeBcIcmsSt);
		jsonDados['percentualMvaIcmsSt'] = this.percentualMvaIcmsSt;
		jsonDados['percentualReducaoBcIcmsSt'] = this.percentualReducaoBcIcmsSt;
		jsonDados['valorBaseCalculoIcmsSt'] = this.valorBaseCalculoIcmsSt;
		jsonDados['aliquotaIcmsSt'] = this.aliquotaIcmsSt;
		jsonDados['valorIcmsSt'] = this.valorIcmsSt;
		jsonDados['valorBcIcmsStRetido'] = this.valorBcIcmsStRetido;
		jsonDados['valorIcmsStRetido'] = this.valorIcmsStRetido;
		jsonDados['valorBcIcmsStDestino'] = this.valorBcIcmsStDestino;
		jsonDados['valorIcmsStDestino'] = this.valorIcmsStDestino;
		jsonDados['aliquotaCreditoIcmsSn'] = this.aliquotaCreditoIcmsSn;
		jsonDados['valorCreditoIcmsSn'] = this.valorCreditoIcmsSn;
		jsonDados['percentualBcOperacaoPropria'] = this.percentualBcOperacaoPropria;
		jsonDados['ufSt'] = this.ufSt;
		jsonDados['valorBcIi'] = this.valorBcIi;
		jsonDados['valorDespesasAduaneiras'] = this.valorDespesasAduaneiras;
		jsonDados['valorImpostoImportacao'] = this.valorImpostoImportacao;
		jsonDados['valorIof'] = this.valorIof;
		jsonDados['cnpjProdutor'] = Biblioteca.removerMascara(this.cnpjProdutor);
		jsonDados['codigoSeloIpi'] = this.codigoSeloIpi;
		jsonDados['quantidadeSeloIpi'] = this.quantidadeSeloIpi ?? 0;
		jsonDados['enquadramentoLegalIpi'] = this.enquadramentoLegalIpi;
		jsonDados['cstIpi'] = this.cstIpi;
		jsonDados['valorBaseCalculoIpi'] = this.valorBaseCalculoIpi;
		jsonDados['aliquotaIpi'] = this.aliquotaIpi;
		jsonDados['quantidadeUnidadeTributavel'] = this.quantidadeUnidadeTributavel;
		jsonDados['valorUnidadeTributavel'] = this.valorUnidadeTributavel;
		jsonDados['valorIpi'] = this.valorIpi;
		jsonDados['baseCalculoIssqn'] = this.baseCalculoIssqn;
		jsonDados['aliquotaIssqn'] = this.aliquotaIssqn;
		jsonDados['valorIssqn'] = this.valorIssqn;
		jsonDados['municipioIssqn'] = this.municipioIssqn ?? 0;
		jsonDados['itemListaServicos'] = this.itemListaServicos ?? 0;
		jsonDados['cstPis'] = this.cstPis;
		jsonDados['quantidadeVendidaPis'] = this.quantidadeVendidaPis;
		jsonDados['valorBaseCalculoPis'] = this.valorBaseCalculoPis;
		jsonDados['aliquotaPisPercentual'] = this.aliquotaPisPercentual;
		jsonDados['aliquotaPisReais'] = this.aliquotaPisReais;
		jsonDados['valorPis'] = this.valorPis;
		jsonDados['produto'] = this.produto == null ? null : this.produto.toJson;
		//jsonDados['tributOperacaoFiscal'] = this.tributOperacaoFiscal == null ? null : this.tributOperacaoFiscal.toJson;
		jsonDados['produtoUnidade'] = this.produtoUnidade == null ? null : this.produtoUnidade.toJson;
	
		return jsonDados;
	}
	
    getIndicadorEscalaRelevante(String indicadorEscalaRelevante) {
    	switch (indicadorEscalaRelevante) {
    		case 'S':
    			return 'Sim';
    			break;
    		case 'N':
    			return 'Não';
    			break;
    		default:
    			return null;
    		}
    	}

    setIndicadorEscalaRelevante(String indicadorEscalaRelevante) {
    	switch (indicadorEscalaRelevante) {
    		case 'Sim':
    			return 'S';
    			break;
    		case 'Não':
    			return 'N';
    			break;
    		default:
    			return null;
    		}
    	}

    getEntraTotal(String entraTotal) {
    	switch (entraTotal) {
    		case '0':
    			return '0=Valor do item (vProd) não compõe o valor total da NF-e';
    			break;
    		case '1':
    			return '1=Valor do item (vProd) compõe o valor total da NF-e (vProd)';
    			break;
    		default:
    			return null;
    		}
    	}

    setEntraTotal(String entraTotal) {
    	switch (entraTotal) {
    		case '0=Valor do item (vProd) não compõe o valor total da NF-e':
    			return '0';
    			break;
    		case '1=Valor do item (vProd) compõe o valor total da NF-e (vProd)':
    			return '1';
    			break;
    		default:
    			return null;
    		}
    	}

    getModalidadeBcIcms(String modalidadeBcIcms) {
    	switch (modalidadeBcIcms) {
    		case '0':
    			return '0=Margem Valor Agregado (%)';
    			break;
    		case '1':
    			return '1=Pauta (valor)';
    			break;
    		case '2':
    			return '2=Preço Tabelado Máximo (valor)';
    			break;
    		case '3':
    			return '3=Valor da Operação';
    			break;
    		default:
    			return null;
    		}
    	}

    setModalidadeBcIcms(String modalidadeBcIcms) {
    	switch (modalidadeBcIcms) {
    		case '0=Margem Valor Agregado (%)':
    			return '0';
    			break;
    		case '1=Pauta (valor)':
    			return '1';
    			break;
    		case '2=Preço Tabelado Máximo (valor)':
    			return '2';
    			break;
    		case '3=Valor da Operação':
    			return '3';
    			break;
    		default:
    			return null;
    		}
    	}

    getModalidadeBcIcmsSt(String modalidadeBcIcmsSt) {
    	switch (modalidadeBcIcmsSt) {
    		case '0':
    			return '0=Preço tabelado ou máximo sugerido';
    			break;
    		case '1':
    			return '1=Lista Negativa (valor)';
    			break;
    		case '2':
    			return '2=Lista Positiva (valor)';
    			break;
    		case '3':
    			return '3=Lista Neutra (valor)';
    			break;
    		case '4':
    			return '4=Margem Valor Agregado (%)';
    			break;
    		case '5':
    			return '5=Pauta (valor)';
    			break;
    		default:
    			return null;
    		}
    	}

    setModalidadeBcIcmsSt(String modalidadeBcIcmsSt) {
    	switch (modalidadeBcIcmsSt) {
    		case '0=Preço tabelado ou máximo sugerido':
    			return '0';
    			break;
    		case '1=Lista Negativa (valor)':
    			return '1';
    			break;
    		case '2=Lista Positiva (valor)':
    			return '2';
    			break;
    		case '3=Lista Neutra (valor)':
    			return '3';
    			break;
    		case '4=Margem Valor Agregado (%)':
    			return '4';
    			break;
    		case '5=Pauta (valor)':
    			return '5';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(ViewSpedNfeDetalhe objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}