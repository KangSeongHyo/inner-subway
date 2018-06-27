package com.intern.dao;

import static org.junit.Assert.*;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.intern.board.BoardVO;
import com.intern.station.StationVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/resources/mybatis/*.xml",
	"file:src/main/webapp/WEB-INF/spring/*.xml"})
@Component
public class BoardDAO {

	Logger log = Logger.getLogger(this.getClass());
	@Autowired
	SqlSession session;

	@Test
	public void test() {
		log.info(session);
	}

	public List<BoardVO> getBoardList(StationVO vo, int startBoard) {
		int limit = 4;
		RowBounds rowbound = new RowBounds(startBoard, limit);

		return session.selectList("board.getBoardList", vo, rowbound);
	}

	public int getEntryCount(StationVO vo) {
		return session.selectOne("board.getEntryCount", vo);
	}

	@Test
	public void getEntryCountTest() {
		BoardVO vo = new BoardVO();
		vo.setScode("SN0101");

		int value = session.selectOne("board.getEntryCount", vo);
		assertEquals(5, value);
	}

	public int boardRegister(BoardVO vo) {
		return session.insert("board.insertBoard", vo);
	}

	public int removeBoard(BoardVO vo) {
		return session.delete("board.deleteBoard", vo);
	}

	public int modifyBoard(BoardVO vo) {
		return session.update("board.updateBoard", vo);
	}

	public BoardVO getBoardOne(BoardVO vo) {
		return session.selectOne("board.getBoardOne", vo);
	}

	public int increaseViewcount(BoardVO vo) {
		return session.update("board.updateViewcount", vo);
	}

	public List<BoardVO> getSearchBoard(Map<String, Object> map, int startBoard) {
		int limit = 4;
		RowBounds rowBounds = new RowBounds(startBoard, limit);
		return session.selectList("board.getSearchBoard", map, rowBounds);
	}

	public int getSearchBoardCount(Map<String, Object> map) {
		return session.selectOne("board.getSearchBoardCount", map);
	}

	@Transactional(rollbackFor = Exception.class)
	public int boardRecommend(BoardVO vo) {
		return session.update("recommend.setRecommend", vo);
	}

	@Transactional(rollbackFor = Exception.class)
	public int recommendModify(BoardVO vo) {
		return session.update("recommend.updateRecommend", vo);
	}

	@Transactional(rollbackFor = Exception.class)
	public int recommendRegister(BoardVO vo) {
		return session.insert("recommend.insertRecommend", vo);
	}

	public int recommendComfirm(BoardVO vo) {
		return session.selectOne("recommend.selectRecommend", vo);
	}

	public Boolean getRecommendOne(BoardVO vo) {
		return session.selectOne("recommend.selectRecommendCheck", vo);
	}

	public List<BoardVO> getSortBoardList(BoardVO vo, int startBoard) {
		int limit = 4;
		RowBounds rowbound = new RowBounds(startBoard, limit);

		return session.selectList("board.getSortBoardList", vo, rowbound);
	}

}
