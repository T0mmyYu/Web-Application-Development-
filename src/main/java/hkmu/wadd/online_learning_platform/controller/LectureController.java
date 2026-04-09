package hkmu.wadd.online_learning_platform.controller;

import hkmu.wadd.online_learning_platform.model.Course;
import hkmu.wadd.online_learning_platform.model.Lecture;
import hkmu.wadd.online_learning_platform.model.Comment;  // 加入
import hkmu.wadd.online_learning_platform.repository.CommentRepository;
import hkmu.wadd.online_learning_platform.repository.CourseRepository;
import hkmu.wadd.online_learning_platform.repository.LectureRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import jakarta.annotation.PostConstruct;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
public class LectureController {

    private final CourseRepository courseRepository;
    private final LectureRepository lectureRepository;
    private final CommentRepository commentRepository;  // 已經有
    private final String uploadDir;
    private final String additionalUploadDir;

    // 修正 Constructor - 加入 commentRepository
    public LectureController(CourseRepository courseRepository,
                             LectureRepository lectureRepository,
                             CommentRepository commentRepository) {  // 加入參數
        this.courseRepository = courseRepository;
        this.lectureRepository = lectureRepository;
        this.commentRepository = commentRepository;  // 加入呢行
        this.uploadDir = System.getProperty("user.dir") + "/uploads/lectures/";
        this.additionalUploadDir = System.getProperty("user.dir") + "/uploads/lectures/additional/";
    }

@PostConstruct
    public void init() {
        try {
            // 建立主要上載目錄
            Path uploadPath = Paths.get(uploadDir);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
                System.out.println("Created upload directory: " + uploadPath.toAbsolutePath());
            }
            System.out.println("Upload directory: " + uploadPath.toAbsolutePath());

            // 建立額外檔案上載目錄
            Path additionalPath = Paths.get(additionalUploadDir);
            if (!Files.exists(additionalPath)) {
                Files.createDirectories(additionalPath);
                System.out.println("Created additional upload directory: " + additionalPath.toAbsolutePath());
            }
            System.out.println("Additional upload directory: " + additionalPath.toAbsolutePath());

        } catch (IOException e) {
            System.err.println("Failed to create upload directory: " + e.getMessage());
        }
    }

    @GetMapping("/course/{courseId}/lecture/create")
    public String showCreatePage(@PathVariable Long courseId, Model model) {
        Course course = courseRepository.findById(courseId).orElse(null);
        if (course == null) {
            return "redirect:/";
        }
        model.addAttribute("course", course);
        return "lecture/create";
    }

    @PostMapping("/lecture/create")
    public String createLecture(@RequestParam Long courseId,
                                @RequestParam String title,
                                @RequestParam String summary,
                                @RequestParam(required = false) String notesUrl,
                                @RequestParam(required = false) MultipartFile notesFile,
                                @RequestParam(required = false) List<MultipartFile> additionalFiles) throws IOException {

        Lecture lecture = new Lecture();
        lecture.setTitle(title);
        lecture.setSummary(summary);

        // 處理主要講義 file upload
        if (notesFile != null && !notesFile.isEmpty()) {
            File directory = new File(uploadDir);
            if (!directory.exists()) {
                directory.mkdirs();
            }

            String originalFileName = notesFile.getOriginalFilename();
            String fileExtension = "";
            if (originalFileName != null && originalFileName.contains(".")) {
                fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
            }

            String fileName = System.currentTimeMillis() + fileExtension;
            String filePath = uploadDir + fileName;

            System.out.println("Saving notes file to: " + filePath);

            File destFile = new File(filePath);
            notesFile.transferTo(destFile);
            lecture.setNotesUrl("/uploads/lectures/" + fileName);

        } else if (notesUrl != null && !notesUrl.trim().isEmpty()) {
            lecture.setNotesUrl(notesUrl);
        }

        // 處理額外檔案
        if (additionalFiles != null && !additionalFiles.isEmpty()) {
            File additionalDir = new File(additionalUploadDir);
            if (!additionalDir.exists()) {
                additionalDir.mkdirs();
            }

            for (MultipartFile file : additionalFiles) {
                if (file != null && !file.isEmpty()) {
                    String originalFileName = file.getOriginalFilename();
                    String fileName = System.currentTimeMillis() + "_" + originalFileName;
                    String filePath = additionalUploadDir + fileName;

                    System.out.println("Saving additional file to: " + filePath);

                    file.transferTo(new File(filePath));
                    lecture.addAdditionalFile("/uploads/lectures/additional/" + fileName);
                }
            }
        }

        Course course = courseRepository.findById(courseId).orElse(null);
        if (course == null) {
            return "redirect:/";
        }
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

        List<Comment> comments = commentRepository.findByLectureIdOrderByCreateTimeDesc(id);

        Course course = lecture.getCourse();
        model.addAttribute("lecture", lecture);
        model.addAttribute("course", course);
        model.addAttribute("comments", comments);

        return "lecture/view";
    }

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

    @PostMapping("/lecture/clear-notes")
    public String clearNotes(@RequestParam Long id) {
        Lecture lecture = lectureRepository.findById(id).orElse(null);
        if (lecture != null) {
            lecture.setNotesUrl(null);
            lectureRepository.save(lecture);
        }
        return "redirect:/lecture/edit?id=" + id;
    }

    @PostMapping("/lecture/edit")
    public String updateLecture(@RequestParam Long id,
                                @RequestParam String title,
                                @RequestParam String summary,
                                @RequestParam(required = false) String notesUrl,
                                @RequestParam(required = false) MultipartFile notesFile,
                                @RequestParam(required = false) List<MultipartFile> additionalFiles,
                                @RequestParam(required = false) List<String> deleteFiles) throws IOException {

        Lecture lecture = lectureRepository.findById(id).orElse(null);
        if (lecture == null) {
            return "redirect:/";
        }

        lecture.setTitle(title);
        lecture.setSummary(summary);

        // 處理主要講義 file upload
        if (notesFile != null && !notesFile.isEmpty()) {
            File directory = new File(uploadDir);
            if (!directory.exists()) {
                directory.mkdirs();
            }

            String originalFileName = notesFile.getOriginalFilename();
            String fileExtension = "";
            if (originalFileName != null && originalFileName.contains(".")) {
                fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
            }

            String fileName = System.currentTimeMillis() + "_" + id + fileExtension;
            String filePath = uploadDir + fileName;

            System.out.println("Saving notes file to: " + filePath);

            File destFile = new File(filePath);
            notesFile.transferTo(destFile);
            lecture.setNotesUrl("/uploads/lectures/" + fileName);

        } else if (notesUrl != null && !notesUrl.trim().isEmpty()) {
            lecture.setNotesUrl(notesUrl);
        }

        // 刪除被標記嘅額外檔案
        if (deleteFiles != null && !deleteFiles.isEmpty()) {
            for (String fileUrl : deleteFiles) {
                // 刪除實體檔案
                String filePath = System.getProperty("user.dir") + fileUrl;
                File file = new File(filePath);
                if (file.exists()) {
                    boolean deleted = file.delete();
                    System.out.println("Deleted file: " + filePath + " - " + deleted);
                }
                lecture.getAdditionalFiles().remove(fileUrl);
            }
        }

        // 處理新嘅額外檔案
        if (additionalFiles != null && !additionalFiles.isEmpty()) {
            File additionalDir = new File(additionalUploadDir);
            if (!additionalDir.exists()) {
                additionalDir.mkdirs();
            }

            for (MultipartFile file : additionalFiles) {
                if (file != null && !file.isEmpty()) {
                    String originalFileName = file.getOriginalFilename();
                    String fileName = System.currentTimeMillis() + "_" + originalFileName;
                    String filePath = additionalUploadDir + fileName;

                    System.out.println("Saving additional file to: " + filePath);

                    file.transferTo(new File(filePath));
                    lecture.addAdditionalFile("/uploads/lectures/additional/" + fileName);
                }
            }
        }

        lectureRepository.save(lecture);
        System.out.println("Final additional files count: " + lecture.getAdditionalFiles().size());

        return "redirect:/lecture/view?id=" + id;
    }
}