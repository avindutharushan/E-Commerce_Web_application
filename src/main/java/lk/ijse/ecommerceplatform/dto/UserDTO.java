package lk.ijse.ecommerceplatform.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDTO {
    private int userId;
    private String email;
    private String password;
    private String name;
    private String role;
    private boolean isActive;
    private String image_url;
}
