package com.intern.aop;

import java.lang.reflect.Field;
import java.lang.reflect.Parameter;
import java.util.ArrayList;
import java.util.List;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.tags.Param;

@Component
@Aspect
public class MethodAop {
/*
	@Pointcut("execution(public * com.intern.isubway.restcontroller.StationRestController.getStations(..))")
	public void pointCut(){}
	
	@Before("pointCut()")
	public void hashBeforeMethod(JoinPoint joinPoint) {
		System.out.println("되니?");
		MethodSignature signature = (MethodSignature) joinPoint.getSignature();
		Parameter[] parameters = signature.getMethod().getParameters();

		// 변수 목록
		Object[] params = joinPoint.getArgs();
		
		// 파라미터가 담길 목록 
		List<Object> paramList = new ArrayList<>();
		
		// 파라미터를 담는 오브젝트만 선별 
		for(Object param : params) {
			if(param instanceof Param) {
				paramList.add(param);
			}
		}
		
		// pathVariable 값 오브젝트에 인젝트
		for (int idx = 0; idx < parameters.length; idx++) {
			Parameter parameter = parameters[idx];
			PathVariable pathVariable = parameter.getAnnotation(PathVariable.class);
			
			if(pathVariable != null && parameter.getType() == String.class) {
				String hashKey = pathVariable.value();
				String hashIds = (String)params[idx];
				try {
					for(Object param : paramList) {
						Field paramHashArgument = param.getClass().getDeclaredField(hashKey);
						paramHashArgument.setAccessible(true);
						paramHashArgument.set(param, hashIds);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			
			}	
		}
		// pathVariable 값 오브젝트에 인젝트
	}*/
	
}
