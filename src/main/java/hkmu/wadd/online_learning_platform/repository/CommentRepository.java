package hkmu.wadd.online_learning_platform.repository;

import hkmu.wadd.online_learning_platform.model.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {
    List<Comment> findByLectureIdOrderByCreateTimeDesc(Long lectureId);
    List<Comment> findByPollIdOrderByCreateTimeDesc(Long pollId);
    void deleteByLectureId(Long lectureId);
    void deleteByPollId(Long pollId);
}