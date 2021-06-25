/*
Title: ERP INFNET                                                                
Description: AbaMestre PersistePage OneToOne relacionada à tabela [CLIENTE] 
                                                                                
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
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:infnet/src/infra/infra.dart';

import 'package:infnet/src/model/model.dart';

import 'package:infnet/src/view/shared/widgets_abas.dart';
import 'package:infnet/src/view/shared/widgets_input.dart';
import 'package:infnet/src/view/shared/view_util_lib.dart';
import 'package:infnet/src/infra/atalhos_desktop_web.dart';

import 'package:infnet/src/view/shared/page/lookup_page.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class ClientePersistePage extends StatefulWidget {
  final Pessoa pessoa;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final FocusNode foco;
  final Function salvarPessoaCallBack;

  const ClientePersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.pessoa, this.foco, this.salvarPessoaCallBack})
      : super(key: key);

  @override
  _ClientePersistePageState createState() => _ClientePersistePageState();
}

class _ClientePersistePageState extends State<ClientePersistePage> {
  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;
  final _foco = FocusNode();

  @override
  void initState() {
    super.initState();
    bootstrapGridParameters(
      gutterSize: Constantes.flutterBootstrapGutterSize,
    );
	
    _shortcutMap = getAtalhosPersistePage();

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };
    _foco.requestFocus();
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.salvar:
        widget.salvarPessoaCallBack();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var _importaTabelaPrecoController = TextEditingController();
    _importaTabelaPrecoController.text = widget.pessoa?.cliente?.tabelaPreco?.nome ?? '';
    var _taxaDescontoController = MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.pessoa?.cliente?.taxaDesconto ?? 0);
    var _limiteCreditoController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.pessoa?.cliente?.limiteCredito ?? 0);
	
    if (widget.pessoa.cliente == null) {
      widget.pessoa.cliente = Cliente();
    }

    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: widget.scaffoldKey,
          body: SafeArea(
            top: false,
            bottom: false,
            child: Form(
              key: widget.formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Scrollbar(
                child: SingleChildScrollView(
                  dragStartBehavior: DragStartBehavior.down,
                  padding: ViewUtilLib.paddingAbaPersistePage,
                  child: BootstrapContainer(
					fluid: true,
					decoration: BoxDecoration(color: Colors.white),
					padding: Biblioteca.isTelaPequena(context) == true ? ViewUtilLib.paddingBootstrapContainerTelaPequena : ViewUtilLib.paddingBootstrapContainerTelaGrande,
					children: <Widget>[			  			  
					  Divider(color: Colors.white,),
					  BootstrapRow(
					    height: 60,
					    children: <BootstrapCol>[
					      BootstrapCol(
					        sizes: 'col-12 col-md-8',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					        child: Row(
					          children: <Widget>[
					            Expanded(
					              flex: 1,
					              child: Container(
					                child: TextFormField(
					                  controller: _importaTabelaPrecoController,
					                  focusNode: widget.foco,
					                  autofocus: true,
					                  readOnly: true,
					                  decoration: getInputDecoration(
					                    '',
					                    'Tabela de Preços',
					                    false),
					                  onSaved: (String value) {
					                  },
					                  onChanged: (text) {
					                    widget.pessoa?.cliente?.tabelaPreco?.nome = text;
					                    paginaMestreDetalheFoiAlterada = true;
					                  },
					                ),
					              ),
					            ),
					            Expanded(
					              flex: 0,
					              child: IconButton(
					                tooltip: 'Importar Tabela de Preços',
					                icon: ViewUtilLib.getIconBotaoLookup(),
					                onPressed: () async {
					                  ///chamando o lookup
					                  Map<String, dynamic> _objetoJsonRetorno =
					                    await Navigator.push(
					                      context,
					                      MaterialPageRoute(
					                        builder: (BuildContext context) =>
					                          LookupPage(
					                            title: 'Importar Tabela de Preços',
					                            colunas: TabelaPreco.colunas,
					                            campos: TabelaPreco.campos,
					                            rota: '/tabela-preco/',
					                            campoPesquisaPadrao: 'nome',
					                            valorPesquisaPadrao: '',
					                          ),
					                          fullscreenDialog: true,
					                        ));
					                  if (_objetoJsonRetorno != null) {
					                    if (_objetoJsonRetorno['nome'] != null) {
					                      _importaTabelaPrecoController.text = _objetoJsonRetorno['nome'];
					                      widget.pessoa.cliente?.idTabelaPreco = _objetoJsonRetorno['id'];
					                      widget.pessoa.cliente?.tabelaPreco = TabelaPreco.fromJson(_objetoJsonRetorno);
					                    }
					                  }
					                },
					              ),
					            ),
					          ],
					        ),
					        ),
					      ),
					      BootstrapCol(
					        sizes: 'col-12 col-md-4',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: InputDecorator(
					            decoration: getInputDecoration(
					              '',
					              'É Cliente Desde',
					              true),
					            isEmpty: widget.pessoa.cliente?.desde == null,
					            child: DatePickerItem(
					              dateTime: widget.pessoa.cliente?.desde,
					              firstDate: DateTime.parse('1900-01-01'),
					              lastDate: DateTime.now(),
					              onChanged: (DateTime value) {
					                paginaMestreDetalheFoiAlterada = true;
					                setState(() {
					                  widget.pessoa.cliente?.desde = value;
					                });
					              },
					            ),
					          ),
					        ),
					      ),
					    ],
					  ),
					  Divider(color: Colors.white,),
					  BootstrapRow(
					    height: 60,
					    children: <BootstrapCol>[
					      BootstrapCol(
					        sizes: 'col-12 col-md-4',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: InputDecorator(
					            decoration: getInputDecoration(
					              '',
					              'Data de Cadastro',
					              true),
					            isEmpty: widget.pessoa.cliente?.dataCadastro == null,
					            child: DatePickerItem(
					              dateTime: widget.pessoa.cliente?.dataCadastro,
					              firstDate: DateTime.parse('1900-01-01'),
					              lastDate: DateTime.now(),
					              onChanged: (DateTime value) {
					                paginaMestreDetalheFoiAlterada = true;
					                setState(() {
					                  widget.pessoa.cliente?.dataCadastro = value;
					                });
					              },
					            ),
					          ),
					        ),
					      ),
					      BootstrapCol(
					        sizes: 'col-12 col-md-4',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: TextFormField(
					            keyboardType: TextInputType.number,
					            textAlign: TextAlign.end,
					            controller: _taxaDescontoController,
					            decoration: getInputDecoration(
					              '',
					              'Taxa de Desconto',
					              false),
					            onSaved: (String value) {
					            },
					            onChanged: (text) {
					              widget.pessoa.cliente.taxaDesconto = _taxaDescontoController.numberValue;
					              paginaMestreDetalheFoiAlterada = true;
					            },
					          ),
					        ),
					      ),
					      BootstrapCol(
					        sizes: 'col-12 col-md-4',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: TextFormField(
					            keyboardType: TextInputType.number,
					            textAlign: TextAlign.end,
					            controller: _limiteCreditoController,
					            decoration: getInputDecoration(
					              '',
					              'Limite de Crédito',
					              false),
					            onSaved: (String value) {
					            },
					            onChanged: (text) {
					              widget.pessoa.cliente.limiteCredito = _limiteCreditoController.numberValue;
					              paginaMestreDetalheFoiAlterada = true;
					            },
					          ),
					        ),
					      ),
					    ],
					  ),
					  Divider(color: Colors.white,),
					  BootstrapRow(
					    height: 60,
					    children: <BootstrapCol>[
					      BootstrapCol(
					        sizes: 'col-12',
					        child: TextFormField(
					          maxLength: 250,
					          maxLines: 3,
					          initialValue: widget.pessoa?.cliente?.observacao ?? '',
					          decoration: getInputDecoration(
					            '',
					            'Observação',
					            false),
					          onSaved: (String value) {
					          },
					          onChanged: (text) {
					            widget.pessoa.cliente?.observacao = text;
					            paginaMestreDetalheFoiAlterada = true;
					          },
					        ),
					      ),
					    ],
					  ),
					  Divider(color: Colors.white,),
					  BootstrapRow(
						height: 60,
						children: <BootstrapCol>[
						  BootstrapCol(
							sizes: 'col-12',
							child: 
							  Text(
								'* indica que o campo é obrigatório',
								style: Theme.of(context).textTheme.caption,
							  ),								
						  ),
						],
					  ),
					  Divider(color: Colors.white,),
					],
                  ),
                ),
              ),			  
            ),
          ),
        ),
      ),
    );
  }
}