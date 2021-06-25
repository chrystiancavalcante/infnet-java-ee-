/*
Title: ERP INFNET                                                                
Description: AbaMestre PersistePage OneToOne relacionada à tabela [COLABORADOR] 
                                                                                
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
import 'package:infnet/src/infra/valida_campo_formulario.dart';
import 'package:infnet/src/view/shared/dropdown_lista.dart';

class ColaboradorPersistePage extends StatefulWidget {
  final Pessoa pessoa;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final FocusNode foco;
  final Function salvarPessoaCallBack;

  const ColaboradorPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.pessoa, this.foco, this.salvarPessoaCallBack})
      : super(key: key);

  @override
  _ColaboradorPersistePageState createState() => _ColaboradorPersistePageState();
}

class _ColaboradorPersistePageState extends State<ColaboradorPersistePage> {
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
    var _importaCargoController = TextEditingController();
    _importaCargoController.text = widget.pessoa?.colaborador?.cargo?.nome ?? '';
    var _importaSetorController = TextEditingController();
    _importaSetorController.text = widget.pessoa?.colaborador?.setor?.nome ?? '';
    var _importaColaboradorSituacaoController = TextEditingController();
    _importaColaboradorSituacaoController.text = widget.pessoa?.colaborador?.colaboradorSituacao?.nome ?? '';
    var _importaTipoAdmissaoController = TextEditingController();
    _importaTipoAdmissaoController.text = widget.pessoa?.colaborador?.tipoAdmissao?.nome ?? '';
    var _importaColaboradorTipoController = TextEditingController();
    _importaColaboradorTipoController.text = widget.pessoa?.colaborador?.colaboradorTipo?.nome ?? '';
    var _importaSindicatoController = TextEditingController();
    _importaSindicatoController.text = widget.pessoa?.colaborador?.sindicato?.nome ?? '';
	
    if (widget.pessoa.colaborador == null) {
      widget.pessoa.colaborador = Colaborador();
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
					        sizes: 'col-12 col-md-6',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					        child: Row(
					          children: <Widget>[
					            Expanded(
					              flex: 1,
					              child: Container(
					                child: TextFormField(
					                  controller: _importaCargoController,
					                  focusNode: widget.foco,
					                  autofocus: true,
					                  readOnly: true,
					                  decoration: getInputDecoration(
					                    'Importe o Cargo Vinculado',
					                    'Cargo *',
					                    false),
					                  onSaved: (String value) {
					                  },
					                  validator: ValidaCampoFormulario.validarObrigatorio,
					                  onChanged: (text) {
					                    widget.pessoa?.colaborador?.cargo?.nome = text;
					                    paginaMestreDetalheFoiAlterada = true;
					                  },
					                ),
					              ),
					            ),
					            Expanded(
					              flex: 0,
					              child: IconButton(
					                tooltip: 'Importar Cargo',
					                icon: ViewUtilLib.getIconBotaoLookup(),
					                onPressed: () async {
					                  ///chamando o lookup
					                  Map<String, dynamic> _objetoJsonRetorno =
					                    await Navigator.push(
					                      context,
					                      MaterialPageRoute(
					                        builder: (BuildContext context) =>
					                          LookupPage(
					                            title: 'Importar Cargo',
					                            colunas: Cargo.colunas,
					                            campos: Cargo.campos,
					                            rota: '/cargo/',
					                            campoPesquisaPadrao: 'nome',
					                            valorPesquisaPadrao: '',
					                          ),
					                          fullscreenDialog: true,
					                        ));
					                  if (_objetoJsonRetorno != null) {
					                    if (_objetoJsonRetorno['nome'] != null) {
					                      _importaCargoController.text = _objetoJsonRetorno['nome'];
					                      widget.pessoa.colaborador?.idCargo = _objetoJsonRetorno['id'];
					                      widget.pessoa.colaborador?.cargo = Cargo.fromJson(_objetoJsonRetorno);
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
					                  controller: _importaSetorController,
					                  readOnly: true,
					                  decoration: getInputDecoration(
					                    'Importe o Setor Vinculado',
					                    'Setor *',
					                    false),
					                  onSaved: (String value) {
					                  },
					                  validator: ValidaCampoFormulario.validarObrigatorio,
					                  onChanged: (text) {
					                    widget.pessoa?.colaborador?.setor?.nome = text;
					                    paginaMestreDetalheFoiAlterada = true;
					                  },
					                ),
					              ),
					            ),
					            Expanded(
					              flex: 0,
					              child: IconButton(
					                tooltip: 'Importar Setor',
					                icon: ViewUtilLib.getIconBotaoLookup(),
					                onPressed: () async {
					                  ///chamando o lookup
					                  Map<String, dynamic> _objetoJsonRetorno =
					                    await Navigator.push(
					                      context,
					                      MaterialPageRoute(
					                        builder: (BuildContext context) =>
					                          LookupPage(
					                            title: 'Importar Setor',
					                            colunas: Setor.colunas,
					                            campos: Setor.campos,
					                            rota: '/setor/',
					                            campoPesquisaPadrao: 'nome',
					                            valorPesquisaPadrao: '',
					                          ),
					                          fullscreenDialog: true,
					                        ));
					                  if (_objetoJsonRetorno != null) {
					                    if (_objetoJsonRetorno['nome'] != null) {
					                      _importaSetorController.text = _objetoJsonRetorno['nome'];
					                      widget.pessoa.colaborador?.idSetor = _objetoJsonRetorno['id'];
					                      widget.pessoa.colaborador?.setor = Setor.fromJson(_objetoJsonRetorno);
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
					        sizes: 'col-12 col-md-6',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					        child: Row(
					          children: <Widget>[
					            Expanded(
					              flex: 1,
					              child: Container(
					                child: TextFormField(
					                  controller: _importaColaboradorSituacaoController,
					                  readOnly: true,
					                  decoration: getInputDecoration(
					                    'Situação do Colaborador',
					                    'Situação Colaborador',
					                    false),
					                  onSaved: (String value) {
					                  },
					                  onChanged: (text) {
					                    widget.pessoa?.colaborador?.colaboradorSituacao?.nome = text;
					                    paginaMestreDetalheFoiAlterada = true;
					                  },
					                ),
					              ),
					            ),
					            Expanded(
					              flex: 0,
					              child: IconButton(
					                tooltip: 'Importar Situação Colaborador',
					                icon: ViewUtilLib.getIconBotaoLookup(),
					                onPressed: () async {
					                  ///chamando o lookup
					                  Map<String, dynamic> _objetoJsonRetorno =
					                    await Navigator.push(
					                      context,
					                      MaterialPageRoute(
					                        builder: (BuildContext context) =>
					                          LookupPage(
					                            title: 'Importar Situação Colaborador',
					                            colunas: ColaboradorSituacao.colunas,
					                            campos: ColaboradorSituacao.campos,
					                            rota: '/colaborador-situacao/',
					                            campoPesquisaPadrao: 'nome',
					                            valorPesquisaPadrao: '',
					                          ),
					                          fullscreenDialog: true,
					                        ));
					                  if (_objetoJsonRetorno != null) {
					                    if (_objetoJsonRetorno['nome'] != null) {
					                      _importaColaboradorSituacaoController.text = _objetoJsonRetorno['nome'];
					                      widget.pessoa.colaborador?.idColaboradorSituacao = _objetoJsonRetorno['id'];
					                      widget.pessoa.colaborador?.colaboradorSituacao = ColaboradorSituacao.fromJson(_objetoJsonRetorno);
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
					                  controller: _importaTipoAdmissaoController,
					                  readOnly: true,
					                  decoration: getInputDecoration(
					                    'Tipo Admissão',
					                    'Tipo Admissão',
					                    false),
					                  onSaved: (String value) {
					                  },
					                  onChanged: (text) {
					                    widget.pessoa?.colaborador?.tipoAdmissao?.nome = text;
					                    paginaMestreDetalheFoiAlterada = true;
					                  },
					                ),
					              ),
					            ),
					            Expanded(
					              flex: 0,
					              child: IconButton(
					                tooltip: 'Importar Tipo Admissão',
					                icon: ViewUtilLib.getIconBotaoLookup(),
					                onPressed: () async {
					                  ///chamando o lookup
					                  Map<String, dynamic> _objetoJsonRetorno =
					                    await Navigator.push(
					                      context,
					                      MaterialPageRoute(
					                        builder: (BuildContext context) =>
					                          LookupPage(
					                            title: 'Importar Tipo Admissão',
					                            colunas: TipoAdmissao.colunas,
					                            campos: TipoAdmissao.campos,
					                            rota: '/tipo-admissao/',
					                            campoPesquisaPadrao: 'nome',
					                            valorPesquisaPadrao: '',
					                          ),
					                          fullscreenDialog: true,
					                        ));
					                  if (_objetoJsonRetorno != null) {
					                    if (_objetoJsonRetorno['nome'] != null) {
					                      _importaTipoAdmissaoController.text = _objetoJsonRetorno['nome'];
					                      widget.pessoa.colaborador?.idTipoAdmissao = _objetoJsonRetorno['id'];
					                      widget.pessoa.colaborador?.tipoAdmissao = TipoAdmissao.fromJson(_objetoJsonRetorno);
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
					        sizes: 'col-12 col-md-6',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					        child: Row(
					          children: <Widget>[
					            Expanded(
					              flex: 1,
					              child: Container(
					                child: TextFormField(
					                  controller: _importaColaboradorTipoController,
					                  readOnly: true,
					                  decoration: getInputDecoration(
					                    'Tipo Colaborador',
					                    'Tipo Colaborador',
					                    false),
					                  onSaved: (String value) {
					                  },
					                  onChanged: (text) {
					                    widget.pessoa?.colaborador?.colaboradorTipo?.nome = text;
					                    paginaMestreDetalheFoiAlterada = true;
					                  },
					                ),
					              ),
					            ),
					            Expanded(
					              flex: 0,
					              child: IconButton(
					                tooltip: 'Importar Tipo Colaborador',
					                icon: ViewUtilLib.getIconBotaoLookup(),
					                onPressed: () async {
					                  ///chamando o lookup
					                  Map<String, dynamic> _objetoJsonRetorno =
					                    await Navigator.push(
					                      context,
					                      MaterialPageRoute(
					                        builder: (BuildContext context) =>
					                          LookupPage(
					                            title: 'Importar Tipo Colaborador',
					                            colunas: ColaboradorTipo.colunas,
					                            campos: ColaboradorTipo.campos,
					                            rota: '/colaborador-tipo/',
					                            campoPesquisaPadrao: 'nome',
					                            valorPesquisaPadrao: '',
					                          ),
					                          fullscreenDialog: true,
					                        ));
					                  if (_objetoJsonRetorno != null) {
					                    if (_objetoJsonRetorno['nome'] != null) {
					                      _importaColaboradorTipoController.text = _objetoJsonRetorno['nome'];
					                      widget.pessoa.colaborador?.idColaboradorTipo = _objetoJsonRetorno['id'];
					                      widget.pessoa.colaborador?.colaboradorTipo = ColaboradorTipo.fromJson(_objetoJsonRetorno);
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
					                  controller: _importaSindicatoController,
					                  readOnly: true,
					                  decoration: getInputDecoration(
					                    'Sindicato',
					                    'Sindicato',
					                    false),
					                  onSaved: (String value) {
					                  },
					                  onChanged: (text) {
					                    widget.pessoa?.colaborador?.sindicato?.nome = text;
					                    paginaMestreDetalheFoiAlterada = true;
					                  },
					                ),
					              ),
					            ),
					            Expanded(
					              flex: 0,
					              child: IconButton(
					                tooltip: 'Importar Sindicato',
					                icon: ViewUtilLib.getIconBotaoLookup(),
					                onPressed: () async {
					                  ///chamando o lookup
					                  Map<String, dynamic> _objetoJsonRetorno =
					                    await Navigator.push(
					                      context,
					                      MaterialPageRoute(
					                        builder: (BuildContext context) =>
					                          LookupPage(
					                            title: 'Importar Sindicato',
					                            colunas: Sindicato.colunas,
					                            campos: Sindicato.campos,
					                            rota: '/sindicato/',
					                            campoPesquisaPadrao: 'nome',
					                            valorPesquisaPadrao: '',
					                          ),
					                          fullscreenDialog: true,
					                        ));
					                  if (_objetoJsonRetorno != null) {
					                    if (_objetoJsonRetorno['nome'] != null) {
					                      _importaSindicatoController.text = _objetoJsonRetorno['nome'];
					                      widget.pessoa.colaborador?.idSindicato = _objetoJsonRetorno['id'];
					                      widget.pessoa.colaborador?.sindicato = Sindicato.fromJson(_objetoJsonRetorno);
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
					        sizes: 'col-12 col-md-4',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: TextFormField(
					            maxLength: 10,
					            maxLines: 1,
					            initialValue: widget.pessoa?.colaborador?.matricula ?? '',
					            decoration: getInputDecoration(
					              'Informe a Matrícula do Colaborador',
					              'Matrícula',
					              false),
					            onSaved: (String value) {
					            },
					            onChanged: (text) {
					              widget.pessoa.colaborador?.matricula = text;
					              paginaMestreDetalheFoiAlterada = true;
					            },
					          ),
					        ),
					      ),
					      BootstrapCol(
					        sizes: 'col-12 col-md-4',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: InputDecorator(
					            decoration: getInputDecoration(
					              'Informe a Data de Cadastro',
					              'Data de Cadastro',
					              true),
					            isEmpty: widget.pessoa.colaborador?.dataCadastro == null,
					            child: DatePickerItem(
					              dateTime: widget.pessoa.colaborador?.dataCadastro,
					              firstDate: DateTime.parse('1900-01-01'),
					              lastDate: DateTime.now(),
					              onChanged: (DateTime value) {
					                paginaMestreDetalheFoiAlterada = true;
					                setState(() {
					                  widget.pessoa.colaborador?.dataCadastro = value;
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
					          child: InputDecorator(
					            decoration: getInputDecoration(
					              'Informe a Data de Admissão',
					              'Data de Demissão',
					              true),
					            isEmpty: widget.pessoa.colaborador?.dataAdmissao == null,
					            child: DatePickerItem(
					              dateTime: widget.pessoa.colaborador?.dataAdmissao,
					              firstDate: DateTime.parse('1900-01-01'),
					              lastDate: DateTime.now(),
					              onChanged: (DateTime value) {
					                paginaMestreDetalheFoiAlterada = true;
					                setState(() {
					                  widget.pessoa.colaborador?.dataAdmissao = value;
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
					              'Informe a Data de Demissão',
					              'Data de Demissão',
					              true),
					            isEmpty: widget.pessoa.colaborador?.dataDemissao == null,
					            child: DatePickerItem(
					              dateTime: widget.pessoa.colaborador?.dataDemissao,
					              firstDate: DateTime.parse('1900-01-01'),
					              lastDate: DateTime.now(),
					              onChanged: (DateTime value) {
					                paginaMestreDetalheFoiAlterada = true;
					                setState(() {
					                  widget.pessoa.colaborador?.dataDemissao = value;
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
					            maxLength: 10,
					            maxLines: 1,
					            initialValue: widget.pessoa?.colaborador?.ctpsNumero ?? '',
					            decoration: getInputDecoration(
					              'Informe o Número da Carteira Profissional',
					              'Número CTPS',
					              false),
					            onSaved: (String value) {
					            },
					            onChanged: (text) {
					              widget.pessoa.colaborador?.ctpsNumero = text;
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
					            maxLength: 10,
					            maxLines: 1,
					            initialValue: widget.pessoa?.colaborador?.ctpsSerie ?? '',
					            decoration: getInputDecoration(
					              'Informe a Série da Carteira Profissional',
					              'Série CTPS',
					              false),
					            onSaved: (String value) {
					            },
					            onChanged: (text) {
					              widget.pessoa.colaborador?.ctpsSerie = text;
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
					        sizes: 'col-12 col-md-4',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: InputDecorator(
					            decoration: getInputDecoration(
					              'Informe a Data de Expedição da CTPS',
					              'Data de Expedição',
					              true),
					            isEmpty: widget.pessoa.colaborador?.ctpsDataExpedicao == null,
					            child: DatePickerItem(
					              dateTime: widget.pessoa.colaborador?.ctpsDataExpedicao,
					              firstDate: DateTime.parse('1900-01-01'),
					              lastDate: DateTime.now(),
					              onChanged: (DateTime value) {
					                paginaMestreDetalheFoiAlterada = true;
					                setState(() {
					                  widget.pessoa.colaborador?.ctpsDataExpedicao = value;
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
					          child: InputDecorator(
					            decoration: getInputDecoration(
					              'Selecione a UF da Carteira Profissional',
					              'UF CTPS',
					              true),
					            isEmpty: widget.pessoa?.colaborador?.ctpsUf == null || widget.pessoa?.colaborador == null,
					            child: getDropDownButton(widget.pessoa.colaborador?.ctpsUf, (String newValue) {
					              paginaMestreDetalheFoiAlterada = true;
					              setState(() {
					                widget.pessoa.colaborador?.ctpsUf = newValue;
					                });
					            }, DropdownLista.listaUF)),
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
					          initialValue: widget.pessoa?.colaborador?.observacao ?? '',
					          decoration: getInputDecoration(
					            'Observações Gerais',
					            'Observação',
					            false),
					          onSaved: (String value) {
					          },
					          onChanged: (text) {
					            widget.pessoa.colaborador?.observacao = text;
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