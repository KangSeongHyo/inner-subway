package com.intern.isubway;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.intern.station.StationService;
import com.intern.station.StationVO;

@Controller
public class MainViewController {

	@Autowired
	StationService stationservice;

	@RequestMapping("/main")
	public void main_page() {}

	/*////메인 역이름 뷰
	@RequestMapping("main/getstationinfo")
	@ResponseBody
	public List<StationVO> getStationInfo(int line_number) {
		List<StationVO> list = service.getStationInfo(line_number);
		return list;
	}*/

}
