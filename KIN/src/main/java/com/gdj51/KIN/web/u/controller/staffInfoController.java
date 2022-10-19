package com.gdj51.KIN.web.u.controller;

import java.util.HashMap;
import java.util.List;
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
import com.gdj51.KIN.common.service.IPagingService;
@Controller
public class staffInfoController {
	@Autowired
	public IKinDao dao;

	@Autowired
	public IPagingService ips;

	// 교직원 목록 페이지 이동
	@RequestMapping(value = "/staffInfoList")
	public ModelAndView staffInfoList(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
			
		int page = 1;
		
		if(params.get("page") != null && params.get("page") != "") {
			page = Integer.parseInt(params.get("page"));
		}

		mav.addObject("page", page);
		
		mav.setViewName("staffInfo/list");
		
		
		return mav;
	}
	
	@RequestMapping(value="/staffInfoListAjax", 
			method=RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String staffInfoListAjax(
			@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = dao.getInt("st.getStaffCnt", params);
		
		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")), cnt, 10, 5);
		
		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));
		
		List<HashMap<String, String>> list = dao.getList("st.getStaffList", params);
		
		model.put("list", list);
		model.put("pd", pd);
		
		return mapper.writeValueAsString(model);
	}

	
	
	// 교직원 등록 페이지 이동
	@RequestMapping(value = "/staffInsert")
	public ModelAndView staffInsert(
			ModelAndView mav) {
			
			mav.setViewName("staffInfo/insert");
			
		return mav;
	}

	@RequestMapping(value="/staffAction/{flag}", 
			method=RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String staffAction(
			@PathVariable String flag,
			@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = 0;
		
		try {
			switch(flag) {
			case "insert" :
				cnt = dao.insert("st.insertStaff", params);
				break;
			case "delete" :
				String[] del = params.get("chkStaff").split(",");
				cnt = dao.update("st.deleteStaff", params);
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
}
