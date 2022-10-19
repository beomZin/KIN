package com.gdj51.KIN.web.u.controller;

import java.util.HashMap;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MapController {

	@RequestMapping(value = "/kinMap")
	public ModelAndView kinMap(ModelAndView mav) {

		mav.setViewName("map/map");

		return mav;
	}

	@RequestMapping(value = "/addrMap")
	public ModelAndView addrMap(@RequestParam HashMap<String, String> params, ModelAndView mav) throws Throwable {
		if (params.get("no") != null && params.get("no") != "") {
			mav.setViewName("map/addrMap");
		} else {
			mav.setViewName("redirect:kinMap");
		}

		return mav;
	}

	@RequestMapping(value = "/disMap")
	public ModelAndView disMap(ModelAndView mav) {

		mav.setViewName("map/disMap");

		return mav;
	}
}
