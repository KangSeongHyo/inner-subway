package com.intern.isubway;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import com.intern.board.BoardVO;
import com.intern.board.BoardService;
import com.intern.comment.CommentService;
import com.intern.station.StationService;
import com.intern.station.StationVO;

@Controller
@SessionAttributes({"sname", "scode"})
public class BoardViewController {

	@Autowired
	BoardService boardService;
	@Autowired
	StationService stationService;

	//////////////외부게시판 뷰
	@RequestMapping(value = "/board/external", method = RequestMethod.GET)
	public ModelAndView externalBoard(@RequestParam(value = "page", defaultValue = "1") int page,
		@ModelAttribute StationVO requestStation, Model model, HttpSession session) {

		ModelAndView mv = new ModelAndView();

		List<BoardVO> boardList = boardService.getBoardList(requestStation, page);

		boardList = boardService.removeHtml(boardList);

		List<StationVO> stationList = stationService
			.getStations(Integer.parseInt(requestStation.getScode().substring(2, 4)));

		mv.addObject("boardList", boardList);
		mv.addObject("stationList", stationList);

		mv.addObject("pageMap", boardService.getPage(page, requestStation));

		model.addAttribute("sname", requestStation.getSname());
		model.addAttribute("scode", requestStation.getScode());

		mv.setViewName("board/external");

		return mv;

	}

}

/*
		////// 검색
		if (search != null) {

			Map<String, Object> map = new HashMap<String, Object>();

			map.put("search", search);
			map.put("select", select);
			map.put("scode", scode);

			list = service.getSearchBoard(map);

			System.out.println(list);
		} else {

			/////////페이징 처리
			int total_board = service.getEntryCount();// 전체 게시물개수
			int boardCount_page = 4;//한 페이지에 보여줄 게시물개수
			int total_page = (total_board / boardCount_page == 0) ? total_board / boardCount_page
				: total_board / boardCount_page + 1;//전체페이지수 
			int pageCount_List = 3;//한번에 보여줄 페이지목록의 수

			// 현재 페이지 기준으로 시작페이지 끝페이지 
			int startPage = ((page - 1) / pageCount_List) * pageCount_List + 1;// -1 하는것은 나누기때문에  +1 1페이지 기준 // * 묶음으로 나오므로 startPage를 구해야하기때문에
			int endPage = startPage + pageCount_List - 1;

			// 마지막 페이지 처리 
			if (endPage > total_page) {
				endPage = total_page;
			}

			// 게시물 목록
			int startEntry = (page - 1) * boardCount_page;
			int limit = 4;

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("startEntry", startEntry);
			map.put("limit", limit);
			map.put("scode", scode);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);

			list = service.getBoardList(map);
			/////페이징처리 게시물
		}

		List<StationVO> slist = station_service.getStationInfo(Integer.parseInt(scode.substring(2, 3)));

		session.setAttribute("scode", scode);
		session.setAttribute("sname", station_service.getStationName(scode));

		for (BoardVO vo : list) {
			String content = getText(vo.getContent());
			vo.setContent(content);
		}

		mv.addObject("list", list);
		mv.addObject("slist", slist);*/
