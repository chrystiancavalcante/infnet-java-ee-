/*
Title: ERP INFNET                                                                
Description: Service que exporta os demais Services
                                                                                
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

// módulo cadastros
export 'package:infnet/src/service/cadastros/banco_service.dart';
export 'package:infnet/src/service/cadastros/banco_agencia_service.dart';
export 'package:infnet/src/service/cadastros/pessoa_service.dart';
export 'package:infnet/src/service/cadastros/produto_service.dart';
export 'package:infnet/src/service/cadastros/banco_conta_caixa_service.dart';
export 'package:infnet/src/service/cadastros/cargo_service.dart';
export 'package:infnet/src/service/cadastros/cep_service.dart';
export 'package:infnet/src/service/cadastros/cfop_service.dart';
export 'package:infnet/src/service/cadastros/cliente_service.dart';
export 'package:infnet/src/service/cadastros/cnae_service.dart';
export 'package:infnet/src/service/cadastros/colaborador_service.dart';
export 'package:infnet/src/service/cadastros/setor_service.dart';
export 'package:infnet/src/service/cadastros/papel_service.dart';
export 'package:infnet/src/service/cadastros/contador_service.dart';
export 'package:infnet/src/service/cadastros/csosn_service.dart';
export 'package:infnet/src/service/cadastros/cst_cofins_service.dart';
export 'package:infnet/src/service/cadastros/cst_icms_service.dart';
export 'package:infnet/src/service/cadastros/cst_ipi_service.dart';
export 'package:infnet/src/service/cadastros/cst_pis_service.dart';
export 'package:infnet/src/service/cadastros/estado_civil_service.dart';
export 'package:infnet/src/service/cadastros/fornecedor_service.dart';
export 'package:infnet/src/service/cadastros/municipio_service.dart';
export 'package:infnet/src/service/cadastros/ncm_service.dart';
export 'package:infnet/src/service/cadastros/nivel_formacao_service.dart';
export 'package:infnet/src/service/cadastros/transportadora_service.dart';
export 'package:infnet/src/service/cadastros/uf_service.dart';
export 'package:infnet/src/service/cadastros/vendedor_service.dart';
export 'package:infnet/src/service/cadastros/produto_grupo_service.dart';
export 'package:infnet/src/service/cadastros/produto_marca_service.dart';
export 'package:infnet/src/service/cadastros/produto_subgrupo_service.dart';
export 'package:infnet/src/service/cadastros/produto_unidade_service.dart';
export 'package:infnet/src/service/cadastros/usuario_service.dart';


// views
export 'package:infnet/src/service/views_db/view_pessoa_colaborador_service.dart';
export 'package:infnet/src/service/views_db/view_pessoa_fornecedor_service.dart';
export 'package:infnet/src/service/views_db/view_pessoa_cliente_service.dart';
export 'package:infnet/src/service/views_db/view_fin_lancamento_pagar_service.dart';
export 'package:infnet/src/service/views_db/view_fin_lancamento_receber_service.dart';
export 'package:infnet/src/service/views_db/view_fin_movimento_caixa_banco_service.dart';
export 'package:infnet/src/service/views_db/view_fin_cheque_nao_compensado_service.dart';
export 'package:infnet/src/service/views_db/view_fin_fluxo_caixa_service.dart';
