package com.gdj51.KIN.web.u.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj51.KIN.common.dao.IKinDao;
import com.gdj51.KIN.common.service.IPagingService;

@Controller
public class KinInfoController {
	@Autowired
	public IKinDao dao;

	@Autowired
	public IPagingService ips;

	@RequestMapping(value = "/kinList")
	public ModelAndView kinList(@RequestParam HashMap<String, String> params, ModelAndView mav) {

		int page = 1;

		if (params.get("page") != null && params.get("page") != "") {
			page = Integer.parseInt(params.get("page"));
		}

		mav.addObject("page", page);

		mav.setViewName("kinInfo/kinList");

		return mav;
	}

	@RequestMapping(value = "/kinListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String kinListAjax(@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> model = new HashMap<String, Object>();

		int cnt = dao.getInt("kin.getKinCnt", params);

		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")), cnt, 10, 5);

		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));

		List<HashMap<String, String>> list = dao.getList("kin.getKinList", params);

		model.put("list", list);
		model.put("pd", pd);
		model.put("cnt", cnt);

		return mapper.writeValueAsString(model);

	}

	@RequestMapping(value = "/kinInfo")
	public ModelAndView kinInfo(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {

		if (params.get("no") != null && params.get("no") != "") {
			HashMap<String, String> kin = dao.getMap("kin.getKin", params);
			HashMap<String, String> info = dao.getMap("kin.getInfo", params);
			HashMap<String, String> pp = dao.getMap("kin.getPp", params);
			HashMap<String, String> staff = dao.getMap("kin.getStaff", params);
			HashMap<String, String> edu = dao.getMap("kin.getEdu", params);
			HashMap<String, String> safe = dao.getMap("kin.getSafe", params);
			HashMap<String, String> diet = dao.getMap("kin.getDiet", params);
			HashMap<String, String> sani = dao.getMap("kin.getSani", params);

			mav.addObject("kin", kin);
			mav.addObject("info", info);
			mav.addObject("pp", pp);
			mav.addObject("staff", staff);
			mav.addObject("edu", edu);
			mav.addObject("safe", safe);
			mav.addObject("diet", diet);
			mav.addObject("sani", sani);

			mav.setViewName("kinInfo/kinInfo");

		} else {
			mav.setViewName("redirect:kinList");
		}

		return mav;
	}

}
