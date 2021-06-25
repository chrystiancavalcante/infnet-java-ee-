package com.infnet.tique.exception;

import org.springframework.security.core.AuthenticationException;

public class FalhaAutenticacaoException extends AuthenticationException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public FalhaAutenticacaoException(String msg) {
		super(msg);
		// TODO Auto-generated constructor stub
	}

}
