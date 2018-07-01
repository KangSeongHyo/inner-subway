package com.intern.board;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

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
import com.intern.check.CheckFile;
import com.intern.check.CheckValue;
import com.intern.board.BoardService;

@Service
public class BoardService implements Board {
	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	BoardDAO dao;
	@Autowired
	CheckFile checkFile;

	@Override
	public BoardVO getBoardOne(BoardVO requstBoard, String id) throws NoAuthException, Exception {

		int resultValue;

		if (!id.equals("load")) {

			if (requstBoard.getWriter().equals(id)) {

				log.info("Processing : board modify, select comment from DB");
				return dao.getBoardOne(requstBoard);

			} else {

				throw new NoAuthException("Error occurred : Discordance writer");
			}

		} else {
			log.info("Processing : select board from DB");
			BoardVO resultBoard = dao.getBoardOne(requstBoard);

			if (resultBoard == null) {
				log.info("Processing : select board from DB");

				return resultBoard;

			} else {

				log.info("Processing : update viewCount in DB");
				resultValue = dao.increaseViewcount(requstBoard);

				if (resultValue == CheckValue.SUCCESS) {
					log.info("Processing : update viewCount Ok");
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
		log.info("Processing : select boardList(+paging) from DB");
		return dao.getBoardList(requestStation, startBoard);
	}

	@Override
	public int getEntryCount(StationVO requestStation) {
		log.info("Processing : select boardCount from DB");
		return dao.getEntryCount(requestStation);
	}

	@Override
	public int modifyBoard(BoardVO requestBoard, MultipartFile file) throws IllegalStateException, IOException {

		if (file != null) {

			log.info("Processing : file upload ");

			String realName = file.getOriginalFilename();

			String ext = realName.substring(realName.lastIndexOf("."));// 확장자 추출

			String uuid = UUID.randomUUID().toString().replaceAll("-", "");//-제거  

			String uniqueName = uuid + ext; //유니크한 이름 생성 

			String uploadPath = "/home1/irteam/apps/apache-tomcat-8.5.23/webapps/storage/" + uniqueName;

			String imgPath = "/storage/" + uniqueName;

			File newfile = new File(uploadPath);

			file.transferTo(newfile);

			if (checkFile.isImageFile(uploadPath)) {
				requestBoard.setImgPath(imgPath);
				log.info("Processing : file upload Ok");

			} else {

				log.warn("Processing : Not img file");
				throw new FileNotFoundException("Error occurred : invaild data[file]");
			}

		} else {

			requestBoard.setImgPath("NotFound");
			log.info("Processing : img not modify in DB");
		}
		log.info("Processing : board modify in DB");
		return dao.modifyBoard(requestBoard);
	}

	@Override
	public int romoveBoard(BoardVO requestBoard, String id) throws NoAuthException {

		int resultValue;

		if (requestBoard.getWriter().equals(id)) {

			log.info("Processing : accordance writer");
			log.info("Processing : remove board in DB");
			resultValue = dao.removeBoard(requestBoard);

		} else {

			throw new NoAuthException("Error occurred : Discordance writer(BoardService.java:157)");
		}

		return resultValue;
	}

	@Override
	public int boardRegister(BoardVO requestBoard, MultipartFile file) throws IllegalStateException, IOException {

		if (file != null) {
			log.info("Processing : file upload");
			String realName = file.getOriginalFilename();

			String ext = realName.substring(realName.lastIndexOf("."));

			String uuid = UUID.randomUUID().toString().replaceAll("-", "");

			String uniqueName = uuid + ext;

			String uploadPath = "/home1/irteam/apps/apache-tomcat-8.5.23/webapps/storage/" + uniqueName;

			String imgPath = "/storage/" + uniqueName;

			File newfile = new File(uploadPath);

			file.transferTo(newfile);

			if (checkFile.isImageFile(uploadPath)) {
				requestBoard.setImgPath(imgPath);
				log.info("Processing : file upload Ok");

			} else {
				log.warn("Processing : Not img file");
				throw new FileNotFoundException("Error occurred : invaild data[file]");
			}

		} else {
			throw new FileNotFoundException("Error occurred : invaild data[file](BoardService.java:190)");
		}

		log.info("Processing : board register in DB");
		return dao.boardRegister(requestBoard);
	}

	@Override
	public List<BoardVO> removeHtml(List<BoardVO> boardList) {

		if (boardList != null) {

			log.info("Processing : remove html for preview");

			for (BoardVO vo : boardList) {
				vo.setContent(remove(vo.getContent()));
			}

		}

		return boardList;
	}

	@Override
	public Map<String, Integer> getPage(int page, StationVO requestStation) {
		log.info("Processing : pagination");

		int totalBoard = dao.getEntryCount(requestStation);

		int boardCountPage = 4;

		int totalPage = (totalBoard % boardCountPage == 0) ? (totalBoard / boardCountPage)
			: (totalBoard / boardCountPage + 1); 

		int pageCountList = 3; //한번에 보여줄 페이지목록의 수
		int startPage = ((page - 1) / pageCountList) * pageCountList + 1;

		int endPage = startPage + pageCountList - 1;

		if (endPage > totalPage) {
			endPage = totalPage;
		}

		Map<String, Integer> pageMap = new HashMap<String, Integer>();
		pageMap.put("startPage", startPage);
		pageMap.put("endPage", endPage);
		pageMap.put("totalPage", totalPage);

		return pageMap;
	}

	@Override
	public Map<String, Object> getSearchBoard(StationVO requestStation, String search, String id, int page)
		throws Exception {

		if (search == null) {

			throw new Exception("Error occurred : No search value");
		}

		Map<String, Object> map = new HashMap<String, Object>();
		int boardCountPage = 4;
		int startBoard = (page - 1) * boardCountPage;

		map.put("scode", requestStation.getScode());
		map.put("search", search);
		map.put("id", id);

		log.info("Processing : get search boardList from DB");
		List<BoardVO> boardList = dao.getSearchBoard(map, startBoard);

		Map<String, Object> searchBoardMap = new HashMap<String, Object>();
		Map<String, Integer> pageMap = new HashMap<String, Integer>();

		if (boardList != null) {

			boardList = removeHtml(boardList);
			log.info("Processing : remove html");

			int totalBoard = dao.getSearchBoardCount(map);

			if ((Integer)totalBoard == null) {
				return null;

			} else {

				log.info("Processing : pagination");
				int totalPage = (totalBoard % boardCountPage == 0) ? (totalBoard / boardCountPage)
					: (totalBoard / boardCountPage + 1);

				int pageCountList = 3;
				int startPage = ((page - 1) / pageCountList) * pageCountList + 1;

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
	@Transactional(rollbackFor = Exception.class)
	public int recommendBoard(BoardVO requestBoard) throws Exception {
		boolean requestRecommendCheck = requestBoard.isRecommendCheck();
		log.info("Processing : check for recommend");

		if (requestRecommendCheck == true || requestRecommendCheck == false) {

			Boolean getRecommendOne = dao.getRecommendOne(requestBoard);

			if (getRecommendOne == null) {
				requestBoard.setRecommendCheck(true);

				dao.boardRecommend(requestBoard);
				log.info("Processing : insert recommendCheck in DB");
				return dao.recommendRegister(requestBoard);

			} else {

				if (getRecommendOne != requestRecommendCheck) {
					dao.boardRecommend(requestBoard);
					log.info("Processing : update recommend count");

					log.info("Processing : update recommendCheck in DB");
					return dao.recommendModify(requestBoard);

				} else {

					throw new Exception("Error occurred : lnvalid request data");
				}

			}

		} else {
			throw new Exception("Error occurred : lnvalid request data");
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

			log.info("Processing : remove html board");
			boardList = removeHtml(boardList);

			StationVO svo = new StationVO();
			svo.setScode(requestBoard.getScode());
			pageMap = getPage(page, svo);

		}

		sortBoardMap.put("boardList", boardList);
		sortBoardMap.put("pageMap", pageMap);

		return sortBoardMap;
	}

	//html코드삭제
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
