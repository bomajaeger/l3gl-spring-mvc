package groupe2.controller;

import groupe2.entity.Product;
import groupe2.service.ProductService;
import groupe2.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    // Le contrôleur a besoin des types pour alimenter la liste déroulante du formulaire.
    @Autowired
    private TypeService typeService;

    @GetMapping
    public String getList(Model model) {
        List<Product> list = productService.findAll();
        model.addAttribute("products", list);
        return "product";
    }

    @GetMapping("/new")
    public String form(Model model) {
        // Objet vide plutôt qu'aucun attribut : évite les valeurs "" dans le formulaire,
        // qui feraient échouer la conversion vers le type primitif double.
        model.addAttribute("product", new Product());
        model.addAttribute("types", typeService.findAll());
        return "form-product";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Long id, Model model) {
        model.addAttribute("product", productService.findById(id));
        model.addAttribute("types", typeService.findAll());
        return "form-product";
    }

    @PostMapping
    public String save(@ModelAttribute Product product,
                       @RequestParam(name = "typeId", required = false) Long typeId,
                       RedirectAttributes redirect) {

        // Le formulaire ne transmet que l'identifiant du type. On recharge l'entité
        // depuis la base : Spring ne sait pas résoudre seul une propriété imbriquée
        // ("type.id") quand product.getType() vaut null.
        product.setType(typeId == null ? null : typeService.findById(typeId));

        productService.save(product);
        redirect.addFlashAttribute("message", "Produit enregistré.");
        return "redirect:/product"; // POST/Redirect/GET : pas de doublon au rafraîchissement
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id, RedirectAttributes redirect) {
        productService.delete(id);
        redirect.addFlashAttribute("message", "Produit supprimé.");
        return "redirect:/product";
    }
}