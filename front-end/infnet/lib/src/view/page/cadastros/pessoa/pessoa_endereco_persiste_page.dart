/*
Title: ERP INFNET                                                                
Description: AbaDetalhe PersistePage relacionada à tabela [PESSOA_ENDERECO] 
                                                                                
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
import 'package:infnet/src/view/shared/caixas_de_dialogo.dart';
import 'package:infnet/src/infra/atalhos_desktop_web.dart';
import 'package:infnet/src/view/shared/botoes.dart';

import 'package:infnet/src/view/shared/page/lookup_page.dart';
import 'package:infnet/src/infra/valida_campo_formulario.dart';

class PessoaEnderecoPersistePage extends StatefulWidget {
  final Pessoa pessoa;
  final PessoaEndereco pessoaEndereco;
  final String title;
  final String operacao;

  const PessoaEnderecoPersistePage(
      {Key key, this.pessoa, this.pessoaEndereco, this.title, this.operacao})
      : super(key: key);

  @override
  _PessoaEnderecoPersistePageState createState() => _PessoaEnderecoPersistePageState();
}

class _PessoaEnderecoPersistePageState extends State<PessoaEnderecoPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formFoiAlterado = false;

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
      case AtalhoTelaType.salvar:
        _salvar();
        break;
      default:
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
	final _importaPessoaController = TextEditingController();
	_importaPessoaController.text = widget.pessoaEndereco?.pessoa?.nome ?? '';

    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(widget.title), 
            actions: widget.operacao == 'I'
              ? getBotoesAppBarPersistePage(context: context, salvar: _salvar)
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
                                        controller: _importaPessoaController,
                                        readOnly: true,
                                        decoration: getInputDecoration(
                                          'Conteúdo para o campo Id Pessoa',
                                          'Id Pessoa *',
                                          false),
                                        onSaved: (String value) {
                                        },
                                        validator: ValidaCampoFormulario.validarObrigatorio,
                                        onChanged: (text) {
                                          widget.pessoaEndereco?.pessoa?.nome = text;
                                    paginaMestreDetalheFoiAlterada = true;
                                          _formFoiAlterado = true;
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: IconButton(
                                      tooltip: 'Importar Id Pessoa',
                                      icon: ViewUtilLib.getIconBotaoLookup(),
                                      onPressed: () async {
                                        ///chamando o lookup
                                        Map<String, dynamic> _objetoJsonRetorno =
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                LookupPage(
                                                  title: 'Importar Id Pessoa',
                                                  colunas: Pessoa.colunas,
                                                  campos: Pessoa.campos,
                                                  rota: '/pessoa/',
                                                  campoPesquisaPadrao: 'nome',
                                                  valorPesquisaPadrao: '',
                                                ),
                                                fullscreenDialog: true,
                                              ));
                                        if (_objetoJsonRetorno != null) {
                                          if (_objetoJsonRetorno['nome'] != null) {
                                            _importaPessoaController.text = _objetoJsonRetorno['nome'];
                                            widget.pessoaEndereco.idPessoa = _objetoJsonRetorno['id'];
                                            widget.pessoaEndereco.pessoa = new Pessoa.fromJson(_objetoJsonRetorno);
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
                              sizes: 'col-12 col-md-8',
                              child: Padding(
                                padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                child: TextFormField(
                                  maxLength: 100,
                                  maxLines: 1,
                                  initialValue: widget.pessoaEndereco?.logradouro ?? '',
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Logradouro',
                                    'Logradouro',
                                    false),
                                  onSaved: (String value) {
                                  },
                                  onChanged: (text) {
                                    widget.pessoaEndereco.logradouro = text;
                                    paginaMestreDetalheFoiAlterada = true;
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
                                  maxLength: 10,
                                  maxLines: 1,
                                  initialValue: widget.pessoaEndereco?.numero ?? '',
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Numero',
                                    'Numero',
                                    false),
                                  onSaved: (String value) {
                                  },
                                  onChanged: (text) {
                                    widget.pessoaEndereco.numero = text;
                                    paginaMestreDetalheFoiAlterada = true;
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
                                maxLength: 100,
                                maxLines: 1,
                                initialValue: widget.pessoaEndereco?.complemento ?? '',
                                decoration: getInputDecoration(
                                  'Conteúdo para o campo Complemento',
                                  'Complemento',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  widget.pessoaEndereco.complemento = text;
                                  paginaMestreDetalheFoiAlterada = true;
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
                              sizes: 'col-12 col-md-5',
                              child: Padding(
                                padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                child: TextFormField(
                                  maxLength: 100,
                                  maxLines: 1,
                                  initialValue: widget.pessoaEndereco?.bairro ?? '',
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Bairro',
                                    'Bairro',
                                    false),
                                  onSaved: (String value) {
                                  },
                                  onChanged: (text) {
                                    widget.pessoaEndereco.bairro = text;
                                    paginaMestreDetalheFoiAlterada = true;
                                    _formFoiAlterado = true;
                                  },
                                ),
                              ),
                            ),
                            BootstrapCol(
                              sizes: 'col-12 col-md-5',
                              child: Padding(
                                padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                child: TextFormField(
                                  maxLength: 100,
                                  maxLines: 1,
                                  initialValue: widget.pessoaEndereco?.cidade ?? '',
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Cidade',
                                    'Cidade',
                                    false),
                                  onSaved: (String value) {
                                  },
                                  onChanged: (text) {
                                    widget.pessoaEndereco.cidade = text;
                                    paginaMestreDetalheFoiAlterada = true;
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
                                  maxLength: 2,
                                  maxLines: 1,
                                  initialValue: widget.pessoaEndereco?.uf ?? '',
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Uf',
                                    'Uf',
                                    false),
                                  onSaved: (String value) {
                                  },
                                  onChanged: (text) {
                                    widget.pessoaEndereco.uf = text;
                                    paginaMestreDetalheFoiAlterada = true;
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
                              sizes: 'col-12 col-md-4',
                              child: Padding(
                                padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                child: TextFormField(
                                  maxLength: 8,
                                  maxLines: 1,
                                  initialValue: widget.pessoaEndereco?.cep ?? '',
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Cep',
                                    'Cep',
                                    false),
                                  onSaved: (String value) {
                                  },
                                  onChanged: (text) {
                                    widget.pessoaEndereco.cep = text;
                                    paginaMestreDetalheFoiAlterada = true;
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
                                  maxLength: 11,
                                  maxLines: 1,
                                  initialValue: widget.pessoaEndereco?.municipioIbge?.toString() ?? '',
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Municipio Ibge',
                                    'Municipio Ibge',
                                    false),
                                  onSaved: (String value) {
                                  },
                                  onChanged: (text) {
                                    widget.pessoaEndereco.municipioIbge = int.tryParse(text);
                                    paginaMestreDetalheFoiAlterada = true;
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
                              sizes: 'col-12 col-md-3',
                              child: Padding(
                                padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                child: InputDecorator(
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Principal',
                                    'Principal',
                                    true),
                                  isEmpty: widget.pessoaEndereco.principal == null,
                                  child: getDropDownButton(widget.pessoaEndereco.principal,
                                    (String newValue) {
                                      paginaMestreDetalheFoiAlterada = true;
                                      setState(() {
                                        widget.pessoaEndereco.principal = newValue;
                                      });
                                  }, <String>[
                                    'Sim',
                                    'Não',
                                ])),
                              ),
                            ),
                            BootstrapCol(
                              sizes: 'col-12 col-md-3',
                              child: Padding(
                                padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                child: InputDecorator(
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Entrega',
                                    'Entrega',
                                    true),
                                  isEmpty: widget.pessoaEndereco.entrega == null,
                                  child: getDropDownButton(widget.pessoaEndereco.entrega,
                                    (String newValue) {
                                      paginaMestreDetalheFoiAlterada = true;
                                      setState(() {
                                        widget.pessoaEndereco.entrega = newValue;
                                      });
                                  }, <String>[
                                    'Sim',
                                    'Não',
                                ])),
                              ),
                            ),
                            BootstrapCol(
                              sizes: 'col-12 col-md-3',
                              child: Padding(
                                padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                child: InputDecorator(
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Cobranca',
                                    'Cobranca',
                                    true),
                                  isEmpty: widget.pessoaEndereco.cobranca == null,
                                  child: getDropDownButton(widget.pessoaEndereco.cobranca,
                                    (String newValue) {
                                      paginaMestreDetalheFoiAlterada = true;
                                      setState(() {
                                        widget.pessoaEndereco.cobranca = newValue;
                                      });
                                  }, <String>[
                                    'Sim',
                                    'Não',
                                ])),
                              ),
                            ),
                            BootstrapCol(
                              sizes: 'col-12 col-md-3',
                              child: Padding(
                                padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                                child: InputDecorator(
                                  decoration: getInputDecoration(
                                    'Conteúdo para o campo Correspondencia',
                                    'Correspondencia',
                                    true),
                                  isEmpty: widget.pessoaEndereco.correspondencia == null,
                                  child: getDropDownButton(widget.pessoaEndereco.correspondencia,
                                    (String newValue) {
                                      paginaMestreDetalheFoiAlterada = true;
                                      setState(() {
                                        widget.pessoaEndereco.correspondencia = newValue;
                                      });
                                  }, <String>[
                                    'Sim',
                                    'Não',
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
                              child: 
                                Text('* indica que o campo é obrigatório',
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
      form.save();
      Navigator.of(context).pop();
    }
  }
  
  void _excluir() {
    gerarDialogBoxExclusao(context, () {
      widget.pessoa.listaPessoaEndereco.remove(widget.pessoaEndereco);
      Navigator.of(context).pop();
    });
  }
  
  Future<bool> _avisarUsuarioFormAlterado() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formFoiAlterado) return true;

    return await gerarDialogBoxFormAlterado(context);
  }
}