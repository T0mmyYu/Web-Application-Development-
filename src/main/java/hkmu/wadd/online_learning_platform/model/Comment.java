package hkmu.wadd.online_learning_platform.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "comments")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String content;
    private String username;
    private LocalDateTime createTime;
    private Long lectureId;
    private Long pollId;

    public Comment() {}

    public Comment(String content, String username, Long lectureId, Long pollId) {
        this.content = content;
        this.username = username;
        this.lectureId = lectureId;
        this.pollId = pollId;
        this.createTime = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public LocalDateTime getCreateTime() { return createTime; }
    public void setCreateTime(LocalDateTime createTime) { this.createTime = createTime; }

    public Long getLectureId() { return lectureId; }
    public void setLectureId(Long lectureId) { this.lectureId = lectureId; }

    public Long getPollId() { return pollId; }
    public void setPollId(Long pollId) { this.pollId = pollId; }
}