package hkmu.wadd.online_learning_platform.controller;

import hkmu.wadd.online_learning_platform.model.User;
import hkmu.wadd.online_learning_platform.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RegisterController {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public RegisterController(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/register")
    public String showRegisterPage() {
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@RequestParam String username,
                               @RequestParam String password,
                               @RequestParam String fullName,
                               @RequestParam String email,
                               @RequestParam String phone,
                               @RequestParam String userType,
                               Model model) {

        // 檢查用戶名是否已存在
        if (userRepository.findById(username).isPresent()) {
            model.addAttribute("error", "Username already exists!");
            return "register";
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword("{noop}" + password);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setUserType(userType);

        userRepository.save(user);

        return "redirect:/login?registered=true";
    }
}