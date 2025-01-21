<%--
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
    <title>Register - Meduza Store</title>
    <!-- Bootstrap CSS -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <style>
        .login-container {
            min-height: 100vh;
            background-color: #f8f9fa;
        }

        .login-card {
            max-width: 400px;
            background: white;
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .btn-dark {
            padding: 12px 24px;
            border-radius: 5px;
        }

        .form-control {
            padding: 12px;
            border-radius: 5px;
            border: 1px solid #dee2e6;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #212529;
        }

    </style>
</head>
<body>
<div
        class="login-container d-flex align-items-center justify-content-center"
>
    <div class="container mt-3">
        <div class="card login-card mx-auto">
            <div class="card-body p-4 p-md-5">


                <h3 class="text-center mb-4" style="margin-top: -10px">
                    Create Account
                </h3>

                <!-- Registration Form -->
                <form action="../user" method="POST" enctype="multipart/form-data">
                    <div class="mb-3">
                        <input
                                type="text"
                                class="form-control"
                                id="fullName"
                                name="fullName"
                                placeholder="Full Name"
                                required
                        />
                    </div>

                    <div class="mb-3">
                        <input
                                type="email"
                                class="form-control"
                                id="email"
                                name="email"
                                placeholder="Email address"
                                required
                        />
                    </div>

                    <div class="mb-3">
                        <input
                                type="password"
                                class="form-control"
                                id="password"
                                name="password"
                                placeholder="Password"
                                required
                        />
                    </div>

                    <div class="mb-3">
                        <input
                                type="password"
                                class="form-control"
                                id="confirmPassword"
                                name="confirmPassword"
                                placeholder="Confirm Password"
                                required
                        />
                    </div>

                    <div class="mb-3">
                    <input type="file" class="form-control" id="image" name="image" accept="image/*">
                    </div>

                    <button type="submit" name="action" value="register" class="btn btn-dark w-100 mb-3">
                        Create Account
                    </button>
                </form>

                <!-- Sign In Link -->
                <p class="text-center mt-3 mb-0">
                    Already have an account?
                    <a
                            href="login.jsp"
                            class="text-dark text-decoration-none fw-bold"
                    >Sign in</a
                    >
                </p>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

