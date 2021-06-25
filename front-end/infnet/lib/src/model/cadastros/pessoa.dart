/*
Title: ERP INFNET                                                                
Description: Model relacionado à tabela [PESSOA] 
                                                                                
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

import 'package:infnet/src/model/model.dart';

class Pessoa {
	int id;
	String nome;
	String tipo;
	String site;
	String email;
	String ehCliente;
	String ehFornecedor;
	String ehTransportadora;
	String ehColaborador;
	String ehContador;
	Cliente cliente;
	Colaborador colaborador;
	Contador contador;
	Fornecedor fornecedor;
	PessoaFisica pessoaFisica;
	PessoaJuridica pessoaJuridica;
	Transportadora transportadora;
	List<PessoaContato> listaPessoaContato = [];
	List<PessoaEndereco> listaPessoaEndereco = [];
	List<PessoaTelefone> listaPessoaTelefone = [];

	Pessoa({
		this.id,
		this.nome,
    this.tipo = 'Física',
		this.site,
		this.email,
		this.ehCliente,
		this.ehFornecedor,
		this.ehTransportadora,
		this.ehColaborador,
		this.ehContador,
		this.cliente,
		this.colaborador,
		this.contador,
		this.fornecedor,
		this.pessoaFisica,
		this.pessoaJuridica,
		this.transportadora,
		this.listaPessoaContato,
		this.listaPessoaEndereco,
		this.listaPessoaTelefone,
	});

	static List<String> campos = <String>[
		'ID', 
		'NOME', 
		'TIPO', 
		'SITE', 
		'EMAIL', 
		'EH_CLIENTE', 
		'EH_FORNECEDOR', 
		'EH_TRANSPORTADORA', 
		'EH_COLABORADOR', 
		'EH_CONTADOR', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Nome', 
		'Tipo Pessoa', 
		'Site', 
		'EMail', 
		'É Cliente', 
		'É Fornecedor', 
		'É Transportadora', 
		'É Colaborador', 
		'É Contador', 
	];

	Pessoa.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		nome = jsonDados['nome'];
		tipo = getTipo(jsonDados['tipo']);
		site = jsonDados['site'];
		email = jsonDados['email'];
		ehCliente = getEhCliente(jsonDados['ehCliente']);
		ehFornecedor = getEhFornecedor(jsonDados['ehFornecedor']);
		ehTransportadora = getEhTransportadora(jsonDados['ehTransportadora']);
		ehColaborador = getEhColaborador(jsonDados['ehColaborador']);
		ehContador = getEhContador(jsonDados['ehContador']);
		cliente = jsonDados['cliente'] == null ? null : new Cliente.fromJson(jsonDados['cliente']);
		colaborador = jsonDados['colaborador'] == null ? null : new Colaborador.fromJson(jsonDados['colaborador']);
		contador = jsonDados['contador'] == null ? null : new Contador.fromJson(jsonDados['contador']);
		fornecedor = jsonDados['fornecedor'] == null ? null : new Fornecedor.fromJson(jsonDados['fornecedor']);
		pessoaFisica = jsonDados['pessoaFisica'] == null ? null : new PessoaFisica.fromJson(jsonDados['pessoaFisica']);
		pessoaJuridica = jsonDados['pessoaJuridica'] == null ? null : new PessoaJuridica.fromJson(jsonDados['pessoaJuridica']);
		transportadora = jsonDados['transportadora'] == null ? null : new Transportadora.fromJson(jsonDados['transportadora']);
		listaPessoaContato = (jsonDados['listaPessoaContato'] as Iterable)?.map((m) => PessoaContato.fromJson(m))?.toList() ?? [];
		listaPessoaEndereco = (jsonDados['listaPessoaEndereco'] as Iterable)?.map((m) => PessoaEndereco.fromJson(m))?.toList() ?? [];
		listaPessoaTelefone = (jsonDados['listaPessoaTelefone'] as Iterable)?.map((m) => PessoaTelefone.fromJson(m))?.toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['nome'] = this.nome;
		jsonDados['tipo'] = setTipo(this.tipo);
		jsonDados['site'] = this.site;
		jsonDados['email'] = this.email;
		jsonDados['ehCliente'] = setEhCliente(this.ehCliente);
		jsonDados['ehFornecedor'] = setEhFornecedor(this.ehFornecedor);
		jsonDados['ehTransportadora'] = setEhTransportadora(this.ehTransportadora);
		jsonDados['ehColaborador'] = setEhColaborador(this.ehColaborador);
		jsonDados['ehContador'] = setEhContador(this.ehContador);
		jsonDados['cliente'] = this.cliente == null ? null : this.cliente.toJson;
		jsonDados['colaborador'] = this.colaborador == null ? null : this.colaborador.toJson;
		jsonDados['contador'] = this.contador == null ? null : this.contador.toJson;
		jsonDados['fornecedor'] = this.fornecedor == null ? null : this.fornecedor.toJson;
		jsonDados['pessoaFisica'] = this.pessoaFisica == null ? null : this.pessoaFisica.toJson;
		jsonDados['pessoaJuridica'] = this.pessoaJuridica == null ? null : this.pessoaJuridica.toJson;
		jsonDados['transportadora'] = this.transportadora == null ? null : this.transportadora.toJson;
		

		var listaPessoaContatoLocal = [];
		for (PessoaContato objeto in this.listaPessoaContato ?? []) {
			listaPessoaContatoLocal.add(objeto.toJson);
		}
		jsonDados['listaPessoaContato'] = listaPessoaContatoLocal;
		

		var listaPessoaEnderecoLocal = [];
		for (PessoaEndereco objeto in this.listaPessoaEndereco ?? []) {
			listaPessoaEnderecoLocal.add(objeto.toJson);
		}
		jsonDados['listaPessoaEndereco'] = listaPessoaEnderecoLocal;
		

		var listaPessoaTelefoneLocal = [];
		for (PessoaTelefone objeto in this.listaPessoaTelefone ?? []) {
			listaPessoaTelefoneLocal.add(objeto.toJson);
		}
		jsonDados['listaPessoaTelefone'] = listaPessoaTelefoneLocal;
	
		return jsonDados;
	}
	
    getTipo(String tipo) {
    	switch (tipo) {
    		case 'F':
    			return 'Física';
    			break;
    		case 'J':
    			return 'Jurídica';
    			break;
    		default:
    			return null;
    		}
    	}

    setTipo(String tipo) {
    	switch (tipo) {
    		case 'Física':
    			return 'F';
    			break;
    		case 'Jurídica':
    			return 'J';
    			break;
    		default:
    			return null;
    		}
    	}

    getEhCliente(String ehCliente) {
    	switch (ehCliente) {
    		case 'S':
    			return 'Sim';
    			break;
    		case 'N':
    			return 'Não';
    			break;
    		default:
    			return null;
    		}
    	}

    setEhCliente(String ehCliente) {
    	switch (ehCliente) {
    		case 'Sim':
    			return 'S';
    			break;
    		case 'Não':
    			return 'N';
    			break;
    		default:
    			return null;
    		}
    	}

    getEhFornecedor(String ehFornecedor) {
    	switch (ehFornecedor) {
    		case 'S':
    			return 'Sim';
    			break;
    		case 'N':
    			return 'Não';
    			break;
    		default:
    			return null;
    		}
    	}

    setEhFornecedor(String ehFornecedor) {
    	switch (ehFornecedor) {
    		case 'Sim':
    			return 'S';
    			break;
    		case 'Não':
    			return 'N';
    			break;
    		default:
    			return null;
    		}
    	}

    getEhTransportadora(String ehTransportadora) {
    	switch (ehTransportadora) {
    		case 'S':
    			return 'Sim';
    			break;
    		case 'N':
    			return 'Não';
    			break;
    		default:
    			return null;
    		}
    	}

    setEhTransportadora(String ehTransportadora) {
    	switch (ehTransportadora) {
    		case 'Sim':
    			return 'S';
    			break;
    		case 'Não':
    			return 'N';
    			break;
    		default:
    			return null;
    		}
    	}

    getEhColaborador(String ehColaborador) {
    	switch (ehColaborador) {
    		case 'S':
    			return 'Sim';
    			break;
    		case 'N':
    			return 'Não';
    			break;
    		default:
    			return null;
    		}
    	}

    setEhColaborador(String ehColaborador) {
    	switch (ehColaborador) {
    		case 'Sim':
    			return 'S';
    			break;
    		case 'Não':
    			return 'N';
    			break;
    		default:
    			return null;
    		}
    	}

    getEhContador(String ehContador) {
    	switch (ehContador) {
    		case 'S':
    			return 'Sim';
    			break;
    		case 'N':
    			return 'Não';
    			break;
    		default:
    			return null;
    		}
    	}

    setEhContador(String ehContador) {
    	switch (ehContador) {
    		case 'Sim':
    			return 'S';
    			break;
    		case 'Não':
    			return 'N';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(Pessoa objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}