package Model;

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
