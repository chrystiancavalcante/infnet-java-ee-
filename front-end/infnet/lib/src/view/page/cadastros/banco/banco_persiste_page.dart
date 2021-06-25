/*
Title: ERP INFNET                                                                
Description: PersistePage relacionada à tabela [BANCO] 
                                                                                
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

import 'package:infnet/src/infra/valida_campo_formulario.dart';

class BancoPersistePage extends StatefulWidget {
  final Banco banco;
  final String title;
  final String operacao;

  const BancoPersistePage({Key key, this.banco, this.title, this.operacao})
      : super(key: key);

  @override
  _BancoPersistePageState createState() => _BancoPersistePageState();
}

class _BancoPersistePageState extends State<BancoPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formFoiAlterado = false;
  var _bancoProvider;

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
    _bancoProvider = Provider.of<BancoViewModel>(context);
	
	
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
                            sizes: 'col-12 col-md-4',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                maxLines: 1,
                                initialValue: widget.banco?.codigo ?? '',
                                decoration: getInputDecoration(
                                  '',
                                  'Código *',
                                  false),
                                onSaved: (String value) {
                                },
                                validator: ValidaCampoFormulario.validarObrigatorio,
                                onChanged: (text) {
                                  widget.banco.codigo = text;
                                  _formFoiAlterado = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-8',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                maxLength: 100,
                                maxLines: 1,
                                initialValue: widget.banco?.nome ?? '',
                                decoration: getInputDecoration(
                                  '',
                                  'Nome *',
                                  false),
                                onSaved: (String value) {
                                },
                                validator: ValidaCampoFormulario.validarObrigatorio,
                                onChanged: (text) {
                                  widget.banco.nome = text;
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
                              keyboardType: TextInputType.url,
                              maxLength: 250,
                              maxLines: 3,
                              initialValue: widget.banco?.url ?? '',
                              decoration: getInputDecoration(
                                '',
                                'URL',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                widget.banco.url = text;
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
          await _bancoProvider.alterar(widget.banco);
        } else {
          await _bancoProvider.inserir(widget.banco);
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
      await _bancoProvider.excluir(widget.banco.id);
      Navigator.of(context).pop();
      showInSnackBar("Registro excluído com sucesso!", context, corFundo: Colors.green);
    });
  }  
}