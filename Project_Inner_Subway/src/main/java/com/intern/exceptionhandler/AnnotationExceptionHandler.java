package com.intern.exceptionhandler;

import java.io.FileNotFoundException;
import java.sql.SQLException;

import org.apache.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class AnnotationExceptionHandler {

	Logger log = Logger.getLogger(this.getClass());

	@ExceptionHandler(Exception.class)
	@ResponseStatus(value = HttpStatus.BAD_REQUEST)
	public void excption(Exception e) {
		e.printStackTrace();
		log.warn(e.getMessage());
	}

	@ExceptionHandler(SQLException.class)
	@ResponseStatus(value = HttpStatus.BAD_REQUEST)
	public void sqlExcption(SQLException e) {
		e.printStackTrace();
		log.warn(e.getMessage());
	}

	@ExceptionHandler(FileNotFoundException.class)
	@ResponseStatus(value = HttpStatus.BAD_REQUEST)
	public void fileNotFoundExcption(FileNotFoundException e) {
		e.printStackTrace();
		log.warn(e.getMessage());
	}

}
