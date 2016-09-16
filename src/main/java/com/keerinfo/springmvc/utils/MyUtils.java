package com.keerinfo.springmvc.utils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;

import javax.activation.MimetypesFileTypeMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

public class MyUtils {
	/**
	 * 配置文件名
	 */
	private static final String PROPFILENAME = "database.properties";
	public static final String TABLENAME = "TABLENAME";
	public static final String CONTENTIDS = "contentIds";
	public static final String CONTENTID = "contentId";
	public static final String PRIMARYKEY = "PRIMARYKEY";
	public static final String PARAMS = "params";

	private static final Logger LOGGER = Logger.getLogger(MyUtils.class);
	/**
	 * 编码 utf-8
	 */
	public static final String ENCODING = "ENCODING";

	private static final String account = "tiaotiwangluo";/* 短信平台账号 */
	private static final String password = "2594511Lbc$";/* 密码 */
	private static Properties p = new Properties();
	private static Properties properties = new Properties();
	static {
		try {
			p.load(Thread.currentThread().getContextClassLoader()
					.getResourceAsStream(PROPFILENAME));
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 从constant.properties文件中读取属性值
	 *
	 * @param propertyName
	 *            属性名称
	 * @return
	 */
	public static String getProperty(String propertyName) {
		return p.getProperty(propertyName);
	}

	/**
	 * 根据参数拼接insert sql
	 * @param tableName
	 * @param primaryKey
	 * @param paramsMap
     * @return
     */
	public static String getInsertSql(String tableName,String primaryKey,Map<String, Object> paramsMap){
		if(MyUtils.isEmpty(tableName) || MyUtils.isEmpty(primaryKey) || paramsMap == null)
			return "";
		StringBuffer sb = new StringBuffer();
		StringBuffer sb1 = new StringBuffer();
		StringBuffer sb2 = new StringBuffer();
		sb.append(" insert into " + tableName + "(");
		sb1.append(primaryKey + ",");
		sb2.append("'" + MyUtils.getUUID() + "',");
		if(paramsMap != null && paramsMap.size() > 0){
			for (Map.Entry<String, Object> entry : paramsMap.entrySet()) {
				sb1.append(entry.getKey() + ",");
				sb2.append("'" + entry.getValue() + "',");
			}
		}
		MyUtils.subString(sb1);
		MyUtils.subString(sb2);
		sb.append(sb1.toString());
		sb.append(") values (");
		sb.append(sb2.toString());
		sb.append(")");
		return sb.toString();
	}

	/**
	 * 根据参数拼接update sql
	 * @param tableName
	 * @param primaryKey
	 * @param paramsMap
     * @return
     */
	public static  String getUpdateSql(String tableName,String primaryKey,String contentId,Map<String, Object> paramsMap){
		if(MyUtils.isEmpty(tableName) || MyUtils.isEmpty(primaryKey) || MyUtils.isEmpty(contentId) || paramsMap == null)
			return "";
		StringBuffer sb = new StringBuffer();
		sb.append("UPDATE "+ tableName +" S SET ");

		if(paramsMap != null && paramsMap.size() > 0){
			for (Map.Entry<String, Object> entry : paramsMap.entrySet()) {
				sb.append("S." + entry.getKey() + " = '" + entry.getValue() + "',");
			}
		}
		MyUtils.subString(sb);
		sb.append(" WHERE S."+ primaryKey +" = '" + contentId + "'");
		return sb.toString();
	}

	/**
	 * 主键生成策略
	 *
	 * @return
	 */
	public static String getUUID() {
		UUID uuid = UUID.randomUUID();
		String str = uuid.toString();
		// 去掉"-"符号
		/*
		 * String temp = str.substring(0, 8) + str.substring(9, 13) +
		 * str.substring(14, 18) + str.substring(19, 23) + str.substring(24);
		 * System.out.println(temp);
		 */
		return str.replaceAll("-", "");
	}
	/**
	 * 去掉字符串中最后一个符号，如果存在
	 * @date 2015-12-8 下午5:21:39
	 * @param sb
	 * @return void
	 */
	public static void subString(StringBuffer sb){
		if(sb.toString().endsWith(",")){
			sb = sb.delete(sb.toString().length()-1, sb.toString().length());
		}
	}
	public static String getParam(HttpServletRequest request, String name){
		return request.getParameter(name);
	}
	public static Map<String, Object> getParamsMap(Map<String, String[]> map){
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		for(Map.Entry<String, String[]> entry : map.entrySet()){
			if(entry.getKey().indexOf(TABLENAME) < 0 && entry.getKey().indexOf(CONTENTID) < 0 && entry.getKey().indexOf(PRIMARYKEY) < 0){
				paramsMap.put(entry.getKey(), entry.getValue()[0]);
			}
		}
		return paramsMap;
	}

	/**
	 * 获取客户端IP
	 * @param request
	 * @return
	 */
	public static String getIp2(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (!isEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)) {
			// 多次反向代理后会有多个ip值，第一个ip才是真实ip
			int index = ip.indexOf(",");
			if (index != -1) {
				return ip.substring(0, index);
			} else {
				return ip;
			}
		}
		ip = request.getHeader("X-Real-IP");
		if (!isEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)) {
			return ip;
		}
		return request.getRemoteAddr();
	}

