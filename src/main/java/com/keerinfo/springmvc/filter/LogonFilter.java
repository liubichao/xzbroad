package com.keerinfo.springmvc.filter;

import org.apache.log4j.Logger;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Administrator on 2016/9/15 0015.
 */
public class LogonFilter extends OncePerRequestFilter {
    private static Logger log = Logger.getLogger(LogonFilter.class);
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        // 请求的uri
        String uri = request.getRequestURI();
        if(uri.indexOf("admin") > -1 || uri.indexOf("service") > -1){
           Object obj = request.getSession().getAttribute("USERNAME");
            if (obj == null || "".equals(obj.toString())){
                log.info("-------- session is time out ----------");
                response.sendRedirect(request.getContextPath() + "/logout");
            }else{
                filterChain.doFilter(request, response);
            }
        }else{
            filterChain.doFilter(request, response);
        }
    }
}
