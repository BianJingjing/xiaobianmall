package bean;

import java.util.List;

public class Category {
    private String name;
    private int id;
    List<Product> products;
    List<List<Product>> productsByRow;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    @Override
    public String toString() {
        return "Category[ name=" + name + "]";
    }}
