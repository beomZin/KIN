package com.gdj51.KIN.web.u.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.SystemPropertyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj51.KIN.common.dao.IKinDao;

@Controller
public class SearchController {

	@Autowired
	public IKinDao dao;

	@RequestMapping(value = "/search")
	public ModelAndView search(ModelAndView mav) {

		mav.setViewName("search/search");

		return mav;
	}

	@RequestMapping(value = "/searchAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String searchAjax(
			HttpSession session,
			@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> model = new HashMap<String, Object>();

		int kinCnt = dao.getInt("search.getKinCnt", params);
		
		String u_tp = String.valueOf(session.getAttribute("sTp"));
		// 관리자
		if(u_tp.equals("0")) {
			params.put("admin", "0");
			List<HashMap<String, String>> kinL = dao.getList("search.getKinL", params);
			List<HashMap<String, String>> kinR = dao.getList("search.getKinR", params);
			List<HashMap<String, String>> lounge = dao.getList("search.getLounge", params);
			List<HashMap<String, String>> educate = dao.getList("search.getEducate", params);
			List<HashMap<String, String>> culture = dao.getList("search.getCulture", params);
			List<HashMap<String, String>> ask = dao.getList("search.getAsk", params);
			
			model.put("dis", "all");
			model.put("kinCnt", kinCnt);
			model.put("kinL", kinL);
			model.put("kinR", kinR);
			model.put("lounge", lounge);
			model.put("educate", educate);
			model.put("culture", culture);
			model.put("ask", ask);
		} else {
			// 일반
			// 동네 라운지 - 유저 지역구 번호
			String dis_no = dao.getString("search.getDisNo", params);
			
			if(dis_no != null && dis_no != "") {
				List<HashMap<String, String>> kinL = dao.getList("search.getKinL", params);
				List<HashMap<String, String>> kinR = dao.getList("search.getKinR", params);
				List<HashMap<String, String>> lounge = dao.getList("search.getLounge", params);
				List<HashMap<String, String>> educate = dao.getList("search.getEducate", params);
				List<HashMap<String, String>> culture = dao.getList("search.getCulture", params);
				List<HashMap<String, String>> ask = dao.getList("search.getAsk", params);
				
				model.put("dis", "0");
				model.put("kinCnt", kinCnt);
				model.put("kinL", kinL);
				model.put("kinR", kinR);
				model.put("lounge", lounge);
				model.put("educate", educate);
				model.put("culture", culture);
				model.put("ask", ask);
			} else {
				List<HashMap<String, String>> kinL = dao.getList("search.getKinL", params);
				List<HashMap<String, String>> kinR = dao.getList("search.getKinR", params);
				List<HashMap<String, String>> educate = dao.getList("search.getEducate", params);
				List<HashMap<String, String>> culture = dao.getList("search.getCulture", params);
				List<HashMap<String, String>> ask = dao.getList("search.getAsk", params);
				
				model.put("dis", "1");
				model.put("kinCnt", kinCnt);
				model.put("kinL", kinL);
				model.put("kinR", kinR);
				model.put("educate", educate);
				model.put("culture", culture);
				model.put("ask", ask);
			}
		}

		return mapper.writeValueAsString(model);

	}
}
