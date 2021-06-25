/*
Title: ERP INFNET                                                                
Description: ViewModel relacionado à tabela [VIEW_FIN_LANCAMENTO_RECEBER] 
                                                                                
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

import 'package:infnet/src/infra/locator.dart';
import 'package:infnet/src/model/model.dart';
import 'package:infnet/src/model/filtro.dart';
import 'package:infnet/src/model/retorno_json_erro.dart';
import 'package:infnet/src/service/service.dart';

class ViewFinLancamentoReceberViewModel extends ChangeNotifier {
  ViewFinLancamentoReceberService _viewFinLancamentoReceberService = locator<ViewFinLancamentoReceberService>();
  List<ViewFinLancamentoReceber> listaViewFinLancamentoReceber;
  ViewFinLancamentoReceber viewFinLancamentoReceber;
  RetornoJsonErro objetoJsonErro;

  ViewFinLancamentoReceberViewModel();

  Future<List<ViewFinLancamentoReceber>> consultarLista({Filtro filtro}) async {
    listaViewFinLancamentoReceber = await _viewFinLancamentoReceberService.consultarLista(filtro: filtro);
    if (listaViewFinLancamentoReceber == null) {
      objetoJsonErro = _viewFinLancamentoReceberService.objetoJsonErro;
    }
    notifyListeners();
    return listaViewFinLancamentoReceber;
  }

  Future<ViewFinLancamentoReceber> consultarObjeto(int id) async {
    viewFinLancamentoReceber = await _viewFinLancamentoReceberService.consultarObjeto(id);
    if (viewFinLancamentoReceber == null) {
      objetoJsonErro = _viewFinLancamentoReceberService.objetoJsonErro;
    }
    notifyListeners();
    return viewFinLancamentoReceber;
  }

  Future<ViewFinLancamentoReceber> inserir(ViewFinLancamentoReceber viewFinLancamentoReceber) async {
    var result = await _viewFinLancamentoReceberService.inserir(viewFinLancamentoReceber);
    if (result == null) {
      objetoJsonErro = _viewFinLancamentoReceberService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<ViewFinLancamentoReceber> alterar(ViewFinLancamentoReceber viewFinLancamentoReceber) async {
    var result = await _viewFinLancamentoReceberService.alterar(viewFinLancamentoReceber);
    if (result == null) {
      objetoJsonErro = _viewFinLancamentoReceberService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<bool> excluir(int id) async {
    var result = await _viewFinLancamentoReceberService.excluir(id);
    if (result == false) {
      objetoJsonErro = _viewFinLancamentoReceberService.objetoJsonErro;
      notifyListeners();
    } else {
      consultarLista();
    }
    return result;
  }
}