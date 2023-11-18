package com.lib.fin.board.announcement;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.lib.fin.board.BoardFileVO;
import com.lib.fin.board.BoardService;
import com.lib.fin.board.BoardVO;
import com.lib.fin.board.LikeVO;
import com.lib.fin.board.comment.CommentVO;
import com.lib.fin.commons.FileVO;
import com.lib.fin.commons.Pager;
import com.lib.fin.member.MemberVO;

public interface AnnouncementService {

	public List<BoardVO> getList(Pager pager) throws Exception;

	public int getTotalAnnouncementCount() throws Exception;

	
	public int addWriting(AnnouncementVO boardVO, List<MultipartFile> list) throws Exception;
	

	public MemberVO getBoardwriter(BoardVO boardVO) throws Exception;
	

	public AnnouncementVO getDetail(AnnouncementVO boardVO) throws Exception;

	public int setUpdate(AnnouncementVO boardVO, List<MultipartFile> files1) throws Exception;

	public int setDelete(AnnouncementVO boardVO) throws Exception;

	public List<BoardFileVO> getFileDetail(AnnouncementVO boardVO) throws Exception;

	public int addComment(CommentVO comment) throws Exception;

	public List<CommentVO> getComments(Long board_no) throws Exception;

	public void likeAnnouncement(Long board_no) throws Exception;

	public void unlikeAnnouncement(Long board_no) throws Exception;

	public void saveLike(LikeVO likeVO) throws Exception;

	public boolean hasLiked(Long board_no, String reg_id) throws Exception;

	public void deleteLike(LikeVO likeVO) throws Exception;

	public void increaseViews(BoardVO boardVO) throws Exception;
	
	public BoardFileVO getFileInfo(Long file_no) throws Exception;
	
	public List<String> uploadImages(List<MultipartFile> files) throws Exception;
	
	public List<MemberVO> searchMembersByName(String name) throws Exception;

	public int deleteFile(Long fileNo) throws Exception;

	public LikeVO checkLike(LikeVO likeVO) throws Exception;

	public String uploadImage(MultipartFile file,MemberVO memberVO) throws Exception;

	public String setContentsImg(MultipartFile files) throws Exception;

	public boolean setContentsImgDelete(String path)throws Exception;



//	

}