<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@page import="com.vegancakes.entity.User"%>
<%@page import="java.util.List"%>
<%@page import="com.vegancakes.admin.control.UserControl"%>

<%
	if(session.getAttribute("admin") == null){
		response.sendRedirect("login.jsp");
	}

	// get user list here
	
	UserControl uc = new UserControl();
	List<User> userList = uc.getNonAdminUser();
	
	pageContext.setAttribute("userList", userList);

%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>User - Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        
        <link href="../static/css/styles-admin.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
    <jsp:include page="../comman/admin-header.jsp"/>
        <!-- Header -->
        <div id="layoutSidenav">
            <!-- Side bar -->
            <jsp:include page="../comman/admin-sidebar.jsp"/>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <h3 class="mt-4">Manage User</h3>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Add</button>
                        </div>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active">Users</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Users
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>FirstName</th>
                                            <th>Email</th>
                                            <th>Mobile</th>
                                            <th>Type</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>FirstName</th>
                                            <th>Email</th>
                                            <th>Mobile</th>
                                            <th>Type</th>
                                            <th>Action</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    <c:forEach var="user" items="${pageScope.userList}" >
                                    	<tr>
                                            <th>${user.firstName}</th>
                                            <th>${user.email}</th>
                                            <th>${user.mobile}</th>
                                            <th>${user.type}</th>
                                            <th>
                                            	<button type="button" data-id="${user.id}" onclick="getUserDetail(this)" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#userEditModal">
                                            		<i class="fa-solid fa-pen"></i>
                                            	</button>
                                            	<a href="remove-user?id=${user.id}" type="button" class="btn btn-danger btn-sm">
                                            		<i class="fa-solid fa-trash"></i>
                                            	</a>
                                            </th>
                                        </tr>
                                    </c:forEach>                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        
        
        <!-- Add Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <form class="modal-content" method="post" action="add-user">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Add New User </h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
				  <div class="form-group">
				    <label for="fname">First Name</label>
				    <input type="text" class="form-control" name="fname"  id="fname" placeholder="Enter First Name" required>
				  </div>
				  <div class="form-group">
				    <label for="lname">Last Name</label>
				    <input type="text" class="form-control" name="lname" id="lname" placeholder="Enter Last Name">
				  </div>
				  <div class="form-group">
				    <label for="email">Email</label>
				    <input type="email" class="form-control" name="email" id="email" placeholder="Enter Email" required>
				  </div>
				  <div class="form-group">
				    <label for="mobile">Mobile</label>
				    <input type="number" class="form-control" name="mobile" id="mobile" placeholder="Enter mobile" required>
				  </div>
				  <div class="form-group">
				    <label for="password">Password</label>
				    <input type="password" class="form-control" name="pass" id="password" placeholder="Password" required>
				  </div>
				  <div class="form-group">
				    <label for="type">User Type</label>
				    <select class="form-control" name="type" id="type" required>
				      <option>Admin</option>
				      <option>Staff</option>
				      <option>Customer</option>
				    </select>
				  </div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="submit" name="submit" class="btn btn-primary">Save</button>
		      </div>
		    </form>
		  </div>
		</div>
		
		<!-- Edit Modal -->
		<div class="modal fade" id="userEditModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <form class="modal-content" method="post" action="update-user">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Edit User </h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
 				  <input type="hidden" name="id" id="edit-id" >
		      
				  <div class="form-group">
				    <label for="fname">First Name</label>
				    <input type="text" class="form-control" name="fname"  id="edit-fname" placeholder="Enter First Name" required>
				  </div>
				  <div class="form-group">
				    <label for="lname">Last Name</label>
				    <input type="text" class="form-control" name="lname" id="edit-lname" placeholder="Enter Last Name">
				  </div>
				  <div class="form-group">
				    <label for="email">Email</label>
				    <input type="email" class="form-control" name="email" id="edit-email" placeholder="Enter Email" required>
				  </div>
				  <div class="form-group">
				    <label for="mobile">Mobile</label>
				    <input type="number" class="form-control" name="mobile" id="edit-mobile" placeholder="Enter mobile" required>
				  </div>
				  <div class="form-group">
				    <label for="edit-pass">Password</label>
				    <input type="password" class="form-control" name="pass" id="edit-pass" placeholder="Password" required>
				  </div>
				  <div class="form-group">
				    <label for="type">User Type</label>
				    <select class="form-control" name="type" id="edit-type" required>
				      <option>Admin</option>
				      <option>Staff</option>
				      <option>Customer</option>
				    </select>
				  </div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="submit" name="submit" class="btn btn-primary">Update</button>
		      </div>
		    </form>
		  </div>
		</div>
    </body>
    
    <script type="text/javascript">
    	async function getUserDetail(event) {
    		
    		console.log(event.dataset.id);
    		fetch("/Vegan-Cakes/admin/get-user-detail?id="+event.dataset.id, {})
            .then(response => response.text())
            .then((result) => {
                result = JSON.parse(result);
                console.log('result',result);
                
                var id = document.querySelector("#edit-id");
                var fname = document.querySelector("#edit-fname");
                var lname = document.querySelector("#edit-lname");
                var email = document.querySelector("#edit-email");
                var mobile = document.querySelector("#edit-mobile");
                var pass = document.querySelector("#edit-pass");
                
                id.value = result.id;
                fname.value = result.firstName;
                lname.value = result.lastName;
                email.value = result.email;
                mobile.value = result.mobile;
                pass.value = result.password;
                
                const select = document.querySelector('#edit-type');
                select.value = result.type;
                
                console.log(id);
                
            })
            .catch((error) => {
                
                console.log('error', error);
                
            });
			
		}
    </script>
	    
	    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    
    	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="../static/js/scripts-admin.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="../static/js/datatables-simple-demo.js"></script>
</html>
