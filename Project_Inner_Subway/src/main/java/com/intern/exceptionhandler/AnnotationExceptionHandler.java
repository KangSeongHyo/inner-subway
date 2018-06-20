package com.intern.exceptionhandler;

import java.io.FileNotFoundException;
import java.sql.SQLException;

import org.apache.log4j.Logger;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class AnnotationExceptionHandler {

	Logger log = Logger.getLogger(this.getClass());

	@ExceptionHandler(Exception.class)
	@ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
	public void excption(Exception e) {

		log.error("예외 : "+e);
	}

	@ExceptionHandler(SQLException.class)
	@ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
	public void sqlExcption(SQLException e) {
		log.error(e);
	}

	@ExceptionHandler(DuplicateKeyException.class)
	@ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
	public void duplicateKeyException(DuplicateKeyException e) {
		log.error(e);
	}

	@ExceptionHandler(FileNotFoundException.class)
	@ResponseStatus(value = HttpStatus.BAD_REQUEST)
	public void fileNotFoundExcption(FileNotFoundException e) {
		log.warn(e);
	}

}
