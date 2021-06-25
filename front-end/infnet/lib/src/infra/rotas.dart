/*
Title: ERP INFNET                                                                
Description: Define as rotas da aplicação
                                                                                
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

//import 'package:infnet/src/view/menu/home_page.dart';
// import 'package:infnet/src/view/login/login_page.dart';
import 'package:infnet/src/view/menu/menu_cadastros.dart';


// import 'package:infnet/src/model/model.dart';
import 'package:infnet/src/view/page/page.dart';

class Rotas {
  static Route<dynamic> definirRotas(RouteSettings settings) {
    switch (settings.name) {
      
      // Login
      case '/':
        return MaterialPageRoute(builder: (_) => MenuCadastros());//HomePage());//LoginPage());

      // Home
      case '/home':
        return MaterialPageRoute(builder: (_) => MenuCadastros());//HomePage());

      // Menus
      case '/cadastrosMenu':
        return MaterialPageRoute(builder: (_) => MenuCadastros());
     
		
      ////////////////////////////////////////////////////////// 
      /// CADASTROS
      //////////////////////////////////////////////////////////

      // Banco
      case '/bancoLista':
        return MaterialPageRoute(builder: (_) => BancoListaPage());
      case '/bancoPersiste':
        return MaterialPageRoute(builder: (_) => BancoPersistePage());

      // BancoAgencia
      case '/bancoAgenciaLista':
        return MaterialPageRoute(builder: (_) => BancoAgenciaListaPage());
      case '/bancoAgenciaPersiste':
        return MaterialPageRoute(builder: (_) => BancoAgenciaPersistePage());

      // Pessoa
      case '/pessoaLista':
        return MaterialPageRoute(builder: (_) => PessoaListaPage());
      case '/pessoaPersiste':
        return MaterialPageRoute(builder: (_) => PessoaPersistePage());

      // Produto
      case '/produtoLista':
        return MaterialPageRoute(builder: (_) => ProdutoListaPage());
      case '/produtoPersiste':
        return MaterialPageRoute(builder: (_) => ProdutoPersistePage());

			// BancoContaCaixa
			case '/bancoContaCaixaLista':
			  return MaterialPageRoute(builder: (_) => BancoContaCaixaListaPage());
			case '/bancoContaCaixaPersiste':
			  return MaterialPageRoute(builder: (_) => BancoContaCaixaPersistePage());

			// Cargo
			case '/cargoLista':
			  return MaterialPageRoute(builder: (_) => CargoListaPage());
			case '/cargoPersiste':
			  return MaterialPageRoute(builder: (_) => CargoPersistePage());

			// Cep
			case '/cepLista':
			  return MaterialPageRoute(builder: (_) => CepListaPage());
			case '/cepPersiste':
			  return MaterialPageRoute(builder: (_) => CepPersistePage());

			// Cfop
			case '/cfopLista':
			  return MaterialPageRoute(builder: (_) => CfopListaPage());
			case '/cfopPersiste':
			  return MaterialPageRoute(builder: (_) => CfopPersistePage());
			
			// Cnae
			case '/cnaeLista':
			  return MaterialPageRoute(builder: (_) => CnaeListaPage());
			case '/cnaePersiste':
			  return MaterialPageRoute(builder: (_) => CnaePersistePage());

			// Setor
			case '/setorLista':
			  return MaterialPageRoute(builder: (_) => SetorListaPage());
			case '/setorPersiste':
			  return MaterialPageRoute(builder: (_) => SetorPersistePage());
			  			
			// Csosn
			case '/csosnLista':
			  return MaterialPageRoute(builder: (_) => CsosnListaPage());
			case '/csosnPersiste':
			  return MaterialPageRoute(builder: (_) => CsosnPersistePage());
			
			// CstCofins
			case '/cstCofinsLista':
			  return MaterialPageRoute(builder: (_) => CstCofinsListaPage());
			case '/cstCofinsPersiste':
			  return MaterialPageRoute(builder: (_) => CstCofinsPersistePage());
			
			// CstIcms
			case '/cstIcmsLista':
			  return MaterialPageRoute(builder: (_) => CstIcmsListaPage());
			case '/cstIcmsPersiste':
			  return MaterialPageRoute(builder: (_) => CstIcmsPersistePage());
			
			// CstIpi
			case '/cstIpiLista':
			  return MaterialPageRoute(builder: (_) => CstIpiListaPage());
			case '/cstIpiPersiste':
			  return MaterialPageRoute(builder: (_) => CstIpiPersistePage());
			
			// CstPis
			case '/cstPisLista':
			  return MaterialPageRoute(builder: (_) => CstPisListaPage());
			case '/cstPisPersiste':
			  return MaterialPageRoute(builder: (_) => CstPisPersistePage());

			// EstadoCivil
			case '/estadoCivilLista':
			  return MaterialPageRoute(builder: (_) => EstadoCivilListaPage());
			case '/estadoCivilPersiste':
			  return MaterialPageRoute(builder: (_) => EstadoCivilPersistePage());
						
			// Municipio
			case '/municipioLista':
			  return MaterialPageRoute(builder: (_) => MunicipioListaPage());
			case '/municipioPersiste':
			  return MaterialPageRoute(builder: (_) => MunicipioPersistePage());
			
			// Ncm
			case '/ncmLista':
			  return MaterialPageRoute(builder: (_) => NcmListaPage());
			case '/ncmPersiste':
			  return MaterialPageRoute(builder: (_) => NcmPersistePage());
			
			// NivelFormacao
			case '/nivelFormacaoLista':
			  return MaterialPageRoute(builder: (_) => NivelFormacaoListaPage());
			case '/nivelFormacaoPersiste':
			  return MaterialPageRoute(builder: (_) => NivelFormacaoPersistePage());
									
			// Uf
			case '/ufLista':
			  return MaterialPageRoute(builder: (_) => UfListaPage());
			case '/ufPersiste':
			  return MaterialPageRoute(builder: (_) => UfPersistePage());
						
			// ProdutoGrupo
			case '/produtoGrupoLista':
			  return MaterialPageRoute(builder: (_) => ProdutoGrupoListaPage());
			case '/produtoGrupoPersiste':
			  return MaterialPageRoute(builder: (_) => ProdutoGrupoPersistePage());
			
			// ProdutoMarca
			case '/produtoMarcaLista':
			  return MaterialPageRoute(builder: (_) => ProdutoMarcaListaPage());
			case '/produtoMarcaPersiste':
			  return MaterialPageRoute(builder: (_) => ProdutoMarcaPersistePage());
			
			// ProdutoSubgrupo
			case '/produtoSubgrupoLista':
			  return MaterialPageRoute(builder: (_) => ProdutoSubgrupoListaPage());
			case '/produtoSubgrupoPersiste':
			  return MaterialPageRoute(builder: (_) => ProdutoSubgrupoPersistePage());
			
			// ProdutoUnidade
			case '/produtoUnidadeLista':
			  return MaterialPageRoute(builder: (_) => ProdutoUnidadeListaPage());
			case '/produtoUnidadePersiste':
			  return MaterialPageRoute(builder: (_) => ProdutoUnidadePersistePage());

		
      // default
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
              body: Center(
            child: Text('Nenhuma rota definida para {$settings.name}'),
          )),
        );
    }
  }
}
