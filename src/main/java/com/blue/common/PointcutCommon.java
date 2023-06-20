package com.blue.common;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
public class PointcutCommon {

	@Pointcut("execution(* com.blue..*Impl.*(..))")
	public void allPointcut() {}
	
	@Pointcut("execution(* com.blue..*Impl.get*(..))")
	public void getPointcut() {}
	
	
}
