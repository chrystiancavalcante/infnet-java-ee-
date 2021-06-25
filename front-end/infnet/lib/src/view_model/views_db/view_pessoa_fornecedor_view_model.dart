/*
Title: ERP INFNET                                                                
Description: ViewModel relacionado à tabela [VIEW_PESSOA_FORNECEDOR] 
                                                                                
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

class ViewPessoaFornecedorViewModel extends ChangeNotifier {
  ViewPessoaFornecedorService _viewPessoaFornecedorService = locator<ViewPessoaFornecedorService>();
  List<ViewPessoaFornecedor> listaViewPessoaFornecedor;
  RetornoJsonErro objetoJsonErro;

  ViewPessoaFornecedorViewModel();

  Future<List<ViewPessoaFornecedor>> consultarLista({Filtro filtro}) async {
    listaViewPessoaFornecedor = await _viewPessoaFornecedorService.consultarLista(filtro: filtro);
    if (listaViewPessoaFornecedor == null) {
      objetoJsonErro = _viewPessoaFornecedorService.objetoJsonErro;
    }
    notifyListeners();
    return listaViewPessoaFornecedor;
  }

  Future<ViewPessoaFornecedor> consultarObjeto(int id) async {
    var result = await _viewPessoaFornecedorService.consultarObjeto(id);
    if (result == null) {
      objetoJsonErro = _viewPessoaFornecedorService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<ViewPessoaFornecedor> inserir(ViewPessoaFornecedor viewPessoaFornecedor) async {
    var result = await _viewPessoaFornecedorService.inserir(viewPessoaFornecedor);
    if (result == null) {
      objetoJsonErro = _viewPessoaFornecedorService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<ViewPessoaFornecedor> alterar(ViewPessoaFornecedor viewPessoaFornecedor) async {
    var result = await _viewPessoaFornecedorService.alterar(viewPessoaFornecedor);
    if (result == null) {
      objetoJsonErro = _viewPessoaFornecedorService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<bool> excluir(int id) async {
    var result = await _viewPessoaFornecedorService.excluir(id);
    if (result == false) {
      objetoJsonErro = _viewPessoaFornecedorService.objetoJsonErro;
      notifyListeners();
    } else {
      consultarLista();
    }
    return result;
  }
}