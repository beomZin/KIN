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
public class WriteController {

	@Autowired
	public IKinDao dao;

	@Autowired
	public IPagingService ips;

	@RequestMapping(value = "/writeBrd")
	public ModelAndView writeBrdList(ModelAndView mav) {

		mav.setViewName("write/writeBrd");

		return mav;
	}

	@RequestMapping(value = "/writeCmt")
	public ModelAndView writeCmtList(ModelAndView mav) {

		mav.setViewName("write/writeCmt");

		return mav;
	}

	// 게시판 목록 조회
	@RequestMapping(value = "/writeBrdAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String writeBrdAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();

		// 데이터 총 개수
		int cnt = dao.getInt("write.getBrdCnt", params);

		// 페이징 데이터
		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")), cnt, 10, 5);

		// 파라미터에 데이터 시작값, 종료값 추가
		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));

		// 목록 조회
		List<HashMap<String, String>> list = dao.getList("write.getBrdList", params);

		// 목록 데이터 전달
		model.put("list", list);

		// 페이징 데이터 전달
		model.put("pd", pd);

		model.put("cnt", cnt);

		return mapper.writeValueAsString(model);
	}

	// 게시판 목록 조회
	@RequestMapping(value = "/writeCmtAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String writeCmtAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();

		// 데이터 총 개수
		int cnt = dao.getInt("write.getCmtCnt", params);

		// 페이징 데이터
		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")), cnt, 10, 5);

		// 파라미터에 데이터 시작값, 종료값 추가
		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));

		// 목록 조회
		List<HashMap<String, String>> list = dao.getList("write.getCmtList", params);

		// 목록 데이터 전달
		model.put("list", list);

		// 페이징 데이터 전달
		model.put("pd", pd);

		model.put("cnt", cnt);

		return mapper.writeValueAsString(model);
	}

}
