/*
Title: ERP INFNET                                                                
Description: Model relacionado à tabela [SINDICATO] 
                                                                                
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

import 'package:intl/intl.dart';

class Sindicato {
	int id;
	String nome;
	int codigoBanco;
	int codigoAgencia;
	String contaBanco;
	String codigoCedente;
	String logradouro;
	String numero;
	String bairro;
	int municipioIbge;
	String uf;
	String fone1;
	String fone2;
	String email;
	String tipoSindicato;
	DateTime dataBase;
	double pisoSalarial;
	String cnpj;
	String classificacaoContabilConta;

	Sindicato({
		this.id,
		this.nome,
		this.codigoBanco,
		this.codigoAgencia,
		this.contaBanco,
		this.codigoCedente,
		this.logradouro,
		this.numero,
		this.bairro,
		this.municipioIbge,
		this.uf,
		this.fone1,
		this.fone2,
		this.email,
		this.tipoSindicato,
		this.dataBase,
		this.pisoSalarial = 0.0,
		this.cnpj,
		this.classificacaoContabilConta,
	});

	static List<String> campos = <String>[
		'ID', 
		'NOME', 
		'CODIGO_BANCO', 
		'CODIGO_AGENCIA', 
		'CONTA_BANCO', 
		'CODIGO_CEDENTE', 
		'LOGRADOURO', 
		'NUMERO', 
		'BAIRRO', 
		'MUNICIPIO_IBGE', 
		'UF', 
		'FONE1', 
		'FONE2', 
		'EMAIL', 
		'TIPO_SINDICATO', 
		'DATA_BASE', 
		'PISO_SALARIAL', 
		'CNPJ', 
		'CLASSIFICACAO_CONTABIL_CONTA', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Nome', 
		'Codigo Banco', 
		'Codigo Agencia', 
		'Conta Banco', 
		'Codigo Cedente', 
		'Logradouro', 
		'Numero', 
		'Bairro', 
		'Municipio Ibge', 
		'Uf', 
		'Fone 1', 
		'Fone 2', 
		'Email', 
		'Tipo Sindicato', 
		'Data Base', 
		'Piso Salarial', 
		'Cnpj', 
		'Classificacao Contabil Conta', 
	];

	Sindicato.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		nome = jsonDados['nome'];
		codigoBanco = jsonDados['codigoBanco'];
		codigoAgencia = jsonDados['codigoAgencia'];
		contaBanco = jsonDados['contaBanco'];
		codigoCedente = jsonDados['codigoCedente'];
		logradouro = jsonDados['logradouro'];
		numero = jsonDados['numero'];
		bairro = jsonDados['bairro'];
		municipioIbge = jsonDados['municipioIbge'];
		uf = jsonDados['uf'];
		fone1 = jsonDados['fone1'];
		fone2 = jsonDados['fone2'];
		email = jsonDados['email'];
		tipoSindicato = jsonDados['tipoSindicato'];
		dataBase = jsonDados['dataBase'] != null ? DateTime.tryParse(jsonDados['dataBase']) : null;
		pisoSalarial = jsonDados['pisoSalarial'] != null ? jsonDados['pisoSalarial'].toDouble() : null;
		cnpj = jsonDados['cnpj'];
		classificacaoContabilConta = jsonDados['classificacaoContabilConta'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['nome'] = this.nome;
		jsonDados['codigoBanco'] = this.codigoBanco ?? 0;
		jsonDados['codigoAgencia'] = this.codigoAgencia ?? 0;
		jsonDados['contaBanco'] = this.contaBanco;
		jsonDados['codigoCedente'] = this.codigoCedente;
		jsonDados['logradouro'] = this.logradouro;
		jsonDados['numero'] = this.numero;
		jsonDados['bairro'] = this.bairro;
		jsonDados['municipioIbge'] = this.municipioIbge ?? 0;
		jsonDados['uf'] = this.uf;
		jsonDados['fone1'] = this.fone1;
		jsonDados['fone2'] = this.fone2;
		jsonDados['email'] = this.email;
		jsonDados['tipoSindicato'] = this.tipoSindicato;
		jsonDados['dataBase'] = this.dataBase != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataBase) : null;
		jsonDados['pisoSalarial'] = this.pisoSalarial;
		jsonDados['cnpj'] = this.cnpj;
		jsonDados['classificacaoContabilConta'] = this.classificacaoContabilConta;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(Sindicato objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}