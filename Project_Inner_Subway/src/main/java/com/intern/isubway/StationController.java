package com.intern.isubway;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.intern.main.StationInfoVO;
import com.intern.main.StationInfo_Service;

@Controller
public class StationController {

	@Autowired
	StationInfo_Service service;
	
	@RequestMapping("main/line")
	public void line_page(){}
	
	@RequestMapping("main/getstationinfo")
	@ResponseBody
	public List<StationInfoVO> getStationInfo(int line_number){
	   System.out.println("들어옴"+line_number);
		List<StationInfoVO> list=service.getStationInfo(line_number);
		System.out.println(list.get(0).getSname());
		return list;
	
	}
	
}
