package hkmu.wadd.online_learning_platform.controller;

import hkmu.wadd.online_learning_platform.model.Course;
import hkmu.wadd.online_learning_platform.model.Lecture;
import hkmu.wadd.online_learning_platform.model.Poll;
import hkmu.wadd.online_learning_platform.repository.CourseRepository;
import hkmu.wadd.online_learning_platform.repository.LectureRepository;
import hkmu.wadd.online_learning_platform.repository.PollRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class CourseController {

    private final CourseRepository courseRepository;
    private final LectureRepository lectureRepository;
    private final PollRepository pollRepository;

    public CourseController(CourseRepository courseRepository,
                            LectureRepository lectureRepository,
                            PollRepository pollRepository) {
        this.courseRepository = courseRepository;
        this.lectureRepository = lectureRepository;
        this.pollRepository = pollRepository;
    }

    @GetMapping("/course/details")
    public String showCourseDetails(@RequestParam Long id, Model model) {
        Course course = courseRepository.findById(id).orElse(null);
        if (course == null) {
            return "redirect:/home";
        }

        // 手動查 lectures 同 polls
        List<Lecture> lectures = lectureRepository.findByCourseId(id);
        List<Poll> polls = pollRepository.findByCourseId(id);

        // Debug: 印出數量
        System.out.println("=== Course Details Debug ===");
        System.out.println("Course ID: " + id);
        System.out.println("Course Name: " + course.getCourseName());
        System.out.println("Lectures found: " + lectures.size());
        System.out.println("Polls found: " + polls.size());

        model.addAttribute("course", course);
        model.addAttribute("lectures", lectures);
        model.addAttribute("polls", polls);

        return "course_details";
    }
}