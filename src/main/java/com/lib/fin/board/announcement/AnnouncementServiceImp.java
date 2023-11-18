package com.lib.fin.board.announcement;

import java.util.ArrayList;
import java.util.List;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.lib.fin.board.BoardFileVO;
import com.lib.fin.board.BoardVO;
import com.lib.fin.board.LikeVO;
import com.lib.fin.board.comment.CommentVO;
import com.lib.fin.commons.FileManager;
import com.lib.fin.commons.FileVO;
import com.lib.fin.commons.Pager;
import com.lib.fin.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AnnouncementServiceImp implements AnnouncementService {

	@Autowired
	private AnnouncementDAO announcementDAO;

	@Value("${app.upload}")
	private String filePath;

	@Value("${app.board.announce}")
	private String announceName;

	@Value("${app.board.announce.summernote}")
	private String summernote;

	@Autowired
	private FileManager fileManager;

	@Override
	public List<BoardVO> getList(Pager pager) throws Exception {
		pager.makeRowNum();
		pager.makePageNum(announcementDAO.getTotal(pager));
		List<BoardVO> list = announcementDAO.getList(pager);
		for (BoardVO boardVO : list) {
			System.out.println("=====Test id : " + boardVO.getReg_id());
			MemberVO memberVO = announcementDAO.getBoardwriter(boardVO);
			boardVO.setBoard_wirter(memberVO.getName() + " " + memberVO.getEmp_position());
		}
		return list;
	}

	@Override
	public int getTotalAnnouncementCount() throws Exception {
		return announcementDAO.getTotalAnnouncementCount();
	}

	@Override
	public List<BoardFileVO> getFileDetail(AnnouncementVO boardVO) throws Exception {
		List<BoardFileVO> ar = announcementDAO.getFileDetail(boardVO);
		for (BoardFileVO boardFileVO : ar) {
			System.out.println("=========boardFileVO :" + boardFileVO.toString());
			System.out.println("=========boardFileVO Origin Name:" + boardFileVO.getFile_oriName());
		}
		return ar;
	}

	@Override
	@Transactional
	public int addWriting(AnnouncementVO boardVO, List<MultipartFile> files1) throws Exception {
		String reg_id = boardVO.getReg_id();
		int result = announcementDAO.addWriting(boardVO);
		boardVO = announcementDAO.getLastestBoard();
		System.out.println("board info : " + boardVO);
		try {
			String path = filePath + announceName;
			if (files1 != null) {

				for (MultipartFile multipartFile : files1) {

					if (multipartFile.isEmpty()) {
						continue;
					}

					BoardFileVO boardFileVO = new BoardFileVO();
					String fileName = fileManager.save(path, multipartFile);
					System.out.println("saveName ===>> : " + fileName);
					boardFileVO.setBoard_no(boardVO.getBoard_no());
					boardFileVO.setFile_name(fileName);
					boardFileVO.setFile_oriName(multipartFile.getOriginalFilename());
					boardFileVO.setFile_type("A");
					boardFileVO.setReg_id(reg_id);
					boardFileVO.setMod_id(reg_id);
					boardFileVO.setUse_yn("Y");
					System.out.println("fileVO" + boardFileVO.toString());
					result = announcementDAO.setFileAdd(boardFileVO);
				}
			}
		} catch (Exception e) {
			System.out.println("파일 업로드 중 오류 발생: " + e.getMessage());
			e.printStackTrace();

		}
		return result;

	}

	@Override
	public int setUpdate(AnnouncementVO boardVO, List<MultipartFile> files1) throws Exception {

		String reg_id = boardVO.getReg_id();
		System.out.println("boardNo1 ===>> : " + boardVO.getBoard_no());

		int result = announcementDAO.setUpdate(boardVO);

		try {
			String path = filePath + announceName;
			if (files1 != null) {

				for (MultipartFile multipartFile : files1) {
					log.info("filenames : " + files1);
					if (multipartFile.isEmpty()) {
						continue;
					}

					BoardFileVO boardFileVO = new BoardFileVO();
					String fileName = fileManager.save(path, multipartFile);
					System.out.println("boardNo2 ===>> : " + boardVO.getBoard_no());
					System.out.println("saveName ===>> : " + fileName);
					boardFileVO.setBoard_no(boardVO.getBoard_no());
					boardFileVO.setFile_name(fileName);
					boardFileVO.setFile_oriName(multipartFile.getOriginalFilename());
					boardFileVO.setFile_type("A");
					boardFileVO.setReg_id(reg_id);
					boardFileVO.setMod_id(reg_id);
					boardFileVO.setUse_yn("Y");
					System.out.println("fileVO" + boardFileVO.toString());
					result = announcementDAO.setFileAdd(boardFileVO);
				}
			}
		} catch (Exception e) {
			System.out.println("파일 업로드 중 오류 발생: " + e.getMessage());
			e.printStackTrace();

		}
		return result;
	}

	@Override
	public MemberVO getBoardwriter(BoardVO boardVO) throws Exception {
		return announcementDAO.getBoardwriter(boardVO);
	}

	@Override
	public AnnouncementVO getDetail(AnnouncementVO boardVO) throws Exception {
		boardVO = announcementDAO.getDetail(boardVO);
		MemberVO memberVO = announcementDAO.getBoardwriter(boardVO);
		boardVO.setBoard_wirter(memberVO.getName() + " " + memberVO.getEmp_position());
		System.out.println("detail : person2" + boardVO.getBoard_wirter());
		return boardVO;
	}

	@Override
	public int setDelete(AnnouncementVO boardVO) throws Exception {

		return announcementDAO.setDelete(boardVO);
	}

	@Override
	public int addComment(CommentVO comment) throws Exception {
		int result = announcementDAO.addComment(comment);
		return result;
	}

	@Override
	public List<CommentVO> getComments(Long board_no) throws Exception {
		return announcementDAO.getComments(board_no);
	}

	@Override
	public void likeAnnouncement(Long board_no) throws Exception {
		announcementDAO.likeAnnouncement(board_no);

	}

	@Override
	public void unlikeAnnouncement(Long board_no) throws Exception {
		announcementDAO.unlikeAnnouncement(board_no);

	}

	@Override
	public void saveLike(LikeVO likeVO) throws Exception {
		announcementDAO.saveLike(likeVO);

	}

	@Override
	public boolean hasLiked(Long board_no, String reg_id) throws Exception {
		return announcementDAO.hasLiked(board_no, reg_id) != null;
	}

	@Override
	public void deleteLike(LikeVO likeVO) throws Exception {
		announcementDAO.deleteLike(likeVO);

	}

	@Override
	public void increaseViews(BoardVO boardVO) throws Exception {
		announcementDAO.increaseViews(boardVO);
	}

	@Override
	public BoardFileVO getFileInfo(Long file_no) throws Exception {
		return announcementDAO.getFileInfo(file_no);
	}

	public List<MemberVO> searchMembersByName(String name) throws Exception {
		return announcementDAO.searchMembersByName(name);
	}

	public List<String> uploadImages(List<MultipartFile> files) throws Exception {

		List<String> imageUrls = new ArrayList<>();

		for (MultipartFile file : files) {
			imageUrls.add(announcementDAO.saveImageFile(file.getOriginalFilename()));
		}

		return imageUrls;
	}

	@Override
	public int deleteFile(Long fileNo) throws Exception {
		return announcementDAO.deleteFile(fileNo);
	}

	@Override
	public LikeVO checkLike(LikeVO likeVO) throws Exception {
		return announcementDAO.checkLike(likeVO);
	}

	@Override
	public String uploadImage(MultipartFile file, MemberVO memberVO) throws Exception {
		try {
			String filePath = this.filePath + "/" + summernote;

			String fileName = fileManager.save(filePath, file);
			String url = "/files" + summernote + "/" + fileName;

			BoardFileVO boardFileVO = new BoardFileVO();
			BoardVO boardVO = announcementDAO.getLastNum();

			boardFileVO.setBoard_no(boardVO.getBoard_no() + 1);
			boardFileVO.setFile_name(url);
			boardFileVO.setFile_oriName(file.getOriginalFilename());
			boardFileVO.setFile_type("A");
			boardFileVO.setReg_id(memberVO.getEmp_no());
			boardFileVO.setMod_id(memberVO.getEmp_no());
			boardFileVO.setUse_yn("Y");
			System.out.println("fileVO" + boardFileVO.toString());
			int result = announcementDAO.setFileAdd(boardFileVO);

			return url; // uri link
		} catch (Exception e) {
			throw new Exception("summernote save error:...{}" + e);
		}
	}

	@Override
	public String setContentsImg(MultipartFile files) throws Exception {
		
		String path = this.filePath + summernote;
		String fileName = fileManager.save(path, files);
		return "/files" + summernote + "/" + fileName;
	}

	@Override
	public boolean setContentsImgDelete(String path) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

}