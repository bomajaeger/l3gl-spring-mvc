package groupe2.service.impl;

import groupe2.entity.Type;
import groupe2.repository.TypeRepository;
import groupe2.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional // toutes les méthodes publiques sont transactionnelles par défaut
public class TypeServiceImpl implements TypeService {

    @Autowired
    private TypeRepository repository;

    @Override
    public void save(Type type) {
        repository.save(type);
    }

    @Override
    @Transactional(readOnly = true) // désactive le dirty checking : gain de perf en lecture
    public List<Type> findAll() {
        return repository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public Type findById(Long id) {
        return repository.findById(id);
    }

    @Override
    public void delete(Long id) {
        Type type = repository.findById(id);

        // Un type encore rattaché à des produits ne peut pas être supprimé :
        // la contrainte de clé étrangère lèverait une erreur SQL brute.
        // On préfère une exception métier explicite, interceptable par le contrôleur.
        if (type != null && !type.getProducts().isEmpty()) {
            throw new IllegalStateException(
                    "Impossible de supprimer ce type : " + type.getProducts().size() + " produit(s) y sont rattachés."
            );
        }
        repository.delete(id);
    }
}