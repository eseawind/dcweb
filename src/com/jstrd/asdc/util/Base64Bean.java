package com.jstrd.asdc.util;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class Base64Bean {
    
    /** BASE64加密  */              
    public static String encryptBASE64(byte[] key) throws Exception {               
        return (new BASE64Encoder()).encodeBuffer(key);               
    }
    
	/** BASE64解密 */              
    public static byte[] decryptBASE64(String key) throws Exception {               
        return (new BASE64Decoder()).decodeBuffer(key);               
    } 
}
