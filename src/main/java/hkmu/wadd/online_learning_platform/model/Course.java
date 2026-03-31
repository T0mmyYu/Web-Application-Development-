package hkmu.wadd.online_learning_platform.model;

import java.util.ArrayList;
import java.util.List;

public class Course {
    private String courseName;
    private String courseCode;
    private List<Lecture> lectures;
    private List<String> polls;

    public Course(String courseName, String courseCode) {
        this.courseName = courseName;
        this.courseCode = courseCode;
        this.lectures = new ArrayList<>();
        this.polls = new ArrayList<>();
    }


    public void addLecture(Lecture lecture) {
        this.lectures.add(lecture);
    }

    public String getCourseName() { return courseName; }
    public String getCourseCode() { return courseCode; }
    public List<Lecture> getLectures() { return lectures; }
    public List<String> getPolls() { return polls; }
}