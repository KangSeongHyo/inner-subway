package com.intern.check;

import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.IOException;

public class CheckFile {
	String resultcode = "";

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

	}
}
