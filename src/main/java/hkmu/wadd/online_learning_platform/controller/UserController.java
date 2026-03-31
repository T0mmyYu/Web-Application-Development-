package hkmu.wadd.online_learning_platform.controller;

import hkmu.wadd.online_learning_platform.model.User;
import hkmu.wadd.online_learning_platform.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserRepository userRepository; // 自動注入

    @GetMapping("/test-db")
    @ResponseBody
    public String testDatabase() {
        List<User> allUsers = userRepository.findAll();

        return "Database 中共有 " + allUsers.size() + " 個用戶。";
    }

    @GetMapping("/find-user")
    @ResponseBody
    public String findOneUser(@RequestParam String name) {
        // 根據 Username 搵人
        User user = userRepository.findById(name).orElse(null);
        return (user != null) ? "搵到用戶：" + user.getUsername() : "搵唔到此人";
    }
}