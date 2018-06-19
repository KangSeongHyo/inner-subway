package com.intern.isubway.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.intern.station.StationService;
import com.intern.station.StationVO;

@RestController
@RequestMapping("/station")
public class StationRestController {

	@Autowired
	StationService stationService;

	/**
	 * 호선별 역정보
	 * 
	 * @param requestStation 요청 호선정보
	 * @return 요청 호선의 역들 정보
	 */
	@RequestMapping(value = "/{line}", method = RequestMethod.GET)
	public ResponseEntity<List<StationVO>> getStations(@ModelAttribute StationVO requestStation) {

		ResponseEntity<List<StationVO>> responseEntity = null;
		try {
			List<StationVO> stationList = stationService.getStations(requestStation.getLine());

			if (stationList != null) {
				responseEntity = new ResponseEntity<List<StationVO>>(stationList, HttpStatus.OK);
			} else {
				responseEntity = new ResponseEntity<List<StationVO>>(HttpStatus.SERVICE_UNAVAILABLE);
			}

		} catch (Exception e) {
			e.printStackTrace();
			responseEntity = new ResponseEntity<List<StationVO>>(HttpStatus.BAD_REQUEST);

		}

		return responseEntity;

	}

}
