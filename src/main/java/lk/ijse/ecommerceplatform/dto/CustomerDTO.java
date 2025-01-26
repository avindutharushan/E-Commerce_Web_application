package lk.ijse.ecommerceplatform.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CustomerDTO {
    private int userId;
    private String email;
    private String password;
    private String name;
    private boolean isActive;
    private String image_url;
    private String address;
}
