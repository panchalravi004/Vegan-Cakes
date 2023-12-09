package com.vegancakes.admin.services;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vegancakes.admin.control.UserControl;
import com.vegancakes.entity.User;


@WebServlet(name="/LoginUser", value = "/admin/login-user")
public class LoginUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	// Call DAO class to access with database.
    UserControl userControl = new UserControl();

    private User getUserCookie(HttpServletRequest request) {
        // Get list cookies of the browser.
        Cookie[] cookies = request.getCookies();

        User user;
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
        user = userControl.checkLoginUser(email, password);
        return user;
    }

    private void executeLogin(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        // Get the status of remember me checkbox.
        HttpSession session = request.getSession();

        session.setAttribute("admin", user);
        
        Cookie emailCookie = new Cookie("email", user.getEmail());
        emailCookie.setMaxAge(600);
        response.addCookie(emailCookie);

        Cookie passwordCookie = new Cookie("password", user.getPassword());
        passwordCookie.setMaxAge(600);
        response.addCookie(passwordCookie);
        
        response.sendRedirect("index.jsp");
    }

    private void checkLoginUserFirstTime(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Get the submitted email and password.
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Check account in database.
        User user = userControl.checkLoginUser(email, password);
        if (user == null ) {
            // An alert to send to login page.
            String alert = "<div class=\"alert alert-danger alert-dismissible wrap-input100\">\n" +
                    "                        <p style=\"font-family: Ubuntu-Bold; font-size: 18px; margin: 0.25em 0; text-align: center\">\n" +
                    "                            Wrong email or password!\n" +
                    "                        </p>\n" +
                    "                    </div>";
            // Set attribute for alert tag in login.jsp page.
            request.setAttribute("alert", alert);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            response.sendRedirect("login.jsp");
        }  else {
            // Login when all information are correct.
            executeLogin(request, response, user);
        }
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check the cookies of account.
        User user = getUserCookie(request);
        if (user == null) {
            // Check if account login first time or not.
            checkLoginUserFirstTime(request, response);
        } else {
            // Execute login if exist account cookie.
            executeLogin(request, response, user);
        }
    }
    
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		service(request, response);
	}

	
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		service(request, response);
	}

}
