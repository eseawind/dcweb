package com.jstrd.asdc.action;

import java.util.Map;

import com.jstrd.asdc.service.InverterService;
import com.jstrd.asdc.service.StationService;

public class BeanAction extends BaseAction{
	
	private StationService stationService;
	
	private InverterService inverterService;
	
	public String getStationName(int stationid){
		Map stationMap = stationService.findStationById(stationid);
		return stationMap.get("stationname")==null?"":stationMap.get("stationname").toString();
	}

	public StationService getStationService() {
		return stationService;
	}

	public void setStationService(StationService stationService) {
		this.stationService = stationService;
	}

	public InverterService getInverterService() {
		return inverterService;
	}

	public void setInverterService(InverterService inverterService) {
		this.inverterService = inverterService;
	}

}
