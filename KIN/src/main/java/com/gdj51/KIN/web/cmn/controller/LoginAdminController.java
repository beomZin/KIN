package com.gdj51.KIN.web.cmn.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.gdj51.KIN.util.Utils;

@Controller
public class LoginAdminController {
	@Autowired
	public IKinDao dao;
	
	@RequestMapping(value="/loginAdmin")
	public ModelAndView loginAdmin(HttpSession session, ModelAndView mav) {
		
		String sTp = String.valueOf(session.getAttribute("sTp"));
		if(sTp.equals("0")) {
			mav.setViewName("redirect:adminPage");
		} else if(sTp.equals("1") || sTp.equals("2") || sTp.equals("3")) {
			mav.setViewName("redirect:kinMain");
		} else {
			mav.setViewName("cmn/login_admin");
		}
		return mav;
	}
	
	@RequestMapping(value = "/loginAdminAjax",
			method = RequestMethod.POST, 
		    produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String loginAdminAjax(
		HttpSession session,
		@RequestParam HashMap<String, String> params) throws Throwable {
	ObjectMapper mapper = new ObjectMapper();
	
	Map<String, Object> model = new HashMap<String, Object>();
	
	// 암호화
	params.put("pw", Utils.encryptAES128(params.get("pw")));
	
	int cnt = 0;
	
	try {
		// 아이디 존재유무
		cnt = dao.getInt("login.checkIdYn", params);
		// 아이디 존재 O
		if(cnt == 1) {
			// 데이터 조회
			HashMap<String, String> data = dao.getMap("login.checkU", params);
			
			// 조회 데이터가 있다면
			if(data != null) {
				// 세션에 값 추가
				session.setAttribute("sNo", data.get("U_NO"));
				session.setAttribute("sId", data.get("ID"));
				session.setAttribute("sTp", data.get("U_TP"));
				session.setAttribute("sNick", data.get("NICK"));
				session.setAttribute("sDis", "all");
				
				// 보낼 데이터 저장
				model.put("u_tp", data.get("U_TP"));
				model.put("msg", "success");
			} else {
				model.put("msg", "pw_failed");
			}
		// 아이디 존재 X
		} else {
			model.put("msg", "id_failed");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	return mapper.writeValueAsString(model);
	}
	
}
