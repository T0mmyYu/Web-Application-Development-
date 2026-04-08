package hkmu.wadd.online_learning_platform.repository;

import hkmu.wadd.online_learning_platform.model.Lecture;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LectureRepository extends JpaRepository<Lecture,Long> {
}
