package hkmu.wadd.online_learning_platform;

import hkmu.wadd.online_learning_platform.repository.UserRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(auth -> auth
                        .dispatcherTypeMatchers(jakarta.servlet.DispatcherType.FORWARD).permitAll()
                        .requestMatchers("/login", "/static/**", "/resources/**", "/error").permitAll()
                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .defaultSuccessUrl("/home", true) // 登入成功後跳去邊
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutSuccessUrl("/login?logout")
                        .permitAll()
                );

        return http.build();
    }

    @Bean
    public UserDetailsService userDetailsService(UserRepository userRepository) {
        return username -> {
            System.out.println("---------- SECURITY DEBUG ----------");
            System.out.println("1. 網頁傳入嚟嘅 Username: [" + username + "]");

            return userRepository.findById(username)
                    .map(user -> {
                        System.out.println("2. ✅ Database 搵到人！");
                        System.out.println("   - DB 入面嘅 Username: [" + user.getUsername() + "]");
                        System.out.println("   - DB 入面嘅 Password: [" + user.getPassword() + "]");
                        System.out.println("   - DB 入面嘅 Role: [" + user.getUserType() + "]");

                        return org.springframework.security.core.userdetails.User
                                .withUsername(user.getUsername())
                                .password(user.getPassword()) // 呢度應該帶住 {noop}
                                .roles(user.getUserType())
                                .build();
                    })
                    .orElseThrow(() -> {
                        System.out.println("2. ❌ 仆街喇，Database 根本搵唔到呢個人！");
                        return new UsernameNotFoundException("User not found: " + username);
                    });
        };
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        // 支援多種加密格式，包括你而家用緊嘅明文 {noop}
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }

}