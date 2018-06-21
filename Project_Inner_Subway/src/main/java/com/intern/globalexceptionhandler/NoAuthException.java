package com.intern.globalexceptionhandler;

public class NoAuthException extends Exception {

	private static final long serialVersionUID = 1L;

	public NoAuthException() {
		super();
	}

	public NoAuthException(String message) {
		super(message);
	}

}
