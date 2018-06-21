package com.intern.isubway.restcontroller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.intern.station.StationService;
import com.intern.station.StationVO;

@RestController
@RequestMapping("/station")
public class StationRestController {
	
	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	StationService stationService;

	/**
	 * 호선별 역정보
	 * @param requestStation 요청 호선정보
	 * @return 요청 호선의 역들 정보 List
	 * @throws Exception 
	 */
	@RequestMapping(value = "/{line}", method = RequestMethod.GET)
	public ResponseEntity<List<StationVO>> getStations(@ModelAttribute StationVO requestStation) throws Exception {

		ResponseEntity<List<StationVO>> responseEntity = null;
		List<StationVO> resultList = stationService.getStations(requestStation.getLine());

		if (resultList != null) {

			responseEntity = new ResponseEntity<List<StationVO>>(resultList, HttpStatus.OK);
			log.info("Result : stationList request OK, Retrun StationList");

		} else {

			throw new Exception("Error occurred : database select");
		}

		return responseEntity;

	}

}
