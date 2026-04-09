package hkmu.wadd.online_learning_platform.repository;

import hkmu.wadd.online_learning_platform.model.PollVote;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PollVoteRepository extends JpaRepository<PollVote, Long> {
    Optional<PollVote> findByPollIdAndUsername(Long pollId, String username);
}