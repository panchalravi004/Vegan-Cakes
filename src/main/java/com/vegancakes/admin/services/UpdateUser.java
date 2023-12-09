package com.vegancakes.admin.services;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vegancakes.admin.control.UserControl;

@WebServlet("/admin/update-user")
public class UpdateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	UserControl userC = new UserControl();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        //String type = request.getParameter("type");
        String password = request.getParameter("pass");
        
        userC.updateProfileInformation(Integer.parseInt(id) ,fname, lname, email, password, mobile);
        String alert = "<div class=\"alert alert-success wrap-input100\">\n" +
                "                        <p style=\"font-family: Ubuntu-Bold; font-size: 18px; margin: 0.25em 0; text-align: center\">\n" +
                "                            Update user successfully!\n" +
                "                        </p>\n" +
                "                    </div>";
        request.setAttribute("alert", alert);
        response.sendRedirect("manage-user.jsp");
		
	}

}