	/**
	 * 格式化时间
	 *
	 * @param d
	 * @return
	 */
	public static String getTime(Date d) {
		Date date = d == null ? new Date() : d;
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
	}

	/**
	 * 根据ResultSet对象转化JSONArray
	 *
	 * @date 2015-12-2 下午12:00:50
	 * @param rs
	 * @throws SQLException
	 * @return JSONArray
	 */
	/*public static JSONArray getAllResultToJSON(ResultSet rs)
			throws SQLException {
		if (rs == null)
			return null;
		ResultSetMetaData rsmd = rs.getMetaData();
		int count = rsmd.getColumnCount();
		JSONArray array = new JSONArray();
		JSONObject o = null;
		while (rs.next()) {
			o = new JSONObject();
			for (int i = 1; i <= count; i++) {
				*//* rsmd.getColumnType(i);//获取列的数据类型 *//*
				o.put(rsmd.getColumnName(i), rs.getString(i));*//* 获取列名,或列值,都是从1开始 *//*
			}
			array.add(o);
		}
		return array;
	}*/

	/**
	 * 判断该文件是否为上传的文件类型
	 *
	 * @param uploadfile
	 * @return
	 */
	public static Boolean readUploadFileType(File uploadfile) {
		if (uploadfile != null && uploadfile.length() > 0) {
			String ext = uploadfile.getName()
					.substring(uploadfile.getName().lastIndexOf(".") + 1)
					.toLowerCase();
			List<String> allowfiletype = new ArrayList<String>();
			for (Object key : properties.keySet()) {
				String value = (String) properties.get(key);
				String[] values = value.split(",");
				for (String v : values) {
					allowfiletype.add(v.trim());
				}
			}
			// "Mime Type of gumby.gif is image/gif"
			return allowfiletype.contains(new MimetypesFileTypeMap()
					.getContentType(uploadfile).toLowerCase())
					&& properties.keySet().contains(ext);
		}
		return true;
	}

	/**
	 * 产生六位验证码100000-999999之间
	 *
	 * @return
	 */
	public static int getRandomNumber() {
		Random random = new Random();
		return random.nextInt(899999) + 100000;
	}

	/**
	 * 产生四位随机数1000-9999之间
	 *
	 * @return
	 */
	public static int getFourRandomNumber() {
		Random random = new Random();
		return random.nextInt(8999) + 1000;
	}

	public static void main(String[] args) {
		/*
		 * int code = getRandomNumber(); try { log.info(getCode(code,
		 * "18771101299,13995539136,13476797171")); } catch
		 * (UnsupportedEncodingException e) { e.printStackTrace(); }
		 */
		System.out.println(getUUID());
	}

