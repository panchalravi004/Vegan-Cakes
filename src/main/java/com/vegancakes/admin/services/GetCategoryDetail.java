package com.vegancakes.admin.services;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vegancakes.admin.control.CategoryControl;
import com.vegancakes.entity.Category;

/**
 * Servlet implementation class GetCategoryDetail
 */
@WebServlet("/admin/get-category-detail")
public class GetCategoryDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	CategoryControl cc = new CategoryControl();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		
		Category cat = cc.getCategory(Integer.parseInt(id));
		
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        out.print(cat.getString());
        out.flush();
	}


}
