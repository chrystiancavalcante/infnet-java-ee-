/*
Title: ERP INFNET                                                                
Description: ViewModel relacionado à tabela [TRANSPORTADORA] 
                                                                                
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
import 'dart:typed_data';

import 'package:infnet/src/infra/locator.dart';
import 'package:infnet/src/model/model.dart';
import 'package:infnet/src/model/filtro.dart';
import 'package:infnet/src/model/retorno_json_erro.dart';
import 'package:infnet/src/service/service.dart';

class TransportadoraViewModel extends ChangeNotifier {
  TransportadoraService _transportadoraService = locator<TransportadoraService>();
  List<Transportadora> listaTransportadora;
  Transportadora transportadora;
  RetornoJsonErro objetoJsonErro;

  TransportadoraViewModel();

  Future<List<Transportadora>> consultarLista({Filtro filtro}) async {
    listaTransportadora = await _transportadoraService.consultarLista(filtro: filtro);
    if (listaTransportadora == null) {
      objetoJsonErro = _transportadoraService.objetoJsonErro;
    }
    notifyListeners();
    return listaTransportadora;
  }

  Future<Transportadora> consultarObjeto(int id) async {
    transportadora = await _transportadoraService.consultarObjeto(id);
    if (transportadora == null) {
      objetoJsonErro = _transportadoraService.objetoJsonErro;
    }
    notifyListeners();
    return transportadora;
  }

  Future<Transportadora> inserir(Transportadora transportadora) async {
    var result = await _transportadoraService.inserir(transportadora);
    if (result == null) {
      objetoJsonErro = _transportadoraService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<Transportadora> alterar(Transportadora transportadora) async {
    var result = await _transportadoraService.alterar(transportadora);
    if (result == null) {
      objetoJsonErro = _transportadoraService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<bool> excluir(int id) async {
    var result = await _transportadoraService.excluir(id);
    if (result == false) {
      objetoJsonErro = _transportadoraService.objetoJsonErro;
      notifyListeners();
    } else {
      consultarLista();
    }
    return result;
  }
  
  Future<Uint8List> visualizarPdf({Filtro filtro}) async {
    var result = await _transportadoraService.visualizarPdf(filtro: filtro);
    if (result == null) {
      objetoJsonErro = _transportadoraService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<void> visualizarPdfWeb({Filtro filtro}) async {
    await _transportadoraService.visualizarPdfWeb(filtro: filtro);
  }
  
}