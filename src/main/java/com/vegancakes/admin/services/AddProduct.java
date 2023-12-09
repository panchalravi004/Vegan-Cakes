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

import com.vegancakes.admin.control.ProductControl;

/**
 * Servlet implementation class AddProduct
 */
@MultipartConfig
@WebServlet("/admin/add-product")
public class AddProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	ProductControl cc = new ProductControl();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String desc = request.getParameter("desc");
		String cat = request.getParameter("category");
		String price = request.getParameter("price");
		//String path = request.getParameter("path");
		String stock = request.getParameter("stock");
		Boolean active = request.getParameter("active") != null;
		String path = "";
		if(request.getPart("product-image") != null) {
			Part part = request.getPart("product-image");
			
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
		
        cc.createProduct(name, desc, Integer.parseInt(cat),Integer.parseInt(price), path, Integer.parseInt(stock), active);
        String alert = "<div class=\"alert alert-success wrap-input100\">\n" +
                "                        <p style=\"font-family: Ubuntu-Bold; font-size: 18px; margin: 0.25em 0; text-align: center\">\n" +
                "                            Create Product successfully!\n" +
                "                        </p>\n" +
                "                    </div>";
        request.setAttribute("alert", alert);
        response.sendRedirect("manage-product.jsp");
	}


}
