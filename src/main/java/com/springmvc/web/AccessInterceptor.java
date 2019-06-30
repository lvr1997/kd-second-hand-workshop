package com.springmvc.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;


@Component
public class AccessInterceptor implements HandlerInterceptor {

	public boolean preHandle(
			HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler)
			throws Exception {
		//获取Session中的登录用户信息
		//如果是登录用户是null, 则重定向到登录页
		//如果不是空, 则返回true继续执行
		HttpSession session 
			= request.getSession();
		if (session.getAttribute("cur_user") == null) {
			//发起重定向
			String path="/user/toLogin";
			response.sendRedirect(path);
			return false;//返回false不再执行后续的控制器
		}
		//如果登录了就直接放行 返回 true

		return true;
	}

	public void postHandle(
			HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

}
