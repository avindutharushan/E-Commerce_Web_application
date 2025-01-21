<%@ page import="lk.ijse.ecommerceplatform.dto.CategoryDTO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: shan
  Date: 1/19/25
  Time: 11:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>E-commerce Store</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <style>
        * {
            font-family: "Merriweather", serif;
            font-weight: 500;
            font-style: normal;
        }
        .brand {
            font-family: "Ubuntu", serif;
        }
        body {
            overflow-x: hidden;
        }
        .hero-section {
            position: relative;
            min-height: 80vh;
            background-color: transparent;
            width: 100%;
            max-width: 1400px;
            margin: 0 auto;
        }

        .hero-content {
            padding: 4rem 0;
        }

        .category-card {
            position: relative;
            height: 300px;
            overflow: hidden;
            background-color: #e9ecef;
            transition: all 0.3s ease;
        }

        .category-card:hover {
            z-index: 1;
            transform: scale(1.02);
        }

        .category-content {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 2rem;
            background: linear-gradient(transparent, rgba(0, 0, 0, 0.7));
            color: white;
        }

        .product-card {
            border: none;
            transition: all 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
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
                    <button type="button" class="btn dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
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
                <a href="pages/cart.jsp" class="btn me-0">
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
    <div class="main-container">
        <video class="position-absolute p-0 mb-0" style="z-index: -1; left: 50%; transform: translateX(-50%); width: 100vw;" src="assets/videos/intro.mp4" autoplay muted></video>
        <div class="hero-content mt-0 m-5" style="background-color: transparent; z-index: 1; color: white; padding-top: 180px !important; padding: 50px;">
            <h1 class="brand display-4 fw-bold mb-4">Meduza</h1>
            <p class="lead mb-4">Clothing Collections</p>
            <p class="mb-5" style="text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5)">
                Step into the world of <b>Curated Clothing Collection</b>, where
                style meets comfort effortlessly. <br />
                Crafted from premium materials, each piece is your perfect blend of
                modern elegance and everyday ease—designed to move, breathe, and
                inspire with you.
            </p>
            <div class="d-flex gap-3">
                <button class="btn btn-light px-4 py-2">Shop Now</button>
                <button class="btn btn-outline-light px-4 py-2">Learn More</button>
            </div>
        </div>
    </div>
</section>

<!-- Categories Section -->
<section id="arrivals" class="section-padding">
    <div class="main-container p-0">
        <div class="row">
            <div class="col-6 p-0">
                <div class="category-card">
                    <img src="assets/images/home/boutique-6796399_1280.jpg" alt="New Arrivals" class="w-100 h-100 object-fit-cover" />
                    <div class="category-content ms-3">
                        <h3>New Arrivals</h3>
                        <p class="mb-3">Our new items are designed right to impress.</p>
                        <div class="d-flex gap-2">
                            <button class="btn btn-outline-light btn-sm">see all</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-6 p-0" style="width: 49%">
                <div class="category-card">
                    <img src="assets/images/home/clothing-3221103_1280.jpg" alt="Accessories" class="w-100 h-100 object-fit-cover" />
                    <div class="category-content">
                        <h3>Best Sellers</h3>
                        <p class="mb-3">Complete your look with our best collection.</p>
                        <div class="d-flex gap-2">
                            <button class="btn btn-outline-light btn-sm">see all</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Products Section -->
<section id="products" class="section-padding bg-light pb-5">
    <div class="main-container">
        <h2 class="text-center mb-5">Our Products</h2>
        <div class="row g-4 " id="category-content">

        </div>
    </div>
</section>


<!-- Newsletter Section -->
<section class="py-5" id="contact" style="background-image: url(assets/images/home/dress-2583113_1280.jpg); object-fit: cover; height: 300px;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6 text-center">
                <h3>Subscribe to Our Newsletter</h3>
                <p>Get updates about new products and special offers!</p>
                <div class="input-group mb-3">
                    <input type="email" class="form-control" style="border-color: black; background-color: rgba(241, 225, 235, 0.76);" placeholder="Enter your email" />
                    <button class="btn btn-dark" type="button">Subscribe</button>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Profile Section -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
    <div class="offcanvas-header border-bottom">
        <h5 class="offcanvas-title" id="offcanvasRightLabel">My Profile</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body p-0">
        <% if (session.getAttribute("user") != null) { %>
        <!-- Logged In View -->
        <div class="profile-header">
            <img src="/api/placeholder/80/80" alt="Profile Picture" class="profile-avatar" />
            <h5 class="mb-1"><%= session.getAttribute("userName") %></h5>
            <p class="text-muted mb-0"><%= session.getAttribute("userEmail") %></p>
        </div>
        <ul class="profile-menu">
            <li><a href="#"><i class="bi bi-person"></i> My Profile</a></li>
            <li><a href="#"><i class="bi bi-bag"></i> My Orders</a></li>
            <li><a href="#"><i class="bi bi-heart"></i> Wishlist</a></li>
            <li><a href="#"><i class="bi bi-geo-alt"></i> Addresses</a></li>
            <li><a href="#"><i class="bi bi-credit-card"></i> Payment Methods</a></li>
            <li><a href="#"><i class="bi bi-gear"></i> Settings</a></li>
            <li><a href="logout" class="text-danger"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
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
            <form action="login" method="get">
                <div class="mb-3">
                    <label for="email" class="form-label">Email address</label>
                    <input type="email" class="form-control" id="email" name="email" required />
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required />
                </div>
                <button type="submit" class="btn btn-dark w-100 mb-2">Login</button>
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
<script src="js/jquery-3.7.1.min.js"></script>
<script>
    const fetchCategories = () => {
        $.ajax({
            url: "http://localhost:8080/Meduza/category-all",
            type: "GET",
            success: (res) => {
                $("#category-content").empty();

                res.data.forEach((category) => {

                    $("#category-content").append(
                        '<div class="col-md-4 col-lg-3">' +
                        '<div class="card product-card">' +
                        '<img src="' + category.image_url + '" class="card-img-top" alt="Product" />' +
                        '<div class="card-body">' +
                        '<h5 class="card-title">' + category.name + '</h5>' +
                        '<p class="card-text">' + category.description + '</p>' +
                        '</div>' +
                        '</div>' +
                        '</div>'
                    );
                });
            },
            error: (err) => {
                console.error("GET Error:", err);
                alert("Failed to fetch data. Please try again later.");
            },
        });
    };

    $(document).ready(() => {
        fetchCategories();
    });
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
