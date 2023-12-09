package com.vegancakes.admin.services;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.vegancakes.admin.control.CategoryControl;

/**
 * Servlet implementation class UpdateCategory
 */
@MultipartConfig
@WebServlet("/admin/update-category")
public class UpdateCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	CategoryControl cc = new CategoryControl();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
        
		String path = request.getParameter("old-path");
		Part part = request.getPart("product-image");
		
		if(part != null && !part.getSubmittedFileName().isEmpty()) {
			
			
			path = part.getSubmittedFileName();
			
			String filePath = request.getRealPath("assets")+File.separator+"products"+File.separator+part.getSubmittedFileName();
			
			System.out.println(filePath);
			
			FileOutputStream fos = new FileOutputStream(filePath);
			
			InputStream is = part.getInputStream();
			byte[] data = new byte[is.available()];
			is.read(data);
			
			fos.write(data);
			fos.close();
			
			is.close();
		}
        cc.updateCategoryInformation(Integer.parseInt(id) ,name, path);
        String alert = "<div class=\"alert alert-success wrap-input100\">\n" +
                "                        <p style=\"font-family: Ubuntu-Bold; font-size: 18px; margin: 0.25em 0; text-align: center\">\n" +
                "                            Update category successfully!\n" +
                "                        </p>\n" +
                "                    </div>";
        request.setAttribute("alert", alert);
        response.sendRedirect("manage-category.jsp");
	}

}
