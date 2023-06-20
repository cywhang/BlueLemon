package com.blue.common;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Service;
import org.springframework.util.StopWatch;

@Service
@Aspect
public class AroundAdvice {
	
	@Around("PointcutCommon.allPointcut()")
	public Object aroundLog(ProceedingJoinPoint pjp) throws Throwable {
		
		String methodName = pjp.getSignature().getName();
		
		// 모든 타입의 값들을 받아내기 위해 오브젝트 배열 형태 Object[] 사용
		Object[] args = pjp.getArgs();
		
		//StopWatch stopWatch = new StopWatch();
		
		System.out.println("[ Around - Before ]  " + methodName + "() 메서드 수행 전");
		
		//stopWatch.start();
		
		// 비즈니스 메서드 (insertBoard, updateBoard ...) 호출한 후 리턴 값을 returnObj에 담아준다.
		Object returnObj = pjp.proceed();
		//stopWatch.stop();
		
		if (args.length == 0) {
			System.out.println("[ Around - Before ]  " + methodName + "() 메서드 ARGS : 없음");
		} else {
			System.out.println("[ Around - Before ]  " + methodName + "() 메서드 ARGS : " + returnObj.toString());
		}		
		//System.out.println("[ Around - After ]  " + methodName + "() 메서드 수행에 걸린 시간 : " + stopWatch.getTotalTimeMillis());
		System.out.println("[ Around - After ]  " + methodName + "() 메서드 수행 완료");
		
		return returnObj;
	}
}
