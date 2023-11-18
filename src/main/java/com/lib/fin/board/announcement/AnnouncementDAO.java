package com.lib.fin.board.announcement;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.lib.fin.board.BoardFileVO;
import com.lib.fin.board.BoardVO;
import com.lib.fin.board.LikeVO;
import com.lib.fin.board.comment.CommentVO;
import com.lib.fin.commons.FileVO;
import com.lib.fin.commons.Pager;
import com.lib.fin.member.MemberVO;

@Mapper
public interface AnnouncementDAO {

	public List<BoardVO> getList(Pager pager) throws Exception;

	public int addWriting(AnnouncementVO boardVO) throws Exception;

	public int fileAdd(FileVO fileVO) throws Exception;

	public AnnouncementVO getDetail(AnnouncementVO boardVO) throws Exception;

	public int setUpdate(AnnouncementVO boardVO) throws Exception;

	public int setHitUpdate(AnnouncementVO boardVO) throws Exception;

	public int setDelete(AnnouncementVO boardVO) throws Exception;

	public List<BoardFileVO> getFileDetail(AnnouncementVO boardVO) throws Exception;
	
	public Long getTotal(Pager pager) throws Exception;

	/**
	 * comment 덕글작성 부
	 */

	public int addComment(CommentVO comment) throws Exception;

	public List<CommentVO> getComments(Long board_no) throws Exception;

	
	/**
	 * like부분
	 * 
	 * @return
	 **/
	
	public void likeAnnouncement(Long board_no) throws Exception;
	

	public void unlikeAnnouncement(Long board_no) throws Exception;
	

	
	//좋아요 하는 부분 saveLik -> save sms DB에 저장
	public void saveLike(LikeVO likeVO) throws Exception;

	//좋아요 check
	public LikeVO hasLiked(Long board_no, String reg_id) throws Exception;

	//
	public void deleteLike(LikeVO likeVO) throws Exception;
	
	public int increaseViews(BoardVO boardVO) throws Exception;


	public int getTotalAnnouncementCount() throws Exception;

	public MemberVO getBoardwriter(BoardVO boardVO) throws Exception;


	public int setFileAdd(BoardFileVO boardFileVO) throws Exception;
	
	public AnnouncementVO getLastestBoard() throws Exception;
	
	public AnnouncementVO getLastNum() throws Exception;

	public BoardFileVO getFileInfo(Long file_no) throws Exception;

	public List<MemberVO> searchMembersByName(String name)throws Exception;

	public String saveImageFile(String originalFilename) throws Exception;

	public int deleteFile(Long fileNo) throws Exception;

	public LikeVO checkLike(LikeVO likeVO) throws Exception;
	

}