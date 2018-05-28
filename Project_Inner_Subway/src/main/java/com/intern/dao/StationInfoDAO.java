package com.intern.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.intern.main.StationInfoVO;

@Component
public class StationInfoDAO {
	
	@Autowired
	SqlSession session;
	
	public List<StationInfoVO> getStationInfo(int line_number){
	return session.selectList("station.getStationInfo",line_number);
	}
	
	
	
}
