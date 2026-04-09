package hkmu.wadd.online_learning_platform.model;

import jakarta.persistence.*;

@Entity
@Table(name = "poll_votes")
public class PollVote {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "poll_id")
    private Poll poll;

    private String username;
    private int optionNumber;  // 1-5

    public PollVote() {}

    public PollVote(Poll poll, String username, int optionNumber) {
        this.poll = poll;
        this.username = username;
        this.optionNumber = optionNumber;
    }

    // Getters
    public Long getId() { return id; }
    public Poll getPoll() { return poll; }
    public String getUsername() { return username; }
    public int getOptionNumber() { return optionNumber; }

    // Setters
    public void setId(Long id) { this.id = id; }
    public void setPoll(Poll poll) { this.poll = poll; }
    public void setUsername(String username) { this.username = username; }
    public void setOptionNumber(int optionNumber) { this.optionNumber = optionNumber; }
}