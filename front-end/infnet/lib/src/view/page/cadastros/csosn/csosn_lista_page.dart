/*
Title: ERP INFNET                                                                
Description: ListaPage relacionada à tabela [CSOSN] 
                                                                                
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

import 'csosn_persiste_page.dart';

class CsosnListaPage extends StatefulWidget {
  @override
  _CsosnListaPageState createState() => _CsosnListaPageState();
}

class _CsosnListaPageState extends State<CsosnListaPage> {
  int _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int _sortColumnIndex;
  bool _sortAscending = true;
  var _filtro = Filtro();
  final _colunas = Csosn.colunas;
  final _campos = Csosn.campos;

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
      (_) => Sessao.tratarErrosSessao(context, Provider.of<CsosnViewModel>(context, listen: false).objetoJsonErro)
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
    final _listaCsosn = Provider.of<CsosnViewModel>(context).listaCsosn;
    final _objetoJsonErro = Provider.of<CsosnViewModel>(context).objetoJsonErro;

    if (_listaCsosn == null && _objetoJsonErro == null) {
      Provider.of<CsosnViewModel>(context, listen: false).consultarLista();
    }
  
    final _CsosnDataSource _csosnDataSource = _CsosnDataSource(_listaCsosn, context);

    void _sort<T>(Comparable<T> getField(Csosn csosn), int columnIndex, bool ascending) {
      _csosnDataSource._sort<T>(getField, ascending);
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
              title: const Text('Cadastro - Csosn'),
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
                child: _listaCsosn == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                  padding: EdgeInsets.all(Constantes.paddingListViewListaPage),
                  children: <Widget>[
                    PaginatedDataTable(                        
                      header: const Text('Relação - Csosn'),
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
                            _sort<num>((Csosn csosn) => csosn.id, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Código'),
                          tooltip: 'Código',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((Csosn csosn) => csosn.codigo, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Descrição'),
                          tooltip: 'Descrição',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((Csosn csosn) => csosn.descricao, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Observação'),
                          tooltip: 'Observação',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((Csosn csosn) => csosn.observacao, columnIndex, ascending),
                        ),
                      ],
                      source: _csosnDataSource,
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
          CsosnPersistePage(csosn: Csosn(), title: 'Csosn - Inserindo', operacao: 'I')))
      .then((_) {
        Provider.of<CsosnViewModel>(context, listen: false).consultarLista();
    });
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Csosn - Filtro',
            colunas: _colunas,
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro.campo != null) {
        _filtro.campo = _campos[int.parse(_filtro.campo)];
        await Provider.of<CsosnViewModel>(context, listen: false).consultarLista(filtro: _filtro);
      }
    }    
  }

  Future _gerarRelatorio() async {
    gerarDialogBoxConfirmacao(
      context, Constantes.perguntaGerarRelatorio, () async {
      Navigator.of(context).pop();

      if (kIsWeb) {
        await Provider.of<CsosnViewModel>(context).visualizarPdfWeb(filtro: _filtro);
      } else {
        var arquivoPdf = await Provider.of<CsosnViewModel>(context).visualizarPdf(filtro: _filtro);
        Navigator.of(context)
          .push(MaterialPageRoute(
            builder: (BuildContext context) => PdfPage(arquivoPdf: arquivoPdf, title: 'Relatório - Csosn')));
      }
    });
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<CsosnViewModel>(context, listen: false).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class _CsosnDataSource extends DataTableSource {
  final List<Csosn> listaCsosn;
  final BuildContext context;

  _CsosnDataSource(this.listaCsosn, this.context);

  void _sort<T>(Comparable<T> getField(Csosn csosn), bool ascending) {
    listaCsosn.sort((Csosn a, Csosn b) {
      if (!ascending) {
        final Csosn c = a;
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
    if (index >= listaCsosn.length) return null;
    final Csosn csosn = listaCsosn[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${csosn.id ?? ''}'), onTap: () {
          _detalharCsosn(csosn, context);
        }),
        DataCell(Text('${csosn.codigo ?? ''}'), onTap: () {
          _detalharCsosn(csosn, context);
        }),
        DataCell(Text('${csosn.descricao ?? ''}'), onTap: () {
          _detalharCsosn(csosn, context);
        }),
        DataCell(Text('${csosn.observacao ?? ''}'), onTap: () {
          _detalharCsosn(csosn, context);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaCsosn.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharCsosn(Csosn csosn, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => 
        CsosnPersistePage(csosn: csosn, title: 'Csosn - Editando', operacao: 'A')));
}