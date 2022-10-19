package com.gdj51.KIN.web.cmn.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj51.KIN.common.dao.IKinDao;

@Controller
public class LoginController {

	@Autowired
	public IKinDao dao;

	@RequestMapping(value = "/loginU")
	public ModelAndView loginU(HttpSession session, ModelAndView mav) {
		
		if (session.getAttribute("sNo") != null && session.getAttribute("sID") != "") {
			mav.setViewName("redirect:kinMain");
		} else {
			mav.setViewName("cmn/login_u");
		}
		return mav;
	}

	@RequestMapping(value = "/loginAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String loginAjax(HttpSession session, @RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = 0;
		String admin = ""; 
		try {
			// 관리자 유무 확인
			admin = dao.getString("login.checkAdminYn", params);
			if(admin.equals("0")) {
				model.put("msg", "admin");
			} else {
				// 아이디 존재유무
				cnt = dao.getInt("login.checkIdYn", params);
				
				// 아이디 존재 O
				if(cnt == 1) {
					// 일반 로그인
					HashMap<String, String> data = dao.getMap("login.checkU", params);
					if (data != null) {
						session.setAttribute("sNo", data.get("U_NO"));
						session.setAttribute("sId", data.get("ID"));
						session.setAttribute("sTp", data.get("U_TP"));
						session.setAttribute("sNick", data.get("NICK"));
						session.setAttribute("sDis", data.get("DIS_NO"));
						
						model.put("msg", "success");
					} else {
						model.put("msg", "pw_failed");
					}
				} else {
					// 아이디 존재 X
					model.put("msg", "id_failed");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return mapper.writeValueAsString(model);
	}
	
	// 카카오 loginAjax
	@RequestMapping(value = "/kakaoLoginAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody 
	public String kakaoLoginAjax (HttpSession session, @RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = 0;
		String u = "";
		
		try {
			cnt = dao.getInt("login.checkEmail", params);
			
			// 이미 회원 가입한 회원이면
			if(cnt == 1) {
				HashMap<String, String> data = dao.getMap("login.checkU_kakao", params);
				
				// 지역구 등록 체크
				String no = String.valueOf(data.get("U_NO"));
				params.put("no", no);
				u = dao.getString("login.checkU_DIS", params);
				
				// 지역구 등록 X
				if(u.equals("0")) {
					session.setAttribute("sNo", data.get("U_NO"));
					session.setAttribute("sId", data.get("ID"));
					session.setAttribute("sTp", data.get("U_TP"));
					session.setAttribute("sNick", data.get("NICK"));
					session.setAttribute("sKa", "true");
				} else {
				// 지역구 등록 O
					session.setAttribute("sNo", data.get("U_NO"));
					session.setAttribute("sId", data.get("ID"));
					session.setAttribute("sTp", data.get("U_TP"));
					session.setAttribute("sNick", data.get("NICK"));
					session.setAttribute("sdis", u);
					session.setAttribute("sKa", "true");
				}
				
				model.put("msg", "login");
			} else {
				// DB에 데이터가 없는 회원이면
				model.put("msg", "join");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mapper.writeValueAsString(model);
	}

	@RequestMapping(value = "/logout")
	public ModelAndView logout(HttpSession session, ModelAndView mav) {

		session.invalidate();

		mav.setViewName("redirect:kinMain");

		return mav;
	}
	
	// 아이디 찾기
	@RequestMapping(value = "findId")
	public ModelAndView findId(ModelAndView mav) {
		
		mav.setViewName("cmn/find_id");
		return mav;
	}
	
	// 아이디 찾기 - 회원정보 조회
	@RequestMapping(value = "/findIdAjax", 
					method = RequestMethod.POST, 
					produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String findIdAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();
		
		HashMap<String, String> u_id = dao.getMap("login.getId", params);
		
		if(u_id != null) {
			model.put("msg", "success");
			String user_id = String.valueOf(u_id.get("ID"));
			model.put("user_id", user_id);
		} else {
			model.put("msg", "fail");
		}
		
		return mapper.writeValueAsString(model);
	}
	
	// 아이디 찾기 - 결과 페이지
	@RequestMapping(value = "findId_r")
	public ModelAndView findId_r(ModelAndView mav) {
		
		mav.setViewName("/cmn/find_id_result");
		return mav;
	}
	
	// 비밀번호 찾기
	@RequestMapping(value = "findPw")
	public ModelAndView findPw(ModelAndView mav) {
		
		mav.setViewName("cmn/find_pw");
		return mav;
	}
	
	// 비밀번호 찾기 - 회원정보 조회
	@RequestMapping(value = "/findPwAjax", 
			method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String findPwAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = 0; 
				
		try {
			cnt = dao.getInt("login.getU", params);
			if(cnt == 1) {
				model.put("msg", "success");
				
				/*
				// 영문 + 숫자 8자리 임시비밀번호 생성
				String pw = dao.getString("login.randomPw");
				
				// 네이버 SMTP 이용
				String host = "smtp.naver.com";
				
				// 보내는 사람 이메일 / 비밀번호
				final String user = "@naver.com";
				final String password ="";
				
				// 받는 사람 이메일
				String to = dao.getString("login.getEmail", params);
				
				// SMTP 서버 정보 설정
				Properties props = new Properties();
				props.put("mail.smtp.host", host);
				props.put("mail.smtp.port", 465);
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.ssl.enable", "true");
				props.put("mail.smtp.ssl.trust", host);
				
				// SMTP 서버 정보와 사용자 정보를 기반으로 Session 클래스의 인스턴스 생성
				Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(user, password);
					}
				});
				
				// Message 클래스를 이용하여 메일 수신자, 제목, 내용 작성
				try {
					MimeMessage message = new MimeMessage(session);
					message.setFrom(new InternetAddress(user));
					message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
					
					// 제목
					message.setSubject("[괜찮아유] 임시비밀번호 발급");
					
					// 내용
					message.setText(" [괜찮아유] 홈페이지에서 회원님에게 발급된 임시비밀번호를 알려드립니다. \n"
							        + " 임시비밀번호를 통해 로그인 후 비밀번호를 변경하세요. \n\n"
							        + " 임시비밀번호 : " + pw);
					
					// 전송
					Transport.send(message);
					System.out.println("mail success");
				} catch (Exception e) {
					e.printStackTrace();
				}
				*/
			} else {
				model.put("msg", "fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.put("msg", "exception");
		}
		
		
		
		return mapper.writeValueAsString(model);
	}
	
	// 비밀번호 찾기 - 결과 페이지
	@RequestMapping(value = "/findPw_r")
	public ModelAndView findPw_r(ModelAndView mav) {
		
		mav.setViewName("cmn/find_pw_result");
		return mav;
	}
}
