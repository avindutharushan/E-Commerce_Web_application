<%--
  Created by IntelliJ IDEA.
  User: shan
  Date: 1/20/25
  Time: 12:11 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Forgot Password - Meduza Store</title>
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
        .brand-link {
            text-decoration: none;
            color: #212529;
            font-size: 1.5rem;
            font-weight: bold;
        }
        .brand-link:hover {
            color: #000;
        }
        .info-text {
            color: #6c757d;
            font-size: 0.95rem;
            text-align: center;
            margin-bottom: 25px;
        }
        #verificationStep {
            display: none;
        }
        .password-requirements {
            font-size: 0.8rem;
            color: #6c757d;
            margin-top: 5px;
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
                <div class="text-center" style="margin-top: -30px">
                    <a href="index.jsp" class="brand-link">
                        <img width="100" src="/assets/images/logo.png" alt="" /><br />
                    </a>
                </div>
                <h3 class="text-center mb-3" style="margin-top: -10px">
                    Forgot Password
                </h3>

                <!-- Email Step -->
                <div id="emailStep">
                    <p class="info-text">
                        Enter your email address below and we'll send you a verification
                        code.
                    </p>
                    <form id="emailForm" onsubmit="showVerificationStep(event)">
                        <div class="mb-4">
                            <input
                                    type="email"
                                    class="form-control"
                                    id="email"
                                    name="email"
                                    placeholder="Email address"
                                    required
                            />
                        </div>
                        <button type="submit" class="btn btn-dark w-100 mb-3">
                            Send Verification Code
                        </button>
                    </form>
                </div>

                <!-- Verification and New Password Step -->
                <div id="verificationStep">
                    <p class="info-text">
                        Enter the verification code sent to your email and set your new
                        password.
                    </p>
                    <form action="<%= request.getContextPath() %>/reset-password" method="POST">
                        <div class="mb-3">
                            <input
                                    type="text"
                                    class="form-control"
                                    id="verificationCode"
                                    name="verificationCode"
                                    placeholder="Verification Code"
                                    required
                                    pattern="[0-9]{6}"
                                    maxlength="6"
                            />
                        </div>
                        <div class="mb-3">
                            <input
                                    type="password"
                                    class="form-control"
                                    id="newPassword"
                                    name="newPassword"
                                    placeholder="New Password"
                                    required
                                    minlength="8"
                            />
                        </div>
                        <div class="mb-4">
                            <input
                                    type="password"
                                    class="form-control"
                                    id="confirmPassword"
                                    name="confirmPassword"
                                    placeholder="Confirm New Password"
                                    required
                            />
                        </div>
                        <button type="submit" class="btn btn-dark w-100 mb-3">
                            Reset Password
                        </button>
                    </form>
                </div>

                <!-- Back to Sign In Link -->
                <p class="text-center mt-4 mb-0">
                    Remember your password?
                    <a
                            href="login.jsp"
                            class="text-dark text-decoration-none fw-bold"
                    >Back to Sign in</a
                    >
                </p>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function showVerificationStep(event) {
        event.preventDefault();
        document.getElementById("emailStep").style.display = "none";
        document.getElementById("verificationStep").style.display = "block";
    }

    // Password validation
    document
        .getElementById("confirmPassword")
        .addEventListener("input", function () {
            const newPassword = document.getElementById("newPassword").value;
            const confirmPassword = this.value;

            if (newPassword !== confirmPassword) {
                this.setCustomValidity("Passwords do not match");
            } else {
                this.setCustomValidity("");
            }
        });
</script>
</body>
</html>

