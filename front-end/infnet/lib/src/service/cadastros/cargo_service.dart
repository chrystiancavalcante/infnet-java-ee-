/*
Title: ERP INFNET                                                                
Description: Service relacionado à tabela [CARGO] 
                                                                                
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
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' show Client;

import 'package:infnet/src/service/service_base.dart';
import 'package:infnet/src/model/filtro.dart';
import 'package:infnet/src/model/model.dart';

/// classe responsável por requisições ao servidor REST
class CargoService extends ServiceBase {
  var clienteHTTP = Client();

  Future<List<Cargo>> consultarLista({Filtro filtro}) async {
    List<Cargo> listaCargo = [];

    try {
      tratarFiltro(filtro, '/cargo/');
	  	
      final response = await clienteHTTP.get(Uri.tryParse(url), headers: ServiceBase.cabecalhoRequisicao);

      if (response.statusCode == 200) {
        if (response.headers["content-type"].contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          var parsed = json.decode(response.body) as List<dynamic>;
          for (var cargo in parsed) {
            listaCargo.add(Cargo.fromJson(cargo));
          }
          return listaCargo;
        }
      } else {
        tratarRetornoErro(response.body, response.headers);
        return null;
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
    }
    return null;
  }

  Future<Cargo> consultarObjeto(int id) async {
    try {
      final response = await clienteHTTP.get(Uri.tryParse('$endpoint/cargo/$id'), headers: ServiceBase.cabecalhoRequisicao);

      if (response.statusCode == 200) {
        if (response.headers["content-type"].contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          var cargoJson = json.decode(response.body);
          return Cargo.fromJson(cargoJson);
        }
      } else {
        tratarRetornoErro(response.body, response.headers);
        return null;
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
    }
    return null;
  }

  Future<Cargo> inserir(Cargo cargo) async {
    try {
      final response = await clienteHTTP.post(
        Uri.tryParse('$endpoint/cargo'),
        headers: ServiceBase.cabecalhoRequisicao,
        body: cargo.objetoEncodeJson(cargo),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.headers["content-type"].contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          var cargoJson = json.decode(response.body);
          return Cargo.fromJson(cargoJson);
        }
      } else {
        tratarRetornoErro(response.body, response.headers);
        return null;
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
    }
    return null;
  }

  Future<Cargo> alterar(Cargo cargo) async {
    try {
      var id = cargo.id;
      final response = await clienteHTTP.put(
        Uri.tryParse('$endpoint/cargo/$id'),
        headers: ServiceBase.cabecalhoRequisicao,
        body: cargo.objetoEncodeJson(cargo),
      );

      if (response.statusCode == 200) {
        if (response.headers["content-type"].contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          var cargoJson = json.decode(response.body);
          return Cargo.fromJson(cargoJson);
        }
      } else {
        tratarRetornoErro(response.body, response.headers);
        return null;
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
    }
    return null;
  }

  Future<bool> excluir(int id) async {
    try {
      final response = await clienteHTTP.delete(
        Uri.tryParse('$endpoint/cargo/$id'),
        headers: ServiceBase.cabecalhoRequisicao,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        tratarRetornoErro(response.body, response.headers);
        return null;
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
    }
    return null;
  }
  
  Future<Uint8List> visualizarPdf({Filtro filtro}) async {
    try {
      tratarFiltroRelatorio(filtro, 'Cargo');
      final response = await clienteHTTP.get(Uri.tryParse(urlRelatorios));
      if (response.statusCode == 200) {
        if (response.headers["content-type"].contains("html")) {
          tratarRetornoErro(response.body, response.headers);
          return null;
        } else {
          final pdf = response.bodyBytes;
          return pdf;        
        }
      } else {
        tratarRetornoErro(response.body, response.headers);
        return null;
      }
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
    }
    return null;
  }

  Future<void> visualizarPdfWeb({Filtro filtro}) async {
    try {
      tratarFiltroRelatorio(filtro, 'Cargo');
      visualizarRelatorioPdfWeb(filtro, 'Relatório Cargo');
    } on Exception catch (e) {
      tratarRetornoErro(null, null, exception: e);
    }
  }
  
}