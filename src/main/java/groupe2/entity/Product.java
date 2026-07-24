package groupe2.entity;


import javax.persistence.*;

@Entity
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String libelle;

    private double prix;

    // Côté propriétaire de la relation : c'est cette classe qui porte la colonne type_id.
    // ManyToOne est EAGER par défaut, donc ${product.type.libelle} fonctionne en JSP.
    @ManyToOne
    @JoinColumn(name = "type_id")
    private Type type;

    public Product() {
    }

    public Product(Long id, String libelle, double prix) {
        this.id = id;
        this.libelle = libelle;
        this.prix = prix;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }

    public Type getType() { return type; }
    public void setType(Type type) { this.type = type; }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", libelle='" + libelle + '\'' +
                ", prix=" + prix +
                '}';
    }
}