	/**
	 * 输出，返回值
	 *
	 * @param response
	 * @param reply
	 * @throws IOException
	 */
	public static void print(HttpServletResponse response, String reply)
			throws IOException {
		PrintWriter out = response.getWriter();
		out.print(reply);
		out.flush();
		out.close();
	}

	/**
	 * http/https post/get
	 *
	 * @param requestUrl
	 * @param requestMethod
	 * @param outputStr
	 * @return
	 */
	public static JSONObject httpRequest(String requestUrl,
										 String requestMethod, String outputStr) {
		StringBuffer buffer = new StringBuffer();
		JSONObject obj = new JSONObject();
		try {
			URL url = new URL(requestUrl);
			HttpURLConnection httpUrlConn = (HttpURLConnection) url
					.openConnection();
			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);

			httpUrlConn.setRequestMethod(requestMethod);

			// if ("GET".equalsIgnoreCase(requestMethod))
			httpUrlConn.connect();
			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				outputStream.write(outputStr.getBytes("UTF-8"));
				outputStream.close();
			}
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(
					inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(
					inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			obj = JSONObject.fromObject(buffer.toString());
		} catch (ConnectException ce) {
			ce.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return obj;
	}

	/**
	 * sha1算法
	 *
	 * @param convertme
	 * @return
	 * @throws Exception
	 */
	public static String SHAsum(byte[] convertme) throws Exception {
		MessageDigest md = MessageDigest.getInstance("SHA-1");
		return byteArray2Hex(md.digest(convertme));
	}

	public static String byteArray2Hex(final byte[] hash) {
		Formatter formatter = new Formatter();
		for (byte b : hash) {
			formatter.format("%02x", b);
		}
		return formatter.toString();
	}

	/**
	 * 短信机 根据获取的随机验证码发送post
	 *
	 * @param code
	 * @param phone
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String getCode(int code, String phone)
			throws UnsupportedEncodingException {
		String content = "验证码为：" + code
				+ "，5分钟内有效。尊敬的客户您好，您刚申请注册挑T网络，如非本人操作，请忽略该短信。【挑T网络】";
		String url = "http://sms.chanzor.com:8001/sms.aspx?action=send";
		String PostData = "userid=&account=" + account + "&password="
				+ password + "&mobile=" + phone + "&sendTime=&content="
				+ java.net.URLEncoder.encode(content, "utf-8");
		String reply = httpRequest(PostData, url);
		return reply;
	}

	/**
	 * 短信机 发送post请求获取验证码
	 *
	 * @param postData
	 * @param postUrl
	 * @return
	 */
	private static String httpRequest(String postData, String postUrl) {
		try {
			// 发送POST请求
			URL url = new URL(postUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type",
					"application/x-www-form-urlencoded");
			conn.setRequestProperty("Connection", "Keep-Alive");
			conn.setUseCaches(false);
			conn.setDoOutput(true);

			conn.setRequestProperty("Content-Length", "" + postData.length());
			OutputStreamWriter out = new OutputStreamWriter(
					conn.getOutputStream(), "UTF-8");
			out.write(postData);
			out.flush();
			out.close();

			// 获取响应状态
			if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
				LOGGER.info("connect failed!");
				return "";
			}
			// 获取响应内容体
			String line, result = "";
			BufferedReader in = new BufferedReader(new InputStreamReader(
					conn.getInputStream(), "utf-8"));
			while ((line = in.readLine()) != null) {
				result += line + "\n";
			}
			in.close();
			return result;
		} catch (IOException e) {
			e.printStackTrace(System.out);
		}
		return "";
	}

	/**
	 * 判断字符串是否为空
	 *
	 * @param str
	 * @return
	 */
	public static boolean isEmpty(String str) {
		return str == null || "".equals(str);
	}

	/**
	 * 判断json对象是否为空
	 *
	 * @param array
	 * @return
	 */
	public static boolean isEmpty(JSONArray array) {
		return array == null || array.size() == 0;
	}
}
