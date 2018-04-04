package Model;

public class CustomerEntity {

    private String email;

    private int id;

    public CustomerEntity(int customerID, String emailCustomer) {
        this.id = customerID;
        this.email = emailCustomer;
    }

    public int getCustomerId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

}
