package hkmu.wadd.online_learning_platform.controller;

import hkmu.wadd.online_learning_platform.model.Course;
import hkmu.wadd.online_learning_platform.repository.CourseRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class CourseController {

    private final CourseRepository courseRepository;

    public CourseController(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    @GetMapping("/course/details")
    public String showCourseDetails(@RequestParam("id") Long id, Model model) {
        Course course = courseRepository.findById(id).orElse(null);

        if (course == null) {
            return "redirect:/";
        }
        model.addAttribute("course", course);
        return "course_details";
    }
}