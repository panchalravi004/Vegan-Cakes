package com.vegancakes.admin.services;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vegancakes.admin.control.UserControl;
import com.vegancakes.entity.User;

@WebServlet("/admin/get-user-detail")
public class GetUserDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    UserControl userC = new UserControl();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		
		User user = userC.getUser(Integer.parseInt(id));
		
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        out.print(user.getString());
        out.flush();
		
	}

}
