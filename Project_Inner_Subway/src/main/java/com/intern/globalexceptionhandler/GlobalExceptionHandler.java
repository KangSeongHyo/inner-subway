package com.intern.globalexceptionhandler;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLIntegrityConstraintViolationException;

import org.apache.log4j.Logger;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class GlobalExceptionHandler {

	Logger log = Logger.getLogger(this.getClass());

	@ExceptionHandler(Exception.class)
	@ResponseStatus(value = HttpStatus.BAD_REQUEST)
	public void excption(Exception e) {

		log.error(e);
		log.debug(" ===================================END=======================================");

	}

	@ExceptionHandler(DuplicateKeyException.class)
	@ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
	public void duplicateKeyException(DuplicateKeyException e) {
		log.error(e);
		log.debug(" ===================================END=======================================");

	}

	@ExceptionHandler(SQLIntegrityConstraintViolationException.class)
	@ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
	public void sqlIntegrityConstraintViolationException(DuplicateKeyException e) {
		log.error(e);
		log.debug(" ===================================END=======================================");

	}

	@ExceptionHandler(DataIntegrityViolationException.class)
	@ResponseStatus(value = HttpStatus.BAD_REQUEST)
	public void dataIntegrityViolationException(DataIntegrityViolationException e) {
		log.error(e);
		log.debug(" ===================================END=======================================");

	}

	@ExceptionHandler(NoAuthException.class)
	@ResponseStatus(value = HttpStatus.UNAUTHORIZED)
	public void noAuthException(NoAuthException e) {
		log.error(e);
		log.debug(" ===================================END=======================================");

	}

	@ExceptionHandler(IllegalStateException.class)
	@ResponseStatus(value = HttpStatus.BAD_REQUEST)
	public void illegalStateException(NoAuthException e) {
		log.error(e);
		log.debug(" ===================================END=======================================");
	}

	@ExceptionHandler(IOException.class)
	@ResponseStatus(value = HttpStatus.BAD_REQUEST)
	public void iOException(IOException e) {
		log.error(e);
		log.debug(" ===================================END=======================================");
	}

	@ExceptionHandler(FileNotFoundException.class)
	@ResponseStatus(value = HttpStatus.BAD_REQUEST)
	public void fileNotFoundException(IOException e) {
		log.error(e);
		log.debug(" ===================================END=======================================");
	}

}
