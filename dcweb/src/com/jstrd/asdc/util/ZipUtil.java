package com.jstrd.asdc.util;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;
import java.util.zip.*;

// 将一个字符串按照zip方式压缩和解压缩
public class ZipUtil {

  // 压缩
  public static String compress(String str) throws IOException {
    if (str == null || str.length() == 0) {
      return str;
    }
    ByteArrayOutputStream out = new ByteArrayOutputStream();
    GZIPOutputStream gzip = new GZIPOutputStream(out);
    gzip.write(str.getBytes());
    gzip.close();
    return out.toString("ISO-8859-1");
  }

  // 解压缩
  public static String uncompress(String str) throws IOException {
    if (str == null || str.length() == 0) {
      return str;
    }
    ByteArrayOutputStream out = new ByteArrayOutputStream();
    ByteArrayInputStream in = new ByteArrayInputStream(str.getBytes("ISO-8859-1"));
    GZIPInputStream gunzip = new GZIPInputStream(in);
    byte[] buffer = new byte[256];
    int n;
    while ((n = gunzip.read(buffer)) >= 0) {
      out.write(buffer, 0, n);
    }
    // toString()使用平台默认编码，也可以显式的指定如toString("GBK")
    return out.toString("ISO-8859-1");
  }

 
  public static final byte[] compress1(String str) {
  if(str == null)
  return null;
   
  byte[] compressed;
  ByteArrayOutputStream out = null;
  ZipOutputStream zout = null;
   
  try {
  out = new ByteArrayOutputStream();
  zout = new ZipOutputStream(out);
  zout.putNextEntry(new ZipEntry("0"));
  zout.write(str.getBytes());
  zout.closeEntry();
  compressed = out.toByteArray();
  } catch(IOException e) {
  compressed = null;
  } finally {
  if(zout != null) {
  try{zout.close();} catch(IOException e){}
  }
  if(out != null) {
  try{out.close();} catch(IOException e){}
  }
  }
   
  return compressed;
  }
   
 
  public static final String decompress(byte[] compressed) {
  if(compressed == null)
  return null;
   
  ByteArrayOutputStream out = null;
  ByteArrayInputStream in = null;
  ZipInputStream zin = null;
  String decompressed;
  try {
  out = new ByteArrayOutputStream();
  in = new ByteArrayInputStream(compressed);
  zin = new ZipInputStream(in);
  ZipEntry entry = zin.getNextEntry();
  byte[] buffer = new byte[1024];
  int offset = -1;
  while((offset = zin.read(buffer)) != -1) {
  out.write(buffer, 0, offset);
  }
  decompressed = out.toString();
  } catch (IOException e) {
  decompressed = null;
  } finally {
  if(zin != null) {
  try {zin.close();} catch(IOException e) {}
  }
  if(in != null) {
  try {in.close();} catch(IOException e) {}
  }
  if(out != null) {
  try {out.close();} catch(IOException e) {}
  }
  }
   
  return decompressed;
  }

  // 测试方法
  public static void main(String[] args) throws IOException {
	  String s1="You have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your accountYou have successfully registered, we sent an activation email to your mailbox, enter your PIN to activate your account";
   System.out.println("starttime="+ZipUtil.compress("starttime"));
   String s=ZipUtil.compress(s1);
   System.out.println(s1.length());
   System.out.println(s.length());
    System.out.println(ZipUtil.uncompress(s));
    System.out.println("starttime="+ZipUtil.compress1(s1).length);
    System.out.println("starttime="+ZipUtil.decompress(ZipUtil.compress1(s1)));
  }

 

}

