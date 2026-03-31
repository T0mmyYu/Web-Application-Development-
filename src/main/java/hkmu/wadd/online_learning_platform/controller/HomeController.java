package hkmu.wadd.online_learning_platform.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    @GetMapping("/home")
    public String dashboard() {
        return "home"; // 搵 /WEB-INF/jsp/home.jsp
    }
}