package com.jstrd.asdc.servlet;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;

//生成等比例高质量缩略图
public class Thumbnail {

    private static BufferedImage scaleImg(BufferedImage srcBufferImg, int formatW, int formatH) throws Exception{
        BufferedImage target = new BufferedImage((int) formatW,   
                (int) formatH, BufferedImage.TYPE_INT_RGB);   
        target.getGraphics().drawImage(   
        		srcBufferImg.getScaledInstance(formatW, formatH,   
                        Image.SCALE_SMOOTH), 0, 0, null);   
        return target;
    }     

    public void writeFinalImg(BufferedImage srcImg, File destFile,int minSize) throws Exception {
        int srcW = srcImg.getWidth();
        int srcH = srcImg.getHeight();
        int formatW = 0;
        int formatH = 0;
        if(srcW>srcH){
        	formatH = minSize;
        	formatW = srcW*formatH/srcH;
        	 
        }else{
        	formatW = minSize;
        	formatH = srcH*formatW/srcW;
        }
    	makeThumbnail(srcImg, destFile,formatW,formatH,false,false);
    }
    public void writeBigImg(BufferedImage srcImg, File destFile,int formatW,int formatH) throws Exception {
    	makeThumbnail(srcImg, destFile,formatW,formatH,false,true);
    }
    public void writeMiddleImg(BufferedImage srcImg, File destFile,int formatW,int formatH) throws Exception {
    	makeThumbnail(srcImg, destFile,formatW,formatH,false,true);
    }
    public void writeSmallImg(BufferedImage srcImg, File destFile,int sqrSize) throws Exception {
    	makeThumbnail(srcImg, destFile,sqrSize,sqrSize,true,true);
    }
    
    public void writeRssImg(BufferedImage srcImg, File destFile,int minSize) throws Exception {
        ScaleImage scaleImage=  new ScaleImage();
        scaleImage.saveImagetoJpg(srcImg, destFile, 320, 250);
    }
    
    /**
     * 生成缩略图
     * cutEdge:去长边
     * needWhiteSpace：空白处留白
     */
    private void makeThumbnail(BufferedImage srcImg, File destFile,int formatW,int formatH,boolean cutEdge,boolean needWhiteSpace) throws Exception {
    	int srcW = srcImg.getWidth();
        int srcH = srcImg.getHeight();
        //如果原图尺寸大于规定输出尺寸，进行等比压缩等处理
        if(srcW>formatW||srcH>formatH){
        	//如果需要截边，原图按输出比例截去长边--仅对长图（原图尺寸）截边
            if(cutEdge&&(srcW>srcH)){
            	srcImg = cutImg(srcImg, formatW, formatH);
                srcW = srcImg.getWidth();
                srcH = srcImg.getHeight();
            }
            int towidth = 0;
            int toheight = 0;
            //等比压缩：以长为基准
        	towidth = formatW;
        	toheight = srcH*formatW/srcW;
        	if(toheight>formatH){
        		//（以长为基准后的图片高超出规定输出图片高度）等比压缩：以高为基准
            	toheight = formatH;
            	towidth = srcW*formatH/srcH;
        	}
        	srcImg = scaleImg(srcImg, towidth, toheight);
            srcW = srcImg.getWidth();
            srcH = srcImg.getHeight();
        	//the end
        }
        //如果需要填白
        if(needWhiteSpace&&(srcW<formatW||srcH<formatH)){
        	//等比压缩后的图比规定输出尺寸小，填充空白处
    		srcImg = drawFixSizeImg(srcImg,formatW,formatH);
        }
        //往服务器写入jpg格式图片
        ImageIO.write(srcImg, "JPEG", destFile);
    }
    /**
     * 根据输出图的长宽比仅对长图（原图尺寸）截边
     */
    private BufferedImage cutImg(BufferedImage srcImg, int formatW, int formatH ){
    	int srcW = srcImg.getWidth();
        int srcH = srcImg.getHeight();
        int toheight = srcH;
        int towidth = formatW/formatH*srcH;//以高为计算基数
        if(srcW>towidth){
    		int x = (srcW-towidth)/2;
    		int y = 0;
    		srcImg = srcImg.getSubimage(x, y, towidth, toheight);
        }
    	return srcImg;
    }
    /**
     * 对图周边填白
     */
    private BufferedImage drawFixSizeImg(BufferedImage srcBufImg, int formatW, int formatH ){
    	
    	BufferedImage target = new BufferedImage(formatW, formatH,BufferedImage.SCALE_SMOOTH);
    	Graphics2D g = target.createGraphics();
        int srcW = srcBufImg.getWidth();
        int srcH = srcBufImg.getHeight();
    	int x = (formatW - srcW)/2;
    	int y = (formatH- srcH)/2;
    	g.fillRect(0, 0, formatW, formatH);//fillRect画的是实心的矩形
    	g.drawImage(srcBufImg,x, y, srcW, srcH, null);
    	g.dispose();
		return target;
    }
}
