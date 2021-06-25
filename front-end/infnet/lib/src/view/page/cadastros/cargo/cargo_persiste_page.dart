/*
Title: ERP INFNET                                                                
Description: PersistePage relacionada à tabela [CARGO] 
                                                                                
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
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:infnet/src/infra/valida_campo_formulario.dart';

class CargoPersistePage extends StatefulWidget {
  final Cargo cargo;
  final String title;
  final String operacao;

  const CargoPersistePage({Key key, this.cargo, this.title, this.operacao})
      : super(key: key);

  @override
  _CargoPersistePageState createState() => _CargoPersistePageState();
}

class _CargoPersistePageState extends State<CargoPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formFoiAlterado = false;
  var _cargoProvider;

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
    _cargoProvider = Provider.of<CargoViewModel>(context);
	
    final _salarioController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.cargo?.salario ?? 0);
    final _importaCboController1994 = TextEditingController();
    _importaCboController1994.text = widget.cargo?.cbo1994 ?? '';
    final _importaCboController2002 = TextEditingController();
    _importaCboController2002.text = widget.cargo?.cbo2002 ?? '';
	
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
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextFormField(
                                      controller: _importaCboController1994,
                                      readOnly: true,
                                      decoration: getInputDecoration(
                                        '',
                                        'CBO 1994',
                                        false),
                                      onSaved: (String value) {
                                      },
                                      onChanged: (text) {
                                        widget.cargo?.cbo1994 = text;
                                        _formFoiAlterado = true;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar CBO 1994',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic> _objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                              LookupPage(
                                                title: 'Importar CBO 1994',
                                                colunas: Cbo.colunas,
                                                campos: Cbo.campos,
                                                rota: '/cbo/',
                                                campoPesquisaPadrao: 'codigo',
                                                valorPesquisaPadrao: '',
                                              ),
                                              fullscreenDialog: true,
                                            ));
                                      if (_objetoJsonRetorno != null) {
                                        if (_objetoJsonRetorno['codigo'] != null) {
                                          _importaCboController1994.text = _objetoJsonRetorno['codigo'];
                                          widget.cargo.cbo1994 = _objetoJsonRetorno['codigo'];
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
                            sizes: 'col-12 col-md-6',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: TextFormField(
                                      controller: _importaCboController2002,
                                      readOnly: true,
                                      decoration: getInputDecoration(
                                        '',
                                        'CBO 2002',
                                        false),
                                      onSaved: (String value) {
                                      },
                                      onChanged: (text) {
                                        widget.cargo?.cbo2002 = text;
                                        _formFoiAlterado = true;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar CBO 2002',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic> _objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                              LookupPage(
                                                title: 'Importar CBO 2002',
                                                colunas: Cbo.colunas,
                                                campos: Cbo.campos,
                                                rota: '/cbo/',
                                                campoPesquisaPadrao: 'codigo',
                                                valorPesquisaPadrao: '',
                                              ),
                                              fullscreenDialog: true,
                                            ));
                                      if (_objetoJsonRetorno != null) {
                                        if (_objetoJsonRetorno['codigo'] != null) {
                                          _importaCboController2002.text = _objetoJsonRetorno['codigo'];
                                          widget.cargo.cbo2002 = _objetoJsonRetorno['codigo'];
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
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
                            sizes: 'col-12 col-md-8',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                maxLength: 100,
                                maxLines: 1,
                                initialValue: widget.cargo?.nome ?? '',
                                decoration: getInputDecoration(
                                  '',
                                  'Nome *',
                                  false),
                                onSaved: (String value) {
                                },
                                validator: ValidaCampoFormulario.validarObrigatorio,
                                onChanged: (text) {
                                  widget.cargo.nome = text;
                                  _formFoiAlterado = true;
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
                                controller: _salarioController,
                                decoration: getInputDecoration(
                                  '',
                                  'Valor Salário *',
                                  false),
                                onSaved: (String value) {
                                },
                                validator: ValidaCampoFormulario.validarObrigatorioDecimal,
                                onChanged: (text) {
                                  widget.cargo.salario = _salarioController.numberValue;
                                  _formFoiAlterado = true;
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
                              initialValue: widget.cargo?.descricao ?? '',
                              decoration: getInputDecoration(
                                '',
                                'Descrição',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                widget.cargo.descricao = text;
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
          await _cargoProvider.alterar(widget.cargo);
        } else {
          await _cargoProvider.inserir(widget.cargo);
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
      await _cargoProvider.excluir(widget.cargo.id);
      Navigator.of(context).pop();
      showInSnackBar("Registro excluído com sucesso!", context, corFundo: Colors.green);
    });
  }  
}