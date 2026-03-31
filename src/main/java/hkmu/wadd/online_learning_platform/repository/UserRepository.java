package hkmu.wadd.online_learning_platform.repository;

import hkmu.wadd.online_learning_platform.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, String> {
    // 這裡繼承了 JpaRepository，基本的 CRUD (Create, Read, Update, Delete) 已經自動寫好了
    // 第一個參數 User 是你的 Model，第二個 String 是 Primary Key (username) 的類型
}