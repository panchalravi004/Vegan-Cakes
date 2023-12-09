package com.vegancakes.admin.services;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LogoutUser
 */
@WebServlet(name="LogoutUser", value="/admin/logout-user")
public class LogoutUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Remove session.
        HttpSession session = request.getSession();
        session.removeAttribute("admin");

        // Remove cookies.
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("email")) {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
            if (cookie.getName().equals("password")) {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }

        response.sendRedirect("login.jsp");
	}

}
