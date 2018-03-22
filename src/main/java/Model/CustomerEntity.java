/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author anaii
 */
class CustomerEntity {
     private String email;

    private int id;

    public CustomerEntity(int customerID, String emailCustomer) {
        this.id = customerID;
        this.email = emailCustomer;
    }

        public int getCustomerId() {
        return id;
    }

    /**
     * Get the value of name
     *
     * @return the value of name
     */
    public String getEmail() {
        return email;
    }

}
