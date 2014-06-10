package com.jstrd.asdc.thread;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.GradientPaint;
import java.awt.Image;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;

import org.apache.log4j.Logger;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.AreaRenderer;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.data.category.DefaultCategoryDataset;

/**
 * 绘制报告图形类
 */
@SuppressWarnings("unchecked")
public class ReportImage{
	private static Logger logger = Logger.getLogger(ReportImage.class.getName());
	public String areaImage(List<Map> data, String title, String fileName)throws IOException {
		DefaultCategoryDataset defaultcategorydataset = new DefaultCategoryDataset();
		if (data != null && data.size() > 0) {
			for (int i = 0; i < data.size(); i++) {
				Map dt = (Map) data.get(i);
				defaultcategorydataset.addValue(Double.parseDouble(dt.get("pac").toString()),"", dt.get("rtime").toString());
			}
		}
		JFreeChart chart = ChartFactory.createAreaChart(
				title, 	//图表标题
				null, 	//目录轴的显示标签
				null, 	//数值轴的显示标签
				defaultcategorydataset,		//数据集 
				PlotOrientation.VERTICAL, 	//图表方向：水平、垂直
				false, 	//是否显示图例(对于简单的柱装图必须是 false)
				false, 	//是否生成工具
				false	//是否生成 URL 链接
				);
		chart.setBackgroundPaint(new Color(204, 255, 255));// 全图背景色
		//设置背景图片
		Image image = null;
		String realPath=this.getClass().getResource("/").getPath().toString();
		realPath=realPath.replaceAll("%20"," ");
		String url = "";
		url = realPath+"/../../images/"+"chart_background.jpg";
		try {
			image = ImageIO.read(new File(url));
		} catch (Exception e) {
			logger.error(e);
		}
		chart.setBackgroundImage(image);
		AreaRenderer renderer = new AreaRenderer();// 绘制的图形
		renderer.setSeriesPaint(0, new Color(0, 153, 255));// 图形前景
		renderer.setSeriesOutlinePaint(0, Color.BLACK);
		renderer.setSeriesOutlineStroke(0, new BasicStroke(5));
		CategoryPlot plot = chart.getCategoryPlot();// 整个绘图区（不包括ＸＹ坐标以外）
		plot.setForegroundAlpha(0.5f);// 前影透明
		plot.setRenderer(renderer);
		plot.setBackgroundPaint(new Color(204, 255, 255));
		//取得横轴
		CategoryAxis axis = plot.getDomainAxis();
		//数据轴下(左)边距
		axis.setLowerMargin(0.0);	// Ｘ轴相对左边距离
		//数据轴上（右）边距
		axis.setUpperMargin(0.0);	// Ｘ轴相对右边距离
		//x坐标轴标尺值是否显示
		axis.setTickLabelsVisible(false);
		axis.setTickMarkOutsideLength(10f);
		axis.setTickMarkInsideLength(10f);
		//坐标轴标尺颜色
		axis.setTickMarkPaint(Color.red);
		//数据轴下（左）边距
		axis.setLowerMargin(0.00);
		//数据轴上（右）边距
		axis.setUpperMargin(0.00);
		axis.setTickMarksVisible(true);
		axis.setCategoryLabelPositionOffset(20);
		//竖着显示 
		plot.getRangeAxis().setLowerMargin(0.0);// Ｙ轴距离底边距离
		FileOutputStream out = new FileOutputStream(fileName);
		ChartUtilities.writeChartAsJPEG(out, chart, 500, 300);
		return null;
	}

	public String barImage(List<Map> data, String title, String fileName) throws IOException {
		DefaultCategoryDataset defaultcategorydataset = new DefaultCategoryDataset();
		if (data != null && data.size() > 0) {
			for (int i = 0; i < data.size(); i++) {
				Map dt = (Map) data.get(i);
				defaultcategorydataset.addValue(Double.parseDouble(dt.get("e_total").toString()), "", dt.get("recvdate").toString());
			}
		}
		JFreeChart jfreechart = ChartFactory.createBarChart("", "", "", defaultcategorydataset, PlotOrientation.VERTICAL, false, false, false);
		jfreechart.setBackgroundPaint(new Color(204, 255, 255));
		CategoryPlot categoryplot = jfreechart.getCategoryPlot();
		categoryplot.setBackgroundPaint(new Color(204, 255, 255));
		categoryplot.setDomainGridlinePaint(new Color(0, 153, 255));
		categoryplot.setDomainGridlinesVisible(true);
		categoryplot.setRangeGridlinePaint(Color.black);
		NumberAxis numberaxis = (NumberAxis) categoryplot.getRangeAxis();
		numberaxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
		BarRenderer barrenderer = (BarRenderer) categoryplot.getRenderer();
		barrenderer.setDrawBarOutline(false);
		GradientPaint gradientpaint = new GradientPaint(0.0F, 0.0F, new Color(0, 153, 255), 0.0F, 0.0F, new Color(0, 0, 64));
		barrenderer.setSeriesPaint(0, gradientpaint);
		CategoryAxis categoryaxis = categoryplot.getDomainAxis();
		categoryaxis.setCategoryLabelPositions(CategoryLabelPositions.createUpRotationLabelPositions(0.52359877559829882D));
		FileOutputStream out = new FileOutputStream(fileName);
		ChartUtilities.writeChartAsJPEG(out, jfreechart, 700, 300);
		return null;
	}
	
	public static void main(String args[]) throws IOException {
		//ReportImage areachartdemo1 = new ReportImage();
		//areachartdemo1.areaImage(null, "2013-10-23", "d:\\1.jpg");
	}
	
}
