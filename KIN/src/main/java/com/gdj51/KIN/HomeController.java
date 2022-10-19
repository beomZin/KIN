package com.gdj51.KIN;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	@RequestMapping(value = "/kinMain")
	public ModelAndView kinMain(ModelAndView mav) {

		mav.setViewName("home");

		return mav;
	}

}
