package hkmu.wadd.online_learning_platform.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class IndexController {
    @GetMapping({"/", "/index"})
    public String index() {
        // 門口淨係負責帶人去 Login 頁
        return "redirect:/login";
    }
}