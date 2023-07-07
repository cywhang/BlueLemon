package com.blue.common;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StopWatch;

@Service
@Aspect
public class AroundAdvice {
	
	@Around("PointcutCommon.allPointcut()")
	public Object aroundLog(ProceedingJoinPoint pjp) throws Throwable {
		
		String methodName = pjp.getSignature().getName();		
		StopWatch stopWatch = new StopWatch();		
		// 모든 타입의 값들을 받아내기 위해 오브젝트 배열 형태 Object[] 사용
		Object[] args = pjp.getArgs();
		
		System.out.println("[ Around - Before ]  " + methodName + "() 메서드 수행 전");
		
		stopWatch.start();
		Object returnObj = pjp.proceed();
		stopWatch.stop();		
		
		System.out.println("[ Around - After  ]  " + methodName + "() 메서드 수행 시간 : " + stopWatch.getTotalTimeMillis());
		
		if (args.length == 0) {
			System.out.println("[ Around - After  ]  " + methodName + "() 메서드 수행 완료 / 리턴값 : 없음");
		} else {
			System.out.println("[ Around - After  ]  " + methodName + "() 메서드 수행 완료 / 리턴값 : 있음");
		}
		
		return returnObj;
	}
}
