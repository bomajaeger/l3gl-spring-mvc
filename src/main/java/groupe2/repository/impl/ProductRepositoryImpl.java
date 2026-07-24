package groupe2.repository.impl;

import groupe2.entity.Product;
import groupe2.repository.ProductRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class ProductRepositoryImpl implements ProductRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void save(Product product) {
        entityManager.merge(product);
    }

    @Override
    public List<Product> findAll() {
        return entityManager
                .createQuery("FROM Product", Product.class)
                .getResultList();
    }

    @Override
    public Product findById(Long id) {
        return entityManager.find(Product.class, id);
    }

    @Override
    public void delete(Long id) {
        Product product = findById(id);

        if(product != null) {
            entityManager.remove(product);
        }
    }
}