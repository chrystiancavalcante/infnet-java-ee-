/*
Title: ERP INFNET                                                                
Description: Menu interno para o módulo vendas
                                                                                
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

Based on: Flutter UIKit by Pawan Kumar - https://github.com/iampawan/Flutter-UI-Kit
*******************************************************************************/
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:infnet/src/infra/constantes.dart';
import 'package:infnet/src/view/menu/menu_lateral_retaguarda.dart';
import 'package:infnet/src/view/shared/custom_background.dart';
import 'package:infnet/src/view/shared/profile_tile.dart';

import 'package:infnet/src/view/menu/menu_interno_botoes.dart';
import 'package:infnet/src/view/menu/menu_titulo_grupo_menu_interno.dart';

class MenuVendas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constantes.menuVendasString),
        backgroundColor: Colors.black87,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: 'Abre o menu de navegação',
            );
          },
        ),
      ),
      drawer: MenuLateralRetaguarda(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomBackground(
            showIcon: false,
          ),
          allCards(context),
        ],
      ),
    );
  }

  Size tamanhoDoDispositivo(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  Widget allCards(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            appBarColumn(context),
            SizedBox(
              height: tamanhoDoDispositivo(context).height * 0.01,
            ),
            actionMenuGrupoCadastros(),
            SizedBox(
              height: tamanhoDoDispositivo(context).height * 0.01,
            ),
            actionMenuGrupoMovimento(),
            SizedBox(
              height: tamanhoDoDispositivo(context).height * 0.01,
            ),
            cardAvisos(),
          ],
        ),
      );

  Widget appBarColumn(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 18.0),
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new ProfileTile(
                    title: "Olá, Albert Eije",
                    subtitle: "Bem Vindo ao Módulo Vendas",
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget actionMenuGrupoCadastros() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  MenuTituloGrupoMenuInterno(titulo: "Cadastros - Vendas"),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.solidUser,
                        label: "Modelo NF",
                        circleColor: Colors.blue,
                        rota: "/notaFiscalModeloLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.addressCard,
                        label: "Tipo NF",
                        circleColor: Colors.orange,
                        rota: "/notaFiscalTipoLista"),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.addressCard,
                        label: "Condições Pagamento",
                        circleColor: Colors.orange,
                        rota: "/vendaCondicoesPagamentoLista"),
                    quartoBotao: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget actionMenuGrupoMovimento() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          color: Colors.amber[50],
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  MenuTituloGrupoMenuInterno(titulo: "Movimento"),
                  MenuInternoBotoes(
                    primeiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.tags,
                        label: "Orçamento",
                        circleColor: Colors.blue,
                        rota: "/vendaOrcamentoCabecalhoLista"),
                    segundoBotao: BotaoMenu(
                        icon: FontAwesomeIcons.archive,
                        label: "Venda",
                        circleColor: Colors.orange,
                        rota: "/vendaCabecalhoLista"),
                    terceiroBotao: BotaoMenu(
                        icon: FontAwesomeIcons.archive,
                        label: "Frete",
                        circleColor: Colors.orange,
                        rota: "/vendaFreteLista"),
                    quartoBotao: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget cardAvisos() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 2.0,
          color: Colors.blueGrey[50],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  MenuTituloGrupoMenuInterno(titulo: "Avisos e Alertas"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(),
                      Text(
                        "Nenhum aviso para ser exibido no momento",
                        style: TextStyle(fontFamily: Constantes.ralewayFont),
                      ),
                      Divider(),
                      Text(
                        "---",
                        style: TextStyle(
                            fontFamily: Constantes.ralewayFont,
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
                            fontSize: 25.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}