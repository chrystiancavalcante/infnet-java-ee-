/*
Title: ERP INFNET                                                                
Description: PersistePage relacionada à tabela [PRODUTO] 
                                                                                
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

class ProdutoPersistePage extends StatefulWidget {
  final Produto produto;
  final String title;
  final String operacao;

  const ProdutoPersistePage({Key key, this.produto, this.title, this.operacao})
      : super(key: key);

  @override
  _ProdutoPersistePageState createState() => _ProdutoPersistePageState();
}

class _ProdutoPersistePageState extends State<ProdutoPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formFoiAlterado = false;
  var _produtoProvider;

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
    _produtoProvider = Provider.of<ProdutoViewModel>(context);
	
    final _importaProdutoSubgrupoController = TextEditingController();
    _importaProdutoSubgrupoController.text = widget.produto?.produtoSubgrupo?.nome ?? '';
    final _importaProdutoMarcaController = TextEditingController();
    _importaProdutoMarcaController.text = widget.produto?.produtoMarca?.nome ?? '';
    final _importaProdutoUnidadeController = TextEditingController();
    _importaProdutoUnidadeController.text = widget.produto?.produtoUnidade?.sigla ?? '';
    final _importaTributIcmsCustomCabController = TextEditingController();
  /*   _importaTributIcmsCustomCabController.text = widget.produto?.tributIcmsCustomCab?.descricao ?? '';
    final _importaTributGrupoTributarioController = TextEditingController();
    _importaTributGrupoTributarioController.text = widget.produto?.tributGrupoTributario?.descricao ?? '';
    final _importaNcmController = TextEditingController(); */
    //_importaNcmController.text = widget.produto?.codigoNcm ?? '';
    final _valorCompraController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.produto?.valorCompra ?? 0);
    final _valorVendaController = MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.produto?.valorVenda ?? 0);
    final _estoqueMinimoController = MoneyMaskedTextController(precision: Constantes.decimaisQuantidade, initialValue: widget.produto?.estoqueMinimo ?? 0);
    final _estoqueMaximoController = MoneyMaskedTextController(precision: Constantes.decimaisQuantidade, initialValue: widget.produto?.estoqueMaximo ?? 0);
    final _quantidadeEstoqueController = MoneyMaskedTextController(precision: Constantes.decimaisQuantidade, initialValue: widget.produto?.quantidadeEstoque ?? 0);
	
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
                                      controller: _importaProdutoSubgrupoController,
                                      readOnly: true,
                                      decoration: getInputDecoration(
                                        'Importe o Subgrupo de Produto Vinculado',
                                        'Subgrupo *',
                                        false),
                                      onSaved: (String value) {
                                      },
                                      validator: ValidaCampoFormulario.validarObrigatorio,
                                      onChanged: (text) {
                                        widget.produto?.produtoSubgrupo?.nome = text;
                                        _formFoiAlterado = true;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Subgrupo',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic> _objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                              LookupPage(
                                                title: 'Importar Subgrupo',
                                                colunas: ProdutoSubgrupo.colunas,
                                                campos: ProdutoSubgrupo.campos,
                                                rota: '/produto-subgrupo/',
                                                campoPesquisaPadrao: 'nome',
                                                valorPesquisaPadrao: '%',
                                              ),
                                              fullscreenDialog: true,
                                            ));
                                      if (_objetoJsonRetorno != null) {
                                        if (_objetoJsonRetorno['nome'] != null) {
                                          _importaProdutoSubgrupoController.text = _objetoJsonRetorno['nome'];
                                          widget.produto.idProdutoSubgrupo = _objetoJsonRetorno['id'];
                                          widget.produto.produtoSubgrupo = new ProdutoSubgrupo.fromJson(_objetoJsonRetorno);
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
                                      controller: _importaProdutoMarcaController,
                                      readOnly: true,
                                      decoration: getInputDecoration(
                                        'Importe a Marca Vinculada',
                                        'Marca *',
                                        false),
                                      onSaved: (String value) {
                                      },
                                      validator: ValidaCampoFormulario.validarObrigatorio,
                                      onChanged: (text) {
                                        widget.produto?.produtoMarca?.nome = text;
                                        _formFoiAlterado = true;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Marca',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic> _objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                              LookupPage(
                                                title: 'Importar Marca',
                                                colunas: ProdutoMarca.colunas,
                                                campos: ProdutoMarca.campos,
                                                rota: '/produto-marca/',
                                                campoPesquisaPadrao: 'nome',
                                                valorPesquisaPadrao: '%',
                                              ),
                                              fullscreenDialog: true,
                                            ));
                                      if (_objetoJsonRetorno != null) {
                                        if (_objetoJsonRetorno['nome'] != null) {
                                          _importaProdutoMarcaController.text = _objetoJsonRetorno['nome'];
                                          widget.produto.idProdutoMarca = _objetoJsonRetorno['id'];
                                          widget.produto.produtoMarca = new ProdutoMarca.fromJson(_objetoJsonRetorno);
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
                                      controller: _importaProdutoUnidadeController,
                                      readOnly: true,
                                      decoration: getInputDecoration(
                                        'Importe a Unidade Vinculada',
                                        'Unidade *',
                                        false),
                                      onSaved: (String value) {
                                      },
                                      validator: ValidaCampoFormulario.validarObrigatorio,
                                      onChanged: (text) {
                                        widget.produto?.produtoUnidade?.sigla = text;
                                        _formFoiAlterado = true;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Unidade',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic> _objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                              LookupPage(
                                                title: 'Importar Unidade',
                                                colunas: ProdutoUnidade.colunas,
                                                campos: ProdutoUnidade.campos,
                                                rota: '/produto-unidade/',
                                                campoPesquisaPadrao: 'sigla',
                                                valorPesquisaPadrao: '%',
                                              ),
                                              fullscreenDialog: true,
                                            ));
                                      if (_objetoJsonRetorno != null) {
                                        if (_objetoJsonRetorno['sigla'] != null) {
                                          _importaProdutoUnidadeController.text = _objetoJsonRetorno['sigla'];
                                          widget.produto.idProdutoUnidade = _objetoJsonRetorno['id'];
                                          widget.produto.produtoUnidade = new ProdutoUnidade.fromJson(_objetoJsonRetorno);
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
                                      controller: _importaTributIcmsCustomCabController,
                                      readOnly: true,
                                      decoration: getInputDecoration(
                                        'Importe o ICMS Customizado Vinculado',
                                        'ICMS Customizado *',
                                        false),
                                      onSaved: (String value) {
                                      },
                                      validator: ValidaCampoFormulario.validarObrigatorio,
                                      onChanged: (text) {
                                       // widget.produto?.tributIcmsCustomCab?.descricao = text;
                                        _formFoiAlterado = true;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar ICMS Customizado',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic> _objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                              LookupPage(
                                                title: 'Importar ICMS Customizado',
                                                //colunas: TributIcmsCustomCab.colunas,
                                                //campos: TributIcmsCustomCab.campos,
                                                rota: '/tribut-icms-custom-cab/',
                                                campoPesquisaPadrao: 'descricao',
                                                valorPesquisaPadrao: '%',
                                              ),
                                              fullscreenDialog: true,
                                            ));
                                      if (_objetoJsonRetorno != null) {
                                        if (_objetoJsonRetorno['descricao'] != null) {
                                          _importaTributIcmsCustomCabController.text = _objetoJsonRetorno['descricao'];
                                          widget.produto.idTributIcmsCustomCab = _objetoJsonRetorno['id'];
                                          //widget.produto.tributIcmsCustomCab = new TributIcmsCustomCab.fromJson(_objetoJsonRetorno);
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
                                      //controller: _importaTributGrupoTributarioController,
                                      readOnly: true,
                                      decoration: getInputDecoration(
                                        'Importe o Grupo Tributário Vinculado',
                                        'Grupo Tributário *',
                                        false),
                                      onSaved: (String value) {
                                      },
                                      validator: ValidaCampoFormulario.validarObrigatorio,
                                      onChanged: (text) {
                                        //widget.produto?.tributGrupoTributario?.descricao = text;
                                        _formFoiAlterado = true;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Grupo Tributário',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic> _objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                              LookupPage(
                                                title: 'Importar Grupo Tributário',
                                                // colunas: TributGrupoTributario.colunas,
                                                // campos: TributGrupoTributario.campos,
                                                rota: '/tribut-grupo-tributario/',
                                                campoPesquisaPadrao: 'descricao',
                                                valorPesquisaPadrao: '%',
                                              ),
                                              fullscreenDialog: true,
                                            ));
                                      if (_objetoJsonRetorno != null) {
                                        if (_objetoJsonRetorno['descricao'] != null) {
                                         // _importaTributGrupoTributarioController.text = _objetoJsonRetorno['descricao'];
                                          widget.produto.idTributGrupoTributario = _objetoJsonRetorno['id'];
                                         // widget.produto.tributGrupoTributario = new TributGrupoTributario.fromJson(_objetoJsonRetorno);
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
                                     // controller: _importaNcmController,
                                      readOnly: true,
                                      decoration: getInputDecoration(
                                        'Importe o Código NCM',
                                        'Código NCM *',
                                        false),
                                      onSaved: (String value) {
                                      },
                                      validator: ValidaCampoFormulario.validarObrigatorio,
                                      onChanged: (text) {
                                        widget.produto?.codigoNcm = text;
                                        _formFoiAlterado = true;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Código NCM',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic> _objetoJsonRetorno =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                              LookupPage(
                                                title: 'Importar Código NCM',
                                                colunas: Ncm.colunas,
                                                campos: Ncm.campos,
                                                rota: '/ncm/',
                                                campoPesquisaPadrao: 'codigo',
                                                valorPesquisaPadrao: '',
                                              ),
                                              fullscreenDialog: true,
                                            ));
                                      if (_objetoJsonRetorno != null) {
                                        if (_objetoJsonRetorno['codigo'] != null) {
                                          //_importaNcmController.text = _objetoJsonRetorno['codigo'];
                                          widget.produto.codigoNcm = _objetoJsonRetorno['codigo'];
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
                                initialValue: widget.produto?.nome ?? '',
                                decoration: getInputDecoration(
                                  'Informe o Nome do Produto',
                                  'Nome *',
                                  false),
                                onSaved: (String value) {
                                },
                                validator: ValidaCampoFormulario.validarObrigatorio,
                                onChanged: (text) {
                                  widget.produto.nome = text;
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
                                maxLength: 14,
                                maxLines: 1,
                                initialValue: widget.produto?.gtin ?? '',
                                decoration: getInputDecoration(
                                  'Informe o GTIN do Produto',
                                  'GTIN',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  widget.produto.gtin = text;
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
                              initialValue: widget.produto?.descricao ?? '',
                              decoration: getInputDecoration(
                                'Informe a Descrição do Produto',
                                'Descrição',
                                false),
                              onSaved: (String value) {
                              },
                              onChanged: (text) {
                                widget.produto.descricao = text;
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
                            sizes: 'col-12 col-md-4',
                            child: Padding(
                              padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
                              child: TextFormField(
                                maxLength: 50,
                                maxLines: 1,
                                initialValue: widget.produto?.codigoInterno ?? '',
                                decoration: getInputDecoration(
                                  'Informe o Código Interno do Produto',
                                  'Código Interno',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  widget.produto.codigoInterno = text;
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
                                controller: _valorCompraController,
                                decoration: getInputDecoration(
                                  'Informe o Valor da Compra do Produto',
                                  'Valor Compra',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  widget.produto.valorCompra = _valorCompraController.numberValue;
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
                                controller: _valorVendaController,
                                decoration: getInputDecoration(
                                  'Informe o Valor da Venda do Produto',
                                  'Valor Venda *',
                                  false),
                                onSaved: (String value) {
                                },
                                validator: ValidaCampoFormulario.validarObrigatorioDecimal,
                                onChanged: (text) {
                                  widget.produto.valorVenda = _valorVendaController.numberValue;
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
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.end,
                                controller: _estoqueMinimoController,
                                decoration: getInputDecoration(
                                  'Informe a Quantidade de Estoque Mínimo',
                                  'Estoque Mínimo',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  widget.produto.estoqueMinimo = _estoqueMinimoController.numberValue;
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
                                controller: _estoqueMaximoController,
                                decoration: getInputDecoration(
                                  'Informe a Quantidade de Estoque Máximo',
                                  'Estoque Máximo',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  widget.produto.estoqueMaximo = _estoqueMaximoController.numberValue;
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
                                controller: _quantidadeEstoqueController,
                                decoration: getInputDecoration(
                                  'Informe a Quantidade em Estoque',
                                  'Quantidade em Estoque',
                                  false),
                                onSaved: (String value) {
                                },
                                onChanged: (text) {
                                  widget.produto.quantidadeEstoque = _quantidadeEstoqueController.numberValue;
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
                              child: InputDecorator(
                                decoration: getInputDecoration(
                                  'Informe a Data de Cadastro',
                                  'Data de Cadastro',
                                  true),
                                isEmpty: widget.produto.dataCadastro == null,
                                child: DatePickerItem(
                                  dateTime: widget.produto.dataCadastro,
                                  firstDate: DateTime.parse('1900-01-01'),
                                  lastDate: DateTime.now(),
                                  onChanged: (DateTime value) {
                                    setState(() {
                                      widget.produto.dataCadastro = value;
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
          await _produtoProvider.alterar(widget.produto);
        } else {
          await _produtoProvider.inserir(widget.produto);
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
      await _produtoProvider.excluir(widget.produto.id);
      Navigator.of(context).pop();
      showInSnackBar("Registro excluído com sucesso!", context, corFundo: Colors.green);
    });
  }  
}