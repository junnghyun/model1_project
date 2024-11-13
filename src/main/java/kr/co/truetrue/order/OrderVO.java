package kr.co.truetrue.order;
public class OrderVO {
    private int orderId;               // order_id from the view
    private String productNames;       // product_names (aggregated product names)
    private String orderDate;          // order_date in 'YYYY-MM-DD' format
    private double totalAmount;        // total_amount (sum of the total price)
    private String deliveryCompleteDate; // delivery_complete_date in 'YYYY-MM-DD' format
    private String deliveryStatus;     // delivery_status (translated status)

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getProductNames() {
        return productNames;
    }

    public void setProductNames(String productNames) {
        this.productNames = productNames;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getDeliveryCompleteDate() {
        return deliveryCompleteDate;
    }

    public void setDeliveryCompleteDate(String deliveryCompleteDate) {
        this.deliveryCompleteDate = deliveryCompleteDate;
    }

    public String getDeliveryStatus() {
        return deliveryStatus;
    }

    public void setDeliveryStatus(String deliveryStatus) {
        this.deliveryStatus = deliveryStatus;
    }

    @Override
    public String toString() {
        return "OrderVO{" +
                "orderId=" + orderId +
                ", productNames='" + productNames + '\'' +
                ", orderDate='" + orderDate + '\'' +
                ", totalAmount=" + totalAmount +
                ", deliveryCompleteDate='" + deliveryCompleteDate + '\'' +
                ", deliveryStatus='" + deliveryStatus + '\'' +
                '}';
    }
}
