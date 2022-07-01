package com.market.root.common;

public class XSSClass {
   public static String[] replaceParmeter(String[] strRep) {
      if(strRep.length > 0) {
         for(int i=0; i<strRep.length ; i++) {
        	 
        	strRep[i] = strRep[i].replace("<", "&lt;");
 			strRep[i] = strRep[i].replace(">", "&gt;");
 			strRep[i] = strRep[i].replace("\\(", "& #40;");
 			strRep[i] = strRep[i].replace("\\)", "& #41;");
 			strRep[i] = strRep[i].replace("'", "& #39;");
 			strRep[i] = strRep[i].replace("eval\\((.*)\\)", "");
 			strRep[i] = strRep[i].replace("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
 			strRep[i] = strRep[i].replace("script", "");
 			strRep[i] = strRep[i].replace("\"", "&quot;");
 			
         }
      }
      return strRep;
   }
}