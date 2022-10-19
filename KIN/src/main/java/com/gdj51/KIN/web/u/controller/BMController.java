package com.gdj51.KIN.web.u.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
public class BMController {
	@Autowired
	public IKinDao dao;

	@Autowired
	public IPagingService ips;

	@RequestMapping(value = "/bm")
	public ModelAndView bm(HttpSession session, @RequestParam HashMap<String, String> params, ModelAndView mav)
			throws Throwable {

		if (session.getAttribute("sNo") != null && session.getAttribute("sNo") != null) {
			int bmpage = 1;

			if (params.get("bmpage") != null && params.get("bmpage") != "") {
				bmpage = Integer.parseInt(params.get("bmpage"));
			}

			mav.addObject("bmpage", bmpage);

			mav.setViewName("bm/list");
		} else {
			mav.setViewName("cmn/login_u");
		}
		return mav;
	}

	@RequestMapping(value = "/bmAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String bmAjax(HttpSession session, @RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> model = new HashMap<String, Object>();

		int cnt = dao.getInt("bm.getBMCnt", params);

		HashMap<String, Integer> bmpd = ips.getPagingData(Integer.parseInt(params.get("bmpage")), cnt, 10, 5);

		params.put("uNo", String.valueOf(session.getAttribute("sNo")));
		params.put("start", Integer.toString(bmpd.get("start")));
		params.put("end", Integer.toString(bmpd.get("end")));

		List<HashMap<String, String>> bmlist = dao.getList("bm.getBMList", params);

		model.put("bmlist", bmlist);
		model.put("bmpd", bmpd);

		return mapper.writeValueAsString(model);
	}

	@RequestMapping(value = "/bmAction/{flag}", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String bmAction(HttpSession session, @PathVariable String flag, @RequestParam HashMap<String, String> params)
			throws Throwable {

		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> model = new HashMap<String, Object>();

		int cnt = 0;

		try {
			switch (flag) {
			case "insert":
				params.put("uNo", String.valueOf(session.getAttribute("sNo")));

				cnt = dao.insert("bm.insertKin", params);
				break;
			case "chkDelete":
				String[] del = params.get("chkdel").split(",");
				params.put("uNo", String.valueOf(session.getAttribute("sNo")));

				for (int i = 0; i < del.length; i++) {
					params.put("del", del[i]);
					cnt = dao.delete("bm.deleteKin", params);
				}
				break;
			case "delete":
				params.put("uNo", String.valueOf(session.getAttribute("sNo")));

				cnt = dao.delete("bm.deleteKin", params);
				break;
			}

			if (cnt > 0) {
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
