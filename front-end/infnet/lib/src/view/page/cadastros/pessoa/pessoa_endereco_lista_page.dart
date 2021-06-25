/*
Title: ERP INFNET                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [PESSOA_ENDERECO] 
                                                                                
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


//import 'pessoa_endereco_detalhe_page.dart';
import 'pessoa_endereco_persiste_page.dart';

class PessoaEnderecoListaPage extends StatefulWidget {
  final Pessoa pessoa;
  final FocusNode foco;
  final Function salvarPessoaCallBack;

  const PessoaEnderecoListaPage({Key key, this.pessoa, this.foco, this.salvarPessoaCallBack}) : super(key: key);

  @override
  _PessoaEnderecoListaPageState createState() => _PessoaEnderecoListaPageState();
}

class _PessoaEnderecoListaPageState extends State<PessoaEnderecoListaPage> {
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
    var _pessoaEndereco = PessoaEndereco();
    widget.pessoa.listaPessoaEndereco.add(_pessoaEndereco);
    Navigator.of(context)
      .push(MaterialPageRoute(
        builder: (BuildContext context) =>
          PessoaEnderecoPersistePage(
            pessoa: widget.pessoa,
            pessoaEndereco: _pessoaEndereco,
            title: 'Pessoa Endereco - Inserindo',
            operacao: 'I')))
      .then((_) {
        setState(() {
          if (_pessoaEndereco.cep == null) { // se esse atributo estiver vazio, o objeto será removido
            widget.pessoa.listaPessoaEndereco.remove(_pessoaEndereco);
          }
          _getRows();
        });
      });
  }
  
  List<DataColumn> _getColumns() {
    List<DataColumn> lista = [];
    lista.add(DataColumn(numeric: true, label: Text('Id')));
    lista.add(DataColumn(label: Text('Id Pessoa')));
    lista.add(DataColumn(label: Text('Logradouro')));
    lista.add(DataColumn(label: Text('Numero')));
    lista.add(DataColumn(label: Text('Bairro')));
    lista.add(DataColumn(numeric: true, label: Text('Municipio Ibge')));
    lista.add(DataColumn(label: Text('Uf')));
    lista.add(DataColumn(label: Text('Cep')));
    lista.add(DataColumn(label: Text('Cidade')));
    lista.add(DataColumn(label: Text('Complemento')));
    lista.add(DataColumn(label: Text('Principal')));
    lista.add(DataColumn(label: Text('Entrega')));
    lista.add(DataColumn(label: Text('Cobranca')));
    lista.add(DataColumn(label: Text('Correspondencia')));
    return lista;
  }

  List<DataRow> _getRows() {
    if (widget.pessoa.listaPessoaEndereco == null) {
      widget.pessoa.listaPessoaEndereco = [];
    }
    List<DataRow> lista = [];
    for (var pessoaEndereco in widget.pessoa.listaPessoaEndereco) {
      List<DataCell> _celulas = [];

      _celulas = [
        DataCell(Text('${ pessoaEndereco.id ?? ''}'), onTap: () {
          _detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
        }),
        DataCell(Text('${pessoaEndereco.pessoa?.nome ?? ''}'), onTap: () {
          _detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
        }),
        DataCell(Text('${pessoaEndereco.logradouro ?? ''}'), onTap: () {
          _detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
        }),
        DataCell(Text('${pessoaEndereco.numero ?? ''}'), onTap: () {
          _detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
        }),
        DataCell(Text('${pessoaEndereco.bairro ?? ''}'), onTap: () {
          _detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
        }),
        DataCell(Text('${pessoaEndereco.municipioIbge ?? ''}'), onTap: () {
          _detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
        }),
        DataCell(Text('${pessoaEndereco.uf ?? ''}'), onTap: () {
          _detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
        }),
        DataCell(Text('${pessoaEndereco.cep ?? ''}'), onTap: () {
          _detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
        }),
        DataCell(Text('${pessoaEndereco.cidade ?? ''}'), onTap: () {
          _detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
        }),
        DataCell(Text('${pessoaEndereco.complemento ?? ''}'), onTap: () {
          _detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
        }),
        DataCell(Text('${pessoaEndereco.principal ?? ''}'), onTap: () {
          _detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
        }),
        DataCell(Text('${pessoaEndereco.entrega ?? ''}'), onTap: () {
          _detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
        }),
        DataCell(Text('${pessoaEndereco.cobranca ?? ''}'), onTap: () {
          _detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
        }),
        DataCell(Text('${pessoaEndereco.correspondencia ?? ''}'), onTap: () {
          _detalharPessoaEndereco(widget.pessoa, pessoaEndereco, context);
        }),
      ];

      lista.add(DataRow(cells: _celulas));
    }
    return lista;
  }

  void _detalharPessoaEndereco(Pessoa pessoa, PessoaEndereco pessoaEndereco, BuildContext context) {
        Navigator.of(context)
          .push(MaterialPageRoute(
            builder: (BuildContext context) => PessoaEnderecoPersistePage(
              pessoa: pessoa,
              pessoaEndereco: pessoaEndereco,
			  title: "Pessoa Endereco - Editando",
			  operacao: "A"
			)))
          .then((_) {
            setState(() {
              _getRows();
            });
          });
  }
  
}