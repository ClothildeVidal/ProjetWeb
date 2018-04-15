package Model;

public class Produits {

    private int productID;
    private int productCode;
    private int quantite;
    private float cout;
    private String description;

    public Produits(int productID, int productCode, int quantite, float cout, String description) {
        this.productID = productID;
        this.productCode = productCode;
        this.quantite = quantite;
        this.cout = cout;
        this.description = description;
    }

    public int getProductID() {
        return productID;
    }

    public int getProductCode() {
        return productCode;
    }

    public int getQuantite() {
        return quantite;
    }

    public float getCout() {
        return cout;
    }

    public String getDescription() {
        return description;
    }
}
