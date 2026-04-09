package hkmu.wadd.online_learning_platform.controller;

import hkmu.wadd.online_learning_platform.model.Course;
import hkmu.wadd.online_learning_platform.model.Poll;
import hkmu.wadd.online_learning_platform.repository.CourseRepository;
import hkmu.wadd.online_learning_platform.repository.PollRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class IndexController {

    private final CourseRepository courseRepository;
    private final PollRepository pollRepository;

    public IndexController(CourseRepository courseRepository, PollRepository pollRepository) {
        this.courseRepository = courseRepository;
        this.pollRepository = pollRepository;
    }

    @GetMapping({"/", "/index"})
    public String index(Model model) {
        List<Course> courses = courseRepository.findAll();
        List<Poll> polls = pollRepository.findAllByOrderByIdDesc();

        model.addAttribute("courses", courses);
        model.addAttribute("polls", polls);

        return "home";
    }
}