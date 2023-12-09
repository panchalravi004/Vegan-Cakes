
<%@page import="com.vegancakes.entity.Category"%>
<%@page import="com.vegancakes.admin.control.CategoryControl"%>
<%@page import="com.vegancakes.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.vegancakes.admin.control.ProductControl"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	if(session.getAttribute("customer") == null){
		response.sendRedirect("login.jsp");
	}

	ProductControl uc = new ProductControl();
	List<Product> proList = uc.getProductActiveAll();
	proList = proList.subList(0, proList.size() >= 6 ? 6 : proList.size()); 
	
	CategoryControl cc = new CategoryControl();
	List<Category> catList = cc.getCategoryAll();
	
	pageContext.setAttribute("proList", proList);
	pageContext.setAttribute("catList", catList);


%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Vegan Cakes</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">
 <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	
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
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>
    
    <jsp:include page="comman/header.jsp"/>

    <!-- Categories Section Begin -->
    <section class="categories">
        <div class="container">
            <div class="row">
                <div class="categories__slider owl-carousel">
                
                	<c:forEach items="${pageScope.catList}" var="cat"  >
                		<div class="col-lg-3">
	                        <div class="categories__item set-bg" data-setbg="/Vegan-Cakes/assets/categories/${cat.path}">
	                            <h5><a href="#"> ${cat.name}</a></h5>
	                        </div>
	                    </div>
                	</c:forEach>
                    
                </div>
            </div>
        </div>
    </section>
    <!-- Categories Section End -->

    <!-- Featured Section Begin -->
    <section class="featured spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h2>Featured Product</h2>
                    </div>
                    <div class="featured__controls">
                        <ul>
                            <li class="active" data-filter="*">All</li>
                            <c:forEach items="${pageScope.catList}" var="cat"  >
                            	<li data-filter=".${cat.name}">${cat.name}</li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="row featured__filter">
            	<c:forEach items="${pageScope.proList}" var="pro"  >
	                <div class="col-lg-4 col-md-4 col-sm-6 mix ${pro.category.name}">
	                    <div class="featured__item">
	                        <div class="featured__item__pic set-bg" data-setbg="/Vegan-Cakes/assets/products/${pro.path}">
	                            <ul class="featured__item__pic__hover">
	                            	<li><a href="shop-details.jsp?id=${pro.id}"><i class="fa-solid fa-eye"></i></a></li>
	                                <li><a href="add-to-cart?user=${customer.id}&pro=${pro.id}"><i class="fa fa-shopping-cart"></i></a></li>
	                            </ul>
	                        </div>
	                        <div class="featured__item__text">
	                            <h6><a href="#">${pro.name}</a></h6>
	                            <h5>$ ${pro.price}</h5>
	                        </div>
	                    </div>
	                </div>
                </c:forEach>
            </div>
        </div>
    </section>
    <!-- Featured Section End -->
    
    
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