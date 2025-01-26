package lk.ijse.ecommerceplatform.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class OrderSuccessDTO {

    private String product;
    private int quantity;
    private double price;
    private double total;
}
