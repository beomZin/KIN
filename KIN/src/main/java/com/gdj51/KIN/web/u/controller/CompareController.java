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
public class CompareController {
	
	@Autowired
	public IKinDao dao;
	
	@RequestMapping(value = "/compare" )
	public ModelAndView compare(HttpSession session, @RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		
		if (session.getAttribute("sNo") != null && session.getAttribute("sID") != "") {
			
			if(params.get("no") != null && params.get("noB") != "") {
				// 비교 대상 kinNo 개별 보관
				String kin1 = params.get("no");
				String kin2 = params.get("noB");
				
				// 첫번째 유치원
				// 요약 탭
				HashMap<String, String> kinA = dao.getMap("kin.getKin", params);
				// 기본현황 탭
				HashMap<String, String> infoA = dao.getMap("kin.getInfo", params);
				// 교직원 탭
				HashMap<String, String> staffA = dao.getMap("kin.getStaff", params);
				// 교직원 탭 평균근속연수 추가
				HashMap<String, String> avgA = dao.getMap("kin.getAvgYr", params);
				// 영유아 탭
				 HashMap<String, String> ppA = dao.getMap("kin.getPp", params);
				// 영유아 탭 평균 유아수 추가
				 HashMap<String, String> avgPPA = dao.getMap("kin.getAvgPP", params);
				// 교육 탭
				HashMap<String, String> eduA = dao.getMap("kin.compareEdu", params);
				// 안전점검 탭
				HashMap<String, String> safeA = dao.getMap("kin.getSafe", params);
				// 영양 탭
				HashMap<String, String> dietA = dao.getMap("kin.getDiet", params);
				// 위생 탭				
				HashMap<String, String> saniA = dao.getMap("kin.compareSani", params);
				
				// 두번째 유치원으로 조건 변경
				params.put("no", kin2);	
				
				HashMap<String, String> kinB = dao.getMap("kin.getKin", params);
				HashMap<String, String> infoB = dao.getMap("kin.getInfo", params);
				HashMap<String, String> staffB = dao.getMap("kin.getStaff", params);
				HashMap<String, String> avgB = dao.getMap("kin.getAvgYr", params);
				HashMap<String, String> ppB = dao.getMap("kin.getPp", params);
				HashMap<String, String> eduB = dao.getMap("kin.compareEdu", params);
				HashMap<String, String> avgPPB = dao.getMap("kin.getAvgPP", params);
				HashMap<String, String> safeB = dao.getMap("kin.getSafe", params);
				HashMap<String, String> dietB = dao.getMap("kin.getDiet", params);
				HashMap<String, String> saniB = dao.getMap("kin.compareSani", params);
				
				mav.addObject("kinA", kinA);
				mav.addObject("kinB", kinB);
				mav.addObject("infoA", infoA);
				mav.addObject("infoB", infoB);
				mav.addObject("staffA", staffA);
				mav.addObject("staffB", staffB);
				mav.addObject("avgA", avgA);
				mav.addObject("avgB", avgB);
				mav.addObject("ppA", ppA);
				mav.addObject("ppB", ppB);
				mav.addObject("avgPPA", avgPPA);
				mav.addObject("avgPPB", avgPPB);
				mav.addObject("eduA", eduA);
				mav.addObject("eduB", eduB);
				mav.addObject("safeA", safeA);
				mav.addObject("safeB", safeB);
				mav.addObject("dietA", dietA);
				mav.addObject("dietB", dietB);
				mav.addObject("saniA", saniA);
				mav.addObject("saniB", saniB);
				
				mav.setViewName("compare/compare");
			} else {
				mav.setViewName("bm/list");
			}
		} else {
			mav.setViewName("cmn/loginU");
		}
		return mav;
	}
}
