package hkmu.wadd.online_learning_platform.controller;

import hkmu.wadd.online_learning_platform.model.Course;
import hkmu.wadd.online_learning_platform.model.Lecture;
import hkmu.wadd.online_learning_platform.repository.CourseRepository;
import hkmu.wadd.online_learning_platform.repository.LectureRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LectureController {

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private LectureRepository lectureRepository;

    @GetMapping("/course/{courseId}/lecture/create")
    public String showCreatePage(@PathVariable Long courseId, Model model) {

        Course course = courseRepository.findById(courseId).orElse(null);

        model.addAttribute("course", course);
        return "lecture/create";
    }

    @PostMapping("/lecture/create")
    public String createLecture(@RequestParam Long courseId,
                                @RequestParam String title,
                                @RequestParam String summary) {

        Lecture lecture = new Lecture();
        lecture.setTitle(title);
        lecture.setSummary(summary);


        Course course = courseRepository.findById(courseId).orElse(null);
        lecture.setCourse(course);

        lectureRepository.save(lecture);

        return "redirect:/course/details?id=" + courseId;
    }
    @GetMapping("/lecture/view")
    public String viewLecture(@RequestParam Long id, Model model) {
        Lecture lecture = lectureRepository.findById(id).orElse(null);
        if (lecture == null) {
            return "redirect:/";
        }

        Course course = lecture.getCourse();
        model.addAttribute("lecture", lecture);
        model.addAttribute("course", course);

        // Optional: Add next lecture navigation
        // You can implement logic to find next lecture in the course

        return "lecture/view";
    }

    // 可選：編輯 Lecture 的方法
    @GetMapping("/lecture/edit")
    public String showEditPage(@RequestParam Long id, Model model) {
        Lecture lecture = lectureRepository.findById(id).orElse(null);
        if (lecture == null) {
            return "redirect:/";
        }
        model.addAttribute("lecture", lecture);
        model.addAttribute("course", lecture.getCourse());
        return "lecture/edit";
    }

    @PostMapping("/lecture/edit")
    public String updateLecture(@RequestParam Long id,
                                @RequestParam String title,
                                @RequestParam String summary,
                                @RequestParam(required = false) String notesUrl) {
        Lecture lecture = lectureRepository.findById(id).orElse(null);
        if (lecture != null) {
            lecture.setTitle(title);
            lecture.setSummary(summary);
            if (notesUrl != null && !notesUrl.trim().isEmpty()) {
                lecture.setNotesUrl(notesUrl);
            }
            lectureRepository.save(lecture);
        }
        return "redirect:/lecture/view?id=" + id;
    }
}