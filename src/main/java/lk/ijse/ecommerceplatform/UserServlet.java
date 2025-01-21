package lk.ijse.ecommerceplatform;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import lk.ijse.ecommerceplatform.dto.UserDTO;

import javax.sql.DataSource;

@WebServlet(name = "user", value = "/user")
public class UserServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("update".equals(action)) {
            // updateCategory(request, response);
        } else if ("delete".equals(action)) {
            // deleteCategory(request, response);
        }else if ("register".equals(action)) {
            //register(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println(action);
        if ("login".equals(action)) {
            loginUser(request, response);
        } else if ("update".equals(action)) {
           // updateCategory(request, response);
        } else if ("delete".equals(action)) {
           // deleteCategory(request, response);
        }else if ("logout".equals(action)) {
            logout(request, response);
        }else if ("register".equals(action)) {
            //register(request, response);
        }

    }

    private void logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);

        if (session != null) {
            session.removeAttribute("user");
            session.removeAttribute("userName");
            session.removeAttribute("userEmail");

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
                PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM users WHERE email = ? AND password = ?");
                preparedStatement.setString(1, email);
                preparedStatement.setString(2, password);
                ResultSet resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    int id = resultSet.getInt(1);
                    String name = resultSet.getString("name");
                    String role = resultSet.getString("role");
                    boolean isActive = resultSet.getBoolean("is_active");
                    String image_url = resultSet.getString("image_url");

                    UserDTO user = new UserDTO(id, email, null, name, role, isActive,image_url);

                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    session.setAttribute("userName", user.getName());
                    session.setAttribute("userEmail", user.getEmail());
                    session.setAttribute("userImage", user.getImage_url());
                    session.setAttribute("isActive", user.isActive());

                    response.sendRedirect("index.jsp");
                }else {
                    response.sendRedirect("login.jsp?error=no user found");
                }
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
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