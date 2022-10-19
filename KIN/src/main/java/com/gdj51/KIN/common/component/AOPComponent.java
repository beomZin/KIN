package com.gdj51.KIN.common.component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

@Aspect
@Component
@EnableAspectJAutoProxy
public class AOPComponent {
	// Pointcut -> 적용범위
	// @Pointcut(범위설정)
	/*
	 * 범위 execution -> include필터 !execution -> exclude필터 * -> 모든것 *(..) -> 모든 메소드 ..
	 * -> 모든 경로 && -> 필터 추가
	 */
	@Pointcut("execution(* com.gdj51.KIN..HomeController.*(..))")
	public void testAOP() {
	}

	// ProceedingJoinPoint -> 대상 적용 이벤트 필터
	/*
	 * @Before -> 메소드 실행 전
	 * 
	 * @After -> 메소드 실행 후
	 * 
	 * @After-returning -> 메소드 정상실행 후
	 * 
	 * @After-throwing -> 메소드 예외 발생 후
	 * 
	 * @Around -> 모든 동작시점
	 */
	@Around("testAOP()")
	public ModelAndView testAOP(ProceedingJoinPoint joinPoint) throws Throwable {
		ModelAndView mav = new ModelAndView();

		// Request 객체 취득
		HttpServletRequest request 
				= ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

		mav = (ModelAndView) joinPoint.proceed(); // 기존 이벤트 처리 행위를 이어서 진행

		System.out.println("------- testAOP 실행됨 ------");

		return mav;
	}
	
	@Pointcut("execution(* com.gdj51.KIN..AdminPageController.*(..))"
			+ "&& !execution(* com.gdj51.KIN..AdminPageController.*Ajax(..))")
	public void adminAOP() {}
	
	@Around("adminAOP()")
	public ModelAndView adminAOP(ProceedingJoinPoint joinPoint) throws Throwable {
		ModelAndView mav = new ModelAndView();
		
		HttpServletRequest request 
		= ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		
		HttpSession session = request.getSession();
		
		// 관리자가 로그인하면
		String sTp = String.valueOf(session.getAttribute("sTp"));
		if(sTp.equals("0")) {
			mav = (ModelAndView)joinPoint.proceed();
		} else {
		// 그 외
			mav.setViewName("redirect:kinMain");
		}
		
		return mav;
	}
	
	@Pointcut("execution(* com.gdj51.KIN..UInfoController.*(..))"
			+ "&& !execution(* com.gdj51.KIN..UInfoController.*Ajax(..))")
	public void uInfoAOP() {}
	
	@Around("uInfoAOP()")
	public ModelAndView uInfoAOP(ProceedingJoinPoint joinPoint) throws Throwable {
		ModelAndView mav = new ModelAndView();
		
		HttpServletRequest request 
		= ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		
		HttpSession session = request.getSession();
		
		// 로그인 상태라면
		if(session.getAttribute("sNo")!=null && session.getAttribute("sID")!="") {
			mav = (ModelAndView)joinPoint.proceed();
		} else {
			mav.setViewName("redirect:loginU");
		}
		
		return mav;
	}
}