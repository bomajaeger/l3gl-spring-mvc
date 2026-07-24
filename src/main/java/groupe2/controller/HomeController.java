package groupe2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Point d'entrée de l'application.
 * <p>
 * Le DispatcherServlet étant mappé sur "/", c'est lui qui reçoit la requête
 * adressée à la racine du contexte : on la redirige vers le catalogue plutôt
 * que de laisser Tomcat servir la page index.jsp de l'archétype Maven.
 */
@Controller
public class HomeController {

    @GetMapping("/")
    public String accueil() {
        return "redirect:/product";
    }
}