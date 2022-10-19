package com.gdj51.KIN.web.u.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gdj51.KIN.common.dao.IKinDao;

@Controller
public class UInfoController {
	@Autowired
	public IKinDao dao;

	// 사용자유형별 회원정보 경로 구분
	@RequestMapping(value = "/uInfo")
	public ModelAndView uInfo(
			HttpSession session,
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		
		params.put("uNo", String.valueOf(session.getAttribute("sNo")));
			// 사용자 유형이 원장(1)이라면
			if(String.valueOf(session.getAttribute("sTp")).equals("1")) {
				HashMap<String, String> data = dao.getMap("su.getSu", params);
				mav.addObject("data", data);
				mav.setViewName("uInfo/uInfo_su");
			} else {
				// 사용자 유형 교직원(2), 일반(3)
					HashMap<String, String> data = dao.getMap("u.getU", params);
					mav.addObject("data", data);
					mav.setViewName("uInfo/uInfo_u");
				}
				
		return mav;
	}
	
	// 회원정보 수정 페이지 이동
	@RequestMapping(value = "/uInfoUpdate")
	public ModelAndView uInfoUpdate(
			HttpSession session,
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {

		params.put("uNo", String.valueOf(session.getAttribute("sNo")));

		// 사용자 유형 원장(1)
		if(String.valueOf(session.getAttribute("sTp")).equals("1")) {
			HashMap<String, String> data = dao.getMap("su.getSu", params);
			mav.addObject("data", data);

			mav.setViewName("uInfo/uInfo_update_su");
		} else {
			// 사용자 유형 교직원(2)
			if(String.valueOf(session.getAttribute("uTp")).equals("2")) {
				HashMap<String, String> data = dao.getMap("u.getU", params);
				
				mav.addObject("data", data);
			} else {
			// 사용자 유형 일반(3)
				String u_dis = String.valueOf(session.getAttribute("sU_DIS"));
				
				if(u_dis.equals("0")) {
					HashMap<String, String> data = dao.getMap("u.getU_kakao", params);
					
					mav.addObject("data", data);
				} else {
					HashMap<String, String> data = dao.getMap("u.getU", params);
					
					mav.addObject("data", data);
				}
			}

			mav.setViewName("uInfo/uInfo_update_u");
		}
		
		return mav;
	}

}
