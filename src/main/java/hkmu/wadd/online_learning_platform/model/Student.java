package hkmu.wadd.online_learning_platform.model;


import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("STUDENT")
public class Student extends User {
    public Student(String fullName, String username, String password, String email, String phone) {
        super(fullName, username, password, email, phone);
    }

    public Student() {}
}