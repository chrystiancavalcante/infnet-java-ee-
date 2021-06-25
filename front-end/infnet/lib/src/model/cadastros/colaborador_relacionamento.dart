/*
Title: ERP INFNET                                                                
Description: Model relacionado à tabela [COLABORADOR_RELACIONAMENTO] 
                                                                                
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
import 'package:infnet/src/model/model.dart';

class ColaboradorRelacionamento {
	int id;
	int idTipoRelacionamento;
	int idColaborador;
	String nome;
	DateTime dataNascimento;
	String cpf;
	String registroMatricula;
	String registroCartorio;
	String registroCartorioNumero;
	String registroNumeroLivro;
	String registroNumeroFolha;
	DateTime dataEntregaDocumento;
	String salarioFamilia;
	int salarioFamiliaIdadeLimite;
	DateTime salarioFamiliaDataFim;
	int impostoRendaIdadeLimite;
	int impostoRendaDataFim;
	TipoRelacionamento tipoRelacionamento;
	Colaborador colaborador;

	ColaboradorRelacionamento({
		this.id,
		this.idTipoRelacionamento,
		this.idColaborador,
		this.nome,
		this.dataNascimento,
		this.cpf,
		this.registroMatricula,
		this.registroCartorio,
		this.registroCartorioNumero,
		this.registroNumeroLivro,
		this.registroNumeroFolha,
		this.dataEntregaDocumento,
		this.salarioFamilia,
		this.salarioFamiliaIdadeLimite,
		this.salarioFamiliaDataFim,
		this.impostoRendaIdadeLimite,
		this.impostoRendaDataFim,
		this.tipoRelacionamento,
		this.colaborador,
	});

	static List<String> campos = <String>[
		'ID', 
		'NOME', 
		'DATA_NASCIMENTO', 
		'CPF', 
		'REGISTRO_MATRICULA', 
		'REGISTRO_CARTORIO', 
		'REGISTRO_CARTORIO_NUMERO', 
		'REGISTRO_NUMERO_LIVRO', 
		'REGISTRO_NUMERO_FOLHA', 
		'DATA_ENTREGA_DOCUMENTO', 
		'SALARIO_FAMILIA', 
		'SALARIO_FAMILIA_IDADE_LIMITE', 
		'SALARIO_FAMILIA_DATA_FIM', 
		'IMPOSTO_RENDA_IDADE_LIMITE', 
		'IMPOSTO_RENDA_DATA_FIM', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Nome', 
		'Data Nascimento', 
		'Cpf', 
		'Registro Matricula', 
		'Registro Cartorio', 
		'Registro Cartorio Numero', 
		'Registro Numero Livro', 
		'Registro Numero Folha', 
		'Data Entrega Documento', 
		'Salario Familia', 
		'Salario Familia Idade Limite', 
		'Salario Familia Data Fim', 
		'Imposto Renda Idade Limite', 
		'Imposto Renda Data Fim', 
	];

	ColaboradorRelacionamento.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idTipoRelacionamento = jsonDados['idTipoRelacionamento'];
		idColaborador = jsonDados['idColaborador'];
		nome = jsonDados['nome'];
		dataNascimento = jsonDados['dataNascimento'] != null ? DateTime.tryParse(jsonDados['dataNascimento']) : null;
		cpf = jsonDados['cpf'];
		registroMatricula = jsonDados['registroMatricula'];
		registroCartorio = jsonDados['registroCartorio'];
		registroCartorioNumero = jsonDados['registroCartorioNumero'];
		registroNumeroLivro = jsonDados['registroNumeroLivro'];
		registroNumeroFolha = jsonDados['registroNumeroFolha'];
		dataEntregaDocumento = jsonDados['dataEntregaDocumento'] != null ? DateTime.tryParse(jsonDados['dataEntregaDocumento']) : null;
		salarioFamilia = jsonDados['salarioFamilia'];
		salarioFamiliaIdadeLimite = jsonDados['salarioFamiliaIdadeLimite'];
		salarioFamiliaDataFim = jsonDados['salarioFamiliaDataFim'] != null ? DateTime.tryParse(jsonDados['salarioFamiliaDataFim']) : null;
		impostoRendaIdadeLimite = jsonDados['impostoRendaIdadeLimite'];
		impostoRendaDataFim = jsonDados['impostoRendaDataFim'];
		tipoRelacionamento = jsonDados['tipoRelacionamento'] == null ? null : new TipoRelacionamento.fromJson(jsonDados['tipoRelacionamento']);
		colaborador = jsonDados['colaborador'] == null ? null : new Colaborador.fromJson(jsonDados['colaborador']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idTipoRelacionamento'] = this.idTipoRelacionamento ?? 0;
		jsonDados['idColaborador'] = this.idColaborador ?? 0;
		jsonDados['nome'] = this.nome;
		jsonDados['dataNascimento'] = this.dataNascimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataNascimento) : null;
		jsonDados['cpf'] = this.cpf;
		jsonDados['registroMatricula'] = this.registroMatricula;
		jsonDados['registroCartorio'] = this.registroCartorio;
		jsonDados['registroCartorioNumero'] = this.registroCartorioNumero;
		jsonDados['registroNumeroLivro'] = this.registroNumeroLivro;
		jsonDados['registroNumeroFolha'] = this.registroNumeroFolha;
		jsonDados['dataEntregaDocumento'] = this.dataEntregaDocumento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataEntregaDocumento) : null;
		jsonDados['salarioFamilia'] = this.salarioFamilia;
		jsonDados['salarioFamiliaIdadeLimite'] = this.salarioFamiliaIdadeLimite ?? 0;
		jsonDados['salarioFamiliaDataFim'] = this.salarioFamiliaDataFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.salarioFamiliaDataFim) : null;
		jsonDados['impostoRendaIdadeLimite'] = this.impostoRendaIdadeLimite ?? 0;
		jsonDados['impostoRendaDataFim'] = this.impostoRendaDataFim ?? 0;
		jsonDados['tipoRelacionamento'] = this.tipoRelacionamento == null ? null : this.tipoRelacionamento.toJson;
		jsonDados['colaborador'] = this.colaborador == null ? null : this.colaborador.toJson;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(ColaboradorRelacionamento objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}