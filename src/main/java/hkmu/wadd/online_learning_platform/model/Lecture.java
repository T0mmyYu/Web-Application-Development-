package hkmu.wadd.online_learning_platform.model;

public class Lecture {
    private int id;
    private String title;
    private String summary;
    private String notesUrl;

    public Lecture(int id, String title, String summary, String notesUrl) {
        this.id = id;
        this.title = title;
        this.summary = summary;
        this.notesUrl = notesUrl;
    }

    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getSummary() { return summary; }
    public String getNotesUrl() { return notesUrl; }
}