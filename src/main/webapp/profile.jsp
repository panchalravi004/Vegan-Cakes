<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	if(session.getAttribute("customer") == null){
		response.sendRedirect("login.jsp");
	}

%>
<!DOCTYPE html>
<html>
<head>

	<meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Vegan Cakes - Profile</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="static/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="static/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="static/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="static/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="static/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="static/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="static/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="static/css/style.css" type="text/css">
</head>
<body>
	
    <div id="preloder">
        <div class="loader"></div>
    </div>
    
    <jsp:include page="comman/header.jsp"/>
    
    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="static/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>Profile</h2>
                        <div class="breadcrumb__option">
                            <a href="./index.jsp">Home</a>
                            <span>Profile</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->
    
    <div class="container">
    	<form action="update-profile" method="post">
            <div class="row d-flex justify-content-center p-4">
                <div class="col-lg-8 col-md-6">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="checkout__input">
                                <p>First Name<span>*</span></p>
                                <input type="text" name="fname" value="${customer.firstName}">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="checkout__input">
                                <p>Last Name<span>*</span></p>
                                <input type="text" name="lname" value="${customer.lastName}">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="checkout__input">
                                <p>Mobile<span>*</span></p>
                                <input type="text" name="mobile" value="${customer.mobile}">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="checkout__input">
                                <p>Email<span>*</span></p>
                                <input type="text" name="email" value="${customer.email}">
                            </div>
                        </div>
                    </div>
                    
                    <div class="checkout__input">
                        <p>Address<span>*</span></p>
                        <input type="text" name="line1" value="${customer.address.line1}" placeholder="Street Address" class="checkout__input__add" required>
                        <input type="text" name="line2" value="${customer.address.line2}" placeholder="Apartment, suite, unite ect (optinal)">
                    </div>
                    
                    <div class="checkout__input">
                        <p>Town/City<span>*</span></p>
                        <input type="text" name="city" value="${customer.address.city}" required>
                    </div>
                    <div class="checkout__input">
                        <p>Country<span>*</span></p>
                        <input type="text" name="country" value="${customer.address.country}" required>
                    </div>
                    
                    <div class="row">
                    	<div class="col-lg-6">
		                    <div class="checkout__input">
		                        <p>Postcode / ZIP<span>*</span></p>
		                        <input type="text" name="pin" value="${customer.address.pin}" required>
		                    </div>
	                    </div>
                        <div class="col-lg-6">
                            <div class="checkout__input">
                                <p>Telephone</p>
                                <input type="text" name="phone" value="${customer.address.phone}">
                            </div>
                        </div>
                    </div>
                    <div class="checkout__input">
                        <p>Account Password<span>*</span></p>
                        <input type="password" name="pass" value="${customer.password}">
                    </div>
                    <div class="col-lg-12 d-flex justify-content-center">
						<button class="btn btn-primary" type="submit" >Update</button>
					</div>
				</div>
				
            </div>
        </form>
    </div>
	
	<jsp:include page="comman/footer.jsp"/>

    <!-- Js Plugins -->
    <script src="static/js/jquery-3.3.1.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/js/jquery.nice-select.min.js"></script>
    <script src="static/js/jquery-ui.min.js"></script>
    <script src="static/js/jquery.slicknav.js"></script>
    <script src="static/js/mixitup.min.js"></script>
    <script src="static/js/owl.carousel.min.js"></script>
    <script src="static/js/main.js"></script>
</body>
</html>