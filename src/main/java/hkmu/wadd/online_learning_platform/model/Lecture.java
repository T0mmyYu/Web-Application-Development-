package hkmu.wadd.online_learning_platform.model;

import jakarta.persistence.*;

@Entity
public class Lecture {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String summary;
    private String notesUrl;

    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;

    public Lecture() {}

    public Lecture(String title, String summary, String notesUrl, Course course) {
        this.title = title;
        this.summary = summary;
        this.notesUrl = notesUrl;
        this.course = course;
    }

    public Long getId() { return id; }
    public String getTitle() { return title; }
    public String getSummary() { return summary; }
    public String getNotesUrl() { return notesUrl; }
    public Course getCourse() { return course; }

    public void setCourse(Course course) { this.course = course; }
    public void setTitle(String title) { this.title = title; }
    public void setSummary(String summary) { this.summary = summary; }
    public void setNotesUrl(String notesUrl) { this.notesUrl = notesUrl; }
}