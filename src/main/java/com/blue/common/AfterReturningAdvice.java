package com.blue.common;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Service;

@Service
@Aspect
public class AfterReturningAdvice {
	
//	@Pointcut("execution(* com.ezen.biz..*Impl.get*(..))")
//	public void getPointcut() { }
	
	@AfterReturning(pointcut = "PointcutCommon.getPointcut()", returning = "returnObj")
	public void afterReturningLog(JoinPoint jp, Object returnObj) {
		
		// 메서드 명
		String methodName = jp.getSignature().getName();
		
		System.out.printf("[ AfterReturning ]  메서드 명 : %s(), 리턴 값 : %s\n", methodName, returnObj.toString());
	}
}
