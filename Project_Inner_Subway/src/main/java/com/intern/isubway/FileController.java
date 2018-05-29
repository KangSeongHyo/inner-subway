package com.intern.isubway;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileController {

	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public void upload(MultipartFile file, HttpServletRequest request) throws IllegalStateException, IOException {
		System.out.println("들어오니?");
		
		String path=request.getSession().getServletContext().getRealPath("/resources/");
		System.out.println(path);
		
		File newfile = new File(path + file.getOriginalFilename());
		
		file.transferTo(newfile);
	}

}
