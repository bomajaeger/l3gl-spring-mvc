package groupe2.rest;

import groupe2.entity.Type;
import groupe2.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/type")
public class TypeRestController {

    @Autowired
    private TypeService typeService;

    @GetMapping
    public List<Type> getList() {
        return typeService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Type> getOne(@PathVariable Long id) {
        Type type = typeService.findById(id);
        // ResponseEntity permet de maîtriser le code HTTP : 404 au lieu d'un corps vide en 200
        return type == null
                ? ResponseEntity.notFound().build()
                : ResponseEntity.ok(type);
    }

    @PostMapping
    public ResponseEntity<Type> save(@RequestBody Type type) {
        typeService.save(type);
        return ResponseEntity.status(HttpStatus.CREATED).body(type);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Type> edit(@PathVariable Long id, @RequestBody Type type) {
        Type typeBd = typeService.findById(id);
        if (typeBd == null) return ResponseEntity.notFound().build();

        // On ne recopie que les champs modifiables : le client ne peut pas
        // écraser l'id ni la collection de produits.
        typeBd.setLibelle(type.getLibelle());
        typeService.save(typeBd);
        return ResponseEntity.ok(typeBd);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Long id) {
        try {
            typeService.delete(id);
            return ResponseEntity.ok("Type supprimé avec succès");
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
        }
    }
}