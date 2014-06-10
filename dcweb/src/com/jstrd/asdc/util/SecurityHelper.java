package com.jstrd.asdc.util;


import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 * @author 向雪平  2013-09-21 加密通用类
 */
public class SecurityHelper
{
	/**
	 * md5加密
	 * 
	 * @param plainText 待加密内容
	 * @param len 长度
	 * @return
	 */
	public static String Md5(String plainText, int len)
	{
		try
		{
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(plainText.getBytes());
			byte b[] = md.digest();
			int i;
			StringBuffer buf = new StringBuffer("");
			for (int offset = 0; offset < b.length; offset++)
			{
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}
			if (len == 16)
				return buf.toString().substring(8, 24);
			else
				return buf.toString();
		} catch (NoSuchAlgorithmException e)
		{
			e.printStackTrace();
			return "";
		}
	}

	/**
	 * 默认md5的32加密
	 * 
	 * @param src 待加密内容
	 * @return String
	 */
	public static String Md5(String src)
	{
		return Md5(src, 32);
	}

	/**
	 * 加密
	 * @param text 待加密内容
	 * @param key 公钥
	 * @return
	 */
	public static String DESEncrypt(String text, String key)
	{
		try
		{
			// 进行3-DES加密后的内容的字节
			DESedeKeySpec dks = new DESedeKeySpec(key.getBytes());
			SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DESede");
			SecretKey skey = keyFactory.generateSecret(dks);
			Cipher cipher = Cipher.getInstance("DESede");
			cipher.init(Cipher.ENCRYPT_MODE, skey);
			byte[] encryptedData = cipher.doFinal(text.getBytes());
			// 进行3-DES加密后的内容进行BASE64编码
			BASE64Encoder base64en = new BASE64Encoder();
			return base64en.encode(encryptedData);
		} catch (Exception e){
			e.printStackTrace();
			return text;
		}
	}

	/**
	 * 解密
	 * @param text 待解密内容
	 * @param key 公钥
	 * @return
	 */
	public static String DESDecrypt(String text, String key)
	{
		try
		{
			// 进行3-DES加密后的内容进行BASE64解码
			BASE64Decoder base64Decode = new BASE64Decoder();
			byte[] base64DValue = base64Decode.decodeBuffer(text);
			// 进行3-DES解密后的内容的字节
			DESedeKeySpec dks = new DESedeKeySpec(key.getBytes());
			SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DESede");
			SecretKey skey = keyFactory.generateSecret(dks);
			Cipher cipher = Cipher.getInstance("DESede");
			cipher.init(Cipher.DECRYPT_MODE, skey);
			byte[] encryptedData = cipher.doFinal(base64DValue);
			return new String(encryptedData);
		} catch (Exception e)
		{
			e.printStackTrace();
			return text;
		}
	}
	
	/**
	 * 测试加密后的密文
	 */
	public static void main(String[] args){ 	
		String banks[]={"dcweb","dcwebtest"};  
		String key = "8a!2e4b4%1b6e2&ba5.-011b?720f-=+";
		for(String a:banks){
			a = DESEncrypt(a,key);
			System.out.println(a);
		}
	}
	


}
