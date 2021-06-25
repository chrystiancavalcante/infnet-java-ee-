/*
Title: ERP INFNET                                                                
Description: PersistePage relacionada à tabela [SETOR] 
                                                                                
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


class SetorPersistePage extends StatefulWidget {
  final Setor setor;
  final String title;
  final String operacao;

  const SetorPersistePage({Key key, this.setor, this.title, this.operacao})
      : super(key: key);

  @override
  _SetorPersistePageState createState() => _SetorPersistePageState();
}

class _SetorPersistePageState extends State<SetorPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formFoiAlterado = false;
  var _setorProvider;

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
    _setorProvider = Provider.of<SetorViewModel>(context);
	
	
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
                            child: TextFormField(
                              maxLength: 100,
                              maxLines: 1,
                              initialValue: widget.setor?.nome ?? '',
                              decoration: getInputDecoration(
                                'Informe o Nome do Setor',
                                'Nome',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                widget.setor.nome = text;
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
                            child: TextFormField(
                              maxLength: 250,
                              maxLines: 3,
                              initialValue: widget.setor?.descricao ?? '',
                              decoration: getInputDecoration(
                                'Informe a Descrição do Setor',
                                'Descrição',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                widget.setor.descricao = text;
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
          await _setorProvider.alterar(widget.setor);
        } else {
          await _setorProvider.inserir(widget.setor);
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
      await _setorProvider.excluir(widget.setor.id);
      Navigator.of(context).pop();
      showInSnackBar("Registro excluído com sucesso!", context, corFundo: Colors.green);
    });
  }  
}