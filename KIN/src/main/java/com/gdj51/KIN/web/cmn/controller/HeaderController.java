package com.gdj51.KIN.web.cmn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HeaderController {

	@RequestMapping(value = "/cmn")
	public ModelAndView cmn(ModelAndView mav) {

		mav.setViewName("cmn/cmn");

		return mav;
	}

	@RequestMapping(value = "/header")
	public ModelAndView header(ModelAndView mav) {

		mav.setViewName("cmn/header");

		return mav;
	}

}
