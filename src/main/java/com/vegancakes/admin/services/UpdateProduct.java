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
 * Servlet implementation class UpdateProduct
 */
@MultipartConfig
@WebServlet("/admin/update-product")
public class UpdateProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	ProductControl cc = new ProductControl();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String desc = request.getParameter("desc");
		String cat = request.getParameter("category");
		String price = request.getParameter("price");
		//String path = request.getParameter("path");
		String stock = request.getParameter("stock");
		Boolean active = request.getParameter("active") != null;
		
		System.out.println(active);
		String path = request.getParameter("old-path");
		
		Part part = request.getPart("product-image");
		
		System.out.println(part.getSubmittedFileName());
		if(part != null &&  !part.getSubmittedFileName().isEmpty()) {
			
			try {
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
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
			
			
		}
        cc.updateProductInformation(Integer.parseInt(id) ,name, desc, Integer.parseInt(cat),Integer.parseInt(price), path, Integer.parseInt(stock), active);
        String alert = "<div class=\"alert alert-success wrap-input100\">\n" +
                "                        <p style=\"font-family: Ubuntu-Bold; font-size: 18px; margin: 0.25em 0; text-align: center\">\n" +
                "                            Update Product successfully!\n" +
                "                        </p>\n" +
                "                    </div>";
        request.setAttribute("alert", alert);
        response.sendRedirect("manage-product.jsp");
	}

}
