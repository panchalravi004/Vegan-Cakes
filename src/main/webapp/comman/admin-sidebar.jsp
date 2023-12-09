<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
            <div class="nav">
                <div class="sb-sidenav-menu-heading">Core</div>
                <a class="nav-link" href="../admin/index.jsp">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Dashboard
                </a>
                <div class="sb-sidenav-menu-heading">Management</div>
             	<c:if test="${sessionScope.admin.type == 'Admin'}">
                	<a class="nav-link" href="../admin/manage-user.jsp">
	                    Manage User
	                </a>
                </c:if>
                
                <a class="nav-link" href="../admin/manage-category.jsp">
                    Manage Category
                </a>
                <a class="nav-link" href="../admin/manage-product.jsp">
                    Manage Product
                </a>
                <a class="nav-link" href="../admin/manage-orders.jsp">
                    Manage Orders
                </a>

            </div>
        </div>
    </nav>
</div>