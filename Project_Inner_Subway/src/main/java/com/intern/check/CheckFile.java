package com.intern.check;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.apache.tika.metadata.Metadata;
import org.apache.tika.parser.AutoDetectParser;
import org.apache.tika.parser.Parser;
import org.apache.tika.sax.BodyContentHandler;
import org.springframework.stereotype.Component;
import org.xml.sax.ContentHandler;


@Component
public class CheckFile {

	public void check(String path) throws IOException {
		FileInputStream is = null;
		System.out.println("들어오니 체크");
		try {
			File f = new File(path);
			is = new FileInputStream(f);

			ContentHandler contenthandler = new BodyContentHandler();
			Metadata metadata = new Metadata();
			metadata.set(Metadata.RESOURCE_NAME_KEY, f.getName());
			Parser parser = new AutoDetectParser();
			// OOXMLParser parser = new OOXMLParser();
			parser.parse(is, contenthandler, metadata, null);
			System.out.println("Mime: " + metadata.get(Metadata.CONTENT_TYPE));
			System.out.println("Title: " + metadata.get(Metadata.TITLE));
			System.out.println("Author: " + metadata.get(Metadata.AUTHOR));
			System.out.println("content: " + contenthandler.toString());

		} catch (Exception e) {

			e.printStackTrace();

		} finally {
			
			if (is != null)
				is.close();
		}
	}

	/*	String resultcode = "";
	
		String resultmessage = "";
	
		//이미지 파일 체크 로직
	
		public boolean isImageFile(String szFilePath) throws IOException {
	
			boolean isRst = false;
			String szFileHeader = "";
			String[] szArrImgHeader = {"89504E470D0A1A0A0000000D49484452", "FFD8FF", "424D"};
	
			if (szFilePath != null && !szFilePath.equals("")) {
	
				if (fileUploadCheckJpg(szFilePath)) {
	
					szFileHeader = fileToByte(szFilePath); //업로드 하려는 파일 헤더 체크 
	
					if (szFileHeader != null && !szFileHeader.equals("")) {
	
						for (int i = 0; i < szArrImgHeader.length; i++) {
	
							int len = szArrImgHeader[i].length();
	
							if (szArrImgHeader[i].equals(szFileHeader.substring(0, len))) {
	
								isRst = true;
	
								break;
	
							}
	
						}
	
					}
	
				}
	
			}
	
			return isRst;
	
		}
	
		//파일 헤더 체크
	
		public String fileToByte(String szFilePath) throws IOException {
	
			byte[] b = new byte[16];
	
			String szFileHeader = "";
	
			DataInputStream in = null;
	
			//파일을 DataInputStream에 넣고 byte array로 읽어들임.(담기)
	
			in = new DataInputStream(new FileInputStream(szFilePath));
	
			in.read(b);
	
			for (int i = 0; i < b.length; i++) {
	
				szFileHeader += byteToHex(b[i]);
	
			}
	
			if (in != null) {
				in.close();
			}
	
			return szFileHeader;
	
		}
	
		//byte -> Hex(String)로 변경
	
		public String byteToHex(byte in) {
	
			byte ch = 0x00;
	
			String pseudo[] = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"};
	
			StringBuffer out = new StringBuffer();
	
			ch = (byte)(in & 0xF0);
	
			ch = (byte)(ch >>> 4);
	
			ch = (byte)(ch & 0x0F);
	
			out.append(pseudo[(int)ch]);
	
			ch = (byte)(in & 0x0F);
	
			out.append(pseudo[(int)ch]);
	
			String rslt = new String(out);
	
			return rslt;
	
		}
	
		public boolean fileUploadCheckJpg(String fileName) {
	
			boolean result = false;
	
			String check = fileName.substring(fileName.lastIndexOf("."));
	
			if (check.equalsIgnoreCase(".jpg") || check.equalsIgnoreCase(".bmp") || check.equalsIgnoreCase(".png")) {
	
				result = true;
	
			}
	
			return result;
	
		}*/
}
