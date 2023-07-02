import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/prova")
public class Controller {

    //@PreAuthorize()
    @GetMapping
    public String check(){
        System.out.println("ciao");
        return "ciao";
    }

}
