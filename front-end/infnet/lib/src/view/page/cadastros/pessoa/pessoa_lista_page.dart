/*
Title: ERP INFNET                                                                
Description: AbaMestre ListaPage relacionada à tabela [PESSOA] 
                                                                                
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

import 'pessoa_page.dart';

class PessoaListaPage extends StatefulWidget {
  @override
  _PessoaListaPageState createState() => _PessoaListaPageState();
}

class _PessoaListaPageState extends State<PessoaListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;
  var _filtro = Filtro();
  final _colunas = Pessoa.colunas;
  final _campos = Pessoa.campos;

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
      (_) => Sessao.tratarErrosSessao(context, Provider.of<PessoaViewModel>(context, listen: false).objetoJsonErro)
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
    final _listaPessoa = Provider.of<PessoaViewModel>(context).listaPessoa;
    final _objetoJsonErro = Provider.of<PessoaViewModel>(context).objetoJsonErro;

    if (_listaPessoa == null && _objetoJsonErro == null) {
      Provider.of<PessoaViewModel>(context, listen: false).consultarLista();
    }

    final _PessoaDataSource _pessoaDataSource = _PessoaDataSource(_listaPessoa, context);

    void _sort<T>(Comparable<T> getField(Pessoa pessoa), int columnIndex, bool ascending) {
      _pessoaDataSource._sort<T>(getField, ascending);
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
              title: const Text('Cadastro - Pessoa'),
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
                child: _listaPessoa == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                  padding: EdgeInsets.all(Constantes.paddingListViewListaPage),
                  children: <Widget>[
                    PaginatedDataTable(
                      header: const Text('Relação - Pessoa'),
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
                            _sort<num>((Pessoa pessoa) => pessoa.id, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Nome'),
                          tooltip: 'Nome',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((Pessoa pessoa) => pessoa.nome, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Tipo Pessoa'),
                          tooltip: 'Tipo Pessoa',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((Pessoa pessoa) => pessoa.tipo, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('Site'),
                          tooltip: 'Site',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((Pessoa pessoa) => pessoa.site, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('EMail'),
                          tooltip: 'EMail',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((Pessoa pessoa) => pessoa.email, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('É Cliente'),
                          tooltip: 'É Cliente',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((Pessoa pessoa) => pessoa.ehCliente, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('É Fornecedor'),
                          tooltip: 'É Fornecedor',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((Pessoa pessoa) => pessoa.ehFornecedor, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('É Transportadora'),
                          tooltip: 'É Transportadora',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((Pessoa pessoa) => pessoa.ehTransportadora, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('É Colaborador'),
                          tooltip: 'É Colaborador',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((Pessoa pessoa) => pessoa.ehColaborador, columnIndex, ascending),
                        ),
                        DataColumn(
                          label: const Text('É Contador'),
                          tooltip: 'É Contador',
                          onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((Pessoa pessoa) => pessoa.ehContador, columnIndex, ascending),
                        ),
                      ],
                      source: _pessoaDataSource,
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
          PessoaPage(pessoa: Pessoa(), title: 'Pessoa - Inserindo', operacao: 'I')))
      .then((_) {
        Provider.of<PessoaViewModel>(context, listen: false).consultarLista();
    });
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Pessoa - Filtro',
            colunas: _colunas,
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro.campo != null) {
        _filtro.campo = _campos[int.parse(_filtro.campo)];
        await Provider.of<PessoaViewModel>(context, listen: false).consultarLista(filtro: _filtro);
      }
    }    
  }

  Future _gerarRelatorio() async {
    gerarDialogBoxConfirmacao(
      context, Constantes.perguntaGerarRelatorio, () async {
      Navigator.of(context).pop();

      if (kIsWeb) {
	    await Provider.of<PessoaViewModel>(context).visualizarPdfWeb(filtro: _filtro);
	  } else {
        var arquivoPdf = await Provider.of<PessoaViewModel>(context).visualizarPdf(filtro: _filtro);
        Navigator.of(context)
          .push(MaterialPageRoute(
		    builder: (BuildContext context) => PdfPage(arquivoPdf: arquivoPdf, title: 'Relatório - Pessoa')));
      }
    });
  }

  Future<Null> _refrescarTela() async {
    await Provider.of<PessoaViewModel>(context, listen: false).consultarLista();
    return null;
  }
}

/// codigo referente a fonte de dados
class _PessoaDataSource extends DataTableSource {
  final List<Pessoa> listaPessoa;
  final BuildContext context;

  _PessoaDataSource(this.listaPessoa, this.context);

  void _sort<T>(Comparable<T> getField(Pessoa pessoa), bool ascending) {
    listaPessoa.sort((Pessoa a, Pessoa b) {
      if (!ascending) {
        final Pessoa c = a;
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
    if (index >= listaPessoa.length) return null;
    final Pessoa pessoa = listaPessoa[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${pessoa.id ?? ''}'), onTap: () {
          _detalharPessoa(pessoa, context);
        }),
        DataCell(Text('${pessoa.nome ?? ''}'), onTap: () {
          _detalharPessoa(pessoa, context);
        }),
        DataCell(Text('${pessoa.tipo ?? ''}'), onTap: () {
          _detalharPessoa(pessoa, context);
        }),
        DataCell(Text('${pessoa.site ?? ''}'), onTap: () {
          _detalharPessoa(pessoa, context);
        }),
        DataCell(Text('${pessoa.email ?? ''}'), onTap: () {
          _detalharPessoa(pessoa, context);
        }),
        DataCell(Text('${pessoa.ehCliente ?? ''}'), onTap: () {
          _detalharPessoa(pessoa, context);
        }),
        DataCell(Text('${pessoa.ehFornecedor ?? ''}'), onTap: () {
          _detalharPessoa(pessoa, context);
        }),
        DataCell(Text('${pessoa.ehTransportadora ?? ''}'), onTap: () {
          _detalharPessoa(pessoa, context);
        }),
        DataCell(Text('${pessoa.ehColaborador ?? ''}'), onTap: () {
          _detalharPessoa(pessoa, context);
        }),
        DataCell(Text('${pessoa.ehContador ?? ''}'), onTap: () {
          _detalharPessoa(pessoa, context);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaPessoa.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharPessoa(Pessoa pessoa, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
        PessoaPage(pessoa: pessoa, title: 'Pessoa - Editando', operacao: 'A')));
}