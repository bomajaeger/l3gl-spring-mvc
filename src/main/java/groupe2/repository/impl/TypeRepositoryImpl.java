package groupe2.repository.impl;

import groupe2.entity.Type;
import groupe2.repository.TypeRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class TypeRepositoryImpl implements TypeRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void save(Type type) {
        // merge : INSERT si id null, UPDATE sinon. Un seul point d'entrée pour les deux cas.
        entityManager.merge(type);
    }

    @Override
    public List<Type> findAll() {
        // DISTINCT + LEFT JOIN FETCH : charge les produits dans la même requête,
        // pendant que la transaction est encore ouverte.
        return entityManager
                .createQuery("SELECT DISTINCT t FROM Type t LEFT JOIN FETCH t.products", Type.class)
                .getResultList();
    }

    @Override
    public Type findById(Long id) {
        return entityManager.find(Type.class, id);
    }

    @Override
    public void delete(Long id) {
        Type type = findById(id);
        if (type != null) {
            entityManager.remove(type);
        }
    }
}