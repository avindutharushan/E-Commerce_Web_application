package lk.ijse.ecommerceplatform;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.ecommerceplatform.dto.CategoryDTO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/categories")
public class CategoryListServlet1 extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("regeg");
        List<CategoryDTO> categories = new ArrayList<>();

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT c.*, COUNT(p.category_id) as product_count " +
                             "FROM ecommerce.categories c " +
                             "LEFT JOIN ecommerce.products p ON c.category_id = p.category_id " +
                             "GROUP BY c.category_id")) {

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                CategoryDTO categoryDTO = new CategoryDTO();
                categoryDTO.setId(rs.getInt("id"));
                categoryDTO.setName(rs.getString("name"));
                categoryDTO.setDescription(rs.getString("description"));

                categories.add(categoryDTO);
            }

            request.setAttribute("categoryList", categories);
            request.getRequestDispatcher("/admin/categories.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addCategory(request, response);
        } else if ("update".equals(action)) {
            updateCategory(request, response);
        } else if ("delete".equals(action)) {
            deleteCategory(request, response);
        }
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "INSERT INTO ecommerce.categories (name, description) VALUES (?, ?)")) {

            stmt.setString(1, request.getParameter("name"));
            stmt.setString(2, request.getParameter("description"));

            stmt.executeUpdate();
            response.sendRedirect(request.getContextPath() + "/admin/categories");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "UPDATE ecommerce.categories SET name=?, description=? WHERE category_id=?")) {

            stmt.setString(1, request.getParameter("name"));
            stmt.setString(2, request.getParameter("description"));
            stmt.setBoolean(3, request.getParameter("active") != null);
            stmt.setInt(4, Integer.parseInt(request.getParameter("id")));

            stmt.executeUpdate();
            response.sendRedirect(request.getContextPath() + "/admin/categories");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "DELETE FROM ecommerce.categories WHERE category_id=?")) {

            stmt.setInt(1, Integer.parseInt(request.getParameter("id")));
            stmt.executeUpdate();

            response.sendRedirect(request.getContextPath() + "/admin/categories");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}