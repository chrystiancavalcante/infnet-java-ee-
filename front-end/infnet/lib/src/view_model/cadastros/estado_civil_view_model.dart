/*
Title: ERP INFNET                                                                
Description: ViewModel relacionado à tabela [ESTADO_CIVIL] 
                                                                                
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

class EstadoCivilViewModel extends ChangeNotifier {
  EstadoCivilService _estadoCivilService = locator<EstadoCivilService>();
  List<EstadoCivil> listaEstadoCivil;
  EstadoCivil estadoCivil;
  RetornoJsonErro objetoJsonErro;

  EstadoCivilViewModel();

  Future<List<EstadoCivil>> consultarLista({Filtro filtro}) async {
    listaEstadoCivil = await _estadoCivilService.consultarLista(filtro: filtro);
    if (listaEstadoCivil == null) {
      objetoJsonErro = _estadoCivilService.objetoJsonErro;
    }
    notifyListeners();
    return listaEstadoCivil;
  }

  Future<EstadoCivil> consultarObjeto(int id) async {
    estadoCivil = await _estadoCivilService.consultarObjeto(id);
    if (estadoCivil == null) {
      objetoJsonErro = _estadoCivilService.objetoJsonErro;
    }
    notifyListeners();
    return estadoCivil;
  }

  Future<EstadoCivil> inserir(EstadoCivil estadoCivil) async {
    var result = await _estadoCivilService.inserir(estadoCivil);
    if (result == null) {
      objetoJsonErro = _estadoCivilService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<EstadoCivil> alterar(EstadoCivil estadoCivil) async {
    var result = await _estadoCivilService.alterar(estadoCivil);
    if (result == null) {
      objetoJsonErro = _estadoCivilService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<bool> excluir(int id) async {
    var result = await _estadoCivilService.excluir(id);
    if (result == false) {
      objetoJsonErro = _estadoCivilService.objetoJsonErro;
      notifyListeners();
    } else {
      consultarLista();
    }
    return result;
  }
  
  Future<Uint8List> visualizarPdf({Filtro filtro}) async {
    var result = await _estadoCivilService.visualizarPdf(filtro: filtro);
    if (result == null) {
      objetoJsonErro = _estadoCivilService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<void> visualizarPdfWeb({Filtro filtro}) async {
    await _estadoCivilService.visualizarPdfWeb(filtro: filtro);
  }
  
}