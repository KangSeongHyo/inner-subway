package com.intern.board;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.intern.dao.BoardDAO;
import com.intern.globalexceptionhandler.NoAuthException;
import com.intern.station.StationVO;

import io.swagger.annotations.Info;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.*;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;
import com.intern.board.BoardVO;
import com.intern.check.CheckValue;
import com.intern.board.BoardService;

/*@RunWith(SpringJUnit4ClassRunner.class) // 테스트하겠다
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/**.xml")// xml 위치설정 스프링로드*/
@Component
@Transactional
public class BoardService implements Board {
	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	BoardDAO dao;

	@Override
	public BoardVO getBoardOne(BoardVO requstBoard, String id) throws NoAuthException, Exception {

		int resultValue;

		if (!id.equals("load")) {

			if (requstBoard.getWriter().equals(id)) {

				return dao.getBoardOne(requstBoard);

			} else {

				throw new NoAuthException("Error occurred : Discordance writer");
			}

		} else {

			BoardVO resultBoard = dao.getBoardOne(requstBoard);

			if (resultBoard == null) {

				return resultBoard;

			} else {

				resultValue = dao.increaseViewcount(requstBoard);

				if (resultValue == CheckValue.SUCCESS) {

					return resultBoard;

				} else {

					throw new Exception("Error occurred : database select");
				}

			}
		}

	}

	@Override
	public List<BoardVO> getBoardList(StationVO requestStation, int page) {

		int boardCountPage = 4;
		int startBoard = (page - 1) * boardCountPage;

		return dao.getBoardList(requestStation, startBoard);
	}

	@Override
	public int getEntryCount(StationVO requestStation) {
		return dao.getEntryCount(requestStation);
	}

	@Override
	public int modifyBoard(BoardVO requestBoard, MultipartFile file) throws IllegalStateException, IOException {
		//////////////file 업로드

		if (file != null) {
			
			String realName = file.getOriginalFilename();

			String ext = realName.substring(realName.lastIndexOf("."));// 확장자 추출

			String uuid = UUID.randomUUID().toString().replaceAll("-", "");//-제거  

			String uniqueName = uuid + ext; //유니크한 이름 생성 

			String uploadPath = "/home1/irteam/apps/apache-tomcat-8.5.23/webapps/storage/" + uniqueName;
			//String uploadPath = "C:/new/" + uniqueName;

			String imgPath = "/storage/" + uniqueName;

			File newfile = new File(uploadPath);

			file.transferTo(newfile);

			requestBoard.setImgPath(imgPath);

		} else {
			
			requestBoard.setImgPath("NotFound");
			System.out.println("들어옴");
		}

		return dao.modifyBoard(requestBoard);
	}

	@Override
	public int romoveBoard(BoardVO requestBoard, String id) throws NoAuthException {

		int resultValue;

		if (requestBoard.getWriter().equals(id)) {

			resultValue = dao.removeBoard(requestBoard);

		} else {

			throw new NoAuthException("Error occurred : Discordance writer");
		}

		return resultValue;
	}

	@Override
	public int boardRegister(BoardVO requestBoard, MultipartFile file) throws IllegalStateException, IOException {
		//////////////file 업로드

		if (file != null) {
			String realName = file.getOriginalFilename();

			String ext = realName.substring(realName.lastIndexOf("."));

			String uuid = UUID.randomUUID().toString().replaceAll("-", "");

			String uniqueName = uuid + ext;

			String uploadPath = "/home1/irteam/apps/apache-tomcat-8.5.23/webapps/storage/" + uniqueName;
			//String uploadPath = "C:/new/" + uniqueName;

			String imgPath = "/storage/" + uniqueName;

			File newfile = new File(uploadPath);

			file.transferTo(newfile);

			requestBoard.setImgPath(imgPath);
		} else {
			throw new FileNotFoundException("Error occurred : invail date[file]");
		}

		return dao.boardRegister(requestBoard);
	}

	@Override
	public List<BoardVO> removeHtml(List<BoardVO> boardList) {

		for (BoardVO vo : boardList) {
			vo.setContent(remove(vo.getContent()));
		}

		return boardList;
	}

	@Override
	public Map<String, Integer> getPage(int page, StationVO requestStation) {
		/////////페이징 처리
		int totalBoard = dao.getEntryCount(requestStation);// 전체 게시물개수

		int boardCountPage = 4;//한 페이지에 보여줄 게시물개수

		int totalPage = (totalBoard % boardCountPage == 0) ? (totalBoard / boardCountPage)
			: (totalBoard / boardCountPage + 1); //전체페이지수 

		int pageCountList = 3; //한번에 보여줄 페이지목록의 수
		// 현재 페이지 기준으로 시작페이지 끝페이지 
		int startPage = ((page - 1) / pageCountList) * pageCountList + 1;
		// -1 하는것은 나누기때문에  +1 1페이지 기준 // * 묶음으로 나오므로 startPage를 구해야하기때문에

		int endPage = startPage + pageCountList - 1;

		// 마지막 페이지 처리 
		if (endPage > totalPage) {
			endPage = totalPage;
		}

		Map<String, Integer> pageMap = new HashMap<String, Integer>();
		pageMap.put("startPage", startPage);
		pageMap.put("endPage", endPage);
		pageMap.put("totalPage", totalPage);
		/////페이징처리 게시물
		return pageMap;
	}

