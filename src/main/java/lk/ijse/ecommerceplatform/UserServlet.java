package lk.ijse.ecommerceplatform;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.*;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import lk.ijse.ecommerceplatform.dto.UserDTO;
import lk.ijse.ecommerceplatform.util.PasswordUtil;

import javax.sql.DataSource;

@WebServlet(name = "user", value = "/user")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class UserServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("register".equals(action)) {
            registerUser(req, resp);
        } else if ("delete".equals(action)) {
            // deleteCategory(request, response);
        }else if ("update".equals(action)) {
            // updateCategory(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            loginUser(request, response);
        } else if ("logout".equals(action)) {
            logout(request, response);
        }

    }

    private void logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);

        if (session != null) {
            session.removeAttribute("user");

            session.invalidate();
        }

        try {
            response.sendRedirect("index.jsp");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void loginUser(HttpServletRequest request, HttpServletResponse response) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            if (email != null && password != null) {
                Connection connection = dataSource.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM users WHERE email = ?");
                preparedStatement.setString(1, email);
                ResultSet resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    if (PasswordUtil.checkPassword(password,resultSet.getString("password"))){
                        int id = resultSet.getInt(1);
                        String name = resultSet.getString("name");
                        String role = resultSet.getString("role");
                        boolean isActive = resultSet.getBoolean("is_active");
                        String image_url = resultSet.getString("image_url");

                        UserDTO user = new UserDTO(id, email, null, name, role, isActive,image_url);

                        HttpSession session = request.getSession();
                        session.setAttribute("user", user);

                        if (user.getRole().equals("ADMIN")) {
                            response.sendRedirect("admin/dashboard.jsp");
                        }else {
                            response.sendRedirect("index.jsp");
                        }
                    }else {
                        request.setAttribute("error", "wrong password");
                        request.getRequestDispatcher("pages/login.jsp").forward(request, response);
                    }
                }else {
                    request.setAttribute("error", "no user found");
                    request.getRequestDispatcher("pages/login.jsp").forward(request, response);
                }
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException | ServletException e) {
            e.printStackTrace();
        }
    }

    private void registerUser(HttpServletRequest req, HttpServletResponse resp){
        try {
            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String confirmPassword = req.getParameter("confirmPassword");
            String role = req.getParameter("role");
            Part imagePart = req.getPart("image");

            if (!password.equals(confirmPassword)) {
                req.setAttribute("error", "Passwords do not match");
                req.getRequestDispatcher("pages/register.jsp").forward(req, resp);
                return;
            }

            if (isEmailExists(email)) {
                req.setAttribute("error", "Email already registered");
                req.getRequestDispatcher("pages/register.jsp").forward(req, resp);
                return;
            }

            String imageFileName = null;
            if (imagePart != null && imagePart.getSize() > 0) {
                imageFileName = saveImageToFolder(imagePart);
            }else {
                imageFileName = "default-user-image.png";
            }

            Connection connection = dataSource.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO users ( email, password, name, role, image_url) VALUES (?, ?, ?, ?, ?)");
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, PasswordUtil.hashPassword(password));
            preparedStatement.setString(3, fullName);
            preparedStatement.setString(4, role);
            preparedStatement.setString(5, "assets/images/users/" + imageFileName);
            int i = preparedStatement.executeUpdate();

            if (i > 0 && role.equals("CUSTOMER")) {
                loginUser(req, resp);
            } else if(i > 0 && role.equals("ADMIN")) {
                loginUser(req, resp);
            } else if (i == 0 && role.equals("ADMIN")) {
                req.setAttribute("error", "Failed to register user");
                req.getRequestDispatcher("admin/users.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Failed to register user");
                req.getRequestDispatcher("pages/register.jsp").forward(req, resp);
            }

        }catch (Exception e) {
            e.printStackTrace();
        }
    }
    private String saveImageToFolder(Part filePart) {
        String imageFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // Sanitize filename

        String uploadDir = "/home/shan/IdeaProjects/E-Commerce-Platform/src/main/webapp/assets/images/users";
        Path uploadDirectory = Paths.get(uploadDir);

        try {
            // Create directory if it doesn't exist
            if (!Files.exists(uploadDirectory)) {
                Files.createDirectories(uploadDirectory);
            }

            // Generate a unique file name to prevent overwriting
            String uniqueFileName = System.currentTimeMillis() + "_" + imageFileName;
            Path imageFilePath = uploadDirectory.resolve(uniqueFileName);

            // Save the file
            try (InputStream inputStream = filePart.getInputStream()) {
                Files.copy(inputStream, imageFilePath, StandardCopyOption.REPLACE_EXISTING);
            }
            return uniqueFileName;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    private boolean isEmailExists(String email)  {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }




        /*private static final long serialVersionUID = 1L;

        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                conn = DatabaseConnection.getConnection();

                // Query to check user credentials
                String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, email);
                pstmt.setString(2, hashPassword(password)); // You should implement password hashing

                rs = pstmt.executeQuery();

                if (rs.next()) {
                    // Create session and set attributes
                    HttpSession session = request.getSession();
                    session.setAttribute("user", rs.getInt("id"));
                    session.setAttribute("userName", rs.getString("name"));
                    session.setAttribute("userEmail", email);

                    // Send success response
                    response.setContentType("application/json");
                    response.getWriter().write("{\"status\": \"success\", \"message\": \"Login successful\"}");
                } else {
                    // Send error response
                    response.setContentType("application/json");
                    response.getWriter().write("{\"status\": \"error\", \"message\": \"Invalid credentials\"}");
                }

            } catch (SQLException e) {
                // Log the error and send error response
                e.printStackTrace();
                response.setContentType("application/json");
                response.getWriter().write("{\"status\": \"error\", \"message\": \"Server error occurred\"}");
            } finally {
                // Close all database resources
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        private String hashPassword(String password) {
            // Implement your password hashing logic here
            // Example using a simple hash (NOT FOR PRODUCTION USE):
            return org.apache.commons.codec.digest.DigestUtils.sha256Hex(password);

            // For production, use a proper password hashing library like BCrypt:
            // return BCrypt.hashpw(password, BCrypt.gensalt());
        }*/

}