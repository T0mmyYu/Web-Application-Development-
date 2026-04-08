package hkmu.wadd.online_learning_platform.repository;

import hkmu.wadd.online_learning_platform.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, String> {
}