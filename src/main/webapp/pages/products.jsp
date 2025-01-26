<%--
  Created by IntelliJ IDEA.
  User: shan
  Date: 1/23/25
  Time: 4:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="lk.ijse.ecommerceplatform.dto.UserDTO" %>
<%@ page import="lk.ijse.ecommerceplatform.dto.ProductDTO" %>
<%
    UserDTO currentUser = (UserDTO) session.getAttribute("user");
    String userName = currentUser != null ? currentUser.getName() : "";
    String userEmail = currentUser != null ? currentUser.getEmail() : "";
    Integer userId = currentUser != null ? currentUser.getUserId() : null;

    List<ProductDTO> products = (List<ProductDTO>) request.getAttribute("products");
    if (products == null) {
        products = new ArrayList<>();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Shop - Meduza</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <style>
        :root {
            --primary-color: #333;
            --secondary-color: #666;
            --background-light: #f8f9fa;
            --border-color: #dee2e6;
        }

        body {
            background-color: white;
            color: var(--primary-color);
        }

        .hero-section {
            position: relative;
            height: 400px;
            background-color: var(--background-light);
            overflow: hidden;
        }

        .hero-text {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 180px;
            font-weight: bold;
            color: white;
            text-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            z-index: 1;
        }

        .search-bar {
            position: relative;
            max-width: 600px;
            margin: -30px auto 0;
            z-index: 2;
        }

        .search-input {
            border-radius: 25px;
            padding: 15px 25px;
            border: 1px solid var(--border-color);
            width: 100%;
        }

        .category-sidebar {
            position: sticky;
            top: 80px;
            padding-right: 10px;
            border-right: 1px solid var(--border-color);
            background-color: white;
            z-index: 10;
        }

        .product-card {
            border: none;
            border-radius: 10px;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .product-card:hover {
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .product-image {
            height: 200px;
            object-fit: cover;
            background-color: var(--background-light);
        }

        .rating {
            color: #ffc107;
        }

        .pagination .page-link {
            color: var(--primary-color);
            border: none;
            padding: 10px 15px;
            margin: 0 5px;
            border-radius: 5px;
        }

        .pagination .page-item.active .page-link {
            background-color: var(--primary-color);
            color: white;
        }

        .newsletter-section {
            background-color: #2c2c2c;
            color: white;
            border-radius: 15px;
            padding: 40px;
            margin: 50px 0;
        }

        .newsletter-input {
            border-radius: 25px;
            padding: 10px 20px;
            border: none;
            margin-right: 10px;
        }
        * {
            font-family: "Merriweather", serif;
            font-weight: 500;
            font-style: normal;
        }
        #brad {
            font-family: "Ubuntu", serif;
        }
        body {
            overflow-x: hidden;
        }
        .navbar {
            background-color: white;
        }

        .nav-link {
            color: #333;
            font-weight: 500;
        }
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .section-padding {
            padding-top: 80px;
        }
        .offcanvas {
            width: 350px !important;
        }

        .profile-header {
            text-align: center;
            padding: 2rem 1rem;
            border-bottom: 1px solid #eee;
        }

        .profile-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin-bottom: 1rem;
        }

        .profile-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .profile-menu li {
            border-bottom: 1px solid #eee;
        }

        .profile-menu li:last-child {
            border-bottom: none;
        }

        .profile-menu a {
            padding: 1rem 1.5rem;
            display: flex;
            align-items: center;
            color: #000;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .profile-menu a:hover {
            background-color: #f8f9fa;
            color: #504e4e;
        }

        .profile-menu i {
            margin-right: 1rem;
            font-size: 1.2rem;
        }

        .auth-buttons .btn {
            width: 100%;
            margin-bottom: 1rem;
        }

        .login-form {
            padding: 1.5rem;
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg sticky-top p-0">
    <div class="container-fluid mx-5">
        <a class="navbar-brand d-flex" href="#">
            <img src="assets/images/logo.png" style="margin-top: -6px" width="50" alt="" />
            <h3 class="brand mt-1">Meduza</h3></a>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item dropdown d-flex">
                    <button type="button" class="btn nav-link">
                        <a class="nav-link p-0" href="#products">Categories</a>
                    </button>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="products">New Arrivals</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="products">Best Sellers</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#contact">Contact Us</a>
                </li>
            </ul>
            <div class="d-flex">
                <a href="cart?user=<%=userId%>" class="btn me-0">
                    <i class="bi bi-cart fs-4"></i>
                </a>
                <a class="btn" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                    <i class="bi bi-person-circle fs-4"></i>
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <img src="${pageContext.request.contextPath}/assets/images/items/shop.jpg" class="w-100 position-absolute" alt="" />
    <div class="hero-text">Shop</div>
    <div class="container">
        <div class="search-bar">
            <input type="text" class="search-input mt-5" placeholder="Search on Meduza" />
        </div>
    </div>
</section>

<!-- Main Content -->
<div class="container-fluid mt-5 p-5">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-lg-2 position-sticky">
            <div class="category-sidebar">
                <h5>Category</h5>
                <button class="btn btn-dark flex-grow-1 rounded-5 w-100 text-start">All Products</button>
                <button class="btn flex-grow-1 rounded-5 w-100 text-start">T-Shirt</button>
                <button class="btn flex-grow-1 rounded-5 w-100 text-start">Cropped Top</button>
                <button class="btn flex-grow-1 rounded-5 w-100 text-start">Collared T-Shirt</button>
                <button class="btn flex-grow-1 rounded-5 w-100 text-start">Long Sleeve</button>
            </div>
        </div>

        <!-- Products Grid -->
        <div class="col-lg-9">
            <div class="row g-4">
                <% for(ProductDTO product : products) { %>
                <div class="col-md-4">
                    <div class="product-card">
                        <img src="<%=product.getImage_url()%>" class="product-image w-100" alt="Product" />
                        <div class="card-body p-3">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <small class="text-muted"><%=product.getDescription()%></small>
                                <div class="rating d-flex">
                                    <i class="bi bi-star-fill me-1"></i>
                                    <i class="bi bi-star-fill me-1"></i>
                                    <i class="bi bi-star-fill me-1"></i>
                                    <i class="bi bi-star-fill me-1"></i>
                                    <i class="bi bi-star-fill me-1"></i>
                                </div>
                            </div>
                            <h5 class="card-title"><%=product.getName()%></h5>
                            <p class="card-text fw-bold">$ <%=String.format("%.2f",product.getPrice())%></p>
                            <div class="d-flex gap-2">
                                <button class="btn btn-outline-dark flex-grow-1 rounded-5" onclick="addToCart('<%=product.getProduct_id()%>','<%=userId%>','<%=product.getImage_url()%>')">Add to Cart</button>
                                <button class="btn btn-dark flex-grow-1 rounded-5" onclick="buyNow(<%=product.getProduct_id()%>)">Buy Now</button>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>

            <!-- Pagination -->
            <nav class="mt-5">
                <ul class="pagination justify-content-center">
                    <li class="page-item">
                        <a class="page-link" href="#">Previous</a>
                    </li>
                    <li class="page-item active">
                        <a class="page-link" href="#">1</a>
                    </li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item"><a class="page-link" href="#">Next</a></li>
                </ul>
            </nav>
        </div>
    </div>

    <!-- Newsletter Section -->
    <div class="newsletter-section">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h3>Ready to Get<br />Our New Stuff?</h3>
            </div>
            <div class="col-md-6">
                <div class="d-flex">
                    <input type="email" class="newsletter-input flex-grow-1" placeholder="Your Email" />
                    <button class="btn btn-light rounded-pill">Send</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!--  Profile Section -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
    <div class="offcanvas-header border-bottom">
        <h5 class="offcanvas-title" id="offcanvasRightLabel">My Profile</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body p-0">
        <%
            if (currentUser != null) { %>
        <!-- Logged In View -->
        <div class="profile-header">
            <img src="<%=currentUser.getImage_url()%>" alt="Profile Picture" class="profile-avatar" />
            <h5 class="mb-1"><%= userName %></h5>
            <p class="text-muted mb-0"><%= userEmail %></p>

            <% if(currentUser.isActive()==true){%>
            <i class="bi bi-circle-fill d-flex justify-content-center" style="color:#18e718"><p style="margin: -3px 0 0 5px">Active</p></i>
            <%
            }else{
            %>
            <i class="bi bi-circle-fill d-flex justify-content-center" style="color: red"><p style="margin: -3px 0 0 5px">Deactivated</p></i>
            <%
                }
            %>

        </div>
        <ul class="profile-menu">
            <li><a href="#"><i class="bi bi-person"></i> My Profile</a></li>
            <li><a href="#"><i class="bi bi-bag"></i> My Orders</a></li>
            <li><a href="#"><i class="bi bi-heart"></i> Wishlist</a></li>
            <li><a href="#"><i class="bi bi-geo-alt"></i> Addresses</a></li>
            <li><a href="#"><i class="bi bi-credit-card"></i> Payment Methods</a></li>
            <li><a href="#"><i class="bi bi-gear"></i> Settings</a></li>
            <li><a href="user?action=logout" class="text-danger"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
        </ul>
        <% } else { %>
        <!-- Logged Out View -->
        <div class="profile-header p-5 w-100">
            <div class="d-flex justify-content-center w-100">
                <img width="120" src="assets/images/logo.png" alt="Profile Picture" />
            </div>
            <h4 class="text-center">Welcome to Meduza</h4>
            <p class="text-muted text-center">Sign in to access your account</p>
        </div>
        <div class="login-form p-3">
            <form action="user" method="get">
                <div class="mb-3">
                    <label for="email" class="form-label">Email address</label>
                    <input type="email" class="form-control" id="email" name="email" required />
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required />
                </div>
                <button type="submit" name="action" value="login" class="btn btn-dark w-100 mb-2">Login</button>
                <button type="button" class="btn btn-outline-dark w-100" onclick="window.location.href='pages/register.jsp'">Create Account</button>
            </form>
            <div class="text-center mt-3">
                <a href="pages/forget-password.jsp" class="text-muted">Forgot password?</a>
            </div>
        </div>
        <% } %>
    </div>
</div>
<!-- Footer -->
<footer class="bg-dark text-light section-padding">
    <div class="main-container">
        <div class="row">
            <div class="col-md-4">
                <h5>About Us</h5>
                <p>Premium clothing and accessories for the modern lifestyle.</p>
            </div>
            <div class="col-md-4">
                <h5>Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="#products" class="text-light">Categories</a></li>
                    <li><a href="#arrivals" class="text-light">New Arrivals</a></li>
                    <li><a href="#arrivals" class="text-light">Accessories</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5>Contact</h5>
                <ul class="list-unstyled">
                    <li>Email: meduzaclothing@gmail.com</li>
                    <li>Phone: +(94) 76 842 5039</li>
                </ul>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function addToCart(productId,userId,image_url) {

        var quantity = "1";

        $.ajax({
            url: '${pageContext.request.contextPath}/cart',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({  action: "add",
                                    userId: userId,
                                    productId: productId,
                                    quantity: quantity,
                                    image_url: image_url}),
            success: function(response) {
                alert('Product added to cart successfully!');
            },
            error: function(xhr) {
                if (xhr.status === 401) {
                    window.location.href = '${pageContext.request.contextPath}/pages/login.jsp?error=Login first';
                } else {
                    alert('Error adding product to cart: ' + xhr.responseText);
                }
            }
        });
    }

    function buyNow(productId) {
        // Buy now logic
        window.location.href = '${pageContext.request.contextPath}/checkout?productId=' + productId;
    }
</script>
</body>
</html>
