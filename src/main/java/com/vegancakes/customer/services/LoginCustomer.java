package com.vegancakes.customer.services;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vegancakes.customer.control.CustomerControl;
import com.vegancakes.entity.Customer;

@WebServlet(name="LoginCustomer",value = "/login")
public class LoginCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// Call DAO class to access with database.
    CustomerControl customerControl = new CustomerControl();

    private Customer getCustomerCookie(HttpServletRequest request) {
        // Get list cookies of the browser.
        Cookie[] cookies = request.getCookies();

        Customer customer;
        String email = "";
        String password = "";
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("email")) {
                email = cookie.getValue();
            }
            if (cookie.getName().equals("password")) {
                password = cookie.getValue();
            }
        }
        customer = customerControl.checkLoginCustomer(email, password);
        return customer;
    }

    private void executeLogin(HttpServletRequest request, HttpServletResponse response, Customer customer) throws IOException {
        // Get the status of remember me checkbox.
        HttpSession session = request.getSession();
        boolean rememberMe = (request.getParameter("remember-me-checkbox") != null);

        session.setAttribute("customer", customer);
        if (rememberMe) {
            Cookie emailCookie = new Cookie("email", customer.getEmail());
            emailCookie.setMaxAge(600);
            response.addCookie(emailCookie);

            Cookie passwordCookie = new Cookie("password", customer.getPassword());
            passwordCookie.setMaxAge(600);
            response.addCookie(passwordCookie);
        }
        response.sendRedirect("index.jsp");
    }

    private void checkLoginCustomerFirstTime(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Get the submitted email and password.
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Check account in database.
        Customer customer = customerControl.checkLoginCustomer(email, password);
        if (customer == null ) {
            // An alert to send to login page.
            String alert = "<div class=\"alert alert-danger wrap-input100\">\n" +
                    "                        <p style=\"font-family: Ubuntu-Bold; font-size: 18px; margin: 0.25em 0; text-align: center\">\n" +
                    "                            Wrong email or password!\n" +
                    "                        </p>\n" +
                    "                    </div>";
            // Set attribute for alert tag in login.jsp page.
            request.setAttribute("alert", alert);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }  else {
            // Login when all information are correct.
            executeLogin(request, response, customer);
        }
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check the cookies of account.
        Customer customer = getCustomerCookie(request);
        if (customer == null) {
            // Check if account login first time or not.
            checkLoginCustomerFirstTime(request, response);
        } else {
            // Execute login if exist account cookie.
            executeLogin(request, response, customer);
        }
    }
    
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.print("Login get");
		service(request, response);
	}

	
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		service(request, response);
	}

}
