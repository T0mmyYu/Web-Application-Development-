package hkmu.wadd.online_learning_platform.model;

import jakarta.persistence.*;

@Entity
@Table(name = "users")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "user_type", discriminatorType = DiscriminatorType.STRING)
public class User {

    @Id
    private String username;
    private String fullName;
    private String password;
    private String email;
    private String phone;
    @Column(name = "user_type", insertable = false, updatable = false)
    private String userType;

    public User() {
    }

    public User(String username, String password, String email, String phone, String fullName) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.fullName = fullName;
    }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getUserType() { return userType; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getFullName() { return fullName; }
    public void setUserType(String userType) { this.userType = userType; }
}