	@Override
	public Map<String, Object> getSearchBoard(StationVO requestStation, String search, String id, int page)
		throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		int boardCountPage = 4;
		int startBoard = (page - 1) * boardCountPage;

		map.put("scode", requestStation.getScode());
		map.put("search", search);
		map.put("id", id);

		List<BoardVO> boardList = dao.getSearchBoard(map, startBoard);

		Map<String, Object> searchBoardMap = new HashMap<String, Object>();
		Map<String, Integer> pageMap = new HashMap<String, Integer>();

		if (boardList != null) {

			boardList = removeHtml(boardList);

			int totalBoard = dao.getSearchBoardCount(map);

			if ((Integer)totalBoard == null) {
				return null;

			} else {

				int totalPage = (totalBoard % boardCountPage == 0) ? (totalBoard / boardCountPage)
					: (totalBoard / boardCountPage + 1);

				int pageCountList = 3; //한번에 보여줄 페이지목록의 수
				int startPage = ((page - 1) / pageCountList) * pageCountList + 1;
				// -1 하는것은 나누기때문에  +1 1페이지 기준 // * 묶음으로 나오므로 startPage를 구해야하기때문에

				int endPage = startPage + pageCountList - 1;

				if (endPage > totalPage) {
					endPage = totalPage;
				}

				pageMap.put("startPage", startPage);
				pageMap.put("endPage", endPage);
				pageMap.put("totalPage", totalPage);
			}
		} else {

			throw new Exception("Error occurred : database select");
		}
		searchBoardMap.put("boardList", boardList);
		searchBoardMap.put("pageMap", pageMap);

		return searchBoardMap;
	}

	@Override
	@Transactional
	public int recommendBoard(BoardVO requestBoard) throws Exception {
		boolean requestRecommendCheck = requestBoard.isRecommendCheck();

		if (requestRecommendCheck == true || requestRecommendCheck == false) {

			Boolean getRecommendOne = dao.getRecommendOne(requestBoard);
			//추천한적 있는지 없는지

			if (getRecommendOne == null) {
				//등록이 안된상태

				requestBoard.setRecommendCheck(true);
				dao.boardRecommend(requestBoard);

				return dao.recommendRegister(requestBoard);

			} else {

				if (getRecommendOne != requestRecommendCheck) {
					dao.boardRecommend(requestBoard);
					return dao.recommendModify(requestBoard);

				} else {

					throw new Exception("Error occurred : lnvalid request data(BoardService.java:296)");
				}

			}

		} else {
			throw new Exception("Error occurred : lnvalid request data(BoardService.java:296)");
		}

	}

	@Override
	public Map<String, Object> getSortBoardList(BoardVO requestBoard, int page) throws Exception {
		int boardCountPage = 4;
		int startBoard = (page - 1) * boardCountPage;

		List<BoardVO> boardList = dao.getSortBoardList(requestBoard, startBoard);

		Map<String, Object> sortBoardMap = new HashMap<String, Object>();
		Map<String, Integer> pageMap = new HashMap<String, Integer>();

		if (boardList == null) {

			throw new Exception("Error occurred : database select");

		} else {

			boardList = removeHtml(boardList);

			StationVO svo = new StationVO();
			svo.setScode(requestBoard.getScode());
			pageMap = getPage(page, svo);

		}

		sortBoardMap.put("boardList", boardList);
		sortBoardMap.put("pageMap", pageMap);

		return sortBoardMap;
	}

	////////////html코드삭제
	private String remove(String content) {
		Pattern scripts = Pattern.compile("<(no)?script[^>]*>.*?</(no)?script>", Pattern.DOTALL);
		Pattern style = Pattern.compile("<style[^>]*>.*</style>", Pattern.DOTALL);
		Pattern tags = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");
		Pattern entityRefs = Pattern.compile("&[^;]+;");
		Pattern whiteSpace = Pattern.compile("\\s\\s+");
		Matcher matcher;
		matcher = scripts.matcher(content);
		content = matcher.replaceAll("");
		matcher = style.matcher(content);
		content = matcher.replaceAll("");
		matcher = tags.matcher(content);
		content = matcher.replaceAll("");
		matcher = entityRefs.matcher(content);
		content = matcher.replaceAll("");
		matcher = whiteSpace.matcher(content);
		content = matcher.replaceAll(" ");
		return content;
	}

}
