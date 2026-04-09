package hkmu.wadd.online_learning_platform.controller;

import hkmu.wadd.online_learning_platform.model.Course;
import hkmu.wadd.online_learning_platform.model.Poll;
import hkmu.wadd.online_learning_platform.model.PollVote;
import hkmu.wadd.online_learning_platform.model.Comment;  // 加入
import hkmu.wadd.online_learning_platform.repository.CourseRepository;
import hkmu.wadd.online_learning_platform.repository.PollRepository;
import hkmu.wadd.online_learning_platform.repository.PollVoteRepository;
import hkmu.wadd.online_learning_platform.repository.CommentRepository;  // 加入
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class PollController {

    private final PollRepository pollRepository;
    private final PollVoteRepository pollVoteRepository;
    private final CourseRepository courseRepository;
    private final CommentRepository commentRepository;  // 加入

    // 修正 Constructor - 加入 commentRepository
    public PollController(PollRepository pollRepository,
                          PollVoteRepository pollVoteRepository,
                          CourseRepository courseRepository,
                          CommentRepository commentRepository) {  // 加入參數
        this.pollRepository = pollRepository;
        this.pollVoteRepository = pollVoteRepository;
        this.courseRepository = courseRepository;
        this.commentRepository = commentRepository;  // 加入
    }

    @GetMapping("/poll/view")
    public String viewPoll(@RequestParam Long id, Model model, Authentication authentication) {
        Poll poll = pollRepository.findById(id).orElse(null);
        if (poll == null) {
            return "redirect:/home";
        }

        List<Comment> comments = commentRepository.findByPollIdOrderByCreateTimeDesc(id);

        model.addAttribute("poll", poll);
        model.addAttribute("comments", comments);

        // 檢查用戶是否已投票
        if (authentication != null && authentication.isAuthenticated()) {
            String username = authentication.getName();
            PollVote existingVote = pollVoteRepository.findByPollIdAndUsername(id, username).orElse(null);
            if (existingVote != null) {
                model.addAttribute("hasVoted", true);
                model.addAttribute("userVotedOption", existingVote.getOptionNumber());
            } else {
                model.addAttribute("hasVoted", false);
            }
        } else {
            model.addAttribute("hasVoted", false);
        }

        return "poll/view";
    }

    @PostMapping("/poll/vote")
    public String vote(@RequestParam Long pollId,
                       @RequestParam int optionNumber,
                       Authentication authentication) {

        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        String username = authentication.getName();
        Poll poll = pollRepository.findById(pollId).orElse(null);

        if (poll == null) {
            return "redirect:/home";
        }

        PollVote existingVote = pollVoteRepository.findByPollIdAndUsername(pollId, username).orElse(null);

        if (existingVote != null) {

            int oldOption = existingVote.getOptionNumber();
            switch (oldOption) {
                case 1: poll.setCount1(poll.getCount1() - 1); break;
                case 2: poll.setCount2(poll.getCount2() - 1); break;
                case 3: poll.setCount3(poll.getCount3() - 1); break;
                case 4: poll.setCount4(poll.getCount4() - 1); break;
                case 5: poll.setCount5(poll.getCount5() - 1); break;
            }

            existingVote.setOptionNumber(optionNumber);
            pollVoteRepository.save(existingVote);
        } else {

            PollVote newVote = new PollVote(poll, username, optionNumber);
            pollVoteRepository.save(newVote);
        }

        switch (optionNumber) {
            case 1: poll.setCount1(poll.getCount1() + 1); break;
            case 2: poll.setCount2(poll.getCount2() + 1); break;
            case 3: poll.setCount3(poll.getCount3() + 1); break;
            case 4: poll.setCount4(poll.getCount4() + 1); break;
            case 5: poll.setCount5(poll.getCount5() + 1); break;
        }

        pollRepository.save(poll);

        return "redirect:/poll/view?id=" + pollId;
    }

    @GetMapping("/poll/create")
    public String showCreatePage(@RequestParam(required = false) Long courseId, Model model) {
        List<Course> courses = courseRepository.findAll();
        model.addAttribute("courses", courses);

        // 如果係從 course page 嚟嘅，傳返 courseId 去 JSP
        if (courseId != null) {
            Course course = courseRepository.findById(courseId).orElse(null);
            model.addAttribute("course", course);
        }

        return "poll/create";
    }

    @PostMapping("/poll/create")
    public String createPoll(@RequestParam String question,
                             @RequestParam String option1,
                             @RequestParam String option2,
                             @RequestParam String option3,
                             @RequestParam String option4,
                             @RequestParam String option5,
                             @RequestParam(required = false) Long courseId) {

        Poll poll = new Poll();
        poll.setQuestion(question);
        poll.setOption1(option1);
        poll.setOption2(option2);
        poll.setOption3(option3);
        poll.setOption4(option4);
        poll.setOption5(option5);
        poll.setCount1(0);
        poll.setCount2(0);
        poll.setCount3(0);
        poll.setCount4(0);
        poll.setCount5(0);

        if (courseId != null) {
            Course course = courseRepository.findById(courseId).orElse(null);
            poll.setCourse(course);
        }

        pollRepository.save(poll);

        if (courseId != null) {
            return "redirect:/course/details?id=" + courseId;
        }
        return "redirect:/home";
    }

    @GetMapping("/poll/edit")
    public String showEditPage(@RequestParam Long id, Model model) {
        Poll poll = pollRepository.findById(id).orElse(null);
        if (poll == null) {
            return "redirect:/home";
        }

        List<Course> courses = courseRepository.findAll();
        model.addAttribute("poll", poll);
        model.addAttribute("courses", courses);
        return "poll/edit";
    }

    @PostMapping("/poll/edit")
    public String updatePoll(@RequestParam Long id,
                             @RequestParam String question,
                             @RequestParam String option1,
                             @RequestParam String option2,
                             @RequestParam String option3,
                             @RequestParam String option4,
                             @RequestParam String option5,
                             @RequestParam(required = false) Long courseId) {

        Poll poll = pollRepository.findById(id).orElse(null);
        if (poll == null) {
            return "redirect:/home";
        }

        poll.setQuestion(question);
        poll.setOption1(option1);
        poll.setOption2(option2);
        poll.setOption3(option3);
        poll.setOption4(option4);
        poll.setOption5(option5);

        if (courseId != null) {
            Course course = courseRepository.findById(courseId).orElse(null);
            poll.setCourse(course);
        } else {
            poll.setCourse(null);
        }

        pollRepository.save(poll);

        return "redirect:/poll/view?id=" + id;
    }
}