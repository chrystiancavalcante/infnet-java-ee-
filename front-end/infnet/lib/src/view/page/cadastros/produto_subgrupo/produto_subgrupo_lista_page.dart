/*
Title: ERP INFNET                                                                
Description: ListaPage relacionada à tabela [PRODUTO_SUBGRUPO] 
                                                                                
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
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

import 'package:infnet/src/infra/sessao.dart';
import 'package:infnet/src/infra/constantes.dart';

import 'package:infnet/src/view/shared/view_util_lib.dart';
import 'package:infnet/src/view/shared/botoes.dart';
import 'package:infnet/src/infra/atalhos_desktop_web.dart';
import 'package:infnet/src/view/shared/caixas_de_dialogo.dart';

import 'package:infnet/src/model/model.dart';
import 'package:infnet/src/model/filtro.dart';
import 'package:infnet/src/view_model/view_model.dart';

import 'package:infnet/src/view/shared/page/filtro_page.dart';
import 'package:infnet/src/view/shared/page/pdf_page.dart';

import 'produto_subgrupo_persiste_page.dart';

class ProdutoSubgrupoListaPage extends StatefulWidget {
  @override
  _ProdutoSubgrupoListaPageState createState() => _ProdutoSubgrupoListaPageState();
}

class _ProdutoSubgrupoListaPageState extends State<ProdutoSubgrupoListaPage> {
  int _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int _sortColumnIndex;
  bool _sortAscending = true;
  var _filtro = Filtro();
  final _colunas = ProdutoSubgrupo.colunas;
  final _campos = ProdutoSubgrupo.campos;

  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosListaPage();

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Sessao.tratarErrosSessao(context, Provider.of<ProdutoSubgrupoViewModel>(context, listen: false).objetoJsonErro)
    );
    super.didChangeDependencies();
  }
  
  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.inserir:
        _inserir();
        break;
      case AtalhoTelaType.imprimir:
        _gerarRelatorio();
        break;
      case AtalhoTelaType.filtrar:
        _chamarFiltro();
        break;
      default:
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final _listaProdutoSubgrupo = Provider.of<ProdutoSubgrupoViewModel>(context).listaProdutoSubgrupo;
    final _objetoJsonErro = Provider.of<ProdutoSubgrupoViewModel>(context).objetoJsonErro;

    if (_listaProdutoSubgrupo == null && _objetoJsonErro == null) {
      Provider.of<ProdutoSubgrupoViewModel>(context, listen: false).consultarLista();
    }
  
    final _ProdutoSubgrupoDataSource _produtoSubgrupoDataSource = _ProdutoSubgrupoDataSource(_listaProdutoSubgrupo, context);

    void _sort<T>(Comparable<T> getField(ProdutoSubgrupo produtoSubgrupo), int columnIndex, bool ascending) {
      _produtoSubgrupoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }
	
      return FocusableActionDetector(
        actions: _actionMap,
        shortcuts: _shortcutMap,
        child: Focus(
          autofocus: true,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Cadastro - Produto Subgrupo'),
              actions: <Widget>[],
            ),
            floatingActionButton: FloatingActionButton(
              focusColor: ViewUtilLib.getBotaoFocusColor(),
              tooltip: Constantes.botaoInserirDica,
              backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
              child: ViewUtilLib.getIconBotaoInserir(),
              onPressed: () {
                _inserir();
              }),
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: BottomAppBar(
              color: ViewUtilLib.getBottomAppBarColor(),          
              shape: CircularNotchedRectangle(),
              child: Row(
                children: getBotoesNavigationBarListaPage(
                  context: context, 
                  chamarFiltro: _chamarFiltro, 
                  gerarRelatorio: _gerarRelatorio,
                ),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: _refrescarTela,
              child: Scrollbar(
                child: _listaProdutoSubgrupo == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                  padding: EdgeInsets.all(Constantes.paddingListViewListaPage),
                  children: <Widget>[
                    PaginatedDataTable(                        
                      header: const Text('Relação - Produto Subgrupo'),
                      rowsPerPage: _rowsPerPage,
                      onRowsPerPageChanged: (int value) {
                        setState(() {
                          _rowsPerPage = value;
                        });
                      },
                      sortColumnIndex: _sortColumnIndex,
                      sortAscending: _sortAscending,
                      columns: <DataColumn>[
                        DataColumn(
                          numeric: true,
                          label: const Text('Id'),
                          tooltip: 'Id',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<num>((ProdutoSubgrupo produtoSubgrupo) => produtoSubgrupo.id, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Grupo'),
                          tooltip: 'Grupo',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((ProdutoSubgrupo produtoSubgrupo) => produtoSubgrupo.produtoGrupo?.nome, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Nome'),
                          tooltip: 'Nome',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((ProdutoSubgrupo produtoSubgrupo) => produtoSubgrupo.nome, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Descrição'),
                          tooltip: 'Descrição',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((ProdutoSubgrupo produtoSubgrupo) => produtoSubgrupo.descricao, columnIndex, ascending),
                        ),
                      ],
                      source: _produtoSubgrupoDataSource,
                    ),
                  ],
                ),
              ),
            ),          
          ),
        ),
      );
  }

  void _inserir() {
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) => 
          ProdutoSubgrupoPersistePage(produtoSubgrupo: ProdutoSubgrupo(), title: 'Produto Subgrupo - Inserindo', operacao: 'I')))
      .then((_) {
        Provider.of<ProdutoSubgrupoViewModel>(context, listen: false).consultarLista();
    });
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Produto Subgrupo - Filtro',
            colunas: _colunas,
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro.campo != null) {
        _filtro.campo = _campos[int.parse(_filtro.campo)];
        await Provider.of<ProdutoSubgrupoViewModel>(context, listen: false).consultarLista(filtro: _filtro);
      }
    }    
  }

  Future _gerarRelatorio() async {
    gerarDialogBoxConfirmacao(
      context, Constantes.perguntaGerarRelatorio, () async {
      Navigator.of(context).pop();

      if (kIsWeb) {
        await Provider.of<ProdutoSubgrupoViewModel>(context).visualizarPdfWeb(filtro: _filtro);
      } else {
        var arquivoPdf = await Provider.of<ProdutoSubgrupoViewModel>(context).visualizarPdf(filtro: _filtro);
        Navigator.of(context)
          .push(MaterialPageRoute(
            builder: (BuildContext context) => PdfPage(arquivoPdf: arquivoPdf, title: 'Relatório - Produto Subgrupo')));
      }
    });
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<ProdutoSubgrupoViewModel>(context, listen: false).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class _ProdutoSubgrupoDataSource extends DataTableSource {
  final List<ProdutoSubgrupo> listaProdutoSubgrupo;
  final BuildContext context;

  _ProdutoSubgrupoDataSource(this.listaProdutoSubgrupo, this.context);

  void _sort<T>(Comparable<T> getField(ProdutoSubgrupo produtoSubgrupo), bool ascending) {
    listaProdutoSubgrupo.sort((ProdutoSubgrupo a, ProdutoSubgrupo b) {
      if (!ascending) {
        final ProdutoSubgrupo c = a;
        a = b;
        b = c;
      }
      Comparable<T> aValue = getField(a);
      Comparable<T> bValue = getField(b);

      if (aValue == null) aValue = '' as Comparable<T>;
      if (bValue == null) bValue = '' as Comparable<T>;

      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= listaProdutoSubgrupo.length) return null;
    final ProdutoSubgrupo produtoSubgrupo = listaProdutoSubgrupo[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${produtoSubgrupo.id ?? ''}'), onTap: () {
          _detalharProdutoSubgrupo(produtoSubgrupo, context);
        }),
        DataCell(Text('${produtoSubgrupo.produtoGrupo?.nome ?? ''}'), onTap: () {
          _detalharProdutoSubgrupo(produtoSubgrupo, context);
        }),
        DataCell(Text('${produtoSubgrupo.nome ?? ''}'), onTap: () {
          _detalharProdutoSubgrupo(produtoSubgrupo, context);
        }),
        DataCell(Text('${produtoSubgrupo.descricao ?? ''}'), onTap: () {
          _detalharProdutoSubgrupo(produtoSubgrupo, context);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaProdutoSubgrupo.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharProdutoSubgrupo(ProdutoSubgrupo produtoSubgrupo, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => 
        ProdutoSubgrupoPersistePage(produtoSubgrupo: produtoSubgrupo, title: 'Produto Subgrupo - Editando', operacao: 'A')));
}