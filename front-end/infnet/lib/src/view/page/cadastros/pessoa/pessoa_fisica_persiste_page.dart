/*
Title: ERP INFNET                                                                
Description: AbaMestre PersistePage OneToOne relacionada à tabela [PESSOA_FISICA] 
                                                                                
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
import 'package:infnet/src/infra/valida_campo_formulario.dart';

class PessoaFisicaPersistePage extends StatefulWidget {
  final Pessoa pessoa;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final FocusNode foco;
  final Function salvarPessoaCallBack;

  const PessoaFisicaPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.pessoa, this.foco, this.salvarPessoaCallBack})
      : super(key: key);

  @override
  _PessoaFisicaPersistePageState createState() => _PessoaFisicaPersistePageState();
}

class _PessoaFisicaPersistePageState extends State<PessoaFisicaPersistePage> {
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
    var _importaNivelFormacaoController = TextEditingController();
    _importaNivelFormacaoController.text = widget.pessoa?.pessoaFisica?.nivelFormacao?.nome ?? '';
    var _importaEstadoCivilController = TextEditingController();
    _importaEstadoCivilController.text = widget.pessoa?.pessoaFisica?.estadoCivil?.nome ?? '';
    var _cpfController = MaskedTextController(
      mask: Constantes.mascaraCPF,
      text: widget.pessoa?.pessoaFisica?.cpf ?? '',
    );
	
    if (widget.pessoa.pessoaFisica == null) {
      widget.pessoa.pessoaFisica = PessoaFisica();
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
					        sizes: 'col-12',
					        child: Row(
					          children: <Widget>[
					            Expanded(
					              flex: 1,
					              child: Container(
					                child: TextFormField(
					                  controller: _importaNivelFormacaoController,
					                  focusNode: widget.foco,
					                  autofocus: true,
					                  readOnly: true,
					                  decoration: getInputDecoration(
					                    'Importe o Nível de Formação Vinculado',
					                    'Nível de Formação *',
					                    false),
					                  onSaved: (String value) {
					                  },
					                  validator: ValidaCampoFormulario.validarObrigatorio,
					                  onChanged: (text) {
					                    widget.pessoa?.pessoaFisica?.nivelFormacao?.nome = text;
					                    paginaMestreDetalheFoiAlterada = true;
					                  },
					                ),
					              ),
					            ),
					            Expanded(
					              flex: 0,
					              child: IconButton(
					                tooltip: 'Importar Nível de Formação',
					                icon: ViewUtilLib.getIconBotaoLookup(),
					                onPressed: () async {
					                  ///chamando o lookup
					                  Map<String, dynamic> _objetoJsonRetorno =
					                    await Navigator.push(
					                      context,
					                      MaterialPageRoute(
					                        builder: (BuildContext context) =>
					                          LookupPage(
					                            title: 'Importar Nível de Formação',
					                            colunas: NivelFormacao.colunas,
					                            campos: NivelFormacao.campos,
					                            rota: '/nivel-formacao/',
					                            campoPesquisaPadrao: 'nome',
					                            valorPesquisaPadrao: '',
					                          ),
					                          fullscreenDialog: true,
					                        ));
					                  if (_objetoJsonRetorno != null) {
					                    if (_objetoJsonRetorno['nome'] != null) {
					                      _importaNivelFormacaoController.text = _objetoJsonRetorno['nome'];
					                      widget.pessoa.pessoaFisica?.idNivelFormacao = _objetoJsonRetorno['id'];
					                      widget.pessoa.pessoaFisica?.nivelFormacao = NivelFormacao.fromJson(_objetoJsonRetorno);
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
					        sizes: 'col-12',
					        child: Row(
					          children: <Widget>[
					            Expanded(
					              flex: 1,
					              child: Container(
					                child: TextFormField(
					                  controller: _importaEstadoCivilController,
					                  readOnly: true,
					                  decoration: getInputDecoration(
					                    'Importe o Estado Civil Vinculado',
					                    'Estado Civil *',
					                    false),
					                  onSaved: (String value) {
					                  },
					                  validator: ValidaCampoFormulario.validarObrigatorio,
					                  onChanged: (text) {
					                    widget.pessoa?.pessoaFisica?.estadoCivil?.nome = text;
					                    paginaMestreDetalheFoiAlterada = true;
					                  },
					                ),
					              ),
					            ),
					            Expanded(
					              flex: 0,
					              child: IconButton(
					                tooltip: 'Importar Estado Civil',
					                icon: ViewUtilLib.getIconBotaoLookup(),
					                onPressed: () async {
					                  ///chamando o lookup
					                  Map<String, dynamic> _objetoJsonRetorno =
					                    await Navigator.push(
					                      context,
					                      MaterialPageRoute(
					                        builder: (BuildContext context) =>
					                          LookupPage(
					                            title: 'Importar Estado Civil',
					                            colunas: EstadoCivil.colunas,
					                            campos: EstadoCivil.campos,
					                            rota: '/estado-civil/',
					                            campoPesquisaPadrao: 'nome',
					                            valorPesquisaPadrao: '',
					                          ),
					                          fullscreenDialog: true,
					                        ));
					                  if (_objetoJsonRetorno != null) {
					                    if (_objetoJsonRetorno['nome'] != null) {
					                      _importaEstadoCivilController.text = _objetoJsonRetorno['nome'];
					                      widget.pessoa.pessoaFisica?.idEstadoCivil = _objetoJsonRetorno['id'];
					                      widget.pessoa.pessoaFisica?.estadoCivil = EstadoCivil.fromJson(_objetoJsonRetorno);
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
					        sizes: 'col-12 col-md-4',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: TextFormField(
					            keyboardType: TextInputType.number,
					            controller: _cpfController,
					            decoration: getInputDecoration(
					              'Informe o CPF',
					              'CPF',
					              false),
					            onSaved: (String value) {
					            },
					            validator: ValidaCampoFormulario.validarCPF,
					            onChanged: (text) {
					              widget.pessoa.pessoaFisica?.cpf = text;
					              paginaMestreDetalheFoiAlterada = true;
					            },
					          ),
					        ),
					      ),
					      BootstrapCol(
					        sizes: 'col-12 col-md-6',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: TextFormField(
					            maxLength: 20,
					            maxLines: 1,
					            initialValue: widget.pessoa?.pessoaFisica?.rg ?? '',
					            decoration: getInputDecoration(
					              'Informe o RG',
					              'RG',
					              false),
					            onSaved: (String value) {
					            },
					            onChanged: (text) {
					              widget.pessoa.pessoaFisica?.rg = text;
					              paginaMestreDetalheFoiAlterada = true;
					            },
					          ),
					        ),
					      ),
					      BootstrapCol(
					        sizes: 'col-12 col-md-2',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: TextFormField(
					            maxLength: 20,
					            maxLines: 1,
					            initialValue: widget.pessoa?.pessoaFisica?.orgaoRg ?? '',
					            decoration: getInputDecoration(
					              'Informe o Órgão RG',
					              'Órgão RG',
					              false),
					            onSaved: (String value) {
					            },
					            onChanged: (text) {
					              widget.pessoa.pessoaFisica?.orgaoRg = text;
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
					        sizes: 'col-12 col-md-6',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: InputDecorator(
					            decoration: getInputDecoration(
					              'Informe a Data de Emissão do RG',
					              'Data de Emissão',
					              true),
					            isEmpty: widget.pessoa.pessoaFisica?.dataEmissaoRg == null,
					            child: DatePickerItem(
					              dateTime: widget.pessoa.pessoaFisica?.dataEmissaoRg,
					              firstDate: DateTime.parse('1900-01-01'),
					              lastDate: DateTime.now(),
					              onChanged: (DateTime value) {
					                paginaMestreDetalheFoiAlterada = true;
					                setState(() {
					                  widget.pessoa.pessoaFisica?.dataEmissaoRg = value;
					                });
					              },
					            ),
					          ),
					        ),
					      ),
					      BootstrapCol(
					        sizes: 'col-12 col-md-6',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: InputDecorator(
					            decoration: getInputDecoration(
					              'Informe a Data de Nascimento',
					              'Data de Nascimento',
					              true),
					            isEmpty: widget.pessoa.pessoaFisica?.dataNascimento == null,
					            child: DatePickerItem(
					              dateTime: widget.pessoa.pessoaFisica?.dataNascimento,
					              firstDate: DateTime.parse('1900-01-01'),
					              lastDate: DateTime.now(),
					              onChanged: (DateTime value) {
					                paginaMestreDetalheFoiAlterada = true;
					                setState(() {
					                  widget.pessoa.pessoaFisica?.dataNascimento = value;
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
					        sizes: 'col-12 col-md-6',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: InputDecorator(
					            decoration: getInputDecoration(
					              'Selecione a Opção Desejada',
					              'Sexo',
					              true),
					            isEmpty: widget.pessoa?.pessoaFisica?.sexo == null || widget.pessoa?.pessoaFisica == null,
					            child: getDropDownButton(widget.pessoa.pessoaFisica?.sexo, (String newValue) {
					              paginaMestreDetalheFoiAlterada = true;
					              setState(() {
					                widget.pessoa.pessoaFisica?.sexo = newValue;
					                });
					            }, <String>[
					              'Masculino',
					              'Feminino',
					              'Outro',
					          ])),
					        ),
					      ),
					      BootstrapCol(
					        sizes: 'col-12 col-md-6',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: InputDecorator(
					            decoration: getInputDecoration(
					              'Selecione a Opção Desejada',
					              'Raça',
					              true),
					            isEmpty: widget.pessoa?.pessoaFisica?.raca == null || widget.pessoa?.pessoaFisica == null,
					            child: getDropDownButton(widget.pessoa.pessoaFisica?.raca, (String newValue) {
					              paginaMestreDetalheFoiAlterada = true;
					              setState(() {
					                widget.pessoa.pessoaFisica?.raca = newValue;
					                });
					            }, <String>[
					              'Branco',
					              'Moreno',
					              'Negro',
					              'Pardo',
					              'Amarelo',
					              'Indígena',
					              'Outro',
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
					        sizes: 'col-12 col-md-6',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: TextFormField(
					            maxLength: 100,
					            maxLines: 1,
					            initialValue: widget.pessoa?.pessoaFisica?.nacionalidade ?? '',
					            decoration: getInputDecoration(
					              'Informe a Nacionalidade',
					              'Nacionalidade',
					              false),
					            onSaved: (String value) {
					            },
					            onChanged: (text) {
					              widget.pessoa.pessoaFisica?.nacionalidade = text;
					              paginaMestreDetalheFoiAlterada = true;
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
					            initialValue: widget.pessoa?.pessoaFisica?.naturalidade ?? '',
					            decoration: getInputDecoration(
					              'Informe a Naturalidade',
					              'Naturalidade',
					              false),
					            onSaved: (String value) {
					            },
					            onChanged: (text) {
					              widget.pessoa.pessoaFisica?.naturalidade = text;
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
					        sizes: 'col-12 col-md-6',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: TextFormField(
					            maxLength: 200,
					            maxLines: 1,
					            initialValue: widget.pessoa?.pessoaFisica?.nomePai ?? '',
					            decoration: getInputDecoration(
					              'Informe o Nome do Pai',
					              'Nome do Pai',
					              false),
					            onSaved: (String value) {
					            },
					            onChanged: (text) {
					              widget.pessoa.pessoaFisica?.nomePai = text;
					              paginaMestreDetalheFoiAlterada = true;
					            },
					          ),
					        ),
					      ),
					      BootstrapCol(
					        sizes: 'col-12 col-md-6',
					        child: Padding(
					          padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
					          child: TextFormField(
					            maxLength: 200,
					            maxLines: 1,
					            initialValue: widget.pessoa?.pessoaFisica?.nomeMae ?? '',
					            decoration: getInputDecoration(
					              'Informe o Nome da Mãe',
					              'Nome da Mãe',
					              false),
					            onSaved: (String value) {
					            },
					            onChanged: (text) {
					              widget.pessoa.pessoaFisica?.nomeMae = text;
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