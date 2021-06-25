/*
Title: ERP INFNET                                                                
Description: ListaPage relacionada à tabela [NIVEL_FORMACAO] 
                                                                                
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

import 'nivel_formacao_persiste_page.dart';

class NivelFormacaoListaPage extends StatefulWidget {
  @override
  _NivelFormacaoListaPageState createState() => _NivelFormacaoListaPageState();
}

class _NivelFormacaoListaPageState extends State<NivelFormacaoListaPage> {
  int _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int _sortColumnIndex;
  bool _sortAscending = true;
  var _filtro = Filtro();
  final _colunas = NivelFormacao.colunas;
  final _campos = NivelFormacao.campos;

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
      (_) => Sessao.tratarErrosSessao(context, Provider.of<NivelFormacaoViewModel>(context, listen: false).objetoJsonErro)
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
    final _listaNivelFormacao = Provider.of<NivelFormacaoViewModel>(context).listaNivelFormacao;
    final _objetoJsonErro = Provider.of<NivelFormacaoViewModel>(context).objetoJsonErro;

    if (_listaNivelFormacao == null && _objetoJsonErro == null) {
      Provider.of<NivelFormacaoViewModel>(context, listen: false).consultarLista();
    }
  
    final _NivelFormacaoDataSource _nivelFormacaoDataSource = _NivelFormacaoDataSource(_listaNivelFormacao, context);

    void _sort<T>(Comparable<T> getField(NivelFormacao nivelFormacao), int columnIndex, bool ascending) {
      _nivelFormacaoDataSource._sort<T>(getField, ascending);
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
              title: const Text('Cadastro - Nivel Formacao'),
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
                child: _listaNivelFormacao == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                  padding: EdgeInsets.all(Constantes.paddingListViewListaPage),
                  children: <Widget>[
                    PaginatedDataTable(                        
                      header: const Text('Relação - Nivel Formacao'),
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
                            _sort<num>((NivelFormacao nivelFormacao) => nivelFormacao.id, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Nome'),
                          tooltip: 'Nome',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((NivelFormacao nivelFormacao) => nivelFormacao.nome, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Descrição'),
                          tooltip: 'Descrição',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((NivelFormacao nivelFormacao) => nivelFormacao.descricao, columnIndex, ascending),
                        ),
                      ],
                      source: _nivelFormacaoDataSource,
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
          NivelFormacaoPersistePage(nivelFormacao: NivelFormacao(), title: 'Nivel Formacao - Inserindo', operacao: 'I')))
      .then((_) {
        Provider.of<NivelFormacaoViewModel>(context, listen: false).consultarLista();
    });
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Nivel Formacao - Filtro',
            colunas: _colunas,
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro.campo != null) {
        _filtro.campo = _campos[int.parse(_filtro.campo)];
        await Provider.of<NivelFormacaoViewModel>(context, listen: false).consultarLista(filtro: _filtro);
      }
    }    
  }

  Future _gerarRelatorio() async {
    gerarDialogBoxConfirmacao(
      context, Constantes.perguntaGerarRelatorio, () async {
      Navigator.of(context).pop();

      if (kIsWeb) {
        await Provider.of<NivelFormacaoViewModel>(context).visualizarPdfWeb(filtro: _filtro);
      } else {
        var arquivoPdf = await Provider.of<NivelFormacaoViewModel>(context).visualizarPdf(filtro: _filtro);
        Navigator.of(context)
          .push(MaterialPageRoute(
            builder: (BuildContext context) => PdfPage(arquivoPdf: arquivoPdf, title: 'Relatório - Nivel Formacao')));
      }
    });
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<NivelFormacaoViewModel>(context, listen: false).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class _NivelFormacaoDataSource extends DataTableSource {
  final List<NivelFormacao> listaNivelFormacao;
  final BuildContext context;

  _NivelFormacaoDataSource(this.listaNivelFormacao, this.context);

  void _sort<T>(Comparable<T> getField(NivelFormacao nivelFormacao), bool ascending) {
    listaNivelFormacao.sort((NivelFormacao a, NivelFormacao b) {
      if (!ascending) {
        final NivelFormacao c = a;
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
    if (index >= listaNivelFormacao.length) return null;
    final NivelFormacao nivelFormacao = listaNivelFormacao[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${nivelFormacao.id ?? ''}'), onTap: () {
          _detalharNivelFormacao(nivelFormacao, context);
        }),
        DataCell(Text('${nivelFormacao.nome ?? ''}'), onTap: () {
          _detalharNivelFormacao(nivelFormacao, context);
        }),
        DataCell(Text('${nivelFormacao.descricao ?? ''}'), onTap: () {
          _detalharNivelFormacao(nivelFormacao, context);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaNivelFormacao.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharNivelFormacao(NivelFormacao nivelFormacao, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => 
        NivelFormacaoPersistePage(nivelFormacao: nivelFormacao, title: 'Nivel Formacao - Editando', operacao: 'A')));
}