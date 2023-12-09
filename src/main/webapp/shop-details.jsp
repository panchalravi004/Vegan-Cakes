
<%@page import="java.util.List"%>
<%@page import="com.vegancakes.entity.Product"%>
<%@page import="com.vegancakes.admin.control.ProductControl"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	if(session.getAttribute("customer") == null){
		response.sendRedirect("login.jsp");
	}
	

	//out.print(request.getParameter("id"));
	
	ProductControl pc = new ProductControl();
	
	Product pro = pc.getProduct(Integer.parseInt(request.getParameter("id")));
	
	
	List<Product> relatedPro = pc.getRelatedProductAll(pro.getCategoryId());
	
	pageContext.setAttribute("proDetail", pro);
	pageContext.setAttribute("relatedPro", relatedPro);


%>

<!DOCTYPE html>
<html lang="zxx">

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

    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="static/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>${pageScope.proDetail.name}</h2>
                        <div class="breadcrumb__option">
                            <a href="./index.jsp">Home</a>
                            <a href="./index.jsp">${pageScope.proDetail.category.name}</a>
                            <span>${pageScope.proDetail.name}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Product Details Section Begin -->
    <section class="product-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <div class="product__details__pic">
                        <div class="product__details__pic__item">
                            <img class="product__details__pic__item--large"
                                src="/Vegan-Cakes/assets/products/${pageScope.proDetail.path}" alt="">
                        </div>
                        
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="product__details__text">
                        <h3>${pageScope.proDetail.name}</h3>
                        
                        <div class="product__details__price">$${pageScope.proDetail.price}</div>
                        <p>
                        	${pageScope.proDetail.desc}
                        </p>
                        <a href="add-to-cart?user=${customer.id}&pro=${pageScope.proDetail.id}" class="primary-btn">ADD TO CARD</a>
                        
                        <ul>
                        	<c:if test="${pageScope.proDetail.stock > 0}">
                        		<li><b>Availability</b> <span>In Stock</span></li>
                        	</c:if>
                        	<c:if test="${pageScope.proDetail.stock <= 0}">
                        		<li><b>Availability</b> <span>Out Of Stock</span></li>
                        	</c:if>
                        	
                            
                            
                        </ul>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="product__details__tab">
                        <ul class="nav nav-tabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab"
                                    aria-selected="true">Description</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="tabs-1" role="tabpanel">
                                <div class="product__details__tab__desc">
                                    <h6>Products Infomation</h6>
                                    <p>
                                    	${pageScope.proDetail.desc}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Product Details Section End -->

    <!-- Related Product Section Begin -->
    <section class="related-product">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title related__product__title">
                        <h2>Related Product</h2>
                    </div>
                </div>
            </div>
            <div class="row">
            	<c:forEach items="${pageScope.relatedPro}" var="pro"  >
	                <div class="col-lg-3 col-md-4 col-sm-6">
	                    <div class="product__item">
	                        <div class="product__item__pic set-bg" data-setbg="/Vegan-Cakes/assets/products/${pro.path}">
	                            <ul class="product__item__pic__hover">
	                                <li><a href="shop-details.jsp?id=${pro.id}"><i class="fa-solid fa-eye"></i></a></li>
	                                <li><a href="add-to-cart?user=${customer.id}&pro=${pro.id}"><i class="fa fa-shopping-cart"></i></a></li>
	                            </ul>
	                        </div>
	                        <div class="product__item__text">
	                            <h6><a href="#">${pro.name}</a></h6>
	                            <h5>$ ${pro.price}</h5>
	                        </div>
	                    </div>
	                </div>
                </c:forEach>
            </div>
        </div>
    </section>
    <!-- Related Product Section End -->
    
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