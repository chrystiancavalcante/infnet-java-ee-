/*
Title: ERP INFNET                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [PESSOA_TELEFONE] 
                                                                                
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
import 'package:flutter/foundation.dart';

import 'package:infnet/src/infra/constantes.dart';

import 'package:infnet/src/model/model.dart';

import 'package:infnet/src/view/shared/view_util_lib.dart';
import 'package:infnet/src/infra/atalhos_desktop_web.dart';


//import 'pessoa_telefone_detalhe_page.dart';
import 'pessoa_telefone_persiste_page.dart';

class PessoaTelefoneListaPage extends StatefulWidget {
  final Pessoa pessoa;
  final FocusNode foco;
  final Function salvarPessoaCallBack;

  const PessoaTelefoneListaPage({Key key, this.pessoa, this.foco, this.salvarPessoaCallBack}) : super(key: key);

  @override
  _PessoaTelefoneListaPageState createState() => _PessoaTelefoneListaPageState();
}

class _PessoaTelefoneListaPageState extends State<PessoaTelefoneListaPage> {
  Map<LogicalKeySet, Intent> _shortcutMap; 
  Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosAbaPage();

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.inserir:
        _inserir();
        break;
      case AtalhoTelaType.salvar:
        widget.salvarPessoaCallBack();
        break;
      default:
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            focusNode: widget.foco,
            autofocus: true,
            focusColor: ViewUtilLib.getBotaoFocusColor(),
            tooltip: Constantes.botaoInserirDica,
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              _inserir();
            }),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: Scrollbar(
            child: ListView(
              padding: const EdgeInsets.all(2.0),
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: DataTable(columns: _getColumns(), rows: _getRows()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _inserir() {
    var _pessoaTelefone = PessoaTelefone();
    widget.pessoa.listaPessoaTelefone.add(_pessoaTelefone);
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) =>
          PessoaTelefonePersistePage(
            pessoa: widget.pessoa,
            pessoaTelefone: _pessoaTelefone,
            title: 'Pessoa Telefone - Inserindo',
            operacao: 'I')))
      .then((_) {
        setState(() {
          if (_pessoaTelefone.numero == null) { // se esse atributo estiver vazio, o objeto será removido
            widget.pessoa.listaPessoaTelefone.remove(_pessoaTelefone);
          }
          _getRows();
        });
      });
  }
  
  List<DataColumn> _getColumns() {
    List<DataColumn> lista = [];
    lista.add(DataColumn(numeric: true, label: Text('Id')));
    lista.add(DataColumn(label: Text('Id Pessoa')));
    lista.add(DataColumn(label: Text('Tipo')));
    lista.add(DataColumn(label: Text('Numero')));
    return lista;
  }

  List<DataRow> _getRows() {
    if (widget.pessoa.listaPessoaTelefone == null) {
      widget.pessoa.listaPessoaTelefone = [];
    }
    List<DataRow> lista = [];
    for (var pessoaTelefone in widget.pessoa.listaPessoaTelefone) {
      List<DataCell> _celulas = [];

      _celulas = [
        DataCell(Text('${ pessoaTelefone.id ?? ''}'), onTap: () {
          _detalharPessoaTelefone(widget.pessoa, pessoaTelefone, context);
        }),
        DataCell(Text('${pessoaTelefone.pessoa?.nome ?? ''}'), onTap: () {
          _detalharPessoaTelefone(widget.pessoa, pessoaTelefone, context);
        }),
        DataCell(Text('${pessoaTelefone.tipo ?? ''}'), onTap: () {
          _detalharPessoaTelefone(widget.pessoa, pessoaTelefone, context);
        }),
        DataCell(Text('${pessoaTelefone.numero ?? ''}'), onTap: () {
          _detalharPessoaTelefone(widget.pessoa, pessoaTelefone, context);
        }),
      ];

      lista.add(DataRow(cells: _celulas));
    }
    return lista;
  }

  void _detalharPessoaTelefone(Pessoa pessoa, PessoaTelefone pessoaTelefone, BuildContext context) {
        Navigator.of(context)
          .push(MaterialPageRoute(
            builder: (BuildContext context) => PessoaTelefonePersistePage(
              pessoa: pessoa,
              pessoaTelefone: pessoaTelefone,
			  title: "Pessoa Telefone - Editando",
			  operacao: "A"
			)))
          .then((_) {
            setState(() {
              _getRows();
            });
          });
  }
  
}