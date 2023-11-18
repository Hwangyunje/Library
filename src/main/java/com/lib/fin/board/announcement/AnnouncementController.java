package com.lib.fin.board.announcement;

import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.lib.fin.board.BoardFileVO;
import com.lib.fin.board.BoardVO;
import com.lib.fin.board.LikeVO;
import com.lib.fin.board.comment.CommentVO;
import com.lib.fin.commons.FileVO;
import com.lib.fin.commons.Pager;
import com.lib.fin.member.MemberService;
import com.lib.fin.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/*")
public class AnnouncementController {

	@Autowired
	private AnnouncementService announcementService;

	@Autowired
	private MemberService memberService;

	@Value("${app.upload}")
	private String serverFilePath;

	@Value("${app.board.announce}")
	private String directory;

	@GetMapping("announcement")
	public ModelAndView goAnnouncement(@AuthenticationPrincipal MemberVO memberVO, Pager pager, ModelAndView mv,
			Model model) throws Exception {
		model.addAttribute("member", memberVO);
		List<BoardVO> list = announcementService.getList(pager);
		mv.addObject("member", memberVO);
		mv.addObject("list", list);
		mv.addObject("pager", pager);
		mv.setViewName("board/announcement/announcementlist");
		return mv;
	}

	@GetMapping("annDetail")
	public ModelAndView goAnnouncementDetail(@AuthenticationPrincipal MemberVO memberVO, AnnouncementVO announcementVO,
			ModelAndView mv, HttpSession session) throws Exception {

		mv.setViewName("board/announcement/anndetail");
		AnnouncementVO boardVO = announcementService.getDetail(announcementVO);

		Boolean isViewed = (Boolean) session.getAttribute("viewed_" + boardVO.getBoard_no());

		if (isViewed == null || !isViewed) {
			announcementService.increaseViews(boardVO);
			session.setAttribute("viewed_" + boardVO.getBoard_no(), true);
		}

		List<BoardFileVO> filelist = announcementService.getFileDetail(announcementVO);
		for (BoardFileVO boardFileVO : filelist) {
			System.out.println("file info : " + boardFileVO.toString());
		}

		LikeVO likeVO = new LikeVO();
		likeVO.setBoard_no(boardVO.getBoard_no());
		System.out.println("^^^^^^^^^^^^^^^^^^boardVO : " + likeVO.getBoard_no());
		likeVO.setReg_id(memberVO.getEmp_no());
		System.out.println("^^^^^^^^^^^^^^^^^^memberVO : " + likeVO.getReg_id());
		likeVO = announcementService.checkLike(likeVO);

		if (likeVO == null) {
			mv.addObject("checkLike", "N");
		} else {
			mv.addObject("checkLike", "Y");
		}

		List<CommentVO> comments = announcementService.getComments(boardVO.getBoard_no());
		if (boardVO.getReg_id().equals(memberVO.getEmp_no())) {
			mv.addObject("ready", "A");
		} else {
			mv.addObject("ready", "B");
		}
		mv.addObject("files", filelist);
		mv.addObject("data", boardVO);
		mv.addObject("comments", comments);

		return mv;
	}

	@GetMapping("fileDown/{file_no}")
	public void getFileDown(@PathVariable Long file_no, HttpServletResponse response) throws Exception {
		log.info("Download file with ID: {}", file_no);

		BoardFileVO boardFileVO = announcementService.getFileInfo(file_no);
		String fileName = boardFileVO.getFile_name();

		String filePath = serverFilePath + directory + "/" + fileName;

		File file = new File(filePath);
		InputStream in = new FileInputStream(file);

		response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
		response.setContentLength((int) file.length());
		response.setHeader("Content-Disposition",
				"attachment; filename=\"" + URLEncoder.encode(fileName, "UTF-8") + "\"");
		response.setHeader("Content-Transfer-Encoding", "binary");

		FileCopyUtils.copy(in, response.getOutputStream());
		in.close();
		response.getOutputStream().close();
	}

	@ResponseBody
	@PostMapping("/deleteFile")
	public int deleteFile(@RequestParam("fileNo") Long fileNo) throws Exception {
		System.out.println("deleteFile");
		int result = announcementService.deleteFile(fileNo);
		return result;
	}

	@GetMapping("addAnn")
	public String goAddAnn(@AuthenticationPrincipal MemberVO memberVO, Model model) throws Exception {
		model.addAttribute("member", memberVO);
		return "board/announcement/annadd";
	}

	@PostMapping("addAnn")
	public String addAnnouncementWritten(@AuthenticationPrincipal MemberVO memberVO, AnnouncementVO announcementVO,
			List<MultipartFile> files1, Model model) throws Exception {
		model.addAttribute("member", memberVO);
		announcementVO.setReg_id(memberVO.getEmp_no());
		log.info("************************ BaordString : {}", announcementVO.getBoard_kind());
		if (announcementVO.getBoard_kind() == null) {
			announcementVO.setBoard_kind("off");
		}
		int result = announcementService.addWriting(announcementVO, files1);

		return "redirect:./announcement";
	}

	@PostMapping(value = "modifyBoard")
	public String modifyBoard(AnnouncementVO announcementVO, Model model, List<MultipartFile> files1,
			@AuthenticationPrincipal MemberVO memberVO) throws Exception {
		System.out.println("======> modifyBoard board no : " + announcementVO.getBoard_no());
		announcementVO.setReg_id(memberVO.getEmp_no());
		announcementVO.setMod_id(memberVO.getEmp_no());
		int result = announcementService.setUpdate(announcementVO, files1);
		return "redirect:./announcement";
	}

	@PostMapping("addComment")
	public String addComment(CommentVO comment) throws Exception {

		announcementService.addComment(comment);
		return "redirect:./annDetail?board_no=" + comment.getBoard_no();
	}

	@PostMapping(value = "deleteBoard", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> setDelete(@RequestBody AnnouncementVO announcementVO) throws Exception {
		System.out.println("vo String : " + announcementVO.getBoard_no());
		int result = announcementService.setDelete(announcementVO);

		if (result > 0) {
			return new ResponseEntity<>("삭제 되었습니다", HttpStatus.OK);
		} else {
			return new ResponseEntity<>("삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping(value = "updateBoard")
	public String setUpdate(AnnouncementVO announcementVO, Model model, @AuthenticationPrincipal MemberVO memberVO)
			throws Exception {
		log.info("======>>board no :{}", announcementVO.getBoard_no());
		announcementVO = announcementService.getDetail(announcementVO);
		List<BoardFileVO> filelist = announcementService.getFileDetail(announcementVO);
		model.addAttribute("board", announcementVO);
		model.addAttribute("member", memberVO);
		model.addAttribute("files", filelist);
		return "board/announcement/annmodify";
	}

	@ResponseBody
	@PostMapping("likeAnnouncement/{board_no}")
	public ResponseEntity<String> likeAnnouncement(@PathVariable Long board_no,
			@AuthenticationPrincipal MemberVO memberVO) throws Exception {
		String reg_id = memberVO.getEmp_no();
		if (!announcementService.hasLiked(board_no, reg_id)) {
			LikeVO likeVO = new LikeVO();
			likeVO.setBoard_no(board_no);
			likeVO.setReg_id(reg_id);
			announcementService.likeAnnouncement(board_no);
			announcementService.saveLike(likeVO);
			return new ResponseEntity<>("Liked", HttpStatus.OK);
		}
		return new ResponseEntity<>("Already Liked", HttpStatus.BAD_REQUEST);
	}

	@ResponseBody
	@PostMapping("unlikeAnnouncement/{board_no}")
	public ResponseEntity<String> unlikeAnnouncement(@PathVariable Long board_no,
			@AuthenticationPrincipal MemberVO memberVO) throws Exception {
		String reg_id = memberVO.getEmp_no();
		if (announcementService.hasLiked(board_no, reg_id)) {
			LikeVO likeVO = new LikeVO();
			likeVO.setBoard_no(board_no);
			likeVO.setReg_id(reg_id);
			announcementService.unlikeAnnouncement(board_no);
			announcementService.deleteLike(likeVO);
			return new ResponseEntity<>("Unliked", HttpStatus.OK);
		}
		return new ResponseEntity<>("Not Liked", HttpStatus.BAD_REQUEST);
	}

	@GetMapping("/getMembers")
	@ResponseBody
	public List<MemberVO> getMembers(@PathVariable String name) throws Exception {
		return announcementService.searchMembersByName(name);
	}



	@PostMapping("setContentsImg")
	@ResponseBody
	public String setContentsImg(MultipartFile files, Model model) throws Exception {
		String path = "";
		if (files !=null) {
			
			path = announcementService.setContentsImg(files);
			System.out.println("path info : "+ path);	
		}
		
		return path;
	}

	@PostMapping("setContentsImgDelete")
	@ResponseBody
	public Boolean setContentsImgDelete(String path, Model model) throws Exception {

		
		  boolean check = announcementService.setContentsImgDelete(path);
		  
		 
		return check;

	}
}
