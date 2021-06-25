/*
Title: ERP INFNET                                                                
Description: PersistePage relacionada à tabela [BANCO_CONTA_CAIXA] 
                                                                                
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
import 'package:provider/provider.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:infnet/src/infra/infra.dart';
import 'package:infnet/src/infra/atalhos_desktop_web.dart';

import 'package:infnet/src/model/model.dart';
import 'package:infnet/src/view_model/view_model.dart';

import 'package:infnet/src/view/shared/widgets_input.dart';
import 'package:infnet/src/view/shared/view_util_lib.dart';
import 'package:infnet/src/view/shared/caixas_de_dialogo.dart';
import 'package:infnet/src/view/shared/botoes.dart';

import 'package:infnet/src/view/shared/page/lookup_page.dart';
import 'package:infnet/src/infra/valida_campo_formulario.dart';

class BancoContaCaixaPersistePage extends StatefulWidget {
  final BancoContaCaixa bancoContaCaixa;
  final String title;
  final String operacao;

  const BancoContaCaixaPersistePage({Key key, this.bancoContaCaixa, this.title, this.operacao})
      : super(key: key);

  @override
  _BancoContaCaixaPersistePageState createState() => _BancoContaCaixaPersistePageState();
}

class _BancoContaCaixaPersistePageState extends State<BancoContaCaixaPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formFoiAlterado = false;
  var _bancoContaCaixaProvider;

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;

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
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.excluir:
        _excluir();
        break;
      case AtalhoTelaType.salvar:
        _salvar();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _bancoContaCaixaProvider = Provider.of<BancoContaCaixaViewModel>(context);
	
    final _importaBancoAgenciaController = TextEditingController();
    _importaBancoAgenciaController.text = widget.bancoContaCaixa?.bancoAgencia?.nome ?? '';
	
    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(widget.title), 
            actions: widget.operacao == "I"
			  ? getBotoesAppBarPersistePage(context: context, salvar: _salvar,)
			  : getBotoesAppBarPersistePageComExclusao(context: context, salvar: _salvar, excluir: _excluir),
          ),      
          body: SafeArea(
            top: false,
            bottom: false,
            child: Form(
              key: _formKey,
              autovalidateMode: _autoValidate,
              onWillPop: _avisarUsuarioFormAlterado,
              child: Scrollbar(
                child: SingleChildScrollView(
                  dragStartBehavior: DragStartBehavior.down,
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
                            sizes: 'col-12',
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextFormField(
                                      controller: _importaBancoAgenciaController,
                                      readOnly: true,
                                      decoration: getInputDecoration(
                                        '',
                                        'Agência',
                                        false),
                                      onSaved: (String value) {
                                      },
                                      onChanged: (text) {
                                        widget.bancoContaCaixa?.bancoAgencia?.nome = text;
                                        _formFoiAlterado = true;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Agência',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic> _objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                              LookupPage(
                                                title: 'Importar Agência',
                                                colunas: BancoAgencia.colunas,
                                                campos: BancoAgencia.campos,
                                                rota: '/banco-agencia/',
                                                campoPesquisaPadrao: 'nome',
                                                valorPesquisaPadrao: '%',
                                              ),
                                              fullscreenDialog: true,
                                            ));
                                      if (_objetoJsonRetorno != null) {
                                        if (_objetoJsonRetorno['nome'] != null) {
                                          _importaBancoAgenciaController.text = _objetoJsonRetorno['nome'];
                                          widget.bancoContaCaixa.idBancoAgencia = _objetoJsonRetorno['id'];
                                          widget.bancoContaCaixa.bancoAgencia = new BancoAgencia.fromJson(_objetoJsonRetorno);
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white,),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12 col-md-2',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                maxLength: 20,
                                maxLines: 1,
                                initialValue: widget.bancoContaCaixa?.numero ?? '',
                                decoration: getInputDecoration(
                                  'Informe o Número da Conta',
                                  'Número',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  widget.bancoContaCaixa.numero = text;
                                  _formFoiAlterado = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-2',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                maxLines: 1,
                                initialValue: widget.bancoContaCaixa?.digito ?? '',
                                decoration: getInputDecoration(
                                  'Informe o Dígito da Conta',
                                  'Dígito',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  widget.bancoContaCaixa.digito = text;
                                  _formFoiAlterado = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                maxLength: 100,
                                maxLines: 1,
                                initialValue: widget.bancoContaCaixa?.nome ?? '',
                                decoration: getInputDecoration(
                                  'Informe o Nome da Conta',
                                  'Nome *',
                                  false),
                                onSaved: (String value) {
                                },
                                validator: ValidaCampoFormulario.validarObrigatorio,
                                onChanged: (text) {
                                  widget.bancoContaCaixa.nome = text;
                                  _formFoiAlterado = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-2',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: InputDecorator(
                                decoration: getInputDecoration(
                                  'Selecione o Tipo da Conta',
                                  'Tipo',
                                  true),
                                isEmpty: widget.bancoContaCaixa.tipo == null,
                                child: getDropDownButton(widget.bancoContaCaixa.tipo,
                                  (String newValue) {
                                    setState(() {
                                      widget.bancoContaCaixa.tipo = newValue;
                                    });
                                }, <String>[
                                  'Corrente',
                                  'Poupança',
                                  'Investimento',
                                  'Caixa Interno',
                              ])),
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
                              initialValue: widget.bancoContaCaixa?.descricao ?? '',
                              decoration: getInputDecoration(
                                'Informe a Descrição da Conta/Caixa',
                                'Descrição',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                widget.bancoContaCaixa.descricao = text;
                                _formFoiAlterado = true;
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

  Future<void> _salvar() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = AutovalidateMode.always;
      showInSnackBar(Constantes.mensagemCorrijaErrosFormSalvar, context);
    } else {
      gerarDialogBoxConfirmacao(context, Constantes.perguntaSalvarAlteracoes, () async {
        form.save();
        if (widget.operacao == 'A') {
          await _bancoContaCaixaProvider.alterar(widget.bancoContaCaixa);
        } else {
          await _bancoContaCaixaProvider.inserir(widget.bancoContaCaixa);
        }
        Navigator.of(context).pop();
		showInSnackBar("Registro salvo com sucesso!", context, corFundo: Colors.green);
      });
    }
  }

  Future<bool> _avisarUsuarioFormAlterado() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formFoiAlterado) return true;

    return await gerarDialogBoxFormAlterado(context);
  }
  
  void _excluir() {
    gerarDialogBoxExclusao(context, () async {
      await _bancoContaCaixaProvider.excluir(widget.bancoContaCaixa.id);
      Navigator.of(context).pop();
      showInSnackBar("Registro excluído com sucesso!", context, corFundo: Colors.green);
    });
  }  
}