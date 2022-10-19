package com.gdj51.KIN.web.u.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj51.KIN.common.dao.IKinDao;

@Controller
public class UController {
	@Autowired
	public IKinDao dao;
	
	@RequestMapping(value ="/reg")
	public ModelAndView reg(ModelAndView mav) throws Throwable{
		
		mav.setViewName("cmn/reg");
		
		return mav;
	}
	
	@RequestMapping(value="/uAction/{flag}", 
			method=RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String uAction(
			@PathVariable String flag,
			@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		// 사용자유형구분 (기본값(3) => 일반사용자)
		int uTp = 3;
		
		if(params.get("uTp") != null && params.get("uTp") != "") {
			uTp = Integer.parseInt(params.get("uTp"));
		}

		int cnt = 0;
		int email = 0;
		
		try {
			
				switch(flag) {
				case "insert" :
					
					// 이메일 중복 확인
					email = dao.getInt("u.checkEmailYn", params);
					
					if(email == 1) {
						model.put("msg", "email_Y");
					} else {
						// 사용자 유형별 회원가입 필수정보 구분
						if(uTp == 1) {
							// insert U + SU
							cnt = dao.insert("u.insertSU", params);
						} else {
							// insert U
							cnt = dao.insert("u.insertU", params);
						}
					}
					break;
					
				case "update" :
					// 이메일 중복 확인
					email = dao.getInt("u.updateEmailYn", params);
					
					if(email == 1) {
						model.put("msg", "email_Y");
					} else {
						// 사용자 유형별 회원정보 수정 정보 구분
						if(uTp == 1) {
							// update U + SU
							cnt = dao.update("u.updateGeneral", params);
							cnt = dao.update("u.updateU", params);
							cnt = dao.update("u.updateSU", params);
						} else {		
							// update U
							cnt = dao.update("u.updateGeneral", params);

							String selDis = String.valueOf(params.get("selectDis"));
	
							if(selDis.equals("")) {
								cnt = dao.insert("u.insertDIS", params);
								System.out.println("지역구번호 없");
							} else {
								cnt = dao.update("u.updateU", params);
								System.out.println("지역구번호 있");
							}
						}
					}
					break;
					
				case "delete" :
					cnt = dao.update("u.deleteU", params);
					break;
				}
				
				if(cnt > 0) {
					model.put("msg", "success");
				} else {
					model.put("msg", "fail");
				}
				
		} catch (Exception e) {
			e.printStackTrace();
			model.put("msg", "error");
		}
		
		return mapper.writeValueAsString(model);
	}
	
	// 카카오 가입
	@RequestMapping(value = "/reg_kakao")
	public ModelAndView reg_kakao (ModelAndView mav) {
		
		mav.setViewName("cmn/reg_kakao");
		return mav;
	}
	
	// 카카오 가입회원 insert, update, delete
	@RequestMapping(value="/uAction_kakao/{gbn}", 
			method=RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String uAction_kakao (
			@PathVariable String gbn,
			@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();
		
		// 사용자 유형 ( 3, 일반사용자 )
		int uTp = Integer.parseInt(params.get("uTp"));
		
		int cnt = 0;
		int email = 0;
		
		try {
			switch(gbn) {
				case "insert" :
					cnt = dao.insert("u.insertU_kakao", params);
					break;
				case "update" :
					cnt = dao.update("u.updateGeneral", params);
					if(cnt != 1) {
						break;
					}
					cnt = dao.insert("u.insertDIS", params);
					break;
				case "delete" :
					cnt = dao.update("u.deleteU", params);
					break;
			}
			
			if(cnt > 0) {
				model.put("msg", "success");
			} else {
				model.put("msg", "fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.put("msg", "exception");
		}
		
		return mapper.writeValueAsString(model);
	}
}
