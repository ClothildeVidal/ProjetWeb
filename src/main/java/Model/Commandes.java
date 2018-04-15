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
public class Commandes {

    private int orderID;
    private float cout;
    private int produit;
    private int quantite;
    private String description;

    public Commandes(int orderID, int produit, int quantite, float cout, String description) {
        this.orderID = orderID;
        this.produit = produit;
        this.quantite = quantite;
        this.cout = cout;
        this.description = description;
    }

    public int getProduit() {
        return produit;
    }

    public int getOrderID() {
        return orderID;
    }

    public int getQuantity() {
        return quantite;
    }

    public float getCout() {
        return cout;
    }

    public String getDescription() {
        return description;
    }
}
