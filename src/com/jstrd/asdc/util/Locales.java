package com.jstrd.asdc.util;

import java.util.Hashtable;
import java.util.Locale;
import java.util.Map;

public class Locales {
	public Map<String, Locale> getLocales() {
        Map<String, Locale> locales =new Hashtable<String, Locale>(3);
        locales.put("American English", Locale.US);
        locales.put("Simplified Chinese", Locale.CHINA);
        return locales;
    }
}
