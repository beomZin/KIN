package com.gdj51.KIN.web.u.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.aspectj.org.eclipse.jdt.internal.compiler.util.WeakHashSet.HashableWeakReference;
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
public class CSController {

	@Autowired
	public IKinDao dao;

	@Autowired
	public IPagingService ips;

	@RequestMapping(value = "/csList")
	public ModelAndView csList(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{
		
		int page = 1;

		if(params.get("page")!= null && params.get("page")!= "" ) {
			page = Integer.parseInt(params.get("page"));
		}

		mav.addObject("page", page);
		
		mav.setViewName("cs/cs_list");
	
		return mav;
	}

	@RequestMapping(value = "/csDetail")
	public ModelAndView csDetail(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		
		if(params.get("no") != null && params.get("no") != "") {
			HashMap<String, String> data = dao.getMap("cs.getCs", params);
			
			mav.addObject("data", data);
			mav.setViewName("cs/cs_detail");
		} else {
			mav.setViewName("redirect:csList");
		}
		return mav;
	}
	
	@RequestMapping(value="/csListAjax", 
			method=RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String csListAjax(
			@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = dao.getInt("cs.getCsCnt", params);
		
		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")), cnt, 10, 5);
		
		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));
		
		List<HashMap<String, String>> list = dao.getList("cs.getCsList", params);
		
		model.put("list", list);
		model.put("pd", pd);
		
		return mapper.writeValueAsString(model);
	}
	
}
