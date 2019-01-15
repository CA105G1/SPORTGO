package com.sg_info.controller;

import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sg_info.model.Sg_infoService;

public class Sg_infoImgServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Sg_infoImgServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String sg_no = req.getParameter("sg_no");
		Sg_infoService svc = new Sg_infoService();
		byte[] pic = svc.GetByPK(sg_no).getSg_pic();
//		pic = shrink(pic, 300);
		
		res.setContentType("image/*");
		res.setContentLength(pic.length);
		ServletOutputStream out = res.getOutputStream();
		out.write(pic);
		out.close();
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	
	
	//照片縮圖
	public static byte[] shrink(byte[] srcImageData, int scaleSize) {
		ByteArrayInputStream bais = new ByteArrayInputStream(srcImageData);
		// 縮小比例，4代表除以4
		int sampleSize = 1;
		int imageWidth = 0;
		int imageHeight = 0;

		// 如果imageSize為0、負數(代表錯誤)或1(1代表與原圖一樣大小)，就直接回傳原圖資料
		if (scaleSize <= 1) {
			return srcImageData;
		}

		try {
			BufferedImage srcBufferedImage = ImageIO.read(bais);
			// 如果無法識別圖檔格式(TYPE_CUSTOM)就回傳TYPE_INT_ARGB；否則回傳既有格式
			int type = srcBufferedImage.getType() == BufferedImage.TYPE_CUSTOM ? BufferedImage.TYPE_INT_RGB
					: srcBufferedImage.getType();
			imageWidth = srcBufferedImage.getWidth();
			imageHeight = srcBufferedImage.getHeight();
			if (imageWidth == 0 || imageHeight == 0) {
				return srcImageData;
			}
			// 只要圖檔較長的一邊超過指定長度(desireSize)，就計算欲縮小的比例
			// 並將圖檔寬高都除以欲縮小比例
			int longer = Math.max(imageWidth, imageHeight);
			if (longer > scaleSize) {
				sampleSize = longer / scaleSize;
				imageWidth = srcBufferedImage.getWidth() / sampleSize;
				imageHeight = srcBufferedImage.getHeight() / sampleSize;
			}
			BufferedImage scaledBufferedImage = new BufferedImage(imageWidth,
					imageHeight, type);
			Graphics graphics = scaledBufferedImage.createGraphics();
			graphics.drawImage(srcBufferedImage, 0, 0, imageWidth, imageHeight,
					null);
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			ImageIO.write(scaledBufferedImage, "jpg", baos);
			return baos.toByteArray();
		} catch (IOException e) {
			e.printStackTrace();
			return srcImageData;
		}
	}
	
	
}
