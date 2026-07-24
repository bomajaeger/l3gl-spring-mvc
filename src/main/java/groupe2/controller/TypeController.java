package groupe2.controller;

import groupe2.entity.Type;
import groupe2.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/type")
public class TypeController {

    @Autowired
    private TypeService typeService;

    @GetMapping
    public String getList(Model model) {
        List<Type> list = typeService.findAll();
        model.addAttribute("types", list);
        return "type";
    }

    @GetMapping("/new")
    public String form(Model model) {
        // On place un objet vide dans le modèle : sans ça, ${type.libelle} serait
        // vide dans la JSP et le binding du champ id poserait problème.
        model.addAttribute("type", new Type());
        return "form-type";
    }

    @PostMapping
    public String save(@ModelAttribute Type type) {
        typeService.save(type);
        return "redirect:/type"; // POST/Redirect/GET : évite le doublon au rafraîchissement
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Long id, Model model) {
        model.addAttribute("type", typeService.findById(id));
        return "form-type";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id, RedirectAttributes redirect) {
        try {
            typeService.delete(id);
            redirect.addFlashAttribute("message", "Type supprimé avec succès.");
        } catch (IllegalStateException e) {
            // La règle métier du service remonte ici et devient un message utilisateur
            redirect.addFlashAttribute("erreur", e.getMessage());
        }
        return "redirect:/type";
    }
}