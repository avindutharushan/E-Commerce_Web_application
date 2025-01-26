<%@ page import="lk.ijse.ecommerceplatform.dto.UserDTO" %>
<%@ page import="lk.ijse.ecommerceplatform.dto.CartDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="lk.ijse.ecommerceplatform.dto.CartDTO2" %><%--
  Created by IntelliJ IDEA.
  User: shan
  Date: 1/20/25
  Time: 12:19 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Your Cart - Meduza</title>
    <link
            href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
    />
    <style>
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

        .cart-container {
            max-width: 1000px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .product-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            background-color: #f1f1f1;
        }
        .quantity-input {
            width: 40px;
            text-align: center;
            border: 1px solid #dee2e6;
            margin: 0 0.5rem;
        }
        .remove-btn {
            color: #333;
            background: none;
            border: none;
            font-size: 1.5rem;
            padding: 0;
            cursor: pointer;
        }
        .remove-btn:hover {
            color: #faa2a2;
        }
        .order-summary {
            background-color: #f1f1f1;
            padding: 1.5rem;
            border-radius: 4px;
            position: sticky;
            top: 80px;
            z-index: 10;
        }
        .checkout-btn {
            background-color: #2ecc71;
            border: none;
            width: 100%;
            padding: 0.75rem;
            color: white;
            font-weight: 500;
            text-transform: uppercase;
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

        .auth-buttons {
            padding: 1.5rem;
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
<%
    UserDTO currentUser = (UserDTO) session.getAttribute("user");
    String userName = currentUser != null ? currentUser.getName() : "";
    String userEmail = currentUser != null ? currentUser.getEmail() : "";
    Integer userId = currentUser != null ? currentUser.getUserId() : null;

    List<CartDTO2> products = (List<CartDTO2>) request.getAttribute("products");
    if (products == null) {
        products = new ArrayList<>();
    }

%>
<nav class="navbar navbar-expand-lg sticky-top p-0">
    <div class="container-fluid mx-5">
        <a class="navbar-brand d-flex" href="#"
        ><img
                src="../assets/images/logo.png"
                style="margin-top: -6px"
                width="50"
                alt=""
        />
            <h3 id="brad" class="mt-1">Meduza</h3></a
        >
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item dropdown d-flex">
                    <button type="button" class="btn nav-link">
                        <a class="nav-link p-0" href="#products">Categories</a>
                    </button>
                    <button
                            type="button"
                            class="btn dropdown-toggle dropdown-toggle-split"
                            data-bs-toggle="dropdown"
                            aria-expanded="false"
                    >
                        <span class="visually-hidden">Toggle Dropdown</span>
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">T-Shirt</a></li>
                        <li><a class="dropdown-item" href="#">Cropped Top</a></li>
                        <li><a class="dropdown-item" href="#">Collared T-Shirt</a></li>
                        <li><a class="dropdown-item" href="#">Long Sleeve</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#arrivals">New Arrivals</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#arrivals">Best Sellers</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#contact">Contact Us</a>
                </li>
            </ul>
            <div class="d-flex">
                <a href="#" class="btn me-0">
                    <i class="bi bi-cart fs-4"></i>
                </a>
                <a
                        class="btn"
                        type="button"
                        data-bs-toggle="offcanvas"
                        data-bs-target="#offcanvasRight"
                        aria-controls="offcanvasRight"
                >
                    <i class="bi bi-person-circle fs-4"></i>
                </a>
            </div>
        </div>
    </div>
</nav>

<div class="p-5 container-fluid">
    <h1 class="mb-4">Your Cart</h1>

    <div class="row">
        <div class="col-md-8">
            <table class="table">
                <thead>
                <tr>
                    <th>PRODUCT</th>
                    <th>PRICE</th>
                    <th>QUANTITY</th>
                    <th>TOTAL</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <%
                    double subtotal = 0;
                    for (CartDTO2 product : products) {
                        double price = product.getProductDTO().getPrice();
                        int quantity = product.getQty();
                        double total = price * quantity;
                        subtotal += total;
                %>
                <tr>
                    <td>
                        <div class="d-flex align-items-center">
                            <img src="<%= product.getImsge_url() %>" alt="<%= product.getProductDTO().getName() %>" class="product-img me-3" />
                            <div>
                                <div><%= product.getProductDTO().getName() %></div>
                                <small class="text-muted"><%= product.getProductDTO().getDescription() %></small>
                            </div>
                        </div>
                    </td>
                    <td>$<%= String.format("%.2f", price) %></td>
                    <td >
                        <form method="post" action="cart">
                            <input type="hidden" name="user" value="<%= userId %>">
                            <input type="hidden" name="cart" value="<%= product.getCart_id() %>">
                            <input type="hidden" name="product" value="<%= product.getProduct_id() %>">
                            <input type="hidden" name="quantity" value="1">
                            <button type="submit" value="update" name="action" class="btn btn-sm ms-3">+</button>
                        </form>
                        <input type="text" value="<%= quantity %>" class="quantity-input" readonly />
                        <form method="post" action="cart">
                            <input type="hidden" name="user" value="<%= userId %>">
                            <input type="hidden" name="cart" value="<%= product.getCart_id() %>">
                            <input type="hidden" name="product" value="<%= product.getProduct_id() %>">
                            <input type="hidden" name="quantity" value="-1">
                            <button type="submit" value="update" name="action" class="btn btn-sm ms-3">-</button>
                        </form>
                    </td>
                    <td>$<%= String.format("%.2f", total) %></td>
                    <td>
                        <form method="post" action="cart">
                            <input type="hidden" name="user" value="<%= userId %>">
                            <input type="hidden" name="cart" value="<%= product.getCart_id() %>">
                            <input type="hidden" name="product" value="<%= product.getProduct_id() %>">
                            <button type="submit" value="remove" name="action" class="remove-btn">
                                <i class="bi bi-x"></i>
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
            <%
                String error = request.getParameter("error");
                if (error != null && !error.isEmpty()) {
            %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% } %>
        </div>

        <div class="col-md-4">
            <form action="order" method="post" class="order-summary">
                <h5 class="mb-4">Order Summary</h5>
                <input type="hidden" name="address" value="<%= currentUser.getAddress() %>">
                <input type="hidden" name="user" value="<%= userId %>">
                <div class="d-flex justify-content-between mb-2">
                    <span>Subtotal</span>
                    <span>$<%= String.format("%.2f", subtotal) %></span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span>Shipping</span>
                    <span>Free</span>
                </div>
                <br />
                <div class="d-flex justify-content-between mb-4">
                    <strong>Total</strong>
                    <strong>$<%= String.format("%.2f", subtotal) %></strong>
                </div>
                <button type="submit"  class="checkout-btn">Checkout</button>
            </form>
        </div>
    </div>
</div>

<!-- Profile Section -->
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

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>

