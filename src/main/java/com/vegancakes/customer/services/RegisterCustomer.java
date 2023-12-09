package com.vegancakes.customer.services;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.vegancakes.customer.control.CustomerControl;


@WebServlet(name="Register Customer", value="/registration")
public class RegisterCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	CustomerControl customer = new CustomerControl();
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get email and password from request.
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String mobile = request.getParameter("contact");
        String type = "Customer";
        String password = request.getParameter("pass");
        String repeatPassword = request.getParameter("re_pass");
        
        System.out.print(fname);
        System.out.print(lname);
        System.out.print(email);

        // Check password and repeatPassword are the same.
        if (!password.equals(repeatPassword)) {
            String alert = "<div class=\"alert alert-danger wrap-input100\">\n" +
                    "                        <p style=\"font-family: Ubuntu-Bold; font-size: 18px; margin: 0.25em 0; text-align: center\">\n" +
                    "                            Incorrect password!\n" +
                    "                        </p>\n" +
                    "                    </div>";
            request.setAttribute("alert", alert);
            request.getRequestDispatcher("registration.jsp").forward(request, response);
        }
        // Check email is existed or not from database.
        else if (customer.checkEmailExists(email)) {
            String alert = "<div class=\"alert alert-danger wrap-input100\">\n" +
                    "                        <p style=\"font-family: Ubuntu-Bold; font-size: 18px; margin: 0.25em 0; text-align: center\">\n" +
                    "                            Email already exist!\n" +
                    "                        </p>\n" +
                    "                    </div>";
            request.setAttribute("alert", alert);
            request.getRequestDispatcher("registration.jsp").forward(request, response);
        }
        // Insert email, password to database and create account.
        else {
            customer.createCustomer(fname, lname, email, password, mobile, type);
            String alert = "<div class=\"alert alert-success wrap-input100\">\n" +
                    "                        <p style=\"font-family: Ubuntu-Bold; font-size: 18px; margin: 0.25em 0; text-align: center\">\n" +
                    "                            Create account successfully!\n" +
                    "                        </p>\n" +
                    "                    </div>";
            request.setAttribute("alert", alert);
            response.sendRedirect("login.jsp");
            //request.getRequestDispatcher("login.jsp").forward(request, response);
        }
	}

}
