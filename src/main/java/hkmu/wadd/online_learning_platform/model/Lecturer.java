package hkmu.wadd.online_learning_platform.model;


import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("LECTURER")
public class Lecturer extends User {
    public Lecturer(String fullName,String username, String password, String email, String phone) {
        super(fullName, username, password, email, phone);
    }

    public Lecturer() {

    }
}