package com.lib.fin.commons;

import java.io.File;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileManager {
	

		public String save(String path, MultipartFile multipartFile)throws Exception{

			
			File file = new File(path);
			
			if(!file.exists()) {
				
				file.mkdirs();
			}
			
			String fileName = UUID.randomUUID().toString()+"_"+multipartFile.getOriginalFilename();
			System.out.println("===========>> FileManager :"+fileName);
			file = new File(file, fileName);

			multipartFile.transferTo(file);
			
				
			return fileName;
			
		}
		
		
		//파일삭제
		public boolean fileDelete(FileVO fileVO, String path) {
		    // 1. 삭제할 폴더의 실제 경로
		   
		    File file = new File(path, fileVO.getFile_name());


		    return file.delete();
		}

}
