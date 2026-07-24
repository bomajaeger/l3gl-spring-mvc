package groupe2.service.impl;

import groupe2.entity.Product;
import groupe2.repository.ProductRepository;
import groupe2.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository repository;

    @Override
    public void save(Product product) {
        repository.save(product);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Product> findAll() {
        return repository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public Product findById(Long id) {
        return repository.findById(id);
    }

    @Override
    public void delete(Long id) {
        repository.delete(id);
    }
}