package com.keerinfo.springmvc.service.impl;

import com.keerinfo.springmvc.service.Service;
import com.keerinfo.springmvc.utils.MyUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class ServiceImpl extends Service {
    private static Logger log = Logger.getLogger(ServiceImpl.class);
    
	/**
	 * 公共添加方法
	 * @Title: save
	 * @Description: 
	 * 2016-9-8下午4:51:35
	 * @param request
	 * @param session
	 * @return   
	 * @throws
	 */
	public int save(HttpServletRequest request, HttpSession session) {
		String logInfo = new Throwable().getStackTrace()[0].toString();
		log.info("---" + logInfo);
		Map<String, String[]> map = request.getParameterMap();
		Map<String, Object> paramsMap = MyUtils.getParamsMap(map);
		String tableName = MyUtils.getParam(request,MyUtils.TABLENAME);
		String primaryKey = MyUtils.getParam(request,MyUtils.PRIMARYKEY);

		String sql = MyUtils.getInsertSql(tableName,primaryKey,paramsMap);
		int flag = update(sql);
		saveLog(request, session, "save", logInfo + "----" + sql + "----- result : " + flag);
		return flag;
	}

	/**
	 * 公共更新方法
	 * @Title: update
	 * @Description: 
	 * 2016-9-8下午4:52:19
	 * @param request
	 * @param session
	 * @return   
	 * @throws
	 */
	public int update(HttpServletRequest request, HttpSession session) {
		String logInfo = new Throwable().getStackTrace()[0].toString();
		log.info("--" + logInfo);
		Map<String, String[]> map = request.getParameterMap();
		Map<String, Object> paramsMap = MyUtils.getParamsMap(map);
		String tableName = MyUtils.getParam(request,MyUtils.TABLENAME);
		String contentId = MyUtils.getParam(request,MyUtils.CONTENTID);
		String primaryKey = MyUtils.getParam(request,MyUtils.PRIMARYKEY);

        String sql = MyUtils.getUpdateSql(tableName,primaryKey,contentId,paramsMap);
		int flag = update(sql);
		saveLog(request, session, "update", logInfo + "----" + sql + "----- result : " + flag);
		return flag;
	}

	/**
	 * 公共删除方法
	 * @Title: delete
	 * @Description: 
	 * 2016-9-8下午4:52:33
	 * @param request
	 * @param session
	 * @return   
	 * @throws
	 */
	public int delete(HttpServletRequest request, HttpSession session) {
		String logInfo = new Throwable().getStackTrace()[0].toString();
		log.info("--" + logInfo);
		String tableName = MyUtils.getParam(request,MyUtils.TABLENAME);
		String contentId = MyUtils.getParam(request,MyUtils.CONTENTID);
		String primaryKey = MyUtils.getParam(request,MyUtils.PRIMARYKEY);

		String sql = "delete from " + tableName + " where " + primaryKey +" = '"+ contentId +"'" ;
		if(!"id".equalsIgnoreCase(primaryKey)){
			sql = "delete from " + tableName + " where " + primaryKey +" <= '"+ contentId +"'" ;
		}
		int flag = update(sql);
		saveLog(request, session, "delete", logInfo + "----" + sql + "----- result : " + flag);
		return flag;
	}

	/**
	 * 登录
	 * @Title: login
	 * @Description: 
	 * 2016-9-8下午6:10:47
	 * @param request
	 * @param session
	 * @return   
	 * @throws
	 */
	/*public int login(HttpServletRequest request, HttpSession session) {
		String logInfo = new Throwable().getStackTrace()[0].toString();
		String username = MyUtils.getParam(request, "username");
		log.info("--" + logInfo);
		String sql = "select count(*) from users where isvalid = 1 and username = '"+ username +"' and password = '"+ MyUtils.getParam(request, "password") +"' ";
		int flag = queryCount(sql);
		if(flag > 0)
		    session.setAttribute("USERNAME", username);
		else
			session.removeAttribute("USERNAME");
		saveLog(request, session, "login", logInfo + "----" + sql + "----- result : " + flag);
		return flag;
	}*/
	/**
	 * 根据上一级ID获取下级分类，如果pid为空，则获取所有的
	 */
	public JSONArray getCategoryArray(HttpServletRequest request) {
		String logInfo = new Throwable().getStackTrace()[0].toString();
		log.info("--" + logInfo);
		JSONArray array = getCategory("0");
		if(array.size() > 0){
			for(int i = 0;i<array.size();i++){
				JSONObject obj = array.getJSONObject(i);
				JSONArray array1 = getCategory(obj.getString("id"));
				if(array1.size() > 0){
					for(int j = 0;j<array1.size();j++){
						JSONObject obj1 = array1.getJSONObject(j);
						JSONArray array2 = getCategory(obj1.getString("id"));
						if(array2.size() > 0){
							for(int k = 0;k<array2.size();k++){
								JSONObject obj2 = array2.getJSONObject(k);
								JSONArray array3 = getCategory(obj2.getString("id"));
								if(array3.size() > 0){
									obj2.put("children", array3.toString());
									array2.set(k, obj2);
								}
							}
							obj1.put("children", array2.toString());
							array1.set(j, obj1);
						}
					}
					obj.put("children", array1.toString());
					array.set(i, obj);
				}
			}
		}
		return array;
	}

	@Override
	public JSONObject getAllResultToJSON(HttpServletRequest request) {
		String params = MyUtils.getParam(request,MyUtils.PARAMS);
		String tableName = MyUtils.getParam(request,MyUtils.TABLENAME);
		String compareName = MyUtils.getParam(request,"compareName");
		String compareName1 = MyUtils.getParam(request,"compareName1");
		String sort = MyUtils.getParam(request,"sort");
		String order = MyUtils.getParam(request,"order");
		int page = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
		int rows = request.getParameter("rows") == null ? 20 : Integer.parseInt(request.getParameter("rows"));
		int first = ( page - 1 ) * rows;
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String param1 = request.getParameter("param1");
		String param2 = request.getParameter("param2");
		StringBuffer sb = new StringBuffer();
		StringBuffer sql = new StringBuffer();
		sb.append(" select " + params + " from " + tableName + " s where 1=1 ");
		sql.append("from " + tableName + " s where 1=1 ");
		JSONObject obj = new JSONObject();
		if(!MyUtils.isEmpty(start)){
             sb.append(" and s. " + compareName + " >= '"+ start +"'" );
			 sql.append(" and s. " + compareName + " >= '"+ start +"'" );
		}
		if(!MyUtils.isEmpty(end)){
			sb.append(" and s. " + compareName + " <= '"+ end +"'");
			sql.append(" and s. " + compareName + " <= '"+ end +"'");
		}
		if(!MyUtils.isEmpty(param1)){
			sb.append(" and s. " + compareName + " = '"+ param1 +"'");
			sql.append(" and s. " + compareName + " = '"+ param1 +"'");
		}
		if(!MyUtils.isEmpty(param2)){
			sb.append(" and s. " + compareName1 + " = '"+ param2 +"'");
			sql.append(" and s. " + compareName1 + " = '"+ param2 +"'");
		}
		if(!MyUtils.isEmpty(sort)){
            sb.append(" order by s."+ sort );
			if(!MyUtils.isEmpty(order)){
                 sb.append(" " + order);
			}
		}
		sb.append(" limit " + first + "," + rows);
		JSONArray array = getAllResultToJSON(sb.toString());
		obj.put("rows",array);
		obj.put("total",queryCount(sql.toString()));
		return obj;
	}

	public String fileUpload(HttpServletRequest request, HttpSession session) {
		/*String title = request.getParameter("title");
		String sort = request.getParameter("sort");
		String tablename = request.getParameter("TABLENAME");
		String primarykey = request.getParameter("PRIMARYKEY");*/

		Map<String, String[]> map = request.getParameterMap();
		Map<String, Object> paramsMap1 = MyUtils.getParamsMap(map);
		String tableName = MyUtils.getParam(request,MyUtils.TABLENAME);
		String contentId = MyUtils.getParam(request,MyUtils.CONTENTID);
		String primaryKey = MyUtils.getParam(request,MyUtils.PRIMARYKEY);

		String path = "";
		String realpath = "";
		String thumbnailUrl = "";
		String realthumbnailUrl = "";
		//创建一个通用的多部分解析器
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
		//判断 request 是否有文件上传,即多部分请求
		if(multipartResolver.isMultipart(request)){
			String baseDir = MyUtils.getProperty("baseDir");
			String realBaseDir = session.getServletContext().getRealPath(baseDir);
			log.info("---项目根路径：" + realBaseDir);
			File baseFile = new File(realBaseDir);
			if (!baseFile.exists()) {
				baseFile.mkdir();
			}
			String fileFolder = new SimpleDateFormat("yyyyMMdd").format(new Date());
			/*文件存储的相对路径*/
			String saveDirPath = baseDir + fileFolder + "/";
			String thsaveDirPath = baseDir + fileFolder + "/thumbnail/";
			/*文件存储在容器中的绝对路径*/
			String saveFilePath = session.getServletContext().getRealPath("") + saveDirPath;
			String thsaveFilePath = session.getServletContext().getRealPath("") + thsaveDirPath;
			/*构建文件目录以及目录文件*/
			File fileDir = new File(saveFilePath);
			if (!fileDir.exists()) {fileDir.mkdirs();}
			File thfileDir = new File(thsaveFilePath);
			if (!thfileDir.exists()) {thfileDir.mkdirs();}
			//转换成多部分request
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
			//取得request中的所有文件名
			Iterator<String> iter = multiRequest.getFileNames();
			while(iter.hasNext()){
				//记录上传过程起始时的时间，用来计算上传时间
				int pre = (int) System.currentTimeMillis();
				//取得上传文件
				MultipartFile file = multiRequest.getFile(iter.next());
				if(file != null){
					//取得当前上传文件的文件名称
					String myFileName = file.getOriginalFilename();
					//如果名称不为“”,说明该文件存在，否则说明该文件不存在
					if(myFileName.trim() !=""){
						log.info("---fileName : " + myFileName);
						String extensionName = myFileName.substring(myFileName.lastIndexOf(".") + 1);
						//重命名上传后的文件名
						String fileName = "Image_" + System.currentTimeMillis() + MyUtils.getRandomNumber() + "." + extensionName;
						//定义上传路径
						realpath = saveFilePath + fileName  ;
						path = saveDirPath + fileName  ;
						thumbnailUrl = thsaveDirPath + fileName;
						realthumbnailUrl = thsaveFilePath + fileName ;
						File localFile = new File(realpath);
						try {
							file.transferTo(localFile);
						} catch (IOException e) {
							e.printStackTrace();
						}
						createPreviewImage(realpath,realthumbnailUrl);
					}
				}
				//记录上传该文件后的时间
				int finaltime = (int) System.currentTimeMillis();
				log.info( "上传时间：" + (finaltime - pre));
			}
		}
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		if(paramsMap1 != null && paramsMap1.size() > 0){
			paramsMap.put("url",path);
			paramsMap.put("thumbnailUrl",thumbnailUrl);
			for (Map.Entry<String, Object> entry : paramsMap1.entrySet()) {
				paramsMap.put(entry.getKey(),entry.getValue());
				log.info("集合遍历 --- " + entry.getKey() + "---" + entry.getValue());
			}
		}
		String sql = MyUtils.getUpdateSql(tableName,primaryKey,contentId,paramsMap);
		if(MyUtils.isEmpty(contentId)){
			sql = MyUtils.getInsertSql(tableName,primaryKey,paramsMap);
		}
        /*String sql = "insert into " + tablename + "("+ primarykey +",title,sort,url,thumbnailUrl) values ('"+ MyUtils.getUUID() +"','"+ title +"',"+ sort +",'"+ path +"','"+ thumbnailUrl +"')";*/
		return update(sql) + "";
	}

	@Override
	public String getCategoryTreeByName(HttpServletRequest request) {
		String module = request.getParameter("module");
		JSONArray array = getCategoryByName(module);
		JSONArray array1 = new JSONArray();
		if(array.size() > 0){
			for(int i = 0;i<array.size();i++){
				JSONObject obj = array.getJSONObject(i);
				array1 = getCategory(obj.getString("id"));
				if(array1.size() > 0){
					for(int j = 0;j<array1.size();j++){
						JSONObject obj1 = array1.getJSONObject(j);
						obj1.put("text",obj1.getString("name"));
						JSONArray array2 = getCategory(obj1.getString("id"));
						if(array2.size() > 0){
							for(int k = 0;k<array2.size();k++){
								JSONObject obj2 = array2.getJSONObject(k);
								obj2.put("text",obj2.getString("name"));
								JSONArray array3 = getCategory(obj2.getString("id"));
								if(array3.size() > 0){
									for (int m = 0;m<array3.size();m++){
										JSONObject obj3 = array3.getJSONObject(m);
										obj3.put("text",obj3.getString("name"));
									}
									obj2.put("children", array3.toString());
									array2.set(k, obj2);
								}
							}
							obj1.put("children", array2.toString());
							array1.set(j, obj1);
						}
					}
					obj.put("children", array1.toString());
					array.set(i, obj);
				}
			}
		}
		return array1.toString();
	}

}
