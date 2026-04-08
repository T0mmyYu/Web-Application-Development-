package hkmu.wadd.online_learning_platform.repository;

import hkmu.wadd.online_learning_platform.model.Course;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CourseRepository extends JpaRepository<Course, Long> {
    List<Course> findByClassSection(String classSection);
    List<Course> findByCourseCode(String courseCode);

}