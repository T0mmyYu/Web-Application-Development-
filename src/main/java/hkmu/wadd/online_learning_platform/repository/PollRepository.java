package hkmu.wadd.online_learning_platform.repository;

import hkmu.wadd.online_learning_platform.model.Poll;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PollRepository extends JpaRepository<Poll, Long> {
    List<Poll> findAllByOrderByIdDesc();
    List<Poll> findByCourseId(Long courseId);
}