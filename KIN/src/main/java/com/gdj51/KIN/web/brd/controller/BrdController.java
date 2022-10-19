package com.gdj51.KIN.web.brd.controller;

import java.util.ArrayList;
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
public class BrdController {
	@Autowired
	public IKinDao dao;

	@Autowired
	public IPagingService ips;

	// 게시글 insert 페이지
	@RequestMapping(value = "/brdInsert")
	public ModelAndView brdInsert(ModelAndView mav) {

		mav.setViewName("/brd/brd_insert");

		return mav;
	}

	// 게시글 update 페이지
	@RequestMapping(value = "/brdUpdate")
	public ModelAndView brdUpdate(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {

		String cateNo = String.valueOf(params.get("cateNo"));

		// 카테고리 - 고객센터
		if (cateNo.equals("4")) {
			// 카테고리 데이터
			HashMap<String, String> data = dao.getMap("cs.getCs", params);

			// 카테고리 데이터 전달
			mav.addObject("data", data);
		} else { // 카테고리 - 게시판
			// 게시글 데이터
			HashMap<String, String> data = dao.getMap("brd.getBrd", params);

			// 게시글 데이터 전달
			mav.addObject("data", data);
		}

		mav.setViewName("brd/brd_update");

		return mav;
	}

	// 게시글 insert,update,delete Action
	@RequestMapping(value = "/BRDAction/{gbn}", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String BRDAction(@PathVariable String gbn, @RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();

		int cnt = 0;
		String cate = String.valueOf(params.get("cateNo"));

		try {
			switch (gbn) {
			case "insert":
				cnt = dao.insert("brd.insert", params);

				// 카테고리 동네라운지라면
				if (cate.equals("2")) {
					HashMap<String, String> dis = dao.getMap("brd.getDis", params);
					dao.insert("brd.insertLounge", dis);
				}
				break;
			case "update":
				cnt = dao.update("brd.update", params);

				// 다른 게시판 -> 카테고리 동네라운지로 변경하는 경우
				if (cate.equals("2")) {
					HashMap<String, String> dis = dao.getMap("brd.getDis", params);
					if(dao.getInt("brd.disBrdYn", dis) == 0 ) {
						dao.insert("brd.insertLounge", dis);
					}
				}

				// 카테고리 동네라운지 -> 다른 게시판 변경하는 경우
				// 지역구 게시판 - 게시판 글번호 비교
				if (dao.getMap("brd.getCha") != null) {
					HashMap<String, String> dis_u = dao.getMap("brd.getCha");
					dao.delete("brd.deleteLounge", dis_u);
				}

				break;
			case "delete":
				cnt = dao.update("brd.delete", params);

				// 카테고리 동네라운지라면
				if (cate.equals("2")) {
					HashMap<String, String> dis_d = dao.getMap("brd.getDis", params);
					dao.delete("brd.deleteLounge", dis_d);
				}
				break;
			}

			if (cnt > 0) {
				model.put("msg", "success");
				model.put("cate", params.get("cateNo"));
			} else {
				model.put("msg", "fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.put("msg", "exception");
		}

		return mapper.writeValueAsString(model);
	}

	// 육아교육 게시판
	@RequestMapping(value = "/brdEducate")
	public ModelAndView brdEducate(HttpSession session, ModelAndView mav) throws Throwable {
		if (session.getAttribute("sNo") != null && session.getAttribute("sID") != "") {
			mav.setViewName("brd/educate");
		} else {
			mav.setViewName("cmn/login_u");
		}
		return mav;
	}

	// 문화생활 게시판
	@RequestMapping(value = "/brdCulture")
	public ModelAndView brdCulture(HttpSession session, ModelAndView mav) throws Throwable {
		if (session.getAttribute("sNo") != null && session.getAttribute("sID") != "") {
			mav.setViewName("brd/culture");
		} else {
			mav.setViewName("cmn/login_u");
		}
		return mav;
	}

	// 동네라운지 게시판
	@RequestMapping(value = "/brdLounge")
	public ModelAndView brdLounge(HttpSession session, ModelAndView mav) throws Throwable {
		if (session.getAttribute("sNo") != null && session.getAttribute("sID") != "") {
			mav.setViewName("brd/lounge");
		} else {
			mav.setViewName("cmn/login_u");
		}

		return mav;
	}

	// 궁금해요 게시판
	@RequestMapping(value = "/brdAsk")
	public ModelAndView brdAsk(HttpSession session, ModelAndView mav) throws Throwable {
		if (session.getAttribute("sNo") != null && session.getAttribute("sID") != "") {
			mav.setViewName("brd/ask");
		} else {
			mav.setViewName("cmn/login_u");
		}
		return mav;
	}

	// 게시판 목록 조회
	@RequestMapping(value = "/brdListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String brdListAjax(
			HttpSession session,
			@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();

		// 카테고리 동네라운지라면
		String cate = String.valueOf(params.get("cateNo"));
		if (cate.equals("2")) {
			// 관리자
			String u_tp = String.valueOf(session.getAttribute("sTp"));
			if(u_tp.equals("0")) {
				params.put("admin", "0");
			} else {
				// 유저
				String dis_no = dao.getString("brd.getDisNo", params);
				params.put("dis_no", dis_no);
			}
		}

		// 데이터 총 개수
		int cnt = dao.getInt("brd.getBrdCnt", params);

		// 페이징 데이터
		HashMap<String, Integer> pd = ips.getPagingData(Integer.parseInt(params.get("page")), cnt, 10, 5);

		// 파라미터에 데이터 시작값, 종료값 추가
		params.put("start", Integer.toString(pd.get("start")));
		params.put("end", Integer.toString(pd.get("end")));

		// 목록 조회
		List<HashMap<String, String>> list = dao.getList("brd.getBrdList", params);

		// 목록 데이터 전달
		model.put("list", list);

		// 페이징 데이터 전달
		model.put("pd", pd);

		return mapper.writeValueAsString(model);
	}

	// 게시글 상세 페이지
	@RequestMapping(value = "brdDetail")
	public ModelAndView brdDetail(HttpSession session, @RequestParam HashMap<String, String> params, ModelAndView mav)
			throws Throwable {
		if (session.getAttribute("sNo") != null && session.getAttribute("sID") != "") {
			if (params.get("no") != null && params.get("no") != "") {

				// 조회수
				dao.update("brd.updateHit", params);

				// 게시글 데이터 조회
				HashMap<String, String> dataBrd = dao.getMap("brd.getBrd", params);

				// 게시글 데이터 전달
				mav.addObject("dataBrd", dataBrd);

				mav.setViewName("brd/brd_detail");
			} else {
				mav.setViewName("redirect:brdMain");
			}
		} else {
			mav.setViewName("cmn/login_u");
		}

		return mav;
	}

	// 게시글 상세 페이지 - 댓글 조회
	@RequestMapping(value = "/brdCmtListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String brdCmtListAjax(@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();

		// 댓글 조회
		List<HashMap<String, String>> listCmt = dao.getList("brd.getBrdCmt", params);

		// 댓글 데이터 전달
		model.put("listCmt", listCmt);

		return mapper.writeValueAsString(model);
	}

	// 게시글 상세 페이지 - 댓글 insert, update, delete
	@RequestMapping(value = "/ActionCmtAjax/{gbn}", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")

	@ResponseBody
	public String ActionCmtAjax(@PathVariable String gbn, @RequestParam HashMap<String, String> params)
			throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> model = new HashMap<String, Object>();

		int cnt = 0;

		try {
			switch (gbn) {
			case "insert":
				cnt = dao.insert("brd.insertCmt", params);
				break;
			case "update":
				cnt = dao.update("brd.updateCmt", params);
				break;
			case "delete":
				cnt = dao.update("brd.deleteCmt", params);
				break;
			}

			if (cnt > 0) {
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

	// 게시판 메인 페이지
	@RequestMapping(value = "/brdMain")
	public ModelAndView brdMain(HttpSession session, ModelAndView mav) {

		if (session.getAttribute("sNo") != null && session.getAttribute("sID") != "") {
			mav.setViewName("brd/brdMain");
		} else {
			mav.setViewName("cmn/login_u");
		}

		return mav;
	}

	// 게시판 메인 페이지 Ajax
	@RequestMapping(value = "/brdMainAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String brdMainAjax(
			HttpSession session,
			@RequestParam HashMap<String, String> params) throws Throwable {

		ObjectMapper mapper = new ObjectMapper();

		Map<String, Object> model = new HashMap<String, Object>();
		
		// 관리자
		String u_tp = String.valueOf(session.getAttribute("sTp"));
		if(u_tp.equals("0")) {
			params.put("admin", "0");
			System.out.println("0");
			List<HashMap<String, String>> lounge = dao.getList("brd.getLounge", params);
			System.out.println("1");
			List<HashMap<String, String>> educate = dao.getList("brd.getEducate", params);
			System.out.println("2");
			List<HashMap<String, String>> culture = dao.getList("brd.getCulture", params);
			System.out.println("3");
			List<HashMap<String, String>> ask = dao.getList("brd.getAsk", params);
			System.out.println("4");
			
			model.put("admin", "0");
			model.put("lounge", lounge);
			model.put("educate", educate);
			model.put("culture", culture);
			model.put("ask", ask);
		} else {
			// 유저
			// 동네 라운지 - 로그인 유저 지역구 번호
			String dis_no = dao.getString("brd.getDisNo", params);
			
			if(dis_no != null && dis_no != "") {
				params.put("dis_no", dis_no);
				List<HashMap<String, String>> lounge = dao.getList("brd.getLounge", params);
				List<HashMap<String, String>> educate = dao.getList("brd.getEducate", params);
				List<HashMap<String, String>> culture = dao.getList("brd.getCulture", params);
				List<HashMap<String, String>> ask = dao.getList("brd.getAsk", params);
				
				model.put("dis", "0");
				model.put("lounge", lounge);
				model.put("educate", educate);
				model.put("culture", culture);
				model.put("ask", ask);
			} else {
				List<HashMap<String, String>> educate = dao.getList("brd.getEducate", params);
				List<HashMap<String, String>> culture = dao.getList("brd.getCulture", params);
				List<HashMap<String, String>> ask = dao.getList("brd.getAsk", params);
				
				model.put("dis", "1");
				model.put("educate", educate);
				model.put("culture", culture);
				model.put("ask", ask);
			}
		}
		
		return mapper.writeValueAsString(model);
	}

}
