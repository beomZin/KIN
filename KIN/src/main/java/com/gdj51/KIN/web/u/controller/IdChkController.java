package com.gdj51.KIN.web.u.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj51.KIN.common.dao.IKinDao;

@Controller
public class IdChkController {
	@Autowired
	public IKinDao dao;

	@RequestMapping(value="/idChkAjax", 
			method=RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String idChkAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> model = new HashMap<String, Object>();

		int cnt = dao.getInt("u.idCnt", params);

		model.put("cnt", cnt);

		return mapper.writeValueAsString(model);
	}


}
