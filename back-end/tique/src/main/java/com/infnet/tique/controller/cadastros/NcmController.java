/*******************************************************************************
Title: Trabalho de bloco Infnet                                                                
Description: Controller relacionado à tabela [NCM] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 chrystiancavalcante@gmail.com                                         
                                                                                
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
           chrystiancavalcante@gmail.com                                                   
                                                                                
@author Chrystian Cavalcante (chrystiancavalcante@gmail.com)                    
@version 1.0.0
*******************************************************************************/
package com.infnet.tique.controller.cadastros;

import java.util.List;
import java.util.NoSuchElementException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.infnet.tique.exception.ExcecaoGenericaServidorException;
import com.infnet.tique.exception.RecursoNaoEncontradoException;
import com.infnet.tique.exception.RequisicaoRuimException;
import com.infnet.tique.model.cadastros.Ncm;
import com.infnet.tique.model.transiente.Filtro;
import com.infnet.tique.service.cadastros.NcmService;

@RestController
@RequestMapping(value = "/ncm", produces = "application/json;charset=UTF-8")
public class NcmController {

	@Autowired
	private NcmService service;

	@GetMapping
	public List<Ncm> consultarLista(@RequestParam(required = false) String filter) {
		try {
			if (filter == null) {
				return service.consultarLista();
			} else {
				// define o filtro
				Filtro filtro = new Filtro(filter);
				return service.consultarLista(filtro);
			}
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Consultar Lista Ncm] - Exceção: " + e.getMessage());
		}
	}

	@GetMapping("/{id}")
	public Ncm consultarObjeto(@PathVariable Integer id) {
		try {
			try {
				return service.consultarObjeto(id);
			} catch (NoSuchElementException e) {
				throw new RecursoNaoEncontradoException("Registro não localizado [Consultar Objeto Ncm].");
			}
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException(
					"Erro no Servidor [Consultar Objeto Ncm] - Exceção: " + e.getMessage());
		}
	}

	@PostMapping
	public Ncm inserir(@RequestBody Ncm objJson) {
		try {
			return service.salvar(objJson);
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Inserir Ncm] - Exceção: " + e.getMessage());
		}
	}

	@PutMapping("/{id}")
	public Ncm alterar(@RequestBody Ncm objJson, @PathVariable Integer id) {
		try {
			if (!objJson.getId().equals(id)) {
				throw new RequisicaoRuimException("Objeto inválido [Alterar Ncm] - ID do objeto difere do ID da URL.");
			}

			Ncm objeto = service.consultarObjeto(objJson.getId());
			if (objeto != null) {
				return service.salvar(objJson);
			} else {
				throw new RequisicaoRuimException("Objeto com ID inválido [Alterar Ncm].");
			}
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Alterar Ncm] - Exceção: " + e.getMessage());
		}
	}

	@DeleteMapping("/{id}")
	public void excluir(@PathVariable Integer id) {
		try {
			service.excluir(id);
		} catch (Exception e) {
			throw new ExcecaoGenericaServidorException("Erro no Servidor [Excluir Ncm] - Exceção: " + e.getMessage());
		}
	}

}