package hkmu.wadd.online_learning_platform.controller;

import hkmu.wadd.online_learning_platform.model.Comment;
import hkmu.wadd.online_learning_platform.repository.CommentRepository;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CommentController {

    private final CommentRepository commentRepository;

    public CommentController(CommentRepository commentRepository) {
        this.commentRepository = commentRepository;
    }

    @PostMapping("/comment/add")
    public String addComment(@RequestParam String content,
                             @RequestParam(required = false) Long lectureId,
                             @RequestParam(required = false) Long pollId,
                             Authentication authentication) {

        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        String username = authentication.getName();

        Comment comment = new Comment(content, username, lectureId, pollId);
        commentRepository.save(comment);

        if (lectureId != null) {
            return "redirect:/lecture/view?id=" + lectureId;
        } else if (pollId != null) {
            return "redirect:/poll/view?id=" + pollId;
        }

        return "redirect:/home";
    }

    @PostMapping("/comment/delete")
    public String deleteComment(@RequestParam Long commentId,
                                @RequestParam(required = false) Long lectureId,
                                @RequestParam(required = false) Long pollId,
                                Authentication authentication) {

        Comment comment = commentRepository.findById(commentId).orElse(null);

        // 只有 comment 作者或者老師可以刪除
        if (comment != null && authentication != null) {
            String currentUser = authentication.getName();
            if (comment.getUsername().equals(currentUser) ||
                    authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_LECTURER"))) {
                commentRepository.delete(comment);
            }
        }

        if (lectureId != null) {
            return "redirect:/lecture/view?id=" + lectureId;
        } else if (pollId != null) {
            return "redirect:/poll/view?id=" + pollId;
        }

        return "redirect:/home";
    }
}