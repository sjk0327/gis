package ictway.gis.map.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GisMapController {
	@RequestMapping(value = "/gisMapMain.do")
	public String selectSampleList() throws Exception {
		return "gis/map";
	}
}
