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

@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDTO user = validateUser(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userName", user.getName());
            session.setAttribute("userEmail", user.getEmail());

            response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("login.jsp?error=true");
        }
    }
    private UserDTO validateUser(String email, String password) {

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

                    UserDTO user = new UserDTO(id, email, password, name, role, isActive);
                    return user;
                }
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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