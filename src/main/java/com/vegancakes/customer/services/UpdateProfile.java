package com.vegancakes.customer.services;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vegancakes.customer.control.AddressControl;
import com.vegancakes.customer.control.CustomerControl;
import com.vegancakes.entity.Customer;

/**
 * Servlet implementation class UpdateProfile
 */
@WebServlet("/update-profile")
public class UpdateProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	CustomerControl cc = new CustomerControl();
	AddressControl ac = new AddressControl();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get email and password from request.
		Customer user = (Customer) request.getSession().getAttribute("customer");
        
		String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("pass");
        
        String line1 = request.getParameter("line1");
        String line2 = request.getParameter("line2");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String pin = request.getParameter("pin");
        String phone = request.getParameter("phone");
        
        cc.updateProfileInformation(user.getId(), fname, lname, email, password, mobile);
        
        if(user.getAddress() != null) {
        	
        	ac.updateAddressInformation(user.getAddress().getId(), line1, line2, city, Integer.parseInt(pin), country, Integer.parseInt(phone), user.getId());
        	
        }else {
        	
        	ac.createAddress(line1, line2, city, Integer.parseInt(pin), country, Integer.parseInt(phone), user.getId());
        }
        
        
        user = cc.getCustomer(user.getId());
        request.getSession().setAttribute("customer", user);
        
        String alert = "<div class=\"alert alert-success wrap-input100\">\n" +
                "                        <p style=\"font-family: Ubuntu-Bold; font-size: 18px; margin: 0.25em 0; text-align: center\">\n" +
                "                            Update account successfully!\n" +
                "                        </p>\n" +
                "                    </div>";
        request.setAttribute("alert", alert);
        response.sendRedirect("profile.jsp");
       
        
        
	}

}
