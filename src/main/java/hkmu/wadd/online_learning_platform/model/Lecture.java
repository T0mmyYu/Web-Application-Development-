package hkmu.wadd.online_learning_platform.model;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Lecture {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String summary;
    private String notesUrl;

    @ElementCollection
    @CollectionTable(name = "lecture_additional_files", joinColumns = @JoinColumn(name = "lecture_id"))
    @Column(name = "file_url")
    private List<String> additionalFiles = new ArrayList<>();

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

    // Getters
    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getSummary() {
        return summary;
    }

    public String getNotesUrl() {
        return notesUrl;
    }

    public Course getCourse() {
        return course;
    }

    public List<String> getAdditionalFiles() {
        return additionalFiles;
    }

    // Setters
    public void setCourse(Course course) {
        this.course = course;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public void setNotesUrl(String notesUrl) {
        this.notesUrl = notesUrl;
    }

    public void setAdditionalFiles(List<String> additionalFiles) {
        this.additionalFiles = additionalFiles;
    }

    // Helper methods
    public void addAdditionalFile(String fileUrl) {
        if (this.additionalFiles == null) {
            this.additionalFiles = new ArrayList<>();
        }
        this.additionalFiles.add(fileUrl);
    }

    public void removeAdditionalFile(String fileUrl) {
        if (this.additionalFiles != null) {
            this.additionalFiles.remove(fileUrl);
        }
    }
}