/*
@RequestMapping("/board/external")
public ModelAndView externalBoard(@RequestParam(value = "page", defaultValue = "1") int page, @ModelAttribute StationVO requestStation,
	@RequestParam("search")String search,@RequestParam("select")String select, HttpSession session) {
	
	System.out.println("들어오니?");
	List<BoardVO> list;
	ModelAndView mv = new ModelAndView();

	////// 검색
	if (search != null) {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("search", search);
		map.put("select", select);
		map.put("scode", scode);

		list = service.getSearchBoard(map);

		System.out.println(list);
	} else {

		/////////페이징 처리
		int total_board = service.getEntryCount();// 전체 게시물개수
		int boardCount_page = 4;//한 페이지에 보여줄 게시물개수
		int total_page = (total_board / boardCount_page == 0) ? total_board / boardCount_page
			: total_board / boardCount_page + 1;//전체페이지수 
		int pageCount_List = 3;//한번에 보여줄 페이지목록의 수

		// 현재 페이지 기준으로 시작페이지 끝페이지 
		int startPage = ((page - 1) / pageCount_List) * pageCount_List + 1;// -1 하는것은 나누기때문에  +1 1페이지 기준 // * 묶음으로 나오므로 startPage를 구해야하기때문에
		int endPage = startPage + pageCount_List - 1;

		// 마지막 페이지 처리 
		if (endPage > total_page) {
			endPage = total_page;
		}

		// 게시물 목록
		int startEntry = (page - 1) * boardCount_page;
		int limit = 4;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startEntry", startEntry);
		map.put("limit", limit);
		map.put("scode", scode);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);

		list = service.getBoardList(map);
		/////페이징처리 게시물
	}

	List<StationVO> slist = station_service.getStationInfo(Integer.parseInt(scode.substring(2, 3)));

	session.setAttribute("scode", scode);
	session.setAttribute("sname", station_service.getStationName(scode));

	for (BoardVO vo : list) {
		String content = getText(vo.getContent());
		vo.setContent(content);
	}

	mv.addObject("list", list);
	mv.addObject("slist", slist);
	mv.setViewName("board/external_board");

	return mv;
}




//////////////////글작성
@RequestMapping("/board/write_result")
public String write_result(MultipartFile file, HttpServletRequest request, HttpSession session)
	throws IllegalStateException, IOException {
	////////////// file 업로드

	String real_name = file.getOriginalFilename();
	String ext = real_name.substring(real_name.lastIndexOf("."));// 확장자 추출
	String uuid = UUID.randomUUID().toString().replaceAll("-", "");//-제거  
	String unique_name = uuid + ext; //유니크한 이름 생성 
	String upload_path = "/home1/irteam/apps/apache-tomcat-8.5.23/webapps/storage/" + unique_name;
	String load_path = "/storage/" + unique_name;
	File newfile = new File(upload_path);
	file.transferTo(newfile);

	String writer = (String)session.getAttribute("id");
	String scode = (String)session.getAttribute("scode");

	String title = request.getParameter("title");
	String content = request.getParameter("content");

	BoardVO vo = new BoardVO(scode, 0, title, writer, new Date(0), 0, content, load_path);
	service.insertBoard(vo);
	String sname = station_service.getStationName(scode);

	return "redirect:/board/external?scode=" + scode + "&sname=" + URLEncoder.encode(sname, "utf-8");
}

///////////// 상세보기
@RequestMapping("/board/inner_board")
@ResponseBody
public List inner_board(String scode, int entry_num) {
	List modalList = new LinkedList();

	HashMap map1 = new HashMap();
	map1.put("scode", scode);
	map1.put("entry_num", entry_num);

	service.updateViewcount(map1);
	BoardVO vo = service.getBoardOne(map1);

	Map map2 = new HashMap();
	map2.put("scode", vo.getScode());
	map2.put("entry_num", vo.getEntry_num());

	List<CommentVO> cvo = comment_service.getCommentList(map2);

	modalList.add(vo);

	for (CommentVO key : cvo) {
		modalList.add(key);
	}

	return modalList;
}

///////////// 글삭제

@RequestMapping("/board/del")
@ResponseBody
public boolean board_del(String scode, int entry_num, String writer, HttpSession session) {
	String id = (String)session.getAttribute("id");

	System.out.println(id);
	if (!id.equals(writer)) {
		return false;
	}

	Map<String, Object> map = new HashMap<String, Object>();
	map.put("scode", scode);
	map.put("entry_num", entry_num);
	service.deleteBoard(map);

	return true;
}

///////////// 글수정 불러오기
@RequestMapping("/board/modify_call")
@ResponseBody
public BoardVO board_modify_call(String scode, int entry_num) {

	HashMap<String, Object> map = new HashMap<String, Object>();
	map.put("scode", scode);
	map.put("entry_num", entry_num);

	BoardVO vo = service.getBoardOne(map);

	return vo;
}

///////////// 글수정
@RequestMapping("/board/modify")
public String board_modify(MultipartFile file, BoardVO vo) throws IllegalStateException, IOException {

	System.out.println(vo.getContent() + " " + vo.getEntry_num() + " " + vo.getScode());

	System.out.println(file.getOriginalFilename() + "뭔데");

	if (!file.getOriginalFilename().equals("")) {
		String real_name = file.getOriginalFilename();
		String ext = real_name.substring(real_name.lastIndexOf("."));// 확장자 추출
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");//-제거  
		String unique_name = uuid + ext; //유니크한 이름 생성 
		String img_path = "C:/new/" + unique_name;
		File newfile = new File(img_path);
		file.transferTo(newfile);
		vo.setImg_path(img_path);
	} else {
		vo.setImg_path(null);
	}

	service.updateBoard(vo);
	String sname = station_service.getStationName(vo.getScode());
	return "redirect:/board/external?scode=" + vo.getScode() + "&sname=" + URLEncoder.encode(sname, "utf-8");
}

////////////html코드삭제
private String getText(String content) {
	Pattern SCRIPTS = Pattern.compile("<(no)?script[^>]*>.*?</(no)?script>", Pattern.DOTALL);
	Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>", Pattern.DOTALL);
	Pattern TAGS = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");
	Pattern nTAGS = Pattern.compile("<\\w+\\s+[^<]*\\s*>");
	Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");
	Pattern WHITESPACE = Pattern.compile("\\s\\s+");
	Matcher m;
	m = SCRIPTS.matcher(content);
	content = m.replaceAll("");
	m = STYLE.matcher(content);
	content = m.replaceAll("");
	m = TAGS.matcher(content);
	content = m.replaceAll("");
	m = ENTITY_REFS.matcher(content);
	content = m.replaceAll("");
	m = WHITESPACE.matcher(content);
	content = m.replaceAll(" ");
	return content;
}
*/
