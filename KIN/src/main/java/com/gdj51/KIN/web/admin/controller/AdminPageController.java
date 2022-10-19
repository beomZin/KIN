package com.gdj51.KIN.web.admin.controller;

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
public class AdminPageController {
	@Autowired
	public IKinDao dao;
	
	@Autowired
	public IPagingService ips;
	
	// 회원 관리 - 사용자
	@RequestMapping(value = "/adminPage")
	public ModelAndView adminPage(ModelAndView mav){
		
		mav.setViewName("admin/admin_user");
		return mav;
	}
	
	// 회원 관리 - 원장
	@RequestMapping(value = "/adminSu")
	public ModelAndView adminSu(ModelAndView mav){
		
		mav.setViewName("admin/admin_su");
		return mav;
	}
	
	// 회원 관리 - 교직원
	@RequestMapping(value = "/adminStaff")
	public ModelAndView adminStaff(ModelAndView mav){
		
		mav.setViewName("admin/admin_staff");
		return mav;
	}
	
	// 회원 관리 - 사용자 조회
	@RequestMapping(value = "/adminUserListAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String adminUserListAjax(
			@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();
		
		// 데이터 총 개수
		int cnt = dao.getInt("admin.getUSERCnt", params);
		
		// 페이징 데이터 계산
		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")), cnt, 20, 5);
		
		// 파라미터에 데이터 시작값, 종료값 추가
		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));
		
		// 목록 데이터
		List<HashMap<String, String>> list
			= dao.getList("admin.getUSERList", params);
		
		// 목록 데이터 전달
		model.put("list", list);
		
		// 페이징 데이터 전달
		model.put("pd", pd);
		
		return mapper.writeValueAsString(model);
	}
	
	// 회원 관리 - 원장 조회
	@RequestMapping(value = "/adminSuListAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String adminSuListAjax(
			@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();
		
		// 데이터 총 개수
		int cnt = dao.getInt("admin.getSUCnt", params);
		
		// 페이징 데이터 계산
		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")), cnt, 20, 5);
		
		// 파라미터에 데이터 시작값, 종료값 추가
		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));
		
		// 목록 데이터
		List<HashMap<String, String>> list
		= dao.getList("admin.getSUList", params);
		
		// 목록 데이터 전달
		model.put("list", list);
		
		// 페이징 데이터 전달
		model.put("pd", pd);
		
		return mapper.writeValueAsString(model);
	}
	
	// 회원 관리 - 교직원 조회
	@RequestMapping(value = "/adminStaffListAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String adminStaffListAjax(
			@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();
		
		// 데이터 총 개수
		int cnt = dao.getInt("admin.getSTAFFCnt", params);
		
		// 페이징 데이터 계산
		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")), cnt, 20, 5);
		
		// 파라미터에 데이터 시작값, 종료값 추가
		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));
		
		// 목록 데이터
		List<HashMap<String, String>> list
		= dao.getList("admin.getSTAFFList", params);
		
		// 목록 데이터 전달
		model.put("list", list);
		
		// 페이징 데이터 전달
		model.put("pd", pd);
		
		return mapper.writeValueAsString(model);
	}
	
	// 원장 증빙서류
	@RequestMapping(value = "/adminSuAtt")
	public ModelAndView adminAtt(
			@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		
		// 원장 데이터 조회
		HashMap<String, String> data = dao.getMap("admin.getSU", params);
		
		// 데이터 전달
		mav.addObject("data", data);
		
		mav.setViewName("admin/su_att");
		
		return mav;
	}
	
	// 원장 증빙서류 승인 or 거절
	@RequestMapping(value = "/adminSuAppvAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String adminSuAppvAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = 0;
		
		try {
			cnt = dao.update("admin.updateAppv", params);
			
			if(cnt == 1) {
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
	
	
	// 회원 관리 - 삭제
	@RequestMapping(value = "/ActionUserAjax",
			method = RequestMethod.POST, 
		    produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String ActionUserAjax(@RequestParam HashMap<String, String> no) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = 0;
		
		try {
			cnt = dao.update("admin.deleteUser", no);
			
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
	
	// 게시판 관리
	@RequestMapping(value = "/adminBrd")
	public ModelAndView adminBrd(ModelAndView mav) {
		
		mav.setViewName("admin/admin_brd");
		return mav;
	}
	
	// 게시판 목록
	@RequestMapping(value = "/adminBrdListAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String adminBrdrdListAjax(
			@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();
		
		// 데이터 총 개수
		int cnt = dao.getInt("admin.getBRDCnt", params);
		
		// 페이징 데이터
		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")), cnt, 20, 5);
		
		// 파라미터에 데이터 시작값, 종료값 추가
		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));
				
		// 목록 데이터
		List<HashMap<String, String>> list
			= dao.getList("admin.getBRDList", params);
		
		// 목록 데이터 전달
		model.put("list", list);
		
		// 페이징 데이터 전달
		model.put("pd", pd);
		
		return mapper.writeValueAsString(model);
	}
	
	// 게시글 삭제
	@RequestMapping(value = "/ActionBrdAjax",
			method = RequestMethod.POST, 
		    produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String ActionBrdAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = 0;
		
		try {
			cnt = dao.update("admin.deleteBrd", params);
			
			// 지역구 게시판 - 게시판 글번호 비교 
			// 카테고리 동네라운지의 게시글 삭제했다면
			if(dao.getList("admin.getCha") != null) {
				List<HashMap<String, String>> dis = dao.getList("admin.getCha");
				for(var data : dis) {
					dao.delete("admin.deleteLounge", data);
				}
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
	
	// 게시글 상세
	@RequestMapping(value = "/adminBrdDetail")
	public ModelAndView adminBrdDetail(
			@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		
		// 게시글 데이터
		HashMap<String, String> dataBrd = dao.getMap("admin.getAdminBrd", params);
		
		// 게시글 데이터 전달
		mav.addObject("dataBrd", dataBrd);
		
		mav.setViewName("admin/admin_brd_detail");
		
		return mav;
	}
	
	// 게시글 상세 - 댓글
	@RequestMapping(value = "/adminCmtListAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String adminCmtListAjax (@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();
		
		// 댓글 조회
		List<HashMap<String, String>> listCmt
			= dao.getList("admin.getAdminCmt", params);
		
		// 댓글 데이터 전달
		model.put("listCmt", listCmt);
		
		return mapper.writeValueAsString(model);
	}
	
	// 고객센터
	@RequestMapping(value = "/adminCs")
	public ModelAndView adminCs(ModelAndView mav) {
		
		mav.setViewName("admin/admin_cs");
		return mav;
	}
	
	// 고객센터 목록
	@RequestMapping(value = "/adminCsListAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String adminCsListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();
		
		// 데이터 총 개수
		int cnt = dao.getInt("admin.getCSCnt", params);
		
		// 페이징 데이터
		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")), cnt, 20, 5);
		
		// 파라메터에 데이터 시작값, 종료값 추가
		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));
		
		// 목록 데이터
		List<HashMap<String, String>> list
			= dao.getList("admin.getCSList", params);
		
		// 목록 데이터 전달
		model.put("list", list);
		
		// 페이징 데이터 전달
		model.put("pd", pd);
		
		return mapper.writeValueAsString(model);
	}
	
	// 고객센터 게시글 삭제
	@RequestMapping(value = "/ActionCsAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String ActionCsAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = 0;
		
		try {
			cnt = dao.update("admin.deleteCs", params);
			
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
	
	// 고객센터 상세
	@RequestMapping(value = "/adminCsDetail")
	public ModelAndView adminCsDetail(
			@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		
		// 고객센터 데이터
		HashMap<String, String> data = dao.getMap("admin.getAdminCs", params);
		
		// 고객센터 데이터 전달
		mav.addObject("data", data);
		
		mav.setViewName("admin/admin_cs_detail");
		
		return mav;
	}
	
	// 고객센터 답변 
	@RequestMapping(value = "/adminCsActionAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	
	@ResponseBody
	public String adminCsActionAjax (@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();
		
		int cnt = 0;
		
		try {
			cnt = dao.update("admin.adminCsRep", params);
				
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
