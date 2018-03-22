/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author asanto01
 */
public class CustomerEntity {
    private int customerId;
    private String name;

    public CustomerEntity(int customerId, String name) {
        this.customerId = customerId;
        this.name = name;
    }

    CustomerEntity(int customerID, String name, String adresse, String emailCustomer) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    /**
     * Get the value of customerId
     *
     * @return the value of customerId
     */
    public int getCustomerId() {
        return customerId;
    }

    /**
     * Get the value of name
     *
     * @return the value of name
     */
    public String getName() {
        return name;
    }
}
