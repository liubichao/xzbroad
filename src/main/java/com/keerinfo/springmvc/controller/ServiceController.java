package com.keerinfo.springmvc.controller;

import com.keerinfo.springmvc.service.Service;
import com.keerinfo.springmvc.service.impl.ServiceImpl;
import com.keerinfo.springmvc.utils.MyUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class ServiceController {
	@ResponseBody
	@RequestMapping(value = "/home/login" )
	public String login(HttpServletRequest request, HttpSession session) {
		Service si = new ServiceImpl();
		String username = MyUtils.getParam(request, "username");
		String sql = "from users where isvalid = 1 and username = '"+ username +"' and password = '"+ MyUtils.getParam(request, "password") +"' ";
		int flag = si.queryCount(sql);
		String reply = "false";
		if(flag > 0){
			session.setAttribute("USERNAME", username);
			reply = "true";
		}else{
			session.removeAttribute("USERNAME");
		}
		si.saveLog(request, session,"login", "----" + sql + "----- result : " + flag);
		return reply;
	}
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/logon.jsp";
	}
	@ResponseBody
	@RequestMapping(value = "/service/save" )
	public String save(HttpServletRequest request, HttpSession session){
		int flag = new ServiceImpl().save(request, session);
		return flag + "";
	}
	@ResponseBody
	@RequestMapping(value = "/service/update" )
    public String update(HttpServletRequest request, HttpSession session){
		int flag = new ServiceImpl().update(request, session);
		return flag + "";
    }
	@ResponseBody
	@RequestMapping(value = "/service/delete" )
    public String delete(HttpServletRequest request, HttpSession session){
		int flag = new ServiceImpl().delete(request, session);
		return flag + "";
    }
	@ResponseBody
	@RequestMapping(value = "/service/getCategoryByPid",produces="text/html;charset=UTF-8")
	public String getCategoryByPid(HttpServletRequest request) {
		return new ServiceImpl().getCategoryArray(request).toString();
	}
	@ResponseBody
	@RequestMapping(value = "/service/checkNameExist")
	public String checkNameExist(HttpServletRequest request) {
		String name = request.getParameter("name");
		String parentId = request.getParameter("id");
		String sql = "from category c where c.name = '"+ name +"' and c.parentId = '"+ parentId +"' ";
		int flag = new ServiceImpl().queryCount(sql);
		if(flag > 0){
			return "false";
		}else{
			return "true";
		}
	}
	@ResponseBody
	@RequestMapping(value = "/service/getLogs",produces="text/html;charset=UTF-8")
	public String getLogs(HttpServletRequest request) {
		return new ServiceImpl().getAllResultToJSON(request).toString();
	}
	@ResponseBody
	@RequestMapping(value = "/service/getLogClear",produces="text/html;charset=UTF-8")
	public String getLogClear(HttpServletRequest request) {
		return new ServiceImpl().getAllResultOfLogClear(request).toString();
	}
	@ResponseBody
	@RequestMapping(value = "/service/fileUpload")
	public String fileUpload(HttpServletRequest request, HttpSession session) {
		return new ServiceImpl().fileUpload(request,session);
	}
	@ResponseBody
	@RequestMapping(value = "/service/getAllImages")
	public String getAllImages(HttpServletRequest request, HttpSession session) {
		return new ServiceImpl().fileUpload(request,session);
	}
	@ResponseBody
	@RequestMapping(value = "/service/getCategoryTreeByName",produces="text/html;charset=UTF-8")
	public String getCategoryTreeByName(HttpServletRequest request) {
		return new ServiceImpl().getCategoryTreeByName(request);
	}
	@ResponseBody
	@RequestMapping(value = "/service/getCount")
	public String getCount(HttpServletRequest request) {
		String wechatId = request.getParameter("wechatId");
		String state = request.getParameter("state");
		String smartCardId = request.getParameter("smartCardId");
		StringBuffer sql = new StringBuffer();
		sql.append("from userBindWechat where state = " + state);
		if(!MyUtils.isEmpty(smartCardId)){
			sql.append(" and smartCardId = '"+ smartCardId +"' ");
		}
		if(!MyUtils.isEmpty(wechatId)){
			sql.append(" and wechatId = '"+ wechatId +"' ");
		}
		return new ServiceImpl().queryCount(sql.toString()) + "";
	}
}
