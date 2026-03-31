package hkmu.wadd.online_learning_platform.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class IndexController {
    // 同時支援 localhost:8080/ 和 localhost:8080/index
    @GetMapping({"/", "/index"})
    public String index() {
        return "redirect:/login";
    